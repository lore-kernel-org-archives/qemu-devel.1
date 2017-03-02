Received: from eggs.gnu.org ([2001:4830:134:3::10]:59078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWlp-0006yN-GZ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWlo-0001nf-23
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:52:13 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWln-0001mT-OX
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:52:12 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so92578wmd.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:52:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <869a8c5b526be9eb1316c9e7c7442bdd1c88c4b2.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<869a8c5b526be9eb1316c9e7c7442bdd1c88c4b2.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:51:49 +0000
Message-ID: <CAFEAcA9zswu1H-66avnAxWdq8QvCWpi1NTbcaGqDE=c=OOHcAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 13/14] sm501: Add reset function and
 vmstate descriptor
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

On 25 February 2017 at 23:53, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 105 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 32223f6..b682a95 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -65,6 +65,7 @@
>
>  #define MMIO_BASE_OFFSET 0x3e00000
>  #define MMIO_SIZE 0x200000
> +#define DC_PALETTE_ENTRIES (0x400 * 3)
>
>  /* SM501 register definitions taken from "linux/include/linux/sm501-regs.h" */
>
> @@ -491,7 +492,7 @@ typedef struct SM501State {
>      uint32_t uart0_mcr;
>      uint32_t uart0_scr;
>
> -    uint8_t dc_palette[0x400 * 3];
> +    uint8_t dc_palette[DC_PALETTE_ENTRIES];
>
>      uint32_t dc_panel_control;
>      uint32_t dc_panel_panning_control;
> @@ -1537,16 +1538,32 @@ static const GraphicHwOps sm501_ops = {
>      .gfx_update  = sm501_update_display,
>  };
>
> +static void sm501_reset(void *p)
> +{
> +    SM501State *s = p;
> +
> +    s->system_control = 0x00100000; /* 2D engine FIFO empty */
> +    s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */

Don't forget to update this patch when you fix this reset value in patch 1.

> +    s->gpio_31_0_control = 0;
> +    s->gpio_63_32_control = 0;
> +    s->dram_control = 0;
> +    s->arbitration_control = 0x05146732;
> +    s->irq_mask = 0;
> +    s->misc_timing = 0;
> +    s->power_mode_control = 0;
> +    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
> +    s->dc_video_control = 0;
> +    s->dc_crt_control = 0x00010000;
> +    s->twoD_control = 0;
> +}
> +
>  static void sm501_init(SM501State *s, DeviceState *dev,
>                         uint32_t local_mem_bytes)
>  {
>      s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>      SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
>                    s->local_mem_size_index);
> -    s->system_control = 0x00100000; /* 2D engine FIFO empty */
> -    s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */
> -    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
> -    s->dc_crt_control = 0x00010000;
> +    qemu_register_reset(sm501_reset, s);

Don't use qemu_register_reset(). Set the appropriate dc->reset
function pointers instead.

>
>      /* local memory */
>      memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
> @@ -1577,6 +1594,77 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>      s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
>  }
>
> +static const VMStateDescription vmstate_sm501_regs = {
> +    .name = "sm501-regs",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(system_control, SM501State),
> +        VMSTATE_UINT32(misc_control, SM501State),
> +        VMSTATE_UINT32(gpio_31_0_control, SM501State),
> +        VMSTATE_UINT32(gpio_63_32_control, SM501State),
> +        VMSTATE_UINT32(dram_control, SM501State),
> +        VMSTATE_UINT32(arbitration_control, SM501State),
> +        VMSTATE_UINT32(irq_mask, SM501State),
> +        VMSTATE_UINT32(misc_timing, SM501State),
> +        VMSTATE_UINT32(power_mode_control, SM501State),
> +        VMSTATE_UINT32(uart0_ier, SM501State),
> +        VMSTATE_UINT32(uart0_lcr, SM501State),
> +        VMSTATE_UINT32(uart0_mcr, SM501State),
> +        VMSTATE_UINT32(uart0_scr, SM501State),
> +        VMSTATE_UINT8_ARRAY(dc_palette, SM501State, DC_PALETTE_ENTRIES),
> +        VMSTATE_UINT32(dc_panel_control, SM501State),
> +        VMSTATE_UINT32(dc_panel_panning_control, SM501State),
> +        VMSTATE_UINT32(dc_panel_fb_addr, SM501State),
> +        VMSTATE_UINT32(dc_panel_fb_offset, SM501State),
> +        VMSTATE_UINT32(dc_panel_fb_width, SM501State),
> +        VMSTATE_UINT32(dc_panel_fb_height, SM501State),
> +        VMSTATE_UINT32(dc_panel_tl_location, SM501State),
> +        VMSTATE_UINT32(dc_panel_br_location, SM501State),
> +        VMSTATE_UINT32(dc_panel_h_total, SM501State),
> +        VMSTATE_UINT32(dc_panel_h_sync, SM501State),
> +        VMSTATE_UINT32(dc_panel_v_total, SM501State),
> +        VMSTATE_UINT32(dc_panel_v_sync, SM501State),
> +        VMSTATE_UINT32(dc_panel_hwc_addr, SM501State),
> +        VMSTATE_UINT32(dc_panel_hwc_location, SM501State),
> +        VMSTATE_UINT32(dc_panel_hwc_color_1_2, SM501State),
> +        VMSTATE_UINT32(dc_panel_hwc_color_3, SM501State),
> +        VMSTATE_UINT32(dc_video_control, SM501State),
> +        VMSTATE_UINT32(dc_crt_control, SM501State),
> +        VMSTATE_UINT32(dc_crt_fb_addr, SM501State),
> +        VMSTATE_UINT32(dc_crt_fb_offset, SM501State),
> +        VMSTATE_UINT32(dc_crt_h_total, SM501State),
> +        VMSTATE_UINT32(dc_crt_h_sync, SM501State),
> +        VMSTATE_UINT32(dc_crt_v_total, SM501State),
> +        VMSTATE_UINT32(dc_crt_v_sync, SM501State),
> +        VMSTATE_UINT32(dc_crt_hwc_addr, SM501State),
> +        VMSTATE_UINT32(dc_crt_hwc_location, SM501State),
> +        VMSTATE_UINT32(dc_crt_hwc_color_1_2, SM501State),
> +        VMSTATE_UINT32(dc_crt_hwc_color_3, SM501State),
> +        VMSTATE_UINT32(twoD_source, SM501State),
> +        VMSTATE_UINT32(twoD_destination, SM501State),
> +        VMSTATE_UINT32(twoD_dimension, SM501State),
> +        VMSTATE_UINT32(twoD_control, SM501State),
> +        VMSTATE_UINT32(twoD_pitch, SM501State),
> +        VMSTATE_UINT32(twoD_foreground, SM501State),
> +        VMSTATE_UINT32(twoD_background, SM501State),
> +        VMSTATE_UINT32(twoD_stretch, SM501State),
> +        VMSTATE_UINT32(twoD_color_compare, SM501State),
> +        VMSTATE_UINT32(twoD_color_compare_mask, SM501State),
> +        VMSTATE_UINT32(twoD_mask, SM501State),
> +        VMSTATE_UINT32(twoD_clip_tl, SM501State),
> +        VMSTATE_UINT32(twoD_clip_br, SM501State),
> +        VMSTATE_UINT32(twoD_mono_pattern_low, SM501State),
> +        VMSTATE_UINT32(twoD_mono_pattern_high, SM501State),
> +        VMSTATE_UINT32(twoD_window_width, SM501State),
> +        VMSTATE_UINT32(twoD_source_base, SM501State),
> +        VMSTATE_UINT32(twoD_destination_base, SM501State),
> +        VMSTATE_UINT32(twoD_alpha, SM501State),
> +        VMSTATE_UINT32(twoD_wrap, SM501State),
> +        VMSTATE_END_OF_LIST()
> +     }
> +};

local_mem_size_index is also guest updatable state (it's some
of the bits from the SM501_DRAM_CONTROL register), so we need
to migrate it as well.

> +
>  #define TYPE_SYSBUS_SM501 "sysbus-sm501"
>  #define SYSBUS_SM501(obj) \
>      OBJECT_CHECK(SM501SysBusState, (obj), TYPE_SYSBUS_SM501)
> @@ -1673,6 +1761,17 @@ static Property sm501_pci_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static const VMStateDescription vmstate_sm501 = {
> +    .name = "sm501",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
> +        VMSTATE_STRUCT(state, SM501PCIState, 1, vmstate_sm501_regs, SM501State),
> +        VMSTATE_END_OF_LIST()
> +     }
> +};
> +
>  static void sm501_pci_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1686,6 +1785,7 @@ static void sm501_pci_class_init(ObjectClass *klass, void *data)
>      dc->desc = "SM501 Display Controller";
>      dc->props = sm501_pci_properties;
>      dc->hotpluggable = false;
> +    dc->vmsd = &vmstate_sm501;
>  }
>
>  static const TypeInfo sm501_pci_info = {
> --
> 2.7.4

What about reset and vmstate for the sysbus device?

Consider putting reset and vmstate in separate patches.

thanks
-- PMM
