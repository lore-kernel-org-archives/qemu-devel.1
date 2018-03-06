Received: from eggs.gnu.org ([2001:4830:134:3::10]:44253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKP-0005kv-Ll
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKO-0008E8-Ar
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:53 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:31:00 +0000
Message-Id: <20180306203103.25563-17-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 16/19] uninorth: rename UNINState to
 UNINHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The existing UNINState actually represents the PCI/AGP host bridge stage so
rename it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c         | 32 ++++++++++++++++----------------
 hw/ppc/mac.h                   |  8 ++++----
 hw/ppc/mac_newworld.c          |  2 +-
 include/hw/pci-host/uninorth.h | 12 ++++++------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 3a29a4410e..fada0ffd5f 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -38,7 +38,7 @@ static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
 
 static void pci_unin_set_irq(void *opaque, int irq_num, int level)
 {
-    UNINState *s = opaque;
+    UNINHostState *s = opaque;
 
     trace_unin_set_irq(unin_irq_line[irq_num], level);
     qemu_set_irq(s->irqs[irq_num], level);
@@ -81,7 +81,7 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint32_t addr)
 static void unin_data_write(void *opaque, hwaddr addr,
                             uint64_t val, unsigned len)
 {
-    UNINState *s = opaque;
+    UNINHostState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     trace_unin_data_write(addr, len, val);
     pci_data_write(phb->bus,
@@ -92,7 +92,7 @@ static void unin_data_write(void *opaque, hwaddr addr,
 static uint64_t unin_data_read(void *opaque, hwaddr addr,
                                unsigned len)
 {
-    UNINState *s = opaque;
+    UNINHostState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     uint32_t val;
 
@@ -109,7 +109,7 @@ static const MemoryRegionOps unin_data_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void pci_unin_init_irqs(UNINState *s)
+static void pci_unin_init_irqs(UNINHostState *s)
 {
     int i;
 
@@ -120,7 +120,7 @@ static void pci_unin_init_irqs(UNINState *s)
 
 static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
+    UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
 
     h->bus = pci_register_root_bus(dev, NULL,
@@ -142,7 +142,7 @@ static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 
 static void pci_unin_main_init(Object *obj)
 {
-    UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(obj);
+    UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -175,7 +175,7 @@ static void pci_unin_main_init(Object *obj)
 
 static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s = U3_AGP_HOST_BRIDGE(dev);
+    UNINHostState *s = U3_AGP_HOST_BRIDGE(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
 
     h->bus = pci_register_root_bus(dev, NULL,
@@ -191,7 +191,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
 
 static void pci_u3_agp_init(Object *obj)
 {
-    UNINState *s = U3_AGP_HOST_BRIDGE(obj);
+    UNINHostState *s = U3_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -223,7 +223,7 @@ static void pci_u3_agp_init(Object *obj)
 
 static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s = UNI_NORTH_AGP_HOST_BRIDGE(dev);
+    UNINHostState *s = UNI_NORTH_AGP_HOST_BRIDGE(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
 
     h->bus = pci_register_root_bus(dev, NULL,
@@ -239,7 +239,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
 
 static void pci_unin_agp_init(Object *obj)
 {
-    UNINState *s = UNI_NORTH_AGP_HOST_BRIDGE(obj);
+    UNINHostState *s = UNI_NORTH_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -260,7 +260,7 @@ static void pci_unin_agp_init(Object *obj)
 
 static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(dev);
+    UNINHostState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
 
     h->bus = pci_register_root_bus(dev, NULL,
@@ -276,7 +276,7 @@ static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
 
 static void pci_unin_internal_init(Object *obj)
 {
-    UNINState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj);
+    UNINHostState *s = UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
 
@@ -466,7 +466,7 @@ static void pci_unin_main_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pci_unin_main_info = {
     .name          = TYPE_UNI_NORTH_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(UNINState),
+    .instance_size = sizeof(UNINHostState),
     .instance_init = pci_unin_main_init,
     .class_init    = pci_unin_main_class_init,
 };
@@ -482,7 +482,7 @@ static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pci_u3_agp_info = {
     .name          = TYPE_U3_AGP_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(UNINState),
+    .instance_size = sizeof(UNINHostState),
     .instance_init = pci_u3_agp_init,
     .class_init    = pci_u3_agp_class_init,
 };
@@ -498,7 +498,7 @@ static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pci_unin_agp_info = {
     .name          = TYPE_UNI_NORTH_AGP_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(UNINState),
+    .instance_size = sizeof(UNINHostState),
     .instance_init = pci_unin_agp_init,
     .class_init    = pci_unin_agp_class_init,
 };
@@ -514,7 +514,7 @@ static void pci_unin_internal_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pci_unin_internal_info = {
     .name          = TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(UNINState),
+    .instance_size = sizeof(UNINHostState),
     .instance_init = pci_unin_internal_init,
     .class_init    = pci_unin_internal_class_init,
 };
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 628415b255..5f5916252a 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -88,10 +88,10 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
                          MemoryRegion *address_space_io);
 
 /* UniNorth PCI */
-UNINState *pci_pmac_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem);
-UNINState *pci_pmac_u3_init(qemu_irq *pic,
-                            MemoryRegion *address_space_mem);
+UNINHostState *pci_pmac_init(qemu_irq *pic,
+                             MemoryRegion *address_space_mem);
+UNINHostState *pci_pmac_u3_init(qemu_irq *pic,
+                                MemoryRegion *address_space_mem);
 
 /* Mac NVRAM */
 #define TYPE_MACIO_NVRAM "macio-nvram"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 5cb9f9abd0..ae0de4e36e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -151,7 +151,7 @@ static void ppc_core99_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
     long kernel_size, initrd_size;
-    UNINState *uninorth_pci;
+    UNINHostState *uninorth_pci;
     PCIBus *pci_bus;
     NewWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index c4771aa7fa..d1424b165a 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -33,15 +33,15 @@
 #define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
 
 #define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
 #define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
 #define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE)
 #define U3_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
 
-typedef struct UNINState {
+typedef struct UNINHostState {
     PCIHostState parent_obj;
 
     OpenPICState *pic;
@@ -49,6 +49,6 @@ typedef struct UNINState {
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
     MemoryRegion pci_io;
-} UNINState;
+} UNINHostState;
 
 #endif /* UNINORTH_H */
-- 
2.11.0
