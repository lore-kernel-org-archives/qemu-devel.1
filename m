Received: from eggs.gnu.org ([2001:4830:134:3::10]:59462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza8-0001jc-5Z
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza7-000272-2j
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:55 +1000
Message-Id: <20180427092126.24812-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/49] uninorth: remove obsolete pci_pmac_init()
 function
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

Instead wire up the PCI/AGP host bridges in mac_newworld.c. Now this is complete
it is possible to move the initialisation of the PCI hole alias into
pci_unin_main_init().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c | 46 +++++-----------------------------------------
 hw/ppc/mac_newworld.c  | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index ccde332fa9..8e4e9b3d35 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -146,8 +146,13 @@ static void pci_unin_main_init(Object *obj)
     memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
                        0x100000000ULL);
 
+    memory_region_init_alias(&s->pci_hole, OBJECT(s),
+                             "unin-pci-hole", &s->pci_mmio,
+                             0x80000000ULL, 0x10000000ULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
+    sysbus_init_mmio(sbd, &s->pci_hole);
 }
 
 static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
@@ -242,47 +247,6 @@ static void pci_unin_internal_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
 
-UNINState *pci_pmac_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    UNINState *d;
-
-    /* Use values found on a real PowerMac */
-    /* Uninorth AGP bus */
-    dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
-    qdev_prop_set_ptr(dev, "pic-irqs", pic);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(s, 0, 0xf0800000);
-    sysbus_mmio_map(s, 1, 0xf0c00000);
-
-    /* Uninorth internal bus */
-    dev = qdev_create(NULL, TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
-    qdev_prop_set_ptr(dev, "pic-irqs", pic);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(s, 0, 0xf4800000);
-    sysbus_mmio_map(s, 1, 0xf4c00000);
-
-    /* Uninorth main bus */
-    dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
-    qdev_prop_set_ptr(dev, "pic-irqs", pic);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    d = UNI_NORTH_PCI_HOST_BRIDGE(dev);
-    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
-                             0x80000000ULL, 0x10000000ULL);
-    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
-                                &d->pci_hole);
-
-    sysbus_mmio_map(s, 0, 0xf2800000);
-    sysbus_mmio_map(s, 1, 0xf2c00000);
-
-    return d;
-}
-
 UNINState *pci_pmac_u3_init(qemu_irq *pic,
                             MemoryRegion *address_space_mem)
 {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3367d7bb93..3033fc0d7e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -348,7 +348,35 @@ static void ppc_core99_init(MachineState *machine)
         uninorth_pci = pci_pmac_u3_init(pic, get_system_memory());
         machine_arch = ARCH_MAC99_U3;
     } else {
-        uninorth_pci = pci_pmac_init(pic, get_system_memory());
+        /* Use values found on a real PowerMac */
+        /* Uninorth AGP bus */
+        dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
+        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        qdev_init_nofail(dev);
+        s = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(s, 0, 0xf0800000);
+        sysbus_mmio_map(s, 1, 0xf0c00000);
+
+        /* Uninorth internal bus */
+        dev = qdev_create(NULL, TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
+        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        qdev_init_nofail(dev);
+        s = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(s, 0, 0xf4800000);
+        sysbus_mmio_map(s, 1, 0xf4c00000);
+
+        /* Uninorth main bus */
+        dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        qdev_init_nofail(dev);
+        uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
+        s = SYS_BUS_DEVICE(dev);
+        /* PCI hole */
+        memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
+                                    sysbus_mmio_get_region(s, 2));
+        sysbus_mmio_map(s, 0, 0xf2800000);
+        sysbus_mmio_map(s, 1, 0xf2c00000);
+
         machine_arch = ARCH_MAC99;
     }
 
-- 
2.14.3
