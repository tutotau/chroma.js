
#
# Based on implementation by Neil Bartlett
# https://github.com/neilbartlett/color-temperature
#

temp2rgb = (kelvin) ->
    temp = kelvin / 100
    if temp < 66
        r = 255
        g = -155.25485562709179 - 0.44596950469579133 * (g = temp-2) + 104.49216199393888 * log(g)
        b = if temp < 20 then 0 else -254.76935184120902 + 0.8274096064007395 * (b = temp-10) + 115.67994401066147 * log(b)
    else
        r = 351.97690566805693 + 0.114206453784165 * (r = temp-55) - 40.25366309332127 * log(r)
        g = 325.4494125711974 + 0.07943456536662342 * (g = temp-50) - 28.0852963507957 * log(g)
        b = 255
    clip_rgb [r,g,b]



rgb2temp = () ->
    [r,g,b] = unpack arguments
    minTemp = 1000
    maxTemp = 40000
    eps = 0.4
    while maxTemp - minTemp > eps
        temp = (maxTemp + minTemp) * 0.5
        rgb = temp2rgb temp
        if (rgb[2] / rgb[0]) >= (b / r)
            maxTemp = temp
        else
            minTemp = temp
    round temp
