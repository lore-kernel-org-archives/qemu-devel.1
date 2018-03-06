Received: from eggs.gnu.org ([2001:4830:134:3::10]:49419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nw-0001VC-KI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nv-0004U7-3d
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:37 +1100
Message-Id: <20180306040154.3669-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/30] heathrow: change heathrow_pic_init() to
 return the heathrow device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This enables the device to be made available during the setup of the Old World
machine. In order to pass back the previous set of IRQs we temporarily introduce
a new pic_irqs parameter until it can be removed.

An additional benefit of this change is that it is also possible to remove the
pic_mem pointer used for macio by accessing the memory region via sysbus.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/heathrow_pic.c | 10 ++++++----
 hw/ppc/mac.h           |  4 ++--
 hw/ppc/mac_oldworld.c  |  9 +++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 5fd2b33a12..393fdd7326 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -170,13 +170,15 @@ static void heathrow_reset(DeviceState *d)
 static void heathrow_init(Object *obj)
 {
     HeathrowState *s = HEATHROW(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
                           "heathrow-pic", 0x1000);
+    sysbus_init_mmio(sbd, &s->mem);
 }
 
-qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
-                            int nb_cpus, qemu_irq **irqs)
+DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
+                               qemu_irq **pic_irqs)
 {
     DeviceState *d;
     HeathrowState *s;
@@ -188,9 +190,9 @@ qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
     /* only 1 CPU */
     s->irqs = irqs[0];
 
-    *pmem = &s->mem;
+    *pic_irqs = qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
 
-    return qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
+    return d;
 }
 
 static void heathrow_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 261b519aa5..5b5fffdff3 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -79,8 +79,8 @@ void macio_init(PCIDevice *dev,
                 MemoryRegion *pic_mem);
 
 /* Heathrow PIC */
-qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
-                            int nb_cpus, qemu_irq **irqs);
+DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
+                               qemu_irq **pic_irqs);
 
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 4401ce5af2..06a61220cb 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -94,11 +94,11 @@ static void ppc_heathrow_init(MachineState *machine)
     PCIBus *pci_bus;
     PCIDevice *macio;
     MACIOIDEState *macio_ide;
-    DeviceState *dev;
+    DeviceState *dev, *pic_dev;
+    SysBusDevice *sbd;
     BusState *adb_bus;
     int bios_size, ndrv_size;
     uint8_t *ndrv_file;
-    MemoryRegion *pic_mem;
     uint16_t ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     void *fw_cfg;
@@ -257,7 +257,7 @@ static void ppc_heathrow_init(MachineState *machine)
         error_report("Only 6xx bus is supported on heathrow machine");
         exit(1);
     }
-    pic = heathrow_pic_init(&pic_mem, 1, heathrow_irqs);
+    pic_dev = heathrow_pic_init(1, heathrow_irqs, &pic);
     pci_bus = pci_grackle_init(0xfec00000, pic,
                                get_system_memory(),
                                get_system_io());
@@ -280,7 +280,8 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
     qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
-    macio_init(macio, pic_mem);
+    sbd = SYS_BUS_DEVICE(pic_dev);
+    macio_init(macio, sysbus_mmio_get_region(sbd, 0));
 
     macio_ide = MACIO_IDE(object_resolve_path_component(OBJECT(macio),
                                                         "ide[0]"));
-- 
2.14.3
