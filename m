Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF6-0000UE-Bx
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF4-0005Wb-Dy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:24 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:47 +0000
Message-Id: <20180306203103.25563-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/19] uninorth: QOMify PCI and AGP host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c | 79 ++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 710818e355..1d4d3f5705 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -129,72 +129,61 @@ static const MemoryRegionOps unin_data_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static int pci_unin_main_init_device(SysBusDevice *dev)
+static void pci_unin_main_init(Object *obj)
 {
-    PCIHostState *h;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
     /* Use values found on a real PowerMac */
     /* Uninorth main bus */
-    h = PCI_HOST_BRIDGE(dev);
-
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
-                          dev, "pci-conf-idx", 0x1000);
-    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, dev,
+                          obj, "pci-conf-idx", 0x1000);
+    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
                           "pci-conf-data", 0x1000);
-    sysbus_init_mmio(dev, &h->conf_mem);
-    sysbus_init_mmio(dev, &h->data_mem);
-
-    return 0;
+    sysbus_init_mmio(sbd, &h->conf_mem);
+    sysbus_init_mmio(sbd, &h->data_mem);
 }
 
-
-static int pci_u3_agp_init_device(SysBusDevice *dev)
+static void pci_u3_agp_init(Object *obj)
 {
-    PCIHostState *h;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
     /* Uninorth U3 AGP bus */
-    h = PCI_HOST_BRIDGE(dev);
-
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
-                          dev, "pci-conf-idx", 0x1000);
-    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, dev,
+                          obj, "pci-conf-idx", 0x1000);
+    memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
                           "pci-conf-data", 0x1000);
-    sysbus_init_mmio(dev, &h->conf_mem);
-    sysbus_init_mmio(dev, &h->data_mem);
-
-    return 0;
+    sysbus_init_mmio(sbd, &h->conf_mem);
+    sysbus_init_mmio(sbd, &h->data_mem);
 }
 
-static int pci_unin_agp_init_device(SysBusDevice *dev)
+static void pci_unin_agp_init(Object *obj)
 {
-    PCIHostState *h;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
     /* Uninorth AGP bus */
-    h = PCI_HOST_BRIDGE(dev);
-
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
-                          dev, "pci-conf-idx", 0x1000);
+                          obj, "pci-conf-idx", 0x1000);
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
-                          dev, "pci-conf-data", 0x1000);
-    sysbus_init_mmio(dev, &h->conf_mem);
-    sysbus_init_mmio(dev, &h->data_mem);
-    return 0;
+                          obj, "pci-conf-data", 0x1000);
+    sysbus_init_mmio(sbd, &h->conf_mem);
+    sysbus_init_mmio(sbd, &h->data_mem);
 }
 
-static int pci_unin_internal_init_device(SysBusDevice *dev)
+static void pci_unin_internal_init(Object *obj)
 {
-    PCIHostState *h;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
     /* Uninorth internal bus */
-    h = PCI_HOST_BRIDGE(dev);
-
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
-                          dev, "pci-conf-idx", 0x1000);
+                          obj, "pci-conf-idx", 0x1000);
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
-                          dev, "pci-conf-data", 0x1000);
-    sysbus_init_mmio(dev, &h->conf_mem);
-    sysbus_init_mmio(dev, &h->data_mem);
-    return 0;
+                          obj, "pci-conf-data", 0x1000);
+    sysbus_init_mmio(sbd, &h->conf_mem);
+    sysbus_init_mmio(sbd, &h->data_mem);
 }
 
 PCIBus *pci_pmac_init(qemu_irq *pic,
@@ -461,10 +450,8 @@ static const TypeInfo unin_internal_pci_host_info = {
 
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sbc->init = pci_unin_main_init_device;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -472,15 +459,14 @@ static const TypeInfo pci_unin_main_info = {
     .name          = TYPE_UNI_NORTH_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(UNINState),
+    .instance_init = pci_unin_main_init,
     .class_init    = pci_unin_main_class_init,
 };
 
 static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sbc->init = pci_u3_agp_init_device;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -488,15 +474,14 @@ static const TypeInfo pci_u3_agp_info = {
     .name          = TYPE_U3_AGP_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(UNINState),
+    .instance_init = pci_u3_agp_init,
     .class_init    = pci_u3_agp_class_init,
 };
 
 static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sbc->init = pci_unin_agp_init_device;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -504,15 +489,14 @@ static const TypeInfo pci_unin_agp_info = {
     .name          = TYPE_UNI_NORTH_AGP_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(UNINState),
+    .instance_init = pci_unin_agp_init,
     .class_init    = pci_unin_agp_class_init,
 };
 
 static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sbc->init = pci_unin_internal_init_device;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -520,6 +504,7 @@ static const TypeInfo pci_unin_internal_info = {
     .name          = TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(UNINState),
+    .instance_init = pci_unin_internal_init,
     .class_init    = pci_unin_internal_class_init,
 };
 
-- 
2.11.0
