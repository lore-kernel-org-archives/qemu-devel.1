Received: from eggs.gnu.org ([2001:4830:134:3::10]:59711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaQ-00021P-Ul
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaP-0002F7-CW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:58 +1000
Message-Id: <20180427092126.24812-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/49] uninorth: move PCI IO (ISA) memory region
 into the uninorth device
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

Do this for both the uninorth main and uninorth u3 AGP buses, using the m=
ain
PCI bus for each machine (this ensures the IO addresses still match those
used by OpenBIOS).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c         | 14 ++++++++++----
 hw/ppc/mac_newworld.c          | 12 ++++++------
 include/hw/pci-host/uninorth.h |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index e2278fd0f0..3a29a4410e 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -127,7 +127,7 @@ static void pci_unin_main_realize(DeviceState *dev, E=
rror **errp)
                                    pci_unin_set_irq, pci_unin_map_irq,
                                    s,
                                    &s->pci_mmio,
-                                   get_system_io(),
+                                   &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
=20
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
@@ -155,6 +155,8 @@ static void pci_unin_main_init(Object *obj)
=20
     memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
                        0x100000000ULL);
+    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj=
,
+                          "unin-pci-isa-mmio", 0x00800000);
=20
     memory_region_init_alias(&s->pci_hole, OBJECT(s),
                              "unin-pci-hole", &s->pci_mmio,
@@ -168,6 +170,7 @@ static void pci_unin_main_init(Object *obj)
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
+    sysbus_init_mmio(sbd, &s->pci_io);
 }
=20
 static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
@@ -179,7 +182,7 @@ static void pci_u3_agp_realize(DeviceState *dev, Erro=
r **errp)
                                    pci_unin_set_irq, pci_unin_map_irq,
                                    s,
                                    &s->pci_mmio,
-                                   get_system_io(),
+                                   &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
=20
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
@@ -200,6 +203,8 @@ static void pci_u3_agp_init(Object *obj)
=20
     memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
                        0x100000000ULL);
+    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj=
,
+                          "unin-pci-isa-mmio", 0x00800000);
=20
     memory_region_init_alias(&s->pci_hole, OBJECT(s),
                              "unin-pci-hole", &s->pci_mmio,
@@ -213,6 +218,7 @@ static void pci_u3_agp_init(Object *obj)
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
+    sysbus_init_mmio(sbd, &s->pci_io);
 }
=20
 static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
@@ -224,7 +230,7 @@ static void pci_unin_agp_realize(DeviceState *dev, Er=
ror **errp)
                                    pci_unin_set_irq, pci_unin_map_irq,
                                    s,
                                    &s->pci_mmio,
-                                   get_system_io(),
+                                   &s->pci_io,
                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
=20
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
@@ -261,7 +267,7 @@ static void pci_unin_internal_realize(DeviceState *de=
v, Error **errp)
                                    pci_unin_set_irq, pci_unin_map_irq,
                                    s,
                                    &s->pci_mmio,
-                                   get_system_io(),
+                                   &s->pci_io,
                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
=20
     pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci"=
);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index e05aa26c3d..bd7ffdb0fb 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -145,7 +145,6 @@ static void ppc_core99_init(MachineState *machine)
     CPUPPCState *env =3D NULL;
     char *filename;
     qemu_irq *pic, **openpic_irqs;
-    MemoryRegion *isa =3D g_new(MemoryRegion, 1);
     MemoryRegion *unin_memory =3D g_new(MemoryRegion, 1);
     int linux_boot, i, j, k;
     MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
@@ -273,11 +272,6 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
=20
-    /* Register 8 MB of ISA IO space */
-    memory_region_init_alias(isa, NULL, "isa_mmio",
-                             get_system_io(), 0, 0x00800000);
-    memory_region_add_subregion(get_system_memory(), 0xf2000000, isa);
-
     /* UniN init: XXX should be a real device */
     memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0=
x1000);
     memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_me=
mory);
@@ -355,6 +349,9 @@ static void ppc_core99_init(MachineState *machine)
         /* PCI hole */
         memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
                                     sysbus_mmio_get_region(s, 2));
+        /* Register 8 MB of ISA IO space */
+        memory_region_add_subregion(get_system_memory(), 0xf2000000,
+                                    sysbus_mmio_get_region(s, 3));
         sysbus_mmio_map(s, 0, 0xf0800000);
         sysbus_mmio_map(s, 1, 0xf0c00000);
=20
@@ -389,6 +386,9 @@ static void ppc_core99_init(MachineState *machine)
         /* PCI hole */
         memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
                                     sysbus_mmio_get_region(s, 2));
+        /* Register 8 MB of ISA IO space */
+        memory_region_add_subregion(get_system_memory(), 0xf2000000,
+                                    sysbus_mmio_get_region(s, 3));
         sysbus_mmio_map(s, 0, 0xf2800000);
         sysbus_mmio_map(s, 1, 0xf2c00000);
=20
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index e048fd56e8..a953b5e9b1 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -50,6 +50,7 @@ typedef struct UNINState {
     qemu_irq irqs[4];
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
+    MemoryRegion pci_io;
 } UNINState;
=20
 #endif /* UNINORTH_H */
--=20
2.14.3
