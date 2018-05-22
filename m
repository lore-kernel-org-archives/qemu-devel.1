Received: from eggs.gnu.org ([2001:4830:134:3::10]:53323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV9-0005wr-3l
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLAV7-0007uP-Gd
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLAV7-0007u5-BH
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9DE1BB402
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 16:51:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 May 2018 18:50:55 +0200
Message-Id: <20180522165058.15404-4-kraxel@redhat.com>
In-Reply-To: <20180522165058.15404-1-kraxel@redhat.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] hw/display: add new bochs-display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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

Compatibility wise it works with OVMF (latest git master).
The bochs-drm.ko linux kernel module can handle it just fine too.
So UEFI guests should not see any functional difference to VGA.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/bochs-display.c | 325 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/display/Makefile.objs   |   1 +
 2 files changed, 326 insertions(+)
 create mode 100644 hw/display/bochs-display.c

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
new file mode 100644
index 0000000000..a523e81d1d
--- /dev/null
+++ b/hw/display/bochs-display.c
@@ -0,0 +1,325 @@
+/*
+ * QEMU PCI bochs display adapter.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+static const VMStateDescription vmstate_bochs_display =3D {
+    .name =3D "bochs-display",
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pci, BochsDisplayState),
+        VMSTATE_UINT16_ARRAY(vbe_regs, BochsDisplayState, VBE_DISPI_INDE=
X_NB),
+        VMSTATE_BOOL(big_endian_fb, BochsDisplayState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static uint64_t bochs_display_vbe_read(void *ptr, hwaddr addr,
+                                       unsigned size)
+{
+    BochsDisplayState *s =3D ptr;
+    unsigned int index =3D addr >> 1;
+
+    switch (index) {
+    case VBE_DISPI_INDEX_ID:
+        return VBE_DISPI_ID5;
+    case VBE_DISPI_INDEX_VIDEO_MEMORY_64K:
+        return s->vgamem / (64 * 1024);
+    }
+
+    if (index >=3D ARRAY_SIZE(s->vbe_regs)) {
+        return -1;
+    }
+    return s->vbe_regs[index];
+}
+
+static void bochs_display_vbe_write(void *ptr, hwaddr addr,
+                                    uint64_t val, unsigned size)
+{
+    BochsDisplayState *s =3D ptr;
+    unsigned int index =3D addr >> 1;
+
+    if (index >=3D ARRAY_SIZE(s->vbe_regs)) {
+        return;
+    }
+    s->vbe_regs[index] =3D val;
+}
+
+static const MemoryRegionOps bochs_display_vbe_ops =3D {
+    .read =3D bochs_display_vbe_read,
+    .write =3D bochs_display_vbe_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .impl.min_access_size =3D 2,
+    .impl.max_access_size =3D 2,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t bochs_display_qext_read(void *ptr, hwaddr addr,
+                                        unsigned size)
+{
+    BochsDisplayState *s =3D ptr;
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
+    BochsDisplayState *s =3D ptr;
+
+    switch (addr) {
+    case PCI_VGA_QEXT_REG_BYTEORDER:
+        if (val =3D=3D PCI_VGA_QEXT_BIG_ENDIAN) {
+            s->big_endian_fb =3D true;
+        }
+        if (val =3D=3D PCI_VGA_QEXT_LITTLE_ENDIAN) {
+            s->big_endian_fb =3D false;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps bochs_display_qext_ops =3D {
+    .read =3D bochs_display_qext_read,
+    .write =3D bochs_display_qext_write,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static int bochs_display_get_mode(BochsDisplayState *s,
+                                   BochsDisplayMode *mode)
+{
+    uint16_t *vbe =3D s->vbe_regs;
+    uint32_t virt_width;
+
+    if (!(vbe[VBE_DISPI_INDEX_ENABLE] & VBE_DISPI_ENABLED)) {
+        return -1;
+    }
+
+    memset(mode, 0, sizeof(*mode));
+    switch (vbe[VBE_DISPI_INDEX_BPP]) {
+    case 16:
+        /* best effort: support native endianess only */
+        mode->format =3D PIXMAN_r5g6b5;
+        mode->bytepp =3D 2;
+    case 32:
+        mode->format =3D s->big_endian_fb
+            ? PIXMAN_BE_x8r8g8b8
+            : PIXMAN_LE_x8r8g8b8;
+        mode->bytepp =3D 4;
+        break;
+    default:
+        return -1;
+    }
+
+    mode->width  =3D vbe[VBE_DISPI_INDEX_XRES];
+    mode->height =3D vbe[VBE_DISPI_INDEX_YRES];
+    virt_width  =3D vbe[VBE_DISPI_INDEX_VIRT_WIDTH];
+    if (virt_width < mode->width) {
+        virt_width =3D mode->width;
+    }
+    mode->stride =3D virt_width * mode->bytepp;
+    mode->size   =3D (uint64_t)mode->stride * mode->height;
+    mode->offset =3D ((uint64_t)vbe[VBE_DISPI_INDEX_X_OFFSET] * mode->by=
tepp +
+                    (uint64_t)vbe[VBE_DISPI_INDEX_Y_OFFSET] * mode->stri=
de);
+
+    if (mode->width < 64 || mode->height < 64) {
+        return -1;
+    }
+    if (mode->offset + mode->size > s->vgamem) {
+        return -1;
+    }
+    return 0;
+}
+
+static void bochs_display_update(void *opaque)
+{
+    BochsDisplayState *s =3D opaque;
+    BochsDisplayMode mode;
+    DisplaySurface *ds;
+    uint8_t *ptr;
+    int ret;
+
+    ret =3D bochs_display_get_mode(s, &mode);
+    if (ret < 0) {
+        /* no (valid) video mode */
+        return;
+    }
+
+    if (memcmp(&s->mode, &mode, sizeof(mode)) !=3D 0) {
+        /* video mode switch */
+        s->mode =3D mode;
+        ptr =3D memory_region_get_ram_ptr(&s->vram);
+        ds =3D qemu_create_displaysurface_from(mode.width,
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
+static const GraphicHwOps bochs_display_gfx_ops =3D {
+    .gfx_update =3D bochs_display_update,
+};
+
+static void bochs_display_realize(PCIDevice *dev, Error **errp)
+{
+    BochsDisplayState *s =3D BOCHS_DISPLAY(dev);
+    Object *obj =3D OBJECT(dev);
+
+    s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_o=
ps, s);
+
+    if (s->vgamem < (4 * 1024 * 1024)) {
+        error_setg(errp, "bochs-display: video memory too small");
+    }
+    if (s->vgamem > (256 * 1024 * 1024)) {
+        error_setg(errp, "bochs-display: video memory too big");
+    }
+    s->vgamem =3D pow2ceil(s->vgamem);
+
+    memory_region_init_ram(&s->vram, obj, "bochs-display-vram", s->vgame=
m,
+                           &error_fatal);
+    memory_region_init_io(&s->vbe, obj, &bochs_display_vbe_ops, s,
+                          "bochs dispi interface", PCI_VGA_BOCHS_SIZE);
+    memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
+                          "qemu extended regs", PCI_VGA_QEXT_SIZE);
+
+    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
+                       PCI_VGA_MMIO_SIZE);
+    memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe)=
;
+    memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext)=
;
+
+    pci_set_byte(&s->pci.config[PCI_REVISION_ID], 2);
+    pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram=
);
+    pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio=
);
+}
+
+static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
+{
+    BochsDisplayState *s =3D BOCHS_DISPLAY(obj);
+
+    return s->big_endian_fb;
+}
+
+static void bochs_display_set_big_endian_fb(Object *obj, bool value,
+                                            Error **errp)
+{
+    BochsDisplayState *s =3D BOCHS_DISPLAY(obj);
+
+    s->big_endian_fb =3D value;
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
+    BochsDisplayState *s =3D BOCHS_DISPLAY(dev);
+
+    graphic_console_close(s->con);
+}
+
+static Property bochs_display_properties[] =3D {
+    DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * 1024 * 10=
24),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bochs_display_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->class_id  =3D PCI_CLASS_DISPLAY_OTHER;
+    k->vendor_id =3D PCI_VENDOR_ID_QEMU;
+    k->device_id =3D PCI_DEVICE_ID_QEMU_VGA;
+
+    k->realize   =3D bochs_display_realize;
+    k->exit      =3D bochs_display_exit;
+    dc->vmsd     =3D &vmstate_bochs_display;
+    dc->props    =3D bochs_display_properties;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo bochs_display_type_info =3D {
+    .name           =3D TYPE_BOCHS_DISPLAY,
+    .parent         =3D TYPE_PCI_DEVICE,
+    .instance_size  =3D sizeof(BochsDisplayState),
+    .instance_init  =3D bochs_display_init,
+    .class_init     =3D bochs_display_class_init,
+    .interfaces     =3D (InterfaceInfo[]) {
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
index 11321e466b..d907b381ae 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_SSD0323) +=3D ssd0323.o
 common-obj-$(CONFIG_XEN) +=3D xenfb.o
=20
 common-obj-$(CONFIG_VGA_PCI) +=3D vga-pci.o
+common-obj-$(CONFIG_VGA_PCI) +=3D bochs-display.o
 common-obj-$(CONFIG_VGA_ISA) +=3D vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) +=3D vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) +=3D vmware_vga.o
--=20
2.9.3
