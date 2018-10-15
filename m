Received: from eggs.gnu.org ([2001:4830:134:3::10]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByok-0001yY-9z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByoh-0008V1-Ul
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gByoh-0008LJ-EW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:35 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 11:05:16 +0200
Message-Id: <20181015090517.26884-7-kraxel@redhat.com>
In-Reply-To: <20181015090517.26884-1-kraxel@redhat.com>
References: <20181015090517.26884-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] hw/display/cirrus_vga: Move
 "isa-cirrus-vga" device into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

In downstream distros like RHEL we'd like to disable some of the "legacy"
devices of QEMU. The ISA version of the Cirrus VGA device is one of these
legacy devices. So let's make the build process a little bit more flexible
here by putting the Cirrus ISA code into a separate file which is only
included if both, CONFIG_VGA_CIRRUS and CONFIG_VGA_ISA are set.

Note that this disables "isa-cirrus-vga" for the ppc-softmmu and the
alpha-softmmu target since CONFIG_VGA_ISA is not set there. But I think
this is OK since these targets are only interested in the PCI variant
anyway.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1539339106-32427-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga_internal.h | 103 ++++++++++++++++++++++++++++
 hw/display/cirrus_vga.c          | 143 ++-------------------------------------
 hw/display/cirrus_vga_isa.c      |  98 +++++++++++++++++++++++++++
 hw/display/Makefile.objs         |   1 +
 4 files changed, 207 insertions(+), 138 deletions(-)
 create mode 100644 hw/display/cirrus_vga_internal.h
 create mode 100644 hw/display/cirrus_vga_isa.c

diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
new file mode 100644
index 0000000000..a78ebbd920
--- /dev/null
+++ b/hw/display/cirrus_vga_internal.h
@@ -0,0 +1,103 @@
+/*
+ * QEMU Cirrus CLGD 54xx VGA Emulator, ISA bus support
+ *
+ * Copyright (c) 2004 Fabrice Bellard
+ * Copyright (c) 2004 Makoto Suzuki (suzu)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef CIRRUS_VGA_INTERNAL_H
+#define CIRRUS_VGA_INTERNAL_H
+
+#include "vga_int.h"
+
+/* IDs */
+#define CIRRUS_ID_CLGD5422  (0x23 << 2)
+#define CIRRUS_ID_CLGD5426  (0x24 << 2)
+#define CIRRUS_ID_CLGD5424  (0x25 << 2)
+#define CIRRUS_ID_CLGD5428  (0x26 << 2)
+#define CIRRUS_ID_CLGD5430  (0x28 << 2)
+#define CIRRUS_ID_CLGD5434  (0x2A << 2)
+#define CIRRUS_ID_CLGD5436  (0x2B << 2)
+#define CIRRUS_ID_CLGD5446  (0x2E << 2)
+
+extern const VMStateDescription vmstate_cirrus_vga;
+
+struct CirrusVGAState;
+typedef void (*cirrus_bitblt_rop_t)(struct CirrusVGAState *s,
+                                    uint32_t dstaddr, uint32_t srcaddr,
+                                    int dstpitch, int srcpitch,
+                                    int bltwidth, int bltheight);
+
+typedef struct CirrusVGAState {
+    VGACommonState vga;
+
+    MemoryRegion cirrus_vga_io;
+    MemoryRegion cirrus_linear_io;
+    MemoryRegion cirrus_linear_bitblt_io;
+    MemoryRegion cirrus_mmio_io;
+    MemoryRegion pci_bar;
+    bool linear_vram;  /* vga.vram mapped over cirrus_linear_io */
+    MemoryRegion low_mem_container; /* container for 0xa0000-0xc0000 */
+    MemoryRegion low_mem;           /* always mapped, overridden by: */
+    MemoryRegion cirrus_bank[2];    /*   aliases at 0xa0000-0xb0000  */
+    uint32_t cirrus_addr_mask;
+    uint32_t linear_mmio_mask;
+    uint8_t cirrus_shadow_gr0;
+    uint8_t cirrus_shadow_gr1;
+    uint8_t cirrus_hidden_dac_lockindex;
+    uint8_t cirrus_hidden_dac_data;
+    uint32_t cirrus_bank_base[2];
+    uint32_t cirrus_bank_limit[2];
+    uint8_t cirrus_hidden_palette[48];
+    bool enable_blitter;
+    int cirrus_blt_pixelwidth;
+    int cirrus_blt_width;
+    int cirrus_blt_height;
+    int cirrus_blt_dstpitch;
+    int cirrus_blt_srcpitch;
+    uint32_t cirrus_blt_fgcol;
+    uint32_t cirrus_blt_bgcol;
+    uint32_t cirrus_blt_dstaddr;
+    uint32_t cirrus_blt_srcaddr;
+    uint8_t cirrus_blt_mode;
+    uint8_t cirrus_blt_modeext;
+    cirrus_bitblt_rop_t cirrus_rop;
+#define CIRRUS_BLTBUFSIZE (2048 * 4) /* one line width */
+    uint8_t cirrus_bltbuf[CIRRUS_BLTBUFSIZE];
+    uint8_t *cirrus_srcptr;
+    uint8_t *cirrus_srcptr_end;
+    uint32_t cirrus_srccounter;
+    /* hwcursor display state */
+    int last_hw_cursor_size;
+    int last_hw_cursor_x;
+    int last_hw_cursor_y;
+    int last_hw_cursor_y_start;
+    int last_hw_cursor_y_end;
+    int real_vram_size; /* XXX: suppress that */
+    int device_id;
+    int bustype;
+} CirrusVGAState;
+
+void cirrus_init_common(CirrusVGAState *s, Object *owner,
+                        int device_id, int is_pci,
+                        MemoryRegion *system_memory, MemoryRegion *system_io);
+
+#endif
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 04c87c8e8d..d9b854d74d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -33,8 +33,8 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "ui/pixel_ops.h"
-#include "vga_int.h"
 #include "hw/loader.h"
+#include "cirrus_vga_internal.h"
 
 /*
  * TODO:
@@ -52,16 +52,6 @@
  *
  ***************************************/
 
-// ID
-#define CIRRUS_ID_CLGD5422  (0x23<<2)
-#define CIRRUS_ID_CLGD5426  (0x24<<2)
-#define CIRRUS_ID_CLGD5424  (0x25<<2)
-#define CIRRUS_ID_CLGD5428  (0x26<<2)
-#define CIRRUS_ID_CLGD5430  (0x28<<2)
-#define CIRRUS_ID_CLGD5434  (0x2A<<2)
-#define CIRRUS_ID_CLGD5436  (0x2B<<2)
-#define CIRRUS_ID_CLGD5446  (0x2E<<2)
-
 // sequencer 0x07
 #define CIRRUS_SR7_BPP_VGA            0x00
 #define CIRRUS_SR7_BPP_SVGA           0x01
@@ -176,65 +166,10 @@
 
 #define CIRRUS_PNPMMIO_SIZE         0x1000
 
-struct CirrusVGAState;
-typedef void (*cirrus_bitblt_rop_t) (struct CirrusVGAState *s,
-                                     uint32_t dstaddr, uint32_t srcaddr,
-				     int dstpitch, int srcpitch,
-				     int bltwidth, int bltheight);
 typedef void (*cirrus_fill_t)(struct CirrusVGAState *s,
                               uint32_t dstaddr, int dst_pitch,
                               int width, int height);
 
-typedef struct CirrusVGAState {
-    VGACommonState vga;
-
-    MemoryRegion cirrus_vga_io;
-    MemoryRegion cirrus_linear_io;
-    MemoryRegion cirrus_linear_bitblt_io;
-    MemoryRegion cirrus_mmio_io;
-    MemoryRegion pci_bar;
-    bool linear_vram;  /* vga.vram mapped over cirrus_linear_io */
-    MemoryRegion low_mem_container; /* container for 0xa0000-0xc0000 */
-    MemoryRegion low_mem;           /* always mapped, overridden by: */
-    MemoryRegion cirrus_bank[2];    /*   aliases at 0xa0000-0xb0000  */
-    uint32_t cirrus_addr_mask;
-    uint32_t linear_mmio_mask;
-    uint8_t cirrus_shadow_gr0;
-    uint8_t cirrus_shadow_gr1;
-    uint8_t cirrus_hidden_dac_lockindex;
-    uint8_t cirrus_hidden_dac_data;
-    uint32_t cirrus_bank_base[2];
-    uint32_t cirrus_bank_limit[2];
-    uint8_t cirrus_hidden_palette[48];
-    bool enable_blitter;
-    int cirrus_blt_pixelwidth;
-    int cirrus_blt_width;
-    int cirrus_blt_height;
-    int cirrus_blt_dstpitch;
-    int cirrus_blt_srcpitch;
-    uint32_t cirrus_blt_fgcol;
-    uint32_t cirrus_blt_bgcol;
-    uint32_t cirrus_blt_dstaddr;
-    uint32_t cirrus_blt_srcaddr;
-    uint8_t cirrus_blt_mode;
-    uint8_t cirrus_blt_modeext;
-    cirrus_bitblt_rop_t cirrus_rop;
-#define CIRRUS_BLTBUFSIZE (2048 * 4) /* one line width */
-    uint8_t cirrus_bltbuf[CIRRUS_BLTBUFSIZE];
-    uint8_t *cirrus_srcptr;
-    uint8_t *cirrus_srcptr_end;
-    uint32_t cirrus_srccounter;
-    /* hwcursor display state */
-    int last_hw_cursor_size;
-    int last_hw_cursor_x;
-    int last_hw_cursor_y;
-    int last_hw_cursor_y_start;
-    int last_hw_cursor_y_end;
-    int real_vram_size; /* XXX: suppress that */
-    int device_id;
-    int bustype;
-} CirrusVGAState;
-
 typedef struct PCICirrusVGAState {
     PCIDevice dev;
     CirrusVGAState cirrus_vga;
@@ -244,16 +179,6 @@ typedef struct PCICirrusVGAState {
 #define PCI_CIRRUS_VGA(obj) \
     OBJECT_CHECK(PCICirrusVGAState, (obj), TYPE_PCI_CIRRUS_VGA)
 
-#define TYPE_ISA_CIRRUS_VGA "isa-cirrus-vga"
-#define ISA_CIRRUS_VGA(obj) \
-    OBJECT_CHECK(ISACirrusVGAState, (obj), TYPE_ISA_CIRRUS_VGA)
-
-typedef struct ISACirrusVGAState {
-    ISADevice parent_obj;
-
-    CirrusVGAState cirrus_vga;
-} ISACirrusVGAState;
-
 static uint8_t rop_to_index[256];
 
 /***************************************
@@ -2829,7 +2754,7 @@ static int cirrus_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_cirrus_vga = {
+const VMStateDescription vmstate_cirrus_vga = {
     .name = "cirrus_vga",
     .version_id = 2,
     .minimum_version_id = 1,
@@ -2932,10 +2857,9 @@ static const MemoryRegionOps cirrus_vga_io_ops = {
     },
 };
 
-static void cirrus_init_common(CirrusVGAState *s, Object *owner,
-                               int device_id, int is_pci,
-                               MemoryRegion *system_memory,
-                               MemoryRegion *system_io)
+void cirrus_init_common(CirrusVGAState *s, Object *owner,
+                        int device_id, int is_pci,
+                        MemoryRegion *system_memory, MemoryRegion *system_io)
 {
     int i;
     static int inited;
@@ -3031,62 +2955,6 @@ static void cirrus_init_common(CirrusVGAState *s, Object *owner,
 
 /***************************************
  *
- *  ISA bus support
- *
- ***************************************/
-
-static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
-{
-    ISADevice *isadev = ISA_DEVICE(dev);
-    ISACirrusVGAState *d = ISA_CIRRUS_VGA(dev);
-    VGACommonState *s = &d->cirrus_vga.vga;
-
-    /* follow real hardware, cirrus card emulated has 4 MB video memory.
-       Also accept 8 MB/16 MB for backward compatibility. */
-    if (s->vram_size_mb != 4 && s->vram_size_mb != 8 &&
-        s->vram_size_mb != 16) {
-        error_setg(errp, "Invalid cirrus_vga ram size '%u'",
-                   s->vram_size_mb);
-        return;
-    }
-    s->global_vmstate = true;
-    vga_common_init(s, OBJECT(dev));
-    cirrus_init_common(&d->cirrus_vga, OBJECT(dev), CIRRUS_ID_CLGD5430, 0,
-                       isa_address_space(isadev),
-                       isa_address_space_io(isadev));
-    s->con = graphic_console_init(dev, 0, s->hw_ops, s);
-    rom_add_vga(VGABIOS_CIRRUS_FILENAME);
-    /* XXX ISA-LFB support */
-    /* FIXME not qdev yet */
-}
-
-static Property isa_cirrus_vga_properties[] = {
-    DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
-                       cirrus_vga.vga.vram_size_mb, 4),
-    DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
-                     cirrus_vga.enable_blitter, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd  = &vmstate_cirrus_vga;
-    dc->realize = isa_cirrus_vga_realizefn;
-    dc->props = isa_cirrus_vga_properties;
-    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-}
-
-static const TypeInfo isa_cirrus_vga_info = {
-    .name          = TYPE_ISA_CIRRUS_VGA,
-    .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(ISACirrusVGAState),
-    .class_init = isa_cirrus_vga_class_init,
-};
-
-/***************************************
- *
  *  PCI bus support
  *
  ***************************************/
@@ -3171,7 +3039,6 @@ static const TypeInfo cirrus_vga_info = {
 
 static void cirrus_vga_register_types(void)
 {
-    type_register_static(&isa_cirrus_vga_info);
     type_register_static(&cirrus_vga_info);
 }
 
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
new file mode 100644
index 0000000000..fa10b74230
--- /dev/null
+++ b/hw/display/cirrus_vga_isa.c
@@ -0,0 +1,98 @@
+/*
+ * QEMU Cirrus CLGD 54xx VGA Emulator, ISA bus support
+ *
+ * Copyright (c) 2004 Fabrice Bellard
+ * Copyright (c) 2004 Makoto Suzuki (suzu)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/loader.h"
+#include "hw/isa/isa.h"
+#include "cirrus_vga_internal.h"
+
+#define TYPE_ISA_CIRRUS_VGA "isa-cirrus-vga"
+#define ISA_CIRRUS_VGA(obj) \
+    OBJECT_CHECK(ISACirrusVGAState, (obj), TYPE_ISA_CIRRUS_VGA)
+
+typedef struct ISACirrusVGAState {
+    ISADevice parent_obj;
+
+    CirrusVGAState cirrus_vga;
+} ISACirrusVGAState;
+
+static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    ISACirrusVGAState *d = ISA_CIRRUS_VGA(dev);
+    VGACommonState *s = &d->cirrus_vga.vga;
+
+    /* follow real hardware, cirrus card emulated has 4 MB video memory.
+       Also accept 8 MB/16 MB for backward compatibility. */
+    if (s->vram_size_mb != 4 && s->vram_size_mb != 8 &&
+        s->vram_size_mb != 16) {
+        error_setg(errp, "Invalid cirrus_vga ram size '%u'",
+                   s->vram_size_mb);
+        return;
+    }
+    s->global_vmstate = true;
+    vga_common_init(s, OBJECT(dev));
+    cirrus_init_common(&d->cirrus_vga, OBJECT(dev), CIRRUS_ID_CLGD5430, 0,
+                       isa_address_space(isadev),
+                       isa_address_space_io(isadev));
+    s->con = graphic_console_init(dev, 0, s->hw_ops, s);
+    rom_add_vga(VGABIOS_CIRRUS_FILENAME);
+    /* XXX ISA-LFB support */
+    /* FIXME not qdev yet */
+}
+
+static Property isa_cirrus_vga_properties[] = {
+    DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
+                       cirrus_vga.vga.vram_size_mb, 4),
+    DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
+                     cirrus_vga.enable_blitter, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd  = &vmstate_cirrus_vga;
+    dc->realize = isa_cirrus_vga_realizefn;
+    dc->props = isa_cirrus_vga_properties;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo isa_cirrus_vga_info = {
+    .name          = TYPE_ISA_CIRRUS_VGA,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ISACirrusVGAState),
+    .class_init = isa_cirrus_vga_class_init,
+};
+
+static void cirrus_vga_isa_register_types(void)
+{
+    type_register_static(&isa_cirrus_vga_info);
+}
+
+type_init(cirrus_vga_isa_register_types)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 2e1b1bcd22..97acd5b6cb 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
 
 common-obj-$(CONFIG_ADS7846) += ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
+common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=cirrus_vga_isa.o
 common-obj-$(CONFIG_G364FB) += g364fb.o
 common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
 common-obj-$(CONFIG_PL110) += pl110.o
-- 
2.9.3
