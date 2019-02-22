Received: from eggs.gnu.org ([209.51.188.92]:48762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx9NA-0003l0-0d
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx9N8-0003MT-3I
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:52:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx9N7-00036C-Ep
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:52:05 -0500
Date: Fri, 22 Feb 2019 12:51:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190222115146.e4e5jlbwlysx433f@sirius.home.kraxel.org>
References: <20190221150353.93DE87465DE@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="p3k6dl3mukj6pywd"
Content-Disposition: inline
In-Reply-To: <20190221150353.93DE87465DE@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, philmd@redhat.com


--p3k6dl3mukj6pywd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 21, 2019 at 03:55:14PM +0100, BALATON Zoltan wrote:
> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
> guests running on these and the PMON2000 firmware of the fulong2e
> expect this to be available. Fortunately these are very similar chips
> so they can be mostly emulated in the same device model. This patch
> adds basic emulation of these ATI VGA chips.
> 
> While this is incomplete and currently only enough to run the MIPS
> firmware and get framebuffer output with Linux, it allows the fulong2e
> board to work more like the real hardware and having it in QEMU in
> this state provides a way to experiment with it and allows others to
> contribute to improve it. It is compiled for all archs but only the
> fulong2e (which currently has no display output at all) is set to use
> it by default (in a patch sent separately).

Attached patch creates two separate devices.  It's just some QOM
boilerplate, they still share 95% of the code.  With that in place
vgabios works just fine for both devices.

On x86 linux:  Fedora live iso happily boots X on both devices, they both
are running with the vesa xorg driver though so that doesn't say much.

With a self-compiled kernel:
aty128fb.ko seems to be able to handle the rage128pro.

Neither radeonfb.ko nor radeon.ko (drm driver) can handle the rv100.
Loading radeonfb results in a kernel panic.  radeon.ko prints an
initialization error.  Seems at least radeonfb tries to pull some info
out of the bios image ...

cheers,
  Gerd


--p3k6dl3mukj6pywd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-ati-vga-add-per-model-types.patch"

>From 465dab28c40c6296065cb991c771e48882ba484c Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 11:15:03 +0100
Subject: [PATCH] ati-vga: add per model types

---
 hw/display/ati_int.h  |  3 +-
 hw/display/ati_regs.h |  1 +
 hw/display/ati.c      | 80 +++++++++++++++++++++++++++++++++++----------------
 vl.c                  |  3 +-
 4 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index c443448c1222..8d3d65198795 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -18,7 +18,7 @@
 #define DPRINTF(fmt, ...) do {} while (0)
 #endif
 
-#define TYPE_ATI_VGA "ati-vga"
+#define TYPE_ATI_VGA "ati-vga-base"
 #define ATI_VGA(obj) OBJECT_CHECK(ATIVGAState, (obj), TYPE_ATI_VGA)
 
 typedef struct ATIVGARegs {
@@ -63,7 +63,6 @@ typedef struct ATIVGARegs {
 typedef struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
-    uint16_t dev_id;
     uint16_t mode;
     MemoryRegion io;
     MemoryRegion mm;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 0550637a9fde..589f58965cdf 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -212,6 +212,7 @@
 #define DP_WRITE_MASK                           0x16cc
 #define DP_CNTL_XDIR_YDIR_YMAJOR                0x16d0
 #define DEFAULT_OFFSET                          0x16e0
+#undef DEFAULT_PITCH /* needed for mingw builds */
 #define DEFAULT_PITCH                           0x16e4
 #define DEFAULT_SC_BOTTOM_RIGHT                 0x16e8
 #define SC_TOP_LEFT                             0x16ec
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 249123acad86..d70266b04e31 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -33,6 +33,18 @@
 
 enum { VGA_MODE, EXT_MODE };
 
+static bool ati_is_rage128pro(ATIVGAState *s)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(&s->dev);
+    return pc->device_id == PCI_DEVICE_ID_ATI_RAGE128_PF;
+}
+
+static bool ati_is_rv100(ATIVGAState *s)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(&s->dev);
+    return pc->device_id == PCI_DEVICE_ID_ATI_RADEON_QY;
+}
+
 static void ati_vga_switch_mode(ATIVGAState *s)
 {
     DPRINTF("%d -> %d\n",
@@ -148,7 +160,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
         i = (addr - BIOS_0_SCRATCH) / 4;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
+        if (ati_is_rage128pro(s) && i > 3) {
             break;
         }
         val = ati_reg_read_offs(s->regs.bios_scratch[i],
@@ -213,7 +225,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case DST_PITCH:
         val = s->regs.dst_pitch;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_is_rage128pro(s)) {
             val &= s->regs.dst_tile << 16;
         }
         break;
@@ -317,7 +329,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
         i = (addr - BIOS_0_SCRATCH) / 4;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF && i > 3) {
+        if (ati_is_rage128pro(s) && i > 3) {
             break;
         }
         ati_reg_write_offs(&s->regs.bios_scratch[i],
@@ -394,12 +406,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_PITCH:
         s->regs.dst_pitch = data & 0x3ff0;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_is_rage128pro(s)) {
             s->regs.dst_tile = (data >> 16) & 1;
         }
         break;
     case DST_TILE:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
+        if (ati_is_rv100(s)) {
             s->regs.dst_tile = data & 3;
         }
         break;
@@ -423,7 +435,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dst_y = data & 0x3fff;
         break;
     case SRC_PITCH_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_is_rage128pro(s)) {
             s->regs.src_offset = (data & 0x1fffe0) << 5;
             s->regs.src_pitch = (data >> 21) & 0x3ff;
             s->regs.src_tile = data >> 31;
@@ -434,7 +446,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DST_PITCH_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_is_rage128pro(s)) {
             s->regs.dst_offset = (data & 0x1fffe0) << 5;
             s->regs.dst_pitch = (data >> 21) & 0x3ff;
             s->regs.dst_tile = data >> 31;
@@ -504,12 +516,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_write_mask = data;
         break;
     case DEFAULT_OFFSET:
-        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+        data &= (ati_is_rage128pro(s) ?
                  0x03fffc00 : 0xfffffc00);
         s->regs.default_offset = data;
         break;
     case DEFAULT_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+        if (ati_is_rage128pro(s)) {
             s->regs.default_pitch = data & 0x103ff;
         }
         break;
@@ -532,13 +544,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
 
-    if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF &&
-        s->dev_id != PCI_DEVICE_ID_ATI_RADEON_QY) {
-        error_setg(errp, "Unknown ATI VGA device id, "
-                   "only 0x5046 and 0x5159 are supported");
-        return;
-    }
-    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY &&
+    if (ati_is_rv100(s) &&
         s->vga.vram_size_mb < 16) {
         warn_report("Too small video memory for device id");
         s->vga.vram_size_mb = 16;
@@ -564,9 +570,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 static void ati_vga_reset(DeviceState *dev)
 {
     ATIVGAState *s = ATI_VGA(dev);
-    PCIDevice *pd = PCI_DEVICE(dev);
 
-    pci_set_word(pd->config + PCI_DEVICE_ID, s->dev_id);
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
@@ -581,12 +585,10 @@ static void ati_vga_exit(PCIDevice *dev)
 
 static Property ati_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ATIVGAState, vga.vram_size_mb, 16),
-    DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
-                       PCI_DEVICE_ID_ATI_RAGE128_PF),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void ati_vga_class_init(ObjectClass *klass, void *data)
+static void ati_vga_base_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -598,26 +600,54 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
 
     k->class_id = PCI_CLASS_DISPLAY_VGA;
     k->vendor_id = PCI_VENDOR_ID_ATI;
-    k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
     k->romfile = "vgabios-stdvga.bin";
     k->realize = ati_vga_realize;
     k->exit = ati_vga_exit;
 }
 
-static const TypeInfo ati_vga_info = {
+static const TypeInfo ati_vga_base_info = {
     .name = TYPE_ATI_VGA,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(ATIVGAState),
-    .class_init = ati_vga_class_init,
+    .class_init = ati_vga_base_class_init,
+    .abstract = true,
     .interfaces = (InterfaceInfo[]) {
           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
           { },
     },
 };
 
+static void ati_rage128pro_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->device_id = PCI_DEVICE_ID_ATI_RAGE128_PF;
+}
+
+static const TypeInfo ati_rage128pro_info = {
+    .name          = "ati-rage128pro",
+    .parent        = TYPE_ATI_VGA,
+    .class_init    = ati_rage128pro_class_init,
+};
+
+static void ati_rv100_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->device_id = PCI_DEVICE_ID_ATI_RADEON_QY;
+}
+
+static const TypeInfo ati_rv100_info = {
+    .name          = "ati-rv100",
+    .parent        = TYPE_ATI_VGA,
+    .class_init    = ati_rv100_class_init,
+};
+
 static void ati_vga_register_types(void)
 {
-    type_register_static(&ati_vga_info);
+    type_register_static(&ati_vga_base_info);
+    type_register_static(&ati_rage128pro_info);
+    type_register_static(&ati_rv100_info);
 }
 
 type_init(ati_vga_register_types)
diff --git a/vl.c b/vl.c
index f0b4fd95f806..04e95a1fdcb5 100644
--- a/vl.c
+++ b/vl.c
@@ -240,7 +240,8 @@ static struct {
     { .driver = "vmware-svga",          .flag = &default_vga       },
     { .driver = "qxl-vga",              .flag = &default_vga       },
     { .driver = "virtio-vga",           .flag = &default_vga       },
-    { .driver = "ati-vga",              .flag = &default_vga       },
+    { .driver = "ati-rage128pro",       .flag = &default_vga       },
+    { .driver = "ati-rv100",            .flag = &default_vga       },
 };
 
 static QemuOptsList qemu_rtc_opts = {
-- 
2.9.3


--p3k6dl3mukj6pywd--
