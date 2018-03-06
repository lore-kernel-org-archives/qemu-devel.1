Received: from eggs.gnu.org ([2001:4830:134:3::10]:44203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKL-0005gd-LH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKK-0008Bk-ON
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:49 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:55 +0000
Message-Id: <20180306203103.25563-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 11/19] uninorth: enable internal PCI host bridge
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
 hw/pci-host/uninorth.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 1f6752c294..ccde332fa9 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -213,6 +213,21 @@ static void pci_unin_agp_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
 
+static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
+{
+    UNINState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(dev);
+    PCIHostState *h = PCI_HOST_BRIDGE(dev);
+
+    h->bus = pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   s->pic_irqs,
+                                   &s->pci_mmio,
+                                   get_system_io(),
+                                   PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
+
+    pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
+}
+
 static void pci_unin_internal_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -244,16 +259,12 @@ UNINState *pci_pmac_init(qemu_irq *pic,
     sysbus_mmio_map(s, 1, 0xf0c00000);
 
     /* Uninorth internal bus */
-#if 0
-    /* XXX: not needed for now */
-    pci_create_simple(h->bus, PCI_DEVFN(14, 0),
-                      "uni-north-internal-pci");
     dev = qdev_create(NULL, TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
+    qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, 0xf4800000);
     sysbus_mmio_map(s, 1, 0xf4c00000);
-#endif
 
     /* Uninorth main bus */
     dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
@@ -523,10 +534,17 @@ static const TypeInfo pci_unin_agp_info = {
     .class_init    = pci_unin_agp_class_init,
 };
 
+static Property pci_unin_internal_class_properties[] = {
+    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = pci_unin_internal_realize;
+    dc->props = pci_unin_internal_class_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
-- 
2.11.0
