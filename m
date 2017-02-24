Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMdC-00036Y-B0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMd9-0005Rq-6z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:38:22 -0500
Date: Fri, 24 Feb 2017 21:38:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8jd10oqz6R4RDC5pOrsXxOMft9q0sghBUqvVpduJ3K1Q@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702242135160.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<e87856482b30803a17c5af8124dad9454c0bed86.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8jd10oqz6R4RDC5pOrsXxOMft9q0sghBUqvVpduJ3K1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 08/10] sm501: Add support for panel layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, Peter Maydell wrote:
> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 73 +++++++++++++++++++++++++++---------------------------
>>  1 file changed, 37 insertions(+), 36 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 1bd0303..2e1c4b7 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -2,6 +2,7 @@
>>   * QEMU SM501 Device
>>   *
>>   * Copyright (c) 2008 Shin-ichiro KAWASAKI
>> + * Copyright (c) 2016 BALATON Zoltan
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>>   * of this software and associated documentation files (the "Software"), to deal
>> @@ -41,8 +42,11 @@
>>   *   - Minimum implementation for Linux console : mmio regs and CRT layer.
>>   *   - 2D graphics acceleration partially supported : only fill rectangle.
>>   *
>> - * TODO:
>> + * Status: 2016/12/04
>> + *   - Misc fixes: endianness, hardware cursor
>>   *   - Panel support
>> + *
>> + * TODO:
>>   *   - Touch panel support
>>   *   - USB support
>>   *   - UART support
>> @@ -1297,53 +1301,62 @@ static inline int get_depth_index(DisplaySurface *surface)
>>      }
>>  }
>>
>> -static void sm501_draw_crt(SM501State *s)
>> +static void sm501_update_display(void *opaque)
>>  {
>> +    SM501State *s = (SM501State *)opaque;
>>      DisplaySurface *surface = qemu_console_surface(s->con);
>>      int y, c_x, c_y;
>> -    uint8_t *hwc_src, *src = s->local_mem;
>> -    int width = get_width(s, 1);
>> -    int height = get_height(s, 1);
>> -    int src_bpp = get_bpp(s, 1);
>> +    int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>> +    int width = get_width(s, crt);
>> +    int height = get_height(s, crt);
>> +    int src_bpp = get_bpp(s, crt);
>>      int dst_bpp = surface_bytes_per_pixel(surface);
>> -    uint32_t *palette = (uint32_t *)&s->dc_palette[SM501_DC_CRT_PALETTE -
>> -                                                   SM501_DC_PANEL_PALETTE];
>> -    uint8_t hwc_palette[3 * 3];
>> -    int ds_depth_index = get_depth_index(surface);
>> +    int dst_depth_index = get_depth_index(surface);
>
> Please don't change variable names in the middle of a patch that's
> adding new functionality, it makes the patch harder to review.

Where should I do it then? Again another patch?

>>      draw_line_func *draw_line = NULL;
>>      draw_hwc_line_func *draw_hwc_line = NULL;
>>      int full_update = 0;
>>      int y_start = -1;
>>      ram_addr_t page_min = ~0l;
>>      ram_addr_t page_max = 0l;
>> -    ram_addr_t offset = 0;
>> +    ram_addr_t offset;
>> +    uint32_t *palette;
>> +    uint8_t hwc_palette[3 * 3];
>> +    uint8_t *hwc_src;
>> +
>> +    if (!((crt ? s->dc_crt_control : s->dc_panel_control)
>> +          & SM501_DC_CRT_CONTROL_ENABLE)) {
>> +        return;
>> +    }
>> +
>> +    palette = (uint32_t *)(crt ? &s->dc_palette[SM501_DC_CRT_PALETTE -
>> +                                                SM501_DC_PANEL_PALETTE]
>> +                               : &s->dc_palette[0]);
>>
>>      /* choose draw_line function */
>>      switch (src_bpp) {
>>      case 1:
>> -        draw_line = draw_line8_funcs[ds_depth_index];
>> +        draw_line = draw_line8_funcs[dst_depth_index];
>>          break;
>>      case 2:
>> -        draw_line = draw_line16_funcs[ds_depth_index];
>> +        draw_line = draw_line16_funcs[dst_depth_index];
>>          break;
>>      case 4:
>> -        draw_line = draw_line32_funcs[ds_depth_index];
>> +        draw_line = draw_line32_funcs[dst_depth_index];
>>          break;
>>      default:
>> -        printf("sm501 draw crt : invalid DC_CRT_CONTROL=%x.\n",
>> -               s->dc_crt_control);
>> +        printf("sm501 update display : invalid control register value.\n");
>
> This shouldn't be in the same patch as "add panel" either.

I think it's related because adding panel layer makes this function not 
only specific the the CRT layer, hence the change in the error message.
