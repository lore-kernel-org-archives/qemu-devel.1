Received: from eggs.gnu.org ([2001:4830:134:3::10]:56508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvE-0000oL-Ox
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvD-0008Vn-UN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:08 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59097
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFgvD-0008Jf-No
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:07 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 17 Nov 2017 13:42:34 +0000
Message-Id: <1510926167-23326-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/15] sun4u: ebus QOMify tidy-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

The main change here is to introduce the proper TYPE_EBUS/EBUS QOM macros
and remove the use of DO_UPCAST.

Alongside this there are some a couple of minor cosmetic changes and a rename
of pci_ebus_realize() to ebus_realize() since the ebus device is always what
is effectively a PCI-ISA bridge.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1672f25..394b7d6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -81,11 +81,16 @@ struct hwdef {
 };
 
 typedef struct EbusState {
-    PCIDevice pci_dev;
+    /*< private >*/
+    PCIDevice parent_obj;
+
     MemoryRegion bar0;
     MemoryRegion bar1;
 } EbusState;
 
+#define TYPE_EBUS "ebus"
+#define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
+
 void DMA_init(ISABus *bus, int high_page_enable)
 {
 }
@@ -236,9 +241,9 @@ pci_ebus_init(PCIDevice *pci_dev, qemu_irq *irqs)
     return isa_bus;
 }
 
-static void pci_ebus_realize(PCIDevice *pci_dev, Error **errp)
+static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 {
-    EbusState *s = DO_UPCAST(EbusState, pci_dev, pci_dev);
+    EbusState *s = EBUS(pci_dev);
 
     if (!isa_bus_new(DEVICE(pci_dev), get_system_memory(),
                      pci_address_space_io(pci_dev), errp)) {
@@ -264,7 +269,7 @@ static void ebus_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = pci_ebus_realize;
+    k->realize = ebus_realize;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_EBUS;
     k->revision = 0x01;
@@ -272,10 +277,10 @@ static void ebus_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ebus_info = {
-    .name          = "ebus",
+    .name          = TYPE_EBUS,
     .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(EbusState),
     .class_init    = ebus_class_init,
+    .instance_size = sizeof(EbusState),
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -463,7 +468,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_busA->slot_reserved_mask = 0xfffffff1;
     pci_busB->slot_reserved_mask = 0xfffffff0;
 
-    ebus = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, "ebus");
+    ebus = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, TYPE_EBUS);
     qdev_init_nofail(DEVICE(ebus));
 
     isa_bus = pci_ebus_init(ebus, pbm_irqs);
-- 
1.7.10.4
