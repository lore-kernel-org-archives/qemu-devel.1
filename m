Received: from eggs.gnu.org ([2001:4830:134:3::10]:50153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWBJ-0003zs-NP
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWBI-0001D5-Kb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:14:29 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWBI-0001Cv-Dp
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:14:28 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so32650160wma.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:14:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7c6e8c071cbd47d6d9065635e97dd88a7197b5be.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<7c6e8c071cbd47d6d9065635e97dd88a7197b5be.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:14:06 +0000
Message-ID: <CAFEAcA-01wdWYs_F-Maxoq7Wa=Xo1J1iaheEQFUdVL1G4PDG7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 04/14] sm501: Get rid of base address in
 draw_hwc_line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 18:23, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Do not use the base address to access data in local memory. This is in
> preparation to allow chip connected via PCI where base address depends
> on where the BAR is mapped so it will be unknown.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c          | 6 ++----
>  hw/display/sm501_template.h | 8 ++++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 22cac97..1cda127 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -460,7 +460,6 @@ typedef struct SM501State {
>      QemuConsole *con;
>
>      /* status & internal resources */
> -    hwaddr base;
>      uint32_t local_mem_size_index;
>      uint8_t *local_mem;
>      MemoryRegion local_mem_region;
> @@ -1400,10 +1399,9 @@ static const GraphicHwOps sm501_ops = {
>      .gfx_update  = sm501_update_display,
>  };
>
> -static void sm501_init(SM501State *s, DeviceState *dev, uint32_t base,
> +static void sm501_init(SM501State *s, DeviceState *dev,
>                         uint32_t local_mem_bytes)
>  {
> -    s->base = base;
>      s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>      SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
>                    s->local_mem_size_index);
> @@ -1461,7 +1459,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      DeviceState *usb_dev;
>
> -    sm501_init(&s->state, dev, s->base, s->vram_size);
> +    sm501_init(&s->state, dev, s->vram_size);
>      sysbus_init_mmio(sbd, &s->state.local_mem_region);
>      sysbus_init_mmio(sbd, &s->state.mmio_region);
>
> diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
> index 16e500b..832ee61 100644
> --- a/hw/display/sm501_template.h
> +++ b/hw/display/sm501_template.h
> @@ -103,13 +103,13 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
>                   uint8_t *palette, int c_y, uint8_t *d, int width)
>  {
>      int x, i;
> -    uint8_t bitset = 0;
> +    uint8_t *pixval, bitset = 0;
>
>      /* get hardware cursor pattern */
>      uint32_t cursor_addr = get_hwc_address(s, crt);
>      assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
>      cursor_addr += SM501_HWC_WIDTH * c_y / 4;  /* 4 pixels per byte */
> -    cursor_addr += s->base;
> +    pixval = s->local_mem + cursor_addr;
>
>      /* get cursor position */
>      x = get_hwc_x(s, crt);
> @@ -120,8 +120,8 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
>
>          /* get pixel value */
>          if (i % 4 == 0) {
> -            bitset = ldub_phys(&address_space_memory, cursor_addr);
> -            cursor_addr++;
> +            bitset = ldub_p(pixval);
> +            pixval++;
>          }
>          v = bitset & 3;
>          bitset >>= 2;
> --
> 2.7.4

(The data sheet suggests that the hardware cursor can also be in
"external memory", but it looks like we never supported that
previously and I can't figure out how it is supposed to work either.
So no problem with restricting it to be in the local video ram blob.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
