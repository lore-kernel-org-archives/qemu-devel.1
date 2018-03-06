Received: from eggs.gnu.org ([2001:4830:134:3::10]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf9-00008F-Jw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf8-0006tJ-EH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:23 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 22:01:56 +0000
Message-Id: <20180306220159.4287-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
References: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/6] grackle: remove deprecated
 pci_grackle_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Instead wire up the grackle device inside the Mac Old World machine.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/grackle.c | 28 +---------------------------
 hw/ppc/mac.h          |  3 ---
 hw/ppc/mac_oldworld.c | 21 ++++++++++++++++++---
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index f8935246c3..e4583d493b 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -66,33 +66,6 @@ static void grackle_init_irqs(GrackleState *s)
     }
 }
 
-PCIBus *pci_grackle_init(uint32_t base, DeviceState *pic_dev,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    PCIHostState *phb;
-    GrackleState *d;
-
-    dev = qdev_create(NULL, TYPE_GRACKLE_PCI_HOST_BRIDGE);
-    object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
-                             &error_abort);
-    qdev_init_nofail(dev);
-
-    s = SYS_BUS_DEVICE(dev);
-    phb = PCI_HOST_BRIDGE(dev);
-    d = GRACKLE_PCI_HOST_BRIDGE(dev);
-
-    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
-                                &d->pci_hole);
-
-    sysbus_mmio_map(s, 0, base);
-    sysbus_mmio_map(s, 1, base + 0x00200000);
-
-    return phb->bus;
-}
-
 static void grackle_realize(DeviceState *dev, Error **errp)
 {
     GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
@@ -132,6 +105,7 @@ static void grackle_init(Object *obj)
 
     sysbus_init_mmio(sbd, &phb->conf_mem);
     sysbus_init_mmio(sbd, &phb->data_mem);
+    sysbus_init_mmio(sbd, &s->pci_hole);
 }
 
 static void grackle_pci_realize(PCIDevice *d, Error **errp)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 2359deb1ec..04568c2a22 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -77,9 +77,6 @@ void macio_init(PCIDevice *dev,
 
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
-PCIBus *pci_grackle_init(uint32_t base, DeviceState *pic_dev,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io);
 
 /* UniNorth PCI */
 PCIBus *pci_pmac_init(qemu_irq *pic,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 17711971e6..b3c1f1bc1b 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -34,6 +34,7 @@
 #include "net/net.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
@@ -56,6 +57,8 @@
 
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
 
+#define GRACKLE_BASE 0xfec00000
+
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
 {
@@ -95,6 +98,7 @@ static void ppc_heathrow_init(MachineState *machine)
     PCIBus *pci_bus;
     OldWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
+    SysBusDevice *s;
     DeviceState *dev, *pic_dev;
     BusState *adb_bus;
     int bios_size, ndrv_size;
@@ -262,9 +266,20 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
 
-    pci_bus = pci_grackle_init(0xfec00000, pic_dev,
-                               get_system_memory(),
-                               get_system_io());
+    /* Grackle PCI host bridge */
+    dev = qdev_create(NULL, TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+                             &error_abort);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, GRACKLE_BASE);
+    sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
+    /* PCI hole */
+    memory_region_add_subregion(get_system_memory(), 0x80000000ULL,
+                                sysbus_mmio_get_region(s, 2));
+
+    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
+
     pci_vga_init(pci_bus);
 
     for (i = 0; i < nb_nics; i++) {
-- 
2.11.0
