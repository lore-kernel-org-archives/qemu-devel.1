Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza5-0001gx-SK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza4-00025D-5n
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:57 +1000
Message-Id: <20180427092126.24812-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/49] uninorth: use object link to pass OpenPIC
 object to uninorth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Now that the OpenPIC is wired up via the board, we can now remove our temporary
PIC qdev pointer property and replace it with an object link instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c         | 73 +++++++++++++++++++++++++-----------------
 hw/ppc/mac_newworld.c          | 12 ++++---
 include/hw/pci-host/uninorth.h |  5 ++-
 3 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index ec6e529d66..e2278fd0f0 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -38,10 +38,10 @@ static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
 
 static void pci_unin_set_irq(void *opaque, int irq_num, int level)
 {
-    qemu_irq *pic = opaque;
+    UNINState *s = opaque;
 
     trace_unin_set_irq(unin_irq_line[irq_num], level);
-    qemu_set_irq(pic[unin_irq_line[irq_num]], level);
+    qemu_set_irq(s->irqs[irq_num], level);
 }
 
 static uint32_t unin_get_config_reg(uint32_t reg, uint32_t addr)
@@ -109,6 +109,15 @@ static const MemoryRegionOps unin_data_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void pci_unin_init_irqs(UNINState *s)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
+        s->irqs[i] = qdev_get_gpio_in(DEVICE(s->pic), unin_irq_line[i]);
+    }
+}
+
 static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 {
     UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
@@ -116,12 +125,13 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   s->pic_irqs,
+                                   s,
                                    &s->pci_mmio,
                                    get_system_io(),
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
+    pci_unin_init_irqs(s);
 
     /* DEC 21154 bridge */
 #if 0
@@ -150,6 +160,11 @@ static void pci_unin_main_init(Object *obj)
                              "unin-pci-hole", &s->pci_mmio,
                              0x80000000ULL, 0x10000000ULL);
 
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
@@ -162,12 +177,13 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   s->pic_irqs,
+                                   s,
                                    &s->pci_mmio,
                                    get_system_io(),
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
+    pci_unin_init_irqs(s);
 }
 
 static void pci_u3_agp_init(Object *obj)
@@ -189,6 +205,11 @@ static void pci_u3_agp_init(Object *obj)
                              "unin-pci-hole", &s->pci_mmio,
                              0x80000000ULL, 0x70000000ULL);
 
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
@@ -201,16 +222,18 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   s->pic_irqs,
+                                   s,
                                    &s->pci_mmio,
                                    get_system_io(),
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
+    pci_unin_init_irqs(s);
 }
 
 static void pci_unin_agp_init(Object *obj)
 {
+    UNINState *s = UNI_NORTH_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -219,6 +242,12 @@ static void pci_unin_agp_init(Object *obj)
                           obj, "unin-agp-conf-idx", 0x1000);
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
                           obj, "unin-agp-conf-data", 0x1000);
+
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
 }
@@ -230,16 +259,18 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
 
     h->bus = pci_register_root_bus(dev, NULL,
                                    pci_unin_set_irq, pci_unin_map_irq,
-                                   s->pic_irqs,
+                                   s,
                                    &s->pci_mmio,
                                    get_system_io(),
                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
 
     pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
+    pci_unin_init_irqs(s);
 }
 
 static void pci_unin_internal_init(Object *obj)
 {
+    UNINState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -248,6 +279,12 @@ static void pci_unin_internal_init(Object *obj)
                           obj, "unin-pci-conf-idx", 0x1000);
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
                           obj, "unin-pci-conf-data", 0x1000);
+
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
 }
@@ -412,17 +449,11 @@ static const TypeInfo unin_internal_pci_host_info = {
     },
 };
 
-static Property pci_unin_main_properties[] = {
-    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_main_realize;
-    dc->props = pci_unin_main_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -434,17 +465,11 @@ static const TypeInfo pci_unin_main_info = {
     .class_init    = pci_unin_main_class_init,
 };
 
-static Property pci_u3_agp_properties[] = {
-    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_u3_agp_realize;
-    dc->props = pci_u3_agp_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -456,17 +481,11 @@ static const TypeInfo pci_u3_agp_info = {
     .class_init    = pci_u3_agp_class_init,
 };
 
-static Property pci_unin_agp_class_properties[] = {
-    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_agp_realize;
-    dc->props = pci_unin_agp_class_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -478,17 +497,11 @@ static const TypeInfo pci_unin_agp_info = {
     .class_init    = pci_unin_agp_class_init,
 };
 
-static Property pci_unin_internal_class_properties[] = {
-    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_internal_realize;
-    dc->props = pci_unin_internal_class_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2360b24a12..e05aa26c3d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -347,7 +347,8 @@ static void ppc_core99_init(MachineState *machine)
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
         dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
-        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                                 &error_abort);
         qdev_init_nofail(dev);
         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
@@ -362,7 +363,8 @@ static void ppc_core99_init(MachineState *machine)
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
         dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
-        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                                 &error_abort);
         qdev_init_nofail(dev);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, 0xf0800000);
@@ -370,7 +372,8 @@ static void ppc_core99_init(MachineState *machine)
 
         /* Uninorth internal bus */
         dev = qdev_create(NULL, TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
-        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                                 &error_abort);
         qdev_init_nofail(dev);
         s = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(s, 0, 0xf4800000);
@@ -378,7 +381,8 @@ static void ppc_core99_init(MachineState *machine)
 
         /* Uninorth main bus */
         dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
-        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                                 &error_abort);
         qdev_init_nofail(dev);
         uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
         s = SYS_BUS_DEVICE(dev);
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index e4fa11c145..e048fd56e8 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -27,6 +27,8 @@
 
 #include "hw/hw.h"
 
+#include "hw/ppc/openpic.h"
+
 #define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
 #define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
 #define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-pcihost"
@@ -44,7 +46,8 @@
 typedef struct UNINState {
     PCIHostState parent_obj;
 
-    void *pic_irqs;
+    OpenPICState *pic;
+    qemu_irq irqs[4];
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
 } UNINState;
-- 
2.14.3
