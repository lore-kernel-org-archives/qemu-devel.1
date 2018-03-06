Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKB-0005WK-8P
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJKA-00086W-Bi
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:36:39 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:57 +0000
Message-Id: <20180306203103.25563-14-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 13/19] uninorth: remove obsolete
 pci_pmac_u3_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Instead wire up the PCI/AGP host bridges in mac_newworld.c. Now this is complete
it is possible to move the initialisation of the PCI hole alias into
pci_u3_agp_init().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c | 30 +++++-------------------------
 hw/ppc/mac_newworld.c  | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 8e4e9b3d35..ec6e529d66 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -185,8 +185,13 @@ static void pci_u3_agp_init(Object *obj)
     memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
                        0x100000000ULL);
 
+    memory_region_init_alias(&s->pci_hole, OBJECT(s),
+                             "unin-pci-hole", &s->pci_mmio,
+                             0x80000000ULL, 0x70000000ULL);
+
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
+    sysbus_init_mmio(sbd, &s->pci_hole);
 }
 
 static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
@@ -247,31 +252,6 @@ static void pci_unin_internal_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
 
-UNINState *pci_pmac_u3_init(qemu_irq *pic,
-                            MemoryRegion *address_space_mem)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    UNINState *d;
-
-    /* Uninorth AGP bus */
-    dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
-    qdev_prop_set_ptr(dev, "pic-irqs", pic);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    d = U3_AGP_HOST_BRIDGE(dev);
-
-    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
-                             0x80000000ULL, 0x70000000ULL);
-    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
-                                &d->pci_hole);
-
-    sysbus_mmio_map(s, 0, 0xf0800000);
-    sysbus_mmio_map(s, 1, 0xf0c00000);
-
-    return d;
-}
-
 static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
 {
     /* cache_line_size */
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index da76c33099..f806187d8c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -346,7 +346,18 @@ static void ppc_core99_init(MachineState *machine)
 
     if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
-        uninorth_pci = pci_pmac_u3_init(pic, get_system_memory());
+        /* Uninorth AGP bus */
+        dev = qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
+        qdev_prop_set_ptr(dev, "pic-irqs", pic);
+        qdev_init_nofail(dev);
+        uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
+        s = SYS_BUS_DEVICE(dev);
+        /* PCI hole */
+        memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
+                                    sysbus_mmio_get_region(s, 2));
+        sysbus_mmio_map(s, 0, 0xf0800000);
+        sysbus_mmio_map(s, 1, 0xf0c00000);
+
         machine_arch = ARCH_MAC99_U3;
     } else {
         /* Use values found on a real PowerMac */
-- 
2.11.0
