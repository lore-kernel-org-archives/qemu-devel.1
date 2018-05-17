Received: from eggs.gnu.org ([2001:4830:134:3::10]:36072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJFA1-0006Ok-Iq
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJF9w-0004WX-7Y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJF9w-0004W7-0A
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2E3381663C0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:25:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 May 2018 11:25:11 +0200
Message-Id: <20180517092513.735-3-kraxel@redhat.com>
In-Reply-To: <20180517092513.735-1-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] display: add new bochs-display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

After writing up the virtual mdev device emulating a display supporting
the bochs vbe dispi interface (mbochs.ko) and seeing how simple it
actually is I've figured that would be useful for qemu too.

So, here it is, -device bochs-display.  It is basically -device VGA
without legacy vga emulation.  PCI bar 0 is the framebuffer, PCI bar 2
is mmio with the registers.  The vga registers are simply not there
though, neither in the legacy ioport location nor in the mmio bar.
Consequently it is PCI class DISPLAY_OTHER not DISPLAY_VGA.

So there is no text mode emulation, no weird video modes (planar,
256color palette), no memory window at 0xa0000.  Just a linear
framebuffer in the pci memory bar.  And the amount of code to emulate
this (and therefore the attack surface) is an order of magnitude smaller
when compared to vga emulation.

Compatibility wise it almost works with OVMF (little tweak needed).
The bochs-drm.ko linux kernel module can handle it just fine too.
So once the OVMF fix is merged UEFI guests should not see any
functional difference to VGA.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 323 +++++++++++++++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs   |   1 +
 2 files changed, 324 insertions(+)
 create mode 100644 hw/display/bochs-display.c

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
new file mode 100644
index 0000000000..beeda58475
--- /dev/null
+++ b/hw/display/bochs-display.c
@@ -0,0 +1,323 @@
+/*
+ * QEMU PCI bochs display adapter.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/display/bochs-vbe.h"
+
+#include "qapi/error.h"
+
+#include "ui/console.h"
+#include "ui/qemu-pixman.h"
+
+typedef struct BochsDisplayMode {
+    pixman_format_code_t format;
+    uint32_t             bytepp;
+    uint32_t             width;
+    uint32_t             height;
+    uint32_t             stride;
+    uint32_t             __pad;
+    uint64_t             offset;
+    uint64_t             size;
+} BochsDisplayMode;
+
+typedef struct BochsDisplayState {
+    /* parent */
+    PCIDevice        pci;
+
+    /* device elements */
+    QemuConsole      *con;
+    MemoryRegion     vram;
+    MemoryRegion     mmio;
+    MemoryRegion     vbe;
+    MemoryRegion     qext;
+
+    /* device config */
+    uint64_t         vgamem;
+
+    /* device registers */
+    uint16_t         vbe_regs[VBE_DISPI_INDEX_NB];
+    bool             big_endian_fb;
+
+    /* device state */
+    BochsDisplayMode mode;
+} BochsDisplayState;
+
+#define TYPE_BOCHS_DISPLAY "bochs-display"
+#define BOCHS_DISPLAY(obj) OBJECT_CHECK(BochsDisplayState, (obj), \
+                                        TYPE_BOCHS_DISPLAY)
+
+static const VMStateDescription vmstate_bochs_display = {
+    .name = "bochs-display",
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pci, BochsDisplayState),
+        VMSTATE_UINT16_ARRAY(vbe_regs, BochsDisplayState, VBE_DISPI_INDEX_NB),
+        VMSTATE_BOOL(big_endian_fb, BochsDisplayState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static uint64_t bochs_display_vbe_read(void *ptr, hwaddr addr,
+                                       unsigned size)
+{
+    BochsDisplayState *s = ptr;
+    unsigned int index = addr >> 1;
+
+    switch (index) {
+    case VBE_DISPI_INDEX_ID:
+        return VBE_DISPI_ID5;
+    case VBE_DISPI_INDEX_VIDEO_MEMORY_64K:
+        return s->vgamem / (64 * 1024);
+    }
+
+    if (index >= ARRAY_SIZE(s->vbe_regs)) {
+        return -1;
+    }
+    return s->vbe_regs[index];
+}
+
+static void bochs_display_vbe_write(void *ptr, hwaddr addr,
+                                    uint64_t val, unsigned size)
+{
+    BochsDisplayState *s = ptr;
+    unsigned int index = addr >> 1;
+
+    if (index >= ARRAY_SIZE(s->vbe_regs)) {
+        return;
+    }
+    s->vbe_regs[index] = val;
+}
+
+static const MemoryRegionOps bochs_display_vbe_ops = {
+    .read = bochs_display_vbe_read,
+    .write = bochs_display_vbe_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 2,
+    .impl.max_access_size = 2,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t bochs_display_qext_read(void *ptr, hwaddr addr,
+                                        unsigned size)
+{
+    BochsDisplayState *s = ptr;
+
+    switch (addr) {
+    case PCI_VGA_QEXT_REG_SIZE:
+        return PCI_VGA_QEXT_SIZE;
+    case PCI_VGA_QEXT_REG_BYTEORDER:
+        return s->big_endian_fb ?
+            PCI_VGA_QEXT_BIG_ENDIAN : PCI_VGA_QEXT_LITTLE_ENDIAN;
+    default:
+        return 0;
+    }
+}
+
+static void bochs_display_qext_write(void *ptr, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    BochsDisplayState *s = ptr;
+
+    switch (addr) {
+    case PCI_VGA_QEXT_REG_BYTEORDER:
+        if (val == PCI_VGA_QEXT_BIG_ENDIAN) {
+            s->big_endian_fb = true;
+        }
+        if (val == PCI_VGA_QEXT_LITTLE_ENDIAN) {
+            s->big_endian_fb = false;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps bochs_display_qext_ops = {
+    .read = bochs_display_qext_read,
+    .write = bochs_display_qext_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void bochs_display_get_mode(BochsDisplayState *s,
+                                   BochsDisplayMode *mode)
+{
+    uint16_t *vbe = s->vbe_regs;
+    uint32_t virt_width;
+
+    if (!(vbe[VBE_DISPI_INDEX_ENABLE] & VBE_DISPI_ENABLED))
+        goto nofb;
+
+    memset(mode, 0, sizeof(*mode));
+    switch (vbe[VBE_DISPI_INDEX_BPP]) {
+    case 16:
+        /* best effort: support native endianess only */
+        mode->format = PIXMAN_r5g6b5;
+        mode->bytepp = 2;
+    case 32:
+        mode->format = s->big_endian_fb ? PIXMAN_BE_x8r8g8b8 : PIXMAN_LE_x8r8g8b8;
+        mode->bytepp = 4;
+        break;
+    default:
+        goto nofb;
+    }
+
+    mode->width  = vbe[VBE_DISPI_INDEX_XRES];
+    mode->height = vbe[VBE_DISPI_INDEX_YRES];
+    virt_width  = vbe[VBE_DISPI_INDEX_VIRT_WIDTH];
+    if (virt_width < mode->width)
+        virt_width = mode->width;
+    mode->stride = virt_width * mode->bytepp;
+    mode->size   = (uint64_t)mode->stride * mode->height;
+    mode->offset = ((uint64_t)vbe[VBE_DISPI_INDEX_X_OFFSET] * mode->bytepp +
+                    (uint64_t)vbe[VBE_DISPI_INDEX_Y_OFFSET] * mode->stride);
+
+    if (mode->width < 64 || mode->height < 64) {
+        goto nofb;
+    }
+    if (mode->offset + mode->size > s->vgamem) {
+        goto nofb;
+    }
+    return;
+
+nofb:
+    memset(mode, 0, sizeof(*mode));
+    return;
+}
+
+static void bochs_display_update(void *opaque)
+{
+    BochsDisplayState *s = opaque;
+    BochsDisplayMode mode;
+    DisplaySurface *ds;
+    uint8_t *ptr;
+
+    bochs_display_get_mode(s, &mode);
+    if (!mode.size) {
+        /* no (valid) video mode */
+        return;
+    }
+
+    if (memcmp(&s->mode, &mode, sizeof(mode)) != 0) {
+        /* video mode switch */
+        s->mode = mode;
+        ptr = memory_region_get_ram_ptr(&s->vram);
+        ds = qemu_create_displaysurface_from(mode.width,
+                                             mode.height,
+                                             mode.format,
+                                             mode.stride,
+                                             ptr + mode.offset);
+        dpy_gfx_replace_surface(s->con, ds);
+    }
+
+    dpy_gfx_update_full(s->con);
+}
+
+static const GraphicHwOps bochs_display_gfx_ops = {
+    .gfx_update = bochs_display_update,
+};
+
+static void bochs_display_realize(PCIDevice *dev, Error **errp)
+{
+    BochsDisplayState *s = BOCHS_DISPLAY(dev);
+    Object *obj = OBJECT(dev);
+
+    s->con = graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_ops, s);
+
+    if (s->vgamem < (4 * 1024 * 1024)) {
+        error_setg(errp, "bochs-display: video memory too small");
+    }
+    if (s->vgamem > (256 * 1024 * 1024)) {
+        error_setg(errp, "bochs-display: video memory too big");
+    }
+    s->vgamem = pow2ceil(s->vgamem);
+
+    memory_region_init_ram(&s->vram, obj, "bochs-display-vram", s->vgamem,
+                           &error_fatal);
+    memory_region_init_io(&s->vbe, obj, &bochs_display_vbe_ops, s,
+                          "bochs dispi interface", PCI_VGA_BOCHS_SIZE);
+    memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
+                          "qemu extended regs", PCI_VGA_QEXT_SIZE);
+
+    memory_region_init(&s->mmio, obj, "bochs-display-mmio", 4096);
+    memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
+    memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
+
+    pci_set_byte(&s->pci.config[PCI_REVISION_ID], 2);
+    pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
+    pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
+}
+
+static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
+{
+    BochsDisplayState *s = BOCHS_DISPLAY(obj);
+
+    return s->big_endian_fb;
+}
+
+static void bochs_display_set_big_endian_fb(Object *obj, bool value, Error **errp)
+{
+    BochsDisplayState *s = BOCHS_DISPLAY(obj);
+
+    s->big_endian_fb = value;
+}
+
+static void bochs_display_init(Object *obj)
+{
+    /* Expose framebuffer byteorder via QOM */
+    object_property_add_bool(obj, "big-endian-framebuffer",
+                             bochs_display_get_big_endian_fb,
+                             bochs_display_set_big_endian_fb,
+                             NULL);
+}
+
+static void bochs_display_exit(PCIDevice *dev)
+{
+    BochsDisplayState *s = BOCHS_DISPLAY(dev);
+
+    graphic_console_close(s->con);
+}
+
+static Property bochs_display_properties[] = {
+    DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * 1024 * 1024),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bochs_display_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->class_id  = PCI_CLASS_DISPLAY_OTHER;
+    k->vendor_id = PCI_VENDOR_ID_QEMU;
+    k->device_id = PCI_DEVICE_ID_QEMU_VGA;
+
+    k->realize   = bochs_display_realize;
+    k->exit      = bochs_display_exit;
+    dc->vmsd     = &vmstate_bochs_display;
+    dc->props    = bochs_display_properties;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo bochs_display_type_info = {
+    .name           = TYPE_BOCHS_DISPLAY,
+    .parent         = TYPE_PCI_DEVICE,
+    .instance_size  = sizeof(BochsDisplayState),
+    .instance_init  = bochs_display_init,
+    .class_init     = bochs_display_class_init,
+    .interfaces     = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void bochs_display_register_types(void)
+{
+    type_register_static(&bochs_display_type_info);
+}
+
+type_init(bochs_display_register_types)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 3c7c75b94d..1181c4a72b 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_SSD0323) += ssd0323.o
 common-obj-$(CONFIG_XEN) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
+common-obj-$(CONFIG_VGA_PCI) += bochs-display.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
-- 
2.9.3
