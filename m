Received: from eggs.gnu.org ([209.51.188.92]:59829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cp-0005He-Pj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9co-0006eu-Cb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9co-0006bj-0W
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:58 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:47 -0500
Message-Id: <20190125220648.28164-8-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
References: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] ide/via: Rename functions to match device
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>

From: BALATON Zoltan <balaton@eik.bme.hu>

The device is called via-ide and the modelled IDE controller is not
specific to 82C686B but is also usable independently. Therefore, change
function name prefixes accordingly to match device name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 2905ced862c8d2ad509d73152171ce2472d72605.1548160772.git.balaton@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/via.c            | 15 +++++++--------
 hw/mips/mips_fulong2e.c |  2 +-
 include/hw/ide.h        |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 46cac7b8d6..c6e43a8812 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -110,7 +110,7 @@ static void bmdma_setup_bar(PCIIDEState *d)
     }
 }
 
-static void via_reset(void *opaque)
+static void via_ide_reset(void *opaque)
 {
     PCIIDEState *d = opaque;
     PCIDevice *pd = PCI_DEVICE(d);
@@ -152,8 +152,7 @@ static void via_reset(void *opaque)
     pci_set_long(pci_conf + 0xc0, 0x00020001);
 }
 
-/* via ide func */
-static void vt82c686b_ide_realize(PCIDevice *dev, Error **errp)
+static void via_ide_realize(PCIDevice *dev, Error **errp)
 {
     PCIIDEState *d = PCI_IDE(dev);
     uint8_t *pci_conf = dev->config;
@@ -162,7 +161,7 @@ static void vt82c686b_ide_realize(PCIDevice *dev, Error **errp)
     pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy ATA mode */
     pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
 
-    qemu_register_reset(via_reset, d);
+    qemu_register_reset(via_ide_reset, d);
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
 
@@ -180,7 +179,7 @@ static void vt82c686b_ide_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static void vt82c686b_ide_exitfn(PCIDevice *dev)
+static void via_ide_exitfn(PCIDevice *dev)
 {
     PCIIDEState *d = PCI_IDE(dev);
     unsigned i;
@@ -191,7 +190,7 @@ static void vt82c686b_ide_exitfn(PCIDevice *dev)
     }
 }
 
-void vt82c686b_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
+void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
 {
     PCIDevice *dev;
 
@@ -204,8 +203,8 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = vt82c686b_ide_realize;
-    k->exit = vt82c686b_ide_exitfn;
+    k->realize = via_ide_realize;
+    k->exit = via_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_VIA;
     k->device_id = PCI_DEVICE_ID_VIA_IDE;
     k->revision = 0x06;
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2fbba32c48..42d09f6892 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -249,7 +249,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    vt82c686b_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
+    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
 
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 3ae087c572..28d8a06439 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -18,7 +18,7 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
-void vt82c686b_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
+void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 
 /* ide-mmio.c */
 void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);
-- 
2.17.2
