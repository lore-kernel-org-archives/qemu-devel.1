Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf8-00007w-43
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf5-0006mc-Kb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 22:01:55 +0000
Message-Id: <20180306220159.4287-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
References: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/6] grackle: general tidy-up and QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is the first step towards removing the old-style pci_grackle_init()
function. Following on from the previous commit we can now pass the heathrow
device as an object link and wire up the heathrow IRQs via qdev GPIOs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/grackle.c | 96 +++++++++++++++++++++++++++++++++------------------
 hw/ppc/mac.h          |  2 +-
 hw/ppc/mac_oldworld.c |  2 +-
 3 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 033588b7d2..f8935246c3 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -27,6 +27,8 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
+#include "hw/intc/heathrow_pic.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
@@ -35,6 +37,8 @@
 typedef struct GrackleState {
     PCIHostState parent_obj;
 
+    HeathrowState *pic;
+    qemu_irq irqs[4];
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
 } GrackleState;
@@ -47,13 +51,22 @@ static int pci_grackle_map_irq(PCIDevice *pci_dev, int irq_num)
 
 static void pci_grackle_set_irq(void *opaque, int irq_num, int level)
 {
-    qemu_irq *pic = opaque;
+    GrackleState *s = opaque;
 
     trace_grackle_set_irq(irq_num, level);
-    qemu_set_irq(pic[irq_num + 0x15], level);
+    qemu_set_irq(s->irqs[irq_num], level);
 }
 
-PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
+static void grackle_init_irqs(GrackleState *s)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
+        s->irqs[i] = qdev_get_gpio_in(DEVICE(s->pic), 0x15 + i);
+    }
+}
+
+PCIBus *pci_grackle_init(uint32_t base, DeviceState *pic_dev,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io)
 {
@@ -63,60 +76,75 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
     GrackleState *d;
 
     dev = qdev_create(NULL, TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                             &error_abort);
+    qdev_init_nofail(dev);
+
     s = SYS_BUS_DEVICE(dev);
     phb = PCI_HOST_BRIDGE(dev);
     d = GRACKLE_PCI_HOST_BRIDGE(dev);
 
-    memory_region_init(&d->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
-    memory_region_init_alias(&d->pci_hole, OBJECT(s), "pci-hole", &d->pci_mmio,
-                             0x80000000ULL, 0x7e000000ULL);
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
+    sysbus_mmio_map(s, 0, base);
+    sysbus_mmio_map(s, 1, base + 0x00200000);
+
+    return phb->bus;
+}
+
+static void grackle_realize(DeviceState *dev, Error **errp)
+{
+    GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
+    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+
     phb->bus = pci_register_root_bus(dev, NULL,
                                      pci_grackle_set_irq,
                                      pci_grackle_map_irq,
-                                     pic,
-                                     &d->pci_mmio,
-                                     address_space_io,
+                                     s,
+                                     &s->pci_mmio,
+                                     get_system_io(),
                                      0, 4, TYPE_PCI_BUS);
 
     pci_create_simple(phb->bus, 0, "grackle");
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(s, 0, base);
-    sysbus_mmio_map(s, 1, base + 0x00200000);
-
-    return phb->bus;
+    grackle_init_irqs(s);
 }
 
-static int pci_grackle_init_device(SysBusDevice *dev)
+static void grackle_init(Object *obj)
 {
-    PCIHostState *phb;
+    GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
 
-    phb = PCI_HOST_BRIDGE(dev);
+    memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
+    memory_region_init_alias(&s->pci_hole, OBJECT(s), "pci-hole", &s->pci_mmio,
+                             0x80000000ULL, 0x7e000000ULL);
 
-    memory_region_init_io(&phb->conf_mem, OBJECT(dev), &pci_host_conf_le_ops,
-                          dev, "pci-conf-idx", 0x1000);
-    memory_region_init_io(&phb->data_mem, OBJECT(dev), &pci_host_data_le_ops,
-                          dev, "pci-data-idx", 0x1000);
-    sysbus_init_mmio(dev, &phb->conf_mem);
-    sysbus_init_mmio(dev, &phb->data_mem);
+    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops,
+                          DEVICE(obj), "pci-conf-idx", 0x1000);
+    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,
+                          DEVICE(obj), "pci-data-idx", 0x1000);
 
-    return 0;
+    object_property_add_link(obj, "pic", TYPE_HEATHROW,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
+    sysbus_init_mmio(sbd, &phb->conf_mem);
+    sysbus_init_mmio(sbd, &phb->data_mem);
 }
 
-static void grackle_pci_host_realize(PCIDevice *d, Error **errp)
+static void grackle_pci_realize(PCIDevice *d, Error **errp)
 {
     d->config[0x09] = 0x01;
 }
 
 static void grackle_pci_class_init(ObjectClass *klass, void *data)
 {
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->realize   = grackle_pci_host_realize;
+    k->realize   = grackle_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_MOTOROLA;
     k->device_id = PCI_DEVICE_ID_MOTOROLA_MPC106;
     k->revision  = 0x00;
@@ -139,26 +167,26 @@ static const TypeInfo grackle_pci_info = {
     },
 };
 
-static void pci_grackle_class_init(ObjectClass *klass, void *data)
+static void grackle_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = pci_grackle_init_device;
+    dc->realize = grackle_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
-static const TypeInfo grackle_pci_host_info = {
+static const TypeInfo grackle_host_info = {
     .name          = TYPE_GRACKLE_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(GrackleState),
-    .class_init    = pci_grackle_class_init,
+    .instance_init = grackle_init,
+    .class_init    = grackle_class_init,
 };
 
 static void grackle_register_types(void)
 {
     type_register_static(&grackle_pci_info);
-    type_register_static(&grackle_pci_host_info);
+    type_register_static(&grackle_host_info);
 }
 
 type_init(grackle_register_types)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 424d20088b..2359deb1ec 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -77,7 +77,7 @@ void macio_init(PCIDevice *dev,
 
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
-PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
+PCIBus *pci_grackle_init(uint32_t base, DeviceState *pic_dev,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 62788a54c0..17711971e6 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -262,7 +262,7 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
 
-    pci_bus = pci_grackle_init(0xfec00000, pic,
+    pci_bus = pci_grackle_init(0xfec00000, pic_dev,
                                get_system_memory(),
                                get_system_io());
     pci_vga_init(pci_bus);
-- 
2.11.0
