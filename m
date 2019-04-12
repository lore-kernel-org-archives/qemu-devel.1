Received: from eggs.gnu.org ([209.51.188.92]:51350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NV-0000Pn-AG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NU-00055c-98
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:29 -0400
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 12 Apr 2019 23:06:15 +0200
Message-Id: <1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 1/4] lsi53c895a: hide 53c895a registers in
 53c810
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

AIX/PReP does access to the aliased IO registers of 53810.
Implement aliasing to make the AIX driver work.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/scsi/lsi53c895a.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d..08841e0 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2266,11 +2266,13 @@ static const struct SCSIBusInfo lsi_scsi_info = {
     .cancel = lsi_request_cancelled
 };
 
-static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
+static void lsi_scsi_realize_8xx(PCIDevice *dev, Error **errp, uint16_t type)
 {
     LSIState *s = LSI53C895A(dev);
     DeviceState *d = DEVICE(dev);
     uint8_t *pci_conf;
+    uint64_t mmio_size;
+    MemoryRegion *mr;
 
     pci_conf = dev->config;
 
@@ -2279,13 +2281,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     /* Interrupt pin A */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
 
-    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
-                          "lsi-mmio", 0x400);
     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
-
+    if (type == PCI_DEVICE_ID_LSI_53C895A) {
+        mmio_size = 0x400;
+    } else {
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
+                                 0, 0x80);
+        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
+        mmio_size = 0x80;
+    }
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
+                          "lsi-mmio", mmio_size);
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
 
@@ -2297,6 +2307,16 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
 }
 
+static void lsi_scsi_realize_895A(PCIDevice *dev, Error **errp)
+{
+    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C895A);
+}
+
+static void lsi_scsi_realize_810(PCIDevice *dev, Error **errp)
+{
+    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C810);
+}
+
 static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
 {
     LSIState *s = LSI53C895A(dev);
@@ -2309,7 +2329,7 @@ static void lsi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize = lsi_scsi_realize;
+    k->realize = lsi_scsi_realize_895A;
     k->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     k->device_id = PCI_DEVICE_ID_LSI_53C895A;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
@@ -2335,6 +2355,7 @@ static void lsi53c810_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    k->realize = lsi_scsi_realize_810;
     k->device_id = PCI_DEVICE_ID_LSI_53C810;
 }
 
-- 
2.7.2
