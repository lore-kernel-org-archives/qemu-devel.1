Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gIbIY-0005Tz-Ii
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gIbIV-0000hv-IH
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:23:46 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  2 Nov 2018 15:22:51 +0000
Message-Id: <20181102152257.20637-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/10] hw/m68k: add macfb video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

From: Laurent Vivier <laurent@vivier.eu>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
---
 arch_init.c                |   4 +
 hw/display/Makefile.objs   |   1 +
 hw/display/macfb.c         | 419 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/display/macfb.h |  43 +++++
 qemu-options.hx            |   2 +-
 vl.c                       |   3 +-
 6 files changed, 470 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/macfb.c
 create mode 100644 include/hw/display/macfb.h

diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..5a71b48dc5 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -39,6 +39,10 @@
 int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
+#elif defined(TARGET_M68K)
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 8;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 97acd5b6cb..1685492ea0 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -27,6 +27,7 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
+common-obj-$(CONFIG_MACFB) += macfb.o
 
 common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
 milkymist-tmu2.o-cflags := $(X11_CFLAGS)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
new file mode 100644
index 0000000000..61ba2e9e15
--- /dev/null
+++ b/hw/display/macfb.c
@@ -0,0 +1,419 @@
+/*
+ * QEMU Motorola 680x0 Macintosh Video Card Emulation
+ *                 Copyright (c) 2012-2018 Laurent Vivier
+ *
+ * some parts from QEMU G364 framebuffer Emulator.
+ *                 Copyright (c) 2007-2011 Herve Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "ui/console.h"
+#include "ui/pixel_ops.h"
+#include "hw/display/macfb.h"
+#include "qapi/error.h"
+
+#define VIDEO_BASE 0x00001000
+#define DAFB_BASE  0x00800000
+
+#define MACFB_PAGE_SIZE 4096
+#define MACFB_VRAM_SIZE (4 * MiB)
+
+#define DAFB_RESET      0x200
+#define DAFB_LUT        0x213
+
+
+typedef void macfb_draw_line_func(MacfbState *s, uint8_t *d, uint32_t addr,
+                                  int width);
+
+static inline uint8_t macfb_read_byte(MacfbState *s, uint32_t addr)
+{
+    return s->vram[addr & s->vram_bit_mask];
+}
+
+/* 1-bit color */
+static void macfb_draw_line1(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = x & 7;
+        int idx = (macfb_read_byte(s, addr) >> (7 - bit)) & 1;
+        r = g = b  = ((1 - idx) << 7);
+        addr += (bit == 7);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 2-bit color */
+static void macfb_draw_line2(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = (x & 3);
+        int idx = (macfb_read_byte(s, addr) >> ((3 - bit) << 1)) & 3;
+        r = s->color_palette[idx * 3];
+        g = s->color_palette[idx * 3 + 1];
+        b = s->color_palette[idx * 3 + 2];
+        addr += (bit == 3);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 4-bit color */
+static void macfb_draw_line4(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = x & 1;
+        int idx = (macfb_read_byte(s, addr) >> ((1 - bit) << 2)) & 15;
+        r = s->color_palette[idx * 3];
+        g = s->color_palette[idx * 3 + 1];
+        b = s->color_palette[idx * 3 + 2];
+        addr += (bit == 1);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 8-bit color */
+static void macfb_draw_line8(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        r = s->color_palette[macfb_read_byte(s, addr) * 3];
+        g = s->color_palette[macfb_read_byte(s, addr) * 3 + 1];
+        b = s->color_palette[macfb_read_byte(s, addr) * 3 + 2];
+        addr++;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 16-bit color */
+static void macfb_draw_line16(MacfbState *s, uint8_t *d, uint32_t addr,
+                              int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        uint16_t pixel;
+        pixel = (macfb_read_byte(s, addr) << 8) | macfb_read_byte(s, addr + 1);
+        r = ((pixel >> 10) & 0x1f) << 3;
+        g = ((pixel >> 5) & 0x1f) << 3;
+        b = (pixel & 0x1f) << 3;
+        addr += 2;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 24-bit color */
+static void macfb_draw_line24(MacfbState *s, uint8_t *d, uint32_t addr,
+                              int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        r = macfb_read_byte(s, addr);
+        g = macfb_read_byte(s, addr + 1);
+        b = macfb_read_byte(s, addr + 2);
+        addr += 3;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+
+enum {
+    MACFB_DRAW_LINE1,
+    MACFB_DRAW_LINE2,
+    MACFB_DRAW_LINE4,
+    MACFB_DRAW_LINE8,
+    MACFB_DRAW_LINE16,
+    MACFB_DRAW_LINE24,
+    MACFB_DRAW_LINE_NB,
+};
+
+static macfb_draw_line_func * const
+                              macfb_draw_line_table[MACFB_DRAW_LINE_NB] = {
+    macfb_draw_line1,
+    macfb_draw_line2,
+    macfb_draw_line4,
+    macfb_draw_line8,
+    macfb_draw_line16,
+    macfb_draw_line24,
+};
+
+static int macfb_check_dirty(MacfbState *s, DirtyBitmapSnapshot *snap,
+                             ram_addr_t addr, int len)
+{
+    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, addr, len);
+}
+
+static void macfb_draw_graphic(MacfbState *s)
+{
+    DisplaySurface *surface = qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap = NULL;
+    ram_addr_t page;
+    uint32_t v = 0;
+    int y, ymin;
+    int macfb_stride = (s->depth * s->width + 7) / 8;
+    macfb_draw_line_func *macfb_draw_line;
+
+    switch (s->depth) {
+    case 1:
+        v = MACFB_DRAW_LINE1;
+        break;
+    case 2:
+        v = MACFB_DRAW_LINE2;
+        break;
+    case 4:
+        v = MACFB_DRAW_LINE4;
+        break;
+    case 8:
+        v = MACFB_DRAW_LINE8;
+        break;
+    case 16:
+        v = MACFB_DRAW_LINE16;
+        break;
+    case 24:
+        v = MACFB_DRAW_LINE24;
+        break;
+    }
+
+    macfb_draw_line = macfb_draw_line_table[v];
+    assert(macfb_draw_line != NULL);
+
+    snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0x0,
+                                             memory_region_size(&s->mem_vram),
+                                             DIRTY_MEMORY_VGA);
+
+    ymin = -1;
+    page = 0;
+    for (y = 0; y < s->height; y++, page += macfb_stride) {
+        if (macfb_check_dirty(s, snap, page, macfb_stride)) {
+            uint8_t *data_display;
+
+            data_display = surface_data(surface) + y * surface_stride(surface);
+            macfb_draw_line(s, data_display, page, s->width);
+
+            if (ymin < 0) {
+                ymin = y;
+            }
+        } else {
+            if (ymin >= 0) {
+                dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
+                ymin = -1;
+            }
+        }
+    }
+
+    if (ymin >= 0) {
+        dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
+    }
+
+    g_free(snap);
+}
+
+static void macfb_invalidate_display(void *opaque)
+{
+    MacfbState *s = opaque;
+
+    memory_region_set_dirty(&s->mem_vram, 0, MACFB_VRAM_SIZE);
+}
+
+static void macfb_update_display(void *opaque)
+{
+    MacfbState *s = opaque;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+
+    qemu_flush_coalesced_mmio_buffer();
+
+    if (s->width == 0 || s->height == 0) {
+        return;
+    }
+
+    if (s->width != surface_width(surface) ||
+        s->height != surface_height(surface)) {
+        qemu_console_resize(s->con, s->width, s->height);
+    }
+
+    macfb_draw_graphic(s);
+}
+
+static void macfb_reset(MacfbState *s)
+{
+    int i;
+
+    s->palette_current = 0;
+    for (i = 0; i < 256; i++) {
+        s->color_palette[i * 3] = 255 - i;
+        s->color_palette[i * 3 + 1] = 255 - i;
+        s->color_palette[i * 3 + 2] = 255 - i;
+    }
+    memset(s->vram, 0, MACFB_VRAM_SIZE);
+    macfb_invalidate_display(s);
+}
+
+static uint64_t macfb_ctrl_read(void *opaque,
+                                hwaddr addr,
+                                unsigned int size)
+{
+    return 0;
+}
+
+static void macfb_ctrl_write(void *opaque,
+                             hwaddr addr,
+                             uint64_t val,
+                             unsigned int size)
+{
+    MacfbState *s = opaque;
+    switch (addr) {
+    case DAFB_RESET:
+        s->palette_current = 0;
+        break;
+    case DAFB_LUT:
+        s->color_palette[s->palette_current++] = val;
+        if (s->palette_current % 3) {
+            macfb_invalidate_display(s);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps macfb_ctrl_ops = {
+    .read = macfb_ctrl_read,
+    .write = macfb_ctrl_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+};
+
+static int macfb_post_load(void *opaque, int version_id)
+{
+    macfb_invalidate_display(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_macfb = {
+    .name = "macfb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .post_load = macfb_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(color_palette, MacfbState, 256 * 3),
+        VMSTATE_UINT32(palette_current, MacfbState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const GraphicHwOps macfb_ops = {
+    .invalidate = macfb_invalidate_display,
+    .gfx_update = macfb_update_display,
+};
+
+static void macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
+{
+    DisplaySurface *surface;
+
+    if (s->depth != 1 && s->depth != 2 && s->depth != 4 && s->depth != 8 &&
+        s->depth != 16 && s->depth != 24) {
+        error_setg(errp, "unknown guest depth %d", s->depth);
+        return;
+    }
+
+    s->con = graphic_console_init(dev, 0, &macfb_ops, s);
+    surface = qemu_console_surface(s->con);
+
+    if (surface_bits_per_pixel(surface) != 32) {
+        error_setg(errp, "unknown host depth %d",
+                   surface_bits_per_pixel(surface));
+        return;
+    }
+
+    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-ctrl",
+                          0x1000);
+
+    memory_region_init_ram_nomigrate(&s->mem_vram, OBJECT(s), "macfb-vram",
+                                     MACFB_VRAM_SIZE, errp);
+    s->vram = memory_region_get_ram_ptr(&s->mem_vram);
+    s->vram_bit_mask = MACFB_VRAM_SIZE - 1;
+    vmstate_register_ram(&s->mem_vram, dev);
+    memory_region_set_coalescing(&s->mem_vram);
+}
+
+static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    MacfbSysBusState *s = MACFB(dev);
+    MacfbState *ms = &s->macfb;
+
+    macfb_common_realize(dev, ms, errp);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_ctrl);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_vram);
+}
+
+static void macfb_sysbus_reset(DeviceState *d)
+{
+    MacfbSysBusState *s = MACFB(d);
+    macfb_reset(&s->macfb);
+}
+
+static Property macfb_sysbus_properties[] = {
+    DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
+    DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
+    DEFINE_PROP_UINT8("depth", MacfbSysBusState, macfb.depth, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = macfb_sysbus_realize;
+    dc->desc = "SysBus Macintosh framebuffer";
+    dc->reset = macfb_sysbus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_sysbus_properties;
+}
+
+static TypeInfo macfb_sysbus_info = {
+    .name          = TYPE_MACFB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MacfbSysBusState),
+    .class_init    = macfb_sysbus_class_init,
+};
+
+static void macfb_register_types(void)
+{
+    type_register_static(&macfb_sysbus_info);
+}
+
+type_init(macfb_register_types)
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
new file mode 100644
index 0000000000..3fe2592735
--- /dev/null
+++ b/include/hw/display/macfb.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Motorola 680x0 Macintosh Video Card Emulation
+ *                 Copyright (c) 2012-2018 Laurent Vivier
+ *
+ * some parts from QEMU G364 framebuffer Emulator.
+ *                 Copyright (c) 2007-2011 Herve Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MACFB_H
+#define MACFB_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "ui/console.h"
+
+typedef struct MacfbState {
+    MemoryRegion mem_vram;
+    MemoryRegion mem_ctrl;
+    QemuConsole *con;
+
+    uint8_t *vram;
+    uint32_t vram_bit_mask;
+    uint32_t palette_current;
+    uint8_t color_palette[256 * 3];
+    uint32_t width, height; /* in pixels */
+    uint8_t depth;
+} MacfbState;
+
+#define TYPE_MACFB "sysbus-macfb"
+#define MACFB(obj) \
+    OBJECT_CHECK(MacfbSysBusState, (obj), TYPE_MACFB)
+
+typedef struct {
+    SysBusDevice busdev;
+
+    MacfbState macfb;
+} MacfbSysBusState;
+
+#endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 38c7a978c1..a84a70168a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1523,7 +1523,7 @@ ETEXI
 
 DEF("g", 1, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
+    QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
 STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
diff --git a/vl.c b/vl.c
index 1fcacc5caa..a84f126417 100644
--- a/vl.c
+++ b/vl.c
@@ -3353,7 +3353,8 @@ int main(int argc, char **argv, char **envp)
                     if (*p == 'x') {
                         p++;
                         depth = strtol(p, (char **)&p, 10);
-                        if (depth != 8 && depth != 15 && depth != 16 &&
+                        if (depth != 1 && depth != 2 && depth != 4 &&
+                            depth != 8 && depth != 15 && depth != 16 &&
                             depth != 24 && depth != 32)
                             goto graphic_error;
                     } else if (*p == '\0') {
-- 
2.11.0
