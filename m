Received: from eggs.gnu.org ([2001:4830:134:3::10]:55496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OU-0005Q3-4z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g04OS-0006rR-1P
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g04OR-0006qn-O0
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BF90C02C733
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 12:37:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Sep 2018 14:37:00 +0200
Message-Id: <20180912123700.7708-3-kraxel@redhat.com>
In-Reply-To: <20180912123700.7708-1-kraxel@redhat.com>
References: <20180912123700.7708-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] display/stdvga: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This patch adds edid support to the qemu stdvga.  It is turned off by
default and can be enabled with the new edid property.  The patch also
adds xres and yres properties to specify the video mode you want the
guest use.  Works only with edid enabled and updated guest driver.

The mmio bar of the stdvga has some unused address space at the start.
It was reserved just in case it'll be needed for virtio, but it turned
out to not be needed for that.  So lets use that region to place the
EDID data block there.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/standard-vga.txt |  2 +-
 hw/display/vga_int.h        |  2 +-
 hw/display/vga-pci.c        | 42 ++++++++++++++++++++++++++++++++++++++----
 hw/display/virtio-vga.c     |  2 +-
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/docs/specs/standard-vga.txt b/docs/specs/standard-vga.txt
index 19d2a74509..18f75f1b30 100644
--- a/docs/specs/standard-vga.txt
+++ b/docs/specs/standard-vga.txt
@@ -61,7 +61,7 @@ MMIO area spec
 
 Likewise applies to the pci variant only for obvious reasons.
 
-0000 - 03ff : reserved, for possible virtio extension.
+0000 - 03ff : edid data blob.
 0400 - 041f : vga ioports (0x3c0 -> 0x3df), remapped 1:1.
               word access is supported, bytes are written
               in little endia order (aka index port first),
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 339661bc01..6e4fa48a79 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -197,6 +197,6 @@ void pci_std_vga_mmio_region_init(VGACommonState *s,
                                   Object *owner,
                                   MemoryRegion *parent,
                                   MemoryRegion *subs,
-                                  bool qext);
+                                  bool qext, bool edid);
 
 #endif
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index e9e62eac70..5e692baf78 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -30,18 +30,23 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/loader.h"
+#include "hw/display/edid.h"
 
 enum vga_pci_flags {
     PCI_VGA_FLAG_ENABLE_MMIO = 1,
     PCI_VGA_FLAG_ENABLE_QEXT = 2,
+    PCI_VGA_FLAG_ENABLE_EDID = 3,
 };
 
 typedef struct PCIVGAState {
     PCIDevice dev;
     VGACommonState vga;
     uint32_t flags;
+    uint32_t xres;
+    uint32_t yres;
     MemoryRegion mmio;
-    MemoryRegion mrs[3];
+    MemoryRegion mrs[4];
+    uint8_t edid[128];
 } PCIVGAState;
 
 #define TYPE_PCI_VGA "pci-vga"
@@ -195,8 +200,10 @@ void pci_std_vga_mmio_region_init(VGACommonState *s,
                                   Object *owner,
                                   MemoryRegion *parent,
                                   MemoryRegion *subs,
-                                  bool qext)
+                                  bool qext, bool edid)
 {
+    PCIVGAState *d = container_of(s, PCIVGAState, vga);
+
     memory_region_init_io(&subs[0], owner, &pci_vga_ioport_ops, s,
                           "vga ioports remapped", PCI_VGA_IOPORT_SIZE);
     memory_region_add_subregion(parent, PCI_VGA_IOPORT_OFFSET,
@@ -213,6 +220,16 @@ void pci_std_vga_mmio_region_init(VGACommonState *s,
         memory_region_add_subregion(parent, PCI_VGA_QEXT_OFFSET,
                                     &subs[2]);
     }
+
+    if (edid) {
+        qemu_edid_info info = {
+            .prefx = d->xres,
+            .prefy = d->yres,
+        };
+        qemu_edid_generate(d->edid, sizeof(d->edid), &info);
+        qemu_edid_region_io(&subs[3], owner, d->edid, sizeof(d->edid));
+        memory_region_add_subregion(parent, 0, &subs[3]);
+    }
 }
 
 static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
@@ -220,6 +237,7 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
     PCIVGAState *d = PCI_VGA(dev);
     VGACommonState *s = &d->vga;
     bool qext = false;
+    bool edid = false;
 
     /* vga + console init */
     vga_common_init(s, OBJECT(dev));
@@ -240,7 +258,11 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
             qext = true;
             pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
         }
-        pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs, qext);
+        if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_EDID)) {
+            edid = true;
+        }
+        pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs,
+                                     qext, edid);
 
         pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
     }
@@ -263,6 +285,7 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
     PCIVGAState *d = PCI_VGA(dev);
     VGACommonState *s = &d->vga;
     bool qext = false;
+    bool edid = false;
 
     /* vga + console init */
     vga_common_init(s, OBJECT(dev));
@@ -276,7 +299,10 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
         qext = true;
         pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
     }
-    pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs, qext);
+    if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_EDID)) {
+        edid = true;
+    }
+    pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs, qext, edid);
 
     pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
     pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
@@ -308,6 +334,10 @@ static Property vga_pci_properties[] = {
     DEFINE_PROP_BIT("mmio", PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_MMIO, true),
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
+    DEFINE_PROP_BIT("edid",
+                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
+    DEFINE_PROP_UINT32("xres", PCIVGAState, xres, 0),
+    DEFINE_PROP_UINT32("yres", PCIVGAState, yres, 0),
     DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -316,6 +346,10 @@ static Property secondary_pci_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16),
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
+    DEFINE_PROP_BIT("edid",
+                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
+    DEFINE_PROP_UINT32("xres", PCIVGAState, xres, 0),
+    DEFINE_PROP_UINT32("yres", PCIVGAState, yres, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 701d980872..3bea0693f6 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -163,7 +163,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* add stdvga mmio regions */
     pci_std_vga_mmio_region_init(vga, OBJECT(vvga), &vpci_dev->modern_bar,
-                                 vvga->vga_mrs, true);
+                                 vvga->vga_mrs, true, false);
 
     vga->con = g->scanout[0].con;
     g->disable_scanout = virtio_vga_disable_scanout;
-- 
2.9.3
