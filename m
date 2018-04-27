Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza2-0001d6-LZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZz-00022n-J6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:52 +1000
Message-Id: <20180427092126.24812-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/49] uninorth: move PCI host bridge bus
 initialisation into device realize
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

Since the IO address space is fixed to use the standard system IO address
space then we can also use the opportunity to remove the address_space_io
parameter from pci_pmac_init() and pci_pmac_u3_init().

Note we also move the default mac99 PCI bus to the end of the initialisat=
ion
list so that it becomes the default destination for any devices specified
via -device without an explicit PCI bus provided.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c | 117 ++++++++++++++++++++++++++++---------------=
------
 hw/ppc/mac.h           |   6 +--
 hw/ppc/mac_newworld.c  |   6 +--
 3 files changed, 72 insertions(+), 57 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index fc59698f06..426b3c4e33 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -109,6 +109,27 @@ static const MemoryRegionOps unin_data_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
+static void pci_unin_main_realize(DeviceState *dev, Error **errp)
+{
+    UNINState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
+    PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
+
+    h->bus =3D pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   s->pic_irqs,
+                                   &s->pci_mmio,
+                                   get_system_io(),
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+
+    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
+
+    /* DEC 21154 bridge */
+#if 0
+    /* XXX: not activated as PPC BIOS doesn't handle multiple buses prop=
erly */
+    pci_create_simple(h->bus, PCI_DEVFN(12, 0), "dec-21154");
+#endif
+}
+
 static void pci_unin_main_init(Object *obj)
 {
     UNINState *s =3D UNI_NORTH_PCI_HOST_BRIDGE(obj);
@@ -129,6 +150,21 @@ static void pci_unin_main_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
=20
+static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
+{
+    UNINState *s =3D U3_AGP_HOST_BRIDGE(dev);
+    PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
+
+    h->bus =3D pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   s->pic_irqs,
+                                   &s->pci_mmio,
+                                   get_system_io(),
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+
+    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
+}
+
 static void pci_u3_agp_init(Object *obj)
 {
     UNINState *s =3D U3_AGP_HOST_BRIDGE(obj);
@@ -148,6 +184,19 @@ static void pci_u3_agp_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
=20
+static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
+{
+    UNINState *s =3D UNI_NORTH_AGP_HOST_BRIDGE(dev);
+    PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
+
+    h->bus =3D pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   s->pic_irqs,
+                                   &s->pci_mmio,
+                                   get_system_io(),
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+}
+
 static void pci_unin_agp_init(Object *obj)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
@@ -177,49 +226,14 @@ static void pci_unin_internal_init(Object *obj)
 }
=20
 UNINState *pci_pmac_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io)
+                         MemoryRegion *address_space_mem)
 {
     DeviceState *dev;
     SysBusDevice *s;
-    PCIHostState *h;
     UNINState *d;
=20
     /* Use values found on a real PowerMac */
-    /* Uninorth main bus */
-    dev =3D qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
-    qdev_prop_set_ptr(dev, "pic-irqs", pic);
-    qdev_init_nofail(dev);
-    s =3D SYS_BUS_DEVICE(dev);
-    h =3D PCI_HOST_BRIDGE(s);
-    d =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
-    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pc=
i_mmio,
-                             0x80000000ULL, 0x10000000ULL);
-    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
-                                &d->pci_hole);
-
-    h->bus =3D pci_register_root_bus(dev, NULL,
-                                   pci_unin_set_irq, pci_unin_map_irq,
-                                   d->pic_irqs,
-                                   &d->pci_mmio,
-                                   address_space_io,
-                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
-
-#if 0
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
-#endif
-
-    sysbus_mmio_map(s, 0, 0xf2800000);
-    sysbus_mmio_map(s, 1, 0xf2c00000);
-
-    /* DEC 21154 bridge */
-#if 0
-    /* XXX: not activated as PPC BIOS doesn't handle multiple buses prop=
erly */
-    pci_create_simple(h->bus, PCI_DEVFN(12, 0), "dec-21154");
-#endif
-
     /* Uninorth AGP bus */
-    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
     dev =3D qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
     qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
@@ -239,16 +253,28 @@ UNINState *pci_pmac_init(qemu_irq *pic,
     sysbus_mmio_map(s, 1, 0xf4c00000);
 #endif
=20
+    /* Uninorth main bus */
+    dev =3D qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+    qdev_prop_set_ptr(dev, "pic-irqs", pic);
+    qdev_init_nofail(dev);
+    s =3D SYS_BUS_DEVICE(dev);
+    d =3D UNI_NORTH_PCI_HOST_BRIDGE(dev);
+    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pc=
i_mmio,
+                             0x80000000ULL, 0x10000000ULL);
+    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
+                                &d->pci_hole);
+
+    sysbus_mmio_map(s, 0, 0xf2800000);
+    sysbus_mmio_map(s, 1, 0xf2c00000);
+
     return d;
 }
=20
 UNINState *pci_pmac_u3_init(qemu_irq *pic,
-                            MemoryRegion *address_space_mem,
-                            MemoryRegion *address_space_io)
+                            MemoryRegion *address_space_mem)
 {
     DeviceState *dev;
     SysBusDevice *s;
-    PCIHostState *h;
     UNINState *d;
=20
     /* Uninorth AGP bus */
@@ -256,7 +282,6 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
     qdev_prop_set_ptr(dev, "pic-irqs", pic);
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
-    h =3D PCI_HOST_BRIDGE(dev);
     d =3D U3_AGP_HOST_BRIDGE(dev);
=20
     memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pc=
i_mmio,
@@ -264,18 +289,9 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
=20
-    h->bus =3D pci_register_root_bus(dev, NULL,
-                                   pci_unin_set_irq, pci_unin_map_irq,
-                                   d->pic_irqs,
-                                   &d->pci_mmio,
-                                   address_space_io,
-                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
-
     sysbus_mmio_map(s, 0, 0xf0800000);
     sysbus_mmio_map(s, 1, 0xf0c00000);
=20
-    pci_create_simple(h->bus, 11 << 3, "u3-agp");
-
     return d;
 }
=20
@@ -448,6 +464,7 @@ static void pci_unin_main_class_init(ObjectClass *kla=
ss, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->realize =3D pci_unin_main_realize;
     dc->props =3D pci_unin_main_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
@@ -469,6 +486,7 @@ static void pci_u3_agp_class_init(ObjectClass *klass,=
 void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->realize =3D pci_u3_agp_realize;
     dc->props =3D pci_u3_agp_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
@@ -490,6 +508,7 @@ static void pci_unin_agp_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->realize =3D pci_unin_agp_realize;
     dc->props =3D pci_unin_agp_class_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index c5a33e96cb..1ab2a3b354 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -90,11 +90,9 @@ void macio_init(PCIDevice *dev,
=20
 /* UniNorth PCI */
 UNINState *pci_pmac_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io);
+                         MemoryRegion *address_space_mem);
 UNINState *pci_pmac_u3_init(qemu_irq *pic,
-                            MemoryRegion *address_space_mem,
-                            MemoryRegion *address_space_io);
+                            MemoryRegion *address_space_mem);
=20
 /* Mac NVRAM */
 #define TYPE_MACIO_NVRAM "macio-nvram"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index ccf34ee36c..3367d7bb93 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -345,12 +345,10 @@ static void ppc_core99_init(MachineState *machine)
=20
     if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
-        uninorth_pci =3D pci_pmac_u3_init(pic, get_system_memory(),
-                                        get_system_io());
+        uninorth_pci =3D pci_pmac_u3_init(pic, get_system_memory());
         machine_arch =3D ARCH_MAC99_U3;
     } else {
-        uninorth_pci =3D pci_pmac_init(pic, get_system_memory(),
-                                     get_system_io());
+        uninorth_pci =3D pci_pmac_init(pic, get_system_memory());
         machine_arch =3D ARCH_MAC99;
     }
=20
--=20
2.14.3
