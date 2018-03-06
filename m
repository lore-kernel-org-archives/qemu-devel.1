Received: from eggs.gnu.org ([2001:4830:134:3::10]:42619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJFD-0000bs-EN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJFC-0005d2-AF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:31 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:52 +0000
Message-Id: <20180306203103.25563-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 08/19] uninorth: introduce temporary pic_irqs
 device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is in preparation for moving the PCI bus wiring inside the uninorth
host bridge devices. In the future it will be possible to remove this once the
PICs have been switched to use qdev GPIOs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c         | 25 +++++++++++++++++++++++--
 include/hw/pci-host/uninorth.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 5b8fc3aa16..fc59698f06 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -188,6 +188,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
     /* Use values found on a real PowerMac */
     /* Uninorth main bus */
     dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+    qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     h = PCI_HOST_BRIDGE(s);
@@ -199,7 +200,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   pic,
+                                   d->pic_irqs,
                                    &d->pci_mmio,
                                    address_space_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
@@ -220,6 +221,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
     /* Uninorth AGP bus */
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
     dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
+    qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, 0xf0800000);
@@ -251,6 +253,7 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
 
     /* Uninorth AGP bus */
     dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
+    qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     h = PCI_HOST_BRIDGE(dev);
@@ -263,7 +266,7 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   pic,
+                                   d->pic_irqs,
                                    &d->pci_mmio,
                                    address_space_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
@@ -436,10 +439,16 @@ static const TypeInfo unin_internal_pci_host_info = {
     },
 };
 
+static Property pci_unin_main_properties[] = {
+    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props = pci_unin_main_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -451,10 +460,16 @@ static const TypeInfo pci_unin_main_info = {
     .class_init    = pci_unin_main_class_init,
 };
 
+static Property pci_u3_agp_properties[] = {
+    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props = pci_u3_agp_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -466,10 +481,16 @@ static const TypeInfo pci_u3_agp_info = {
     .class_init    = pci_u3_agp_class_init,
 };
 
+static Property pci_unin_agp_class_properties[] = {
+    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props = pci_unin_agp_class_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index 9364c14bdd..12979712d0 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -42,6 +42,7 @@
 typedef struct UNINState {
     PCIHostState parent_obj;
 
+    void *pic_irqs;
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
 } UNINState;
-- 
2.11.0
