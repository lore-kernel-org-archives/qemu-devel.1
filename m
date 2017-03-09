Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltaw-0006SD-ED
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltar-00011p-GD
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cltar-00011N-A9
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44971C04BD2B
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 08:38:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 09:38:29 +0100
Message-Id: <1489048710-22084-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
References: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] stdvga: move common properties to
 common base class
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga-pci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index ac9a764..8500362 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -306,15 +306,12 @@ static void pci_secondary_vga_reset(DeviceState *dev)
     vga_common_reset(&d->vga);
 }
 
-static Property vga_pci_properties[] = {
-    DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16),
+static Property vga_pci_primary_properties[] = {
     DEFINE_PROP_BIT("mmio", PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_MMIO, true),
-    DEFINE_PROP_BIT("qemu-extended-regs",
-                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property secondary_pci_properties[] = {
+static Property vga_pci_common_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16),
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
@@ -329,6 +326,7 @@ static void vga_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_QEMU;
     k->device_id = PCI_DEVICE_ID_QEMU_VGA;
     dc->vmsd = &vmstate_vga_pci;
+    dc->props = vga_pci_common_properties;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
 
@@ -348,7 +346,7 @@ static void vga_class_init(ObjectClass *klass, void *data)
     k->realize = pci_std_vga_realize;
     k->romfile = "vgabios-stdvga.bin";
     k->class_id = PCI_CLASS_DISPLAY_VGA;
-    dc->props = vga_pci_properties;
+    dc->props = vga_pci_primary_properties;
     dc->hotpluggable = false;
 }
 
@@ -359,7 +357,6 @@ static void secondary_class_init(ObjectClass *klass, void *data)
 
     k->realize = pci_secondary_vga_realize;
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
-    dc->props = secondary_pci_properties;
     dc->reset = pci_secondary_vga_reset;
 }
 
-- 
1.8.3.1
