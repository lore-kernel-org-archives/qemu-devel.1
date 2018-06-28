Received: from eggs.gnu.org ([2001:4830:134:3::10]:60858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYVeW-0004Lb-Hr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYVeU-0005Py-EV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:03:56 -0400
Date: Thu, 28 Jun 2018 13:03:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180628120336.GD2536@work-vm>
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-5-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627232951.14725-5-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [RFC v3 04/10] hw/m68k: add video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

* Laurent Vivier (laurent@vivier.eu) wrote:
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  arch_init.c                 |   4 +
>  hw/display/Makefile.objs    |   1 +
>  hw/display/macfb-template.h | 158 +++++++++++++++++++++++++++
>  hw/display/macfb.c          | 252 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/display/macfb.h  |  42 ++++++++
>  qemu-options.hx             |   2 +-
>  vl.c                        |   3 +-
>  7 files changed, 460 insertions(+), 2 deletions(-)
>  create mode 100644 hw/display/macfb-template.h
>  create mode 100644 hw/display/macfb.c
>  create mode 100644 include/hw/display/macfb.h
> 
> diff --git a/arch_init.c b/arch_init.c
> index f4f3f610c8..5a71b48dc5 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -39,6 +39,10 @@
>  int graphic_width = 1024;
>  int graphic_height = 768;
>  int graphic_depth = 8;
> +#elif defined(TARGET_M68K)
> +int graphic_width = 800;
> +int graphic_height = 600;
> +int graphic_depth = 8;
>  #else
>  int graphic_width = 800;
>  int graphic_height = 600;
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index fb8408c6d0..bb9f509e4f 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -22,6 +22,7 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
>  common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
>  common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
> +common-obj-$(CONFIG_MACFB) += macfb.o
>  
>  common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
>  milkymist-tmu2.o-cflags := $(X11_CFLAGS)
> diff --git a/hw/display/macfb-template.h b/hw/display/macfb-template.h
> new file mode 100644
> index 0000000000..b6ae5d728f
> --- /dev/null
> +++ b/hw/display/macfb-template.h
> @@ -0,0 +1,158 @@
> +#if defined(READ_BITS)
> +#define PALETTE(i, r, g, b)                        \
> +    do {                                           \
> +        r =  s->color_palette[i * 3];              \
> +        g =  s->color_palette[i * 3 + 1];          \
> +        b =  s->color_palette[i * 3 + 2];          \
> +    } while (0)
> +
> +#if READ_BITS == 1
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = x & 7;                           \
> +        int idx = (*from >> (7 - bit)) & 1;        \
> +        r = g = b  = ((1 - idx) << 7);             \
> +        from += (bit == 7);                        \
> +    } while (0)
> +#elif READ_BITS == 2
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = (x & 3);                         \
> +        int idx = (*from >> ((3 - bit) << 1)) & 3; \
> +        PALETTE(idx, r, g, b);                     \
> +        from += (bit == 3);                        \
> +    } while (0)
> +#elif READ_BITS == 4
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = x & 1;                           \
> +        int idx = (*from >> ((1 - bit) << 2)) & 15; \
> +        PALETTE(idx, r, g, b);                     \
> +        from += (bit == 1);                        \
> +    } while (0)
> +#elif READ_BITS == 8
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        PALETTE(*from, r, g, b);                   \
> +        from++;                                    \
> +    } while (0)
> +#elif READ_BITS == 16
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        uint16_t pixel;                            \
> +        pixel = (from[0] << 8) | from[1];          \
> +        r = ((pixel >> 10) & 0x1f) << 3;           \
> +        g = ((pixel >> 5) & 0x1f) << 3;            \
> +        b = (pixel & 0x1f) << 3;                   \
> +        from += 2;                                 \
> +    } while (0)
> +#elif READ_BITS == 24
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        r = *from++;                               \
> +        g = *from++;                               \
> +        b = *from++;                               \
> +    } while (0)
> +#else
> +#error unknown bit depth
> +#endif
> +
> +#if WRITE_BITS == 8
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *to = rgb_to_pixel8(r, g, b);              \
> +        to += 1;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 15
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint16_t *)to = rgb_to_pixel15(r, g, b); \
> +        to += 2;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 16
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint16_t *)to = rgb_to_pixel16(r, g, b); \
> +        to += 2;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 24
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        uint32_t tmp = rgb_to_pixel24(r, g, b);    \
> +        *(to++) =         tmp & 0xff;              \
> +        *(to++) =  (tmp >> 8) & 0xff;              \
> +        *(to++) = (tmp >> 16) & 0xff;              \
> +    } while (0)
> +#elif WRITE_BITS == 32
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint32_t *)to = rgb_to_pixel32(r, g, b); \
> +        to += 4;                                   \
> +    } while (0)
> +#else
> +#error unknown bit depth
> +#endif
> +
> +static void glue(glue(glue(draw_line, READ_BITS), _), WRITE_BITS)
> +                          (MacfbState *s, uint8_t *to, uint8_t *from, int width)
> +{
> +    uint8_t r, g, b;
> +    int x;
> +    for (x = 0; x < width; x++) {
> +        READ_PIXEL(from, x, r, g, b);
> +        WRITE_PIXEL(to, r, g, b);
> +    }
> +}
> +#undef READ_BITS
> +#undef READ_PIXEL
> +#undef WRITE_PIXEL
> +
> +#elif defined(WRITE_BITS)
> +
> +#undef MACFB_RECLEVEL
> +#define MACFB_RECLEVEL 2
> +#define READ_BITS 1
> +#include "macfb-template.h"
> +#define READ_BITS 2
> +#include "macfb-template.h"
> +#define READ_BITS 4
> +#include "macfb-template.h"
> +#define READ_BITS 8
> +#include "macfb-template.h"
> +#define READ_BITS 16
> +#include "macfb-template.h"
> +#define READ_BITS 24
> +#include "macfb-template.h"
> +#undef WRITE_BITS
> +
> +#else
> +
> +#define WRITE_BITS 8
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 16
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 24
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 32
> +#include "macfb-template.h"
> +
> +typedef void (*macfb_draw_line_func_t)(MacfbState *, uint8_t *, uint8_t *, int);
> +
> +static macfb_draw_line_func_t macfb_draw_line[24][32] = {
> +    [0] = { [7] = draw_line1_8, [15] = draw_line1_16,
> +            [23] = draw_line1_24, [31] = draw_line1_32 },
> +    [1] = { [7] = draw_line2_8, [15] = draw_line2_16,
> +            [23] = draw_line2_24, [31] = draw_line2_32 },
> +    [3] = { [7] = draw_line4_8, [15] = draw_line4_16,
> +            [23] = draw_line4_24, [31] = draw_line4_32 },
> +    [7] = { [7] = draw_line8_8, [15] = draw_line8_16,
> +            [23] = draw_line8_24, [31] = draw_line8_32 },
> +    [15] = { [7] = draw_line16_8, [15] = draw_line16_16,
> +             [23] = draw_line16_24, [31] = draw_line16_32 },
> +    [23] = { [7] = draw_line24_8, [15] = draw_line24_16,
> +             [23] = draw_line24_24, [31] = draw_line24_32 },
> +};
> +#endif
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> new file mode 100644
> index 0000000000..05841f4483
> --- /dev/null
> +++ b/hw/display/macfb.c
> @@ -0,0 +1,252 @@
> +/*
> + * QEMU Motorola 680x0 Macintosh Video Card Emulation
> + *                 Copyright (c) 2012-2018 Laurent Vivier
> + *
> + * some parts from QEMU G364 framebuffer Emulator.
> + *                 Copyright (c) 2007-2011 Herve Poussineau
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "ui/console.h"
> +#include "ui/pixel_ops.h"
> +#include "hw/display/macfb.h"
> +
> +#define VIDEO_BASE 0x00001000
> +#define DAFB_BASE  0x00800000
> +
> +#define MACFB_PAGE_SIZE 4096
> +#define MACFB_VRAM_SIZE (4 * 1024 * 1024)
> +
> +#define DAFB_RESET      0x200
> +#define DAFB_LUT        0x213
> +
> +#include "macfb-template.h"
> +
> +static int macfb_check_dirty(MacfbState *s, DirtyBitmapSnapshot *snap,
> +                             ram_addr_t addr, int len)
> +{
> +    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, addr, len);
> +}
> +
> +static void macfb_draw_graphic(MacfbState *s)
> +{
> +    DisplaySurface *surface = qemu_console_surface(s->con);
> +    DirtyBitmapSnapshot *snap = NULL;
> +    ram_addr_t page;
> +    int y, ymin;
> +    int macfb_stride = (s->depth * s->width + 7) / 8;
> +    macfb_draw_line_func_t draw_line;
> +
> +    if (s->depth > 24) {
> +        hw_error("macfb: unknown guest depth %d", s->depth);
> +        return;
> +    }
> +    if (surface_bits_per_pixel(surface) > 32) {
> +        hw_error("macfb: unknown host depth %d",
> +                 surface_bits_per_pixel(surface));
> +        return;
> +    }
> +    draw_line = macfb_draw_line[s->depth - 1][surface_bits_per_pixel(surface)
> +                                              - 1];
> +
> +    if (draw_line == NULL) {
> +        hw_error("macfb: unknown guest/host depth combination %d/%d", s->depth,
> +                 surface_bits_per_pixel(surface));
> +        return;
> +    }
> +
> +    snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0x0,
> +                                             memory_region_size(&s->mem_vram),
> +                                             DIRTY_MEMORY_VGA);
> +
> +    ymin = -1;
> +    page = 0;
> +    for (y = 0; y < s->height; y++, page += macfb_stride) {
> +        if (macfb_check_dirty(s, snap, page, macfb_stride)) {
> +            uint8_t *data_display;
> +
> +            data_display = surface_data(surface) + y * surface_stride(surface);
> +            draw_line(s, data_display, s->vram + page, s->width);
> +
> +            if (ymin < 0) {
> +                ymin = y;
> +            }
> +        } else {
> +            if (ymin >= 0) {
> +                dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
> +                ymin = -1;
> +            }
> +        }
> +    }
> +
> +    if (ymin >= 0) {
> +        dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
> +    }
> +
> +    g_free(snap);
> +}
> +
> +static void macfb_invalidate_display(void *opaque)
> +{
> +    MacfbState *s = opaque;
> +
> +    memory_region_set_dirty(&s->mem_vram, 0, MACFB_VRAM_SIZE);
> +}
> +
> +static void macfb_update_display(void *opaque)
> +{
> +    MacfbState *s = opaque;
> +    DisplaySurface *surface = qemu_console_surface(s->con);
> +
> +    qemu_flush_coalesced_mmio_buffer();
> +
> +    if (s->width == 0 || s->height == 0) {
> +        return;
> +    }
> +
> +    if (s->width != surface_width(surface) ||
> +        s->height != surface_height(surface)) {
> +        qemu_console_resize(s->con, s->width, s->height);
> +    }
> +
> +    macfb_draw_graphic(s);
> +}
> +
> +static void macfb_reset(MacfbState *s)
> +{
> +    int i;
> +
> +    s->palette_current = 0;
> +    for (i = 0; i < 256; i++) {
> +        s->color_palette[i * 3] = 255 - i;
> +        s->color_palette[i * 3 + 1] = 255 - i;
> +        s->color_palette[i * 3 + 2] = 255 - i;
> +    }
> +    memset(s->vram, 0, MACFB_VRAM_SIZE);
> +    macfb_invalidate_display(s);
> +}
> +
> +static uint64_t macfb_ctrl_read(void *opaque,
> +                                hwaddr addr,
> +                                unsigned int size)
> +{
> +    return 0;
> +}
> +
> +static void macfb_ctrl_write(void *opaque,
> +                             hwaddr addr,
> +                             uint64_t val,
> +                             unsigned int size)
> +{
> +    MacfbState *s = opaque;
> +    switch (addr) {
> +    case DAFB_RESET:
> +        s->palette_current = 0;
> +        break;
> +    case DAFB_LUT:
> +        s->color_palette[s->palette_current++] = val;
> +        if (s->palette_current % 3) {
> +            macfb_invalidate_display(s);
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps macfb_ctrl_ops = {
> +    .read = macfb_ctrl_read,
> +    .write = macfb_ctrl_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 4,
> +};
> +
> +static int macfb_post_load(void *opaque, int version_id)
> +{
> +    macfb_invalidate_display(opaque);

You should probably validate palette_current, otherwise loading a
stream with a bogus palette_current could crash if it got to
macfb_ctrl_write/DAFB_LUT  

Dave

> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_macfb = {
> +    .name = "macfb",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .minimum_version_id_old = 1,
> +    .post_load = macfb_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BUFFER_UNSAFE(color_palette, MacfbState, 0, 256 * 3),

Does:
  VMSTATE_UINT8_ARRAY(color_palette, MacfbState, 256*3)

work there in a safer way?

> +        VMSTATE_UINT32(palette_current, MacfbState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const GraphicHwOps macfb_ops = {
> +    .invalidate = macfb_invalidate_display,
> +    .gfx_update = macfb_update_display,
> +};
> +
> +static void macfb_common_realize(DeviceState *dev, MacfbState *s)
> +{
> +    s->vram = g_malloc0(MACFB_VRAM_SIZE);
> +
> +    s->con = graphic_console_init(dev, 0, &macfb_ops, s);
> +
> +    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-ctrl",
> +                          0x1000);
> +    memory_region_init_ram_ptr(&s->mem_vram, NULL, "macfb-vram",
> +                               MACFB_VRAM_SIZE, s->vram);
> +    vmstate_register_ram(&s->mem_vram, dev);
> +    memory_region_set_coalescing(&s->mem_vram);
> +}
> +
> +static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
> +{
> +    MacfbSysBusState *s = MACFB(dev);
> +    MacfbState *ms = &s->macfb;
> +
> +    macfb_common_realize(dev, ms);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_ctrl);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_vram);
> +}
> +
> +static void macfb_sysbus_reset(DeviceState *d)
> +{
> +    MacfbSysBusState *s = MACFB(d);
> +    macfb_reset(&s->macfb);
> +}
> +
> +static Property macfb_sysbus_properties[] = {
> +    DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
> +    DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
> +    DEFINE_PROP_UINT8("depth", MacfbSysBusState, macfb.depth, 8),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = macfb_sysbus_realize;
> +    dc->desc = "SysBus Macintosh framebuffer";
> +    dc->reset = macfb_sysbus_reset;
> +    dc->vmsd = &vmstate_macfb;
> +    dc->props = macfb_sysbus_properties;
> +}
> +
> +static TypeInfo macfb_sysbus_info = {
> +    .name          = TYPE_MACFB,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(MacfbSysBusState),
> +    .class_init    = macfb_sysbus_class_init,
> +};
> +
> +static void macfb_register_types(void)
> +{
> +    type_register_static(&macfb_sysbus_info);
> +}
> +
> +type_init(macfb_register_types)
> diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
> new file mode 100644
> index 0000000000..70ea5480fe
> --- /dev/null
> +++ b/include/hw/display/macfb.h
> @@ -0,0 +1,42 @@
> +/*
> + * QEMU Motorola 680x0 Macintosh Video Card Emulation
> + *                 Copyright (c) 2012-2018 Laurent Vivier
> + *
> + * some parts from QEMU G364 framebuffer Emulator.
> + *                 Copyright (c) 2007-2011 Herve Poussineau
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef MACFB_H
> +#define MACFB_H
> +
> +#include "qemu/osdep.h"
> +#include "exec/memory.h"
> +#include "ui/console.h"
> +
> +typedef struct MacfbState {
> +    MemoryRegion mem_vram;
> +    MemoryRegion mem_ctrl;
> +    QemuConsole *con;
> +
> +    uint8_t *vram;
> +    uint32_t palette_current;
> +    uint8_t color_palette[256 * 3];
> +    uint32_t width, height; /* in pixels */
> +    uint8_t depth;
> +} MacfbState;
> +
> +#define TYPE_MACFB "sysbus-macfb"
> +#define MACFB(obj) \
> +    OBJECT_CHECK(MacfbSysBusState, (obj), TYPE_MACFB)
> +
> +typedef struct {
> +    SysBusDevice busdev;
> +
> +    MacfbState macfb;
> +} MacfbSysBusState;
> +
> +#endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d5b0c26e8e..b48f925128 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1539,7 +1539,7 @@ ETEXI
>  
>  DEF("g", 1, QEMU_OPTION_g ,
>      "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
> -    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
> +    QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
>  STEXI
>  @item -g @var{width}x@var{height}[x@var{depth}]
>  @findex -g
> diff --git a/vl.c b/vl.c
> index d26f19b06d..87ba3859eb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3310,7 +3310,8 @@ int main(int argc, char **argv, char **envp)
>                      if (*p == 'x') {
>                          p++;
>                          depth = strtol(p, (char **)&p, 10);
> -                        if (depth != 8 && depth != 15 && depth != 16 &&
> +                        if (depth != 1 && depth != 2 && depth != 4 &&
> +                            depth != 8 && depth != 15 && depth != 16 &&
>                              depth != 24 && depth != 32)
>                              goto graphic_error;
>                      } else if (*p == '\0') {
> -- 
> 2.14.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
