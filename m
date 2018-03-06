Received: from eggs.gnu.org ([2001:4830:134:3::10]:53333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf9-00008N-T7
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf8-0006u6-So
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:23 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 22:01:57 +0000
Message-Id: <20180306220159.4287-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
References: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/6] grackle: move PCI IO (ISA) memory region
 into the grackle device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This simplifies the Old World machine to simply mapping the ISA memory region
into the main address space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/grackle.c | 7 ++++++-
 hw/ppc/mac_oldworld.c | 9 +++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index e4583d493b..4810a4de79 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -41,6 +41,7 @@ typedef struct GrackleState {
     qemu_irq irqs[4];
     MemoryRegion pci_mmio;
     MemoryRegion pci_hole;
+    MemoryRegion pci_io;
 } GrackleState;
 
 /* Don't know if this matches real hardware, but it agrees with OHW.  */
@@ -76,7 +77,7 @@ static void grackle_realize(DeviceState *dev, Error **errp)
                                      pci_grackle_map_irq,
                                      s,
                                      &s->pci_mmio,
-                                     get_system_io(),
+                                     &s->pci_io,
                                      0, 4, TYPE_PCI_BUS);
 
     pci_create_simple(phb->bus, 0, "grackle");
@@ -90,6 +91,9 @@ static void grackle_init(Object *obj)
     PCIHostState *phb = PCI_HOST_BRIDGE(obj);
 
     memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
+    memory_region_init_io(&s->pci_io, OBJECT(s), &unassigned_io_ops, obj,
+                          "pci-isa-mmio", 0x00200000);
+
     memory_region_init_alias(&s->pci_hole, OBJECT(s), "pci-hole", &s->pci_mmio,
                              0x80000000ULL, 0x7e000000ULL);
 
@@ -106,6 +110,7 @@ static void grackle_init(Object *obj)
     sysbus_init_mmio(sbd, &phb->conf_mem);
     sysbus_init_mmio(sbd, &phb->data_mem);
     sysbus_init_mmio(sbd, &s->pci_hole);
+    sysbus_init_mmio(sbd, &s->pci_io);
 }
 
 static void grackle_pci_realize(PCIDevice *d, Error **errp)
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index b3c1f1bc1b..2bf70c4375 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -92,7 +92,6 @@ static void ppc_heathrow_init(MachineState *machine)
     int linux_boot, i;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
-    MemoryRegion *isa = g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
     PCIBus *pci_bus;
@@ -226,11 +225,6 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
 
-    /* Register 2 MB of ISA IO space */
-    memory_region_init_alias(isa, NULL, "isa_mmio",
-                             get_system_io(), 0, 0x00200000);
-    memory_region_add_subregion(sysmem, 0xfe000000, isa);
-
     /* XXX: we register only 1 output pin for heathrow PIC */
     pic_dev = qdev_create(NULL, TYPE_HEATHROW);
     qdev_init_nofail(pic_dev);
@@ -277,6 +271,9 @@ static void ppc_heathrow_init(MachineState *machine)
     /* PCI hole */
     memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
                                 sysbus_mmio_get_region(s, 2));
+    /* Register 2 MB of ISA IO space */
+    memory_region_add_subregion(get_system_memory(), 0xfe000000,
+                                sysbus_mmio_get_region(s, 3));
 
     pci_bus = PCI_HOST_BRIDGE(dev)->bus;
 
-- 
2.11.0
