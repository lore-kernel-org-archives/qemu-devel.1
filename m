Received: from eggs.gnu.org ([2001:4830:134:3::10]:59481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaA-0001m6-7A
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza5-00026D-K4
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:59 +1000
Message-Id: <20180427092126.24812-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/49] uninorth: rename UNINState to
 UNINHostState
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

The existing UNINState actually represents the PCI/AGP host bridge stage =
so
rename it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
@@ -38,7 +38,7 @@ static int pci_unin_map_irq(PCIDevice *pci_dev, int irq=
_num)
=20
 static void pci_unin_set_irq(void *opaque, int irq_num, int level)
 {
-    UNINState *s =3D opaque;
+    UNINHostState *s =3D opaque;
=20
     trace_unin_set_irq(unin_irq_line[irq_num], level);
     qemu_set_irq(s->irqs[irq_num], level);
@@ -81,7 +81,7 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint3=
2_t addr)
 static void unin_data_write(void *opaque, hwaddr addr,
                             uint64_t val, unsigned len)
 {
-    UNINState *s =3D opaque;
+    UNINHostState *s =3D opaque;
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     trace_unin_data_write(addr, len, val);
     pci_data_write(phb->bus,
@@ -92,7 +92,7 @@ static void unin_data_write(void *opaque, hwaddr addr,
 static uint64_t unin_data_read(void *opaque, hwaddr addr,
                                unsigned len)
 {
-    UNINState *s =3D opaque;
+    UNINHostState *s =3D opaque;
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     uint32_t val;
=20
@@ -109,7 +109,7 @@ static const MemoryRegionOps unin_data_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
-static void pci_unin_init_irqs(UNINState *s)
+static void pci_unin_init_irqs(UNINHostState *s)
 {
     int i;
=20
@@ -120,7 +120,7 @@ static void pci_unin_init_irqs(UNINState *s)
=20
 static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
+    UNINHostState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
     PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
=20
     h->bus =3D pci_register_root_bus(dev, NULL,
@@ -142,7 +142,7 @@ static void pci_unin_main_realize(DeviceState *dev, E=
rror **errp)
=20
 static void pci_unin_main_init(Object *obj)
 {
-    UNINState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(obj);
+    UNINHostState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
=20
@@ -175,7 +175,7 @@ static void pci_unin_main_init(Object *obj)
=20
 static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s =3D U3_AGP_HOST_BRIDGE(dev);
+    UNINHostState *s =3D U3_AGP_HOST_BRIDGE(dev);
     PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
=20
     h->bus =3D pci_register_root_bus(dev, NULL,
@@ -191,7 +191,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Erro=
r **errp)
=20
 static void pci_u3_agp_init(Object *obj)
 {
-    UNINState *s =3D U3_AGP_HOST_BRIDGE(obj);
+    UNINHostState *s =3D U3_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
=20
@@ -223,7 +223,7 @@ static void pci_u3_agp_init(Object *obj)
=20
 static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(dev);
+    UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(dev);
     PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
=20
     h->bus =3D pci_register_root_bus(dev, NULL,
@@ -239,7 +239,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Er=
ror **errp)
=20
 static void pci_unin_agp_init(Object *obj)
 {
-    UNINState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
+    UNINHostState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
=20
@@ -260,7 +260,7 @@ static void pci_unin_agp_init(Object *obj)
=20
 static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
 {
-    UNINState *s =3D UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(dev);
+    UNINHostState *s =3D UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(dev);
     PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
=20
     h->bus =3D pci_register_root_bus(dev, NULL,
@@ -276,7 +276,7 @@ static void pci_unin_internal_realize(DeviceState *de=
v, Error **errp)
=20
 static void pci_unin_internal_init(Object *obj)
 {
-    UNINState *s =3D UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj);
+    UNINHostState *s =3D UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
=20
@@ -466,7 +466,7 @@ static void pci_unin_main_class_init(ObjectClass *kla=
ss, void *data)
 static const TypeInfo pci_unin_main_info =3D {
     .name          =3D TYPE_UNI_NORTH_PCI_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
-    .instance_size =3D sizeof(UNINState),
+    .instance_size =3D sizeof(UNINHostState),
     .instance_init =3D pci_unin_main_init,
     .class_init    =3D pci_unin_main_class_init,
 };
@@ -482,7 +482,7 @@ static void pci_u3_agp_class_init(ObjectClass *klass,=
 void *data)
 static const TypeInfo pci_u3_agp_info =3D {
     .name          =3D TYPE_U3_AGP_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
-    .instance_size =3D sizeof(UNINState),
+    .instance_size =3D sizeof(UNINHostState),
     .instance_init =3D pci_u3_agp_init,
     .class_init    =3D pci_u3_agp_class_init,
 };
@@ -498,7 +498,7 @@ static void pci_unin_agp_class_init(ObjectClass *klas=
s, void *data)
 static const TypeInfo pci_unin_agp_info =3D {
     .name          =3D TYPE_UNI_NORTH_AGP_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
-    .instance_size =3D sizeof(UNINState),
+    .instance_size =3D sizeof(UNINHostState),
     .instance_init =3D pci_unin_agp_init,
     .class_init    =3D pci_unin_agp_class_init,
 };
@@ -514,7 +514,7 @@ static void pci_unin_internal_class_init(ObjectClass =
*klass, void *data)
 static const TypeInfo pci_unin_internal_info =3D {
     .name          =3D TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
-    .instance_size =3D sizeof(UNINState),
+    .instance_size =3D sizeof(UNINHostState),
     .instance_init =3D pci_unin_internal_init,
     .class_init    =3D pci_unin_internal_class_init,
 };
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 1ab2a3b354..892dd03789 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -89,10 +89,10 @@ void macio_init(PCIDevice *dev,
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
=20
 /* UniNorth PCI */
-UNINState *pci_pmac_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem);
-UNINState *pci_pmac_u3_init(qemu_irq *pic,
-                            MemoryRegion *address_space_mem);
+UNINHostState *pci_pmac_init(qemu_irq *pic,
+                             MemoryRegion *address_space_mem);
+UNINHostState *pci_pmac_u3_init(qemu_irq *pic,
+                                MemoryRegion *address_space_mem);
=20
 /* Mac NVRAM */
 #define TYPE_MACIO_NVRAM "macio-nvram"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bd7ffdb0fb..29bd3838bf 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -150,7 +150,7 @@ static void ppc_core99_init(MachineState *machine)
     MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
     hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
     long kernel_size, initrd_size;
-    UNINState *uninorth_pci;
+    UNINHostState *uninorth_pci;
     PCIBus *pci_bus;
     NewWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index a953b5e9b1..f0e6836c76 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -35,15 +35,15 @@
 #define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
=20
 #define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
 #define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
 #define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRID=
GE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_=
BRIDGE)
 #define U3_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
+    OBJECT_CHECK(UNINHostState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
=20
-typedef struct UNINState {
+typedef struct UNINHostState {
     PCIHostState parent_obj;
=20
     OpenPICState *pic;
@@ -51,6 +51,6 @@ typedef struct UNINState {
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
     MemoryRegion pci_io;
-} UNINState;
+} UNINHostState;
=20
 #endif /* UNINORTH_H */
--=20
2.14.3
