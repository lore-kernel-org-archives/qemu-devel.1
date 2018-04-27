Received: from eggs.gnu.org ([2001:4830:134:3::10]:58991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZU-0000sy-3g
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZS-0001p8-LW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:44 +1000
Message-Id: <20180427092126.24812-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/49] heathrow: remove obsolete heathow_init()
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

Instead wire up heathrow to the CPU and grackle PCI host using qdev GPIOs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/heathrow_pic.c         | 23 +++++------------------
 hw/ppc/mac.h                   |  4 ----
 hw/ppc/mac_oldworld.c          | 20 ++++++++++++--------
 include/hw/intc/heathrow_pic.h |  2 +-
 4 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 393fdd7326..b8b997deca 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -172,27 +172,14 @@ static void heathrow_init(Object *obj)
     HeathrowState *s = HEATHROW(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
-                          "heathrow-pic", 0x1000);
-    sysbus_init_mmio(sbd, &s->mem);
-}
-
-DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
-                               qemu_irq **pic_irqs)
-{
-    DeviceState *d;
-    HeathrowState *s;
-
-    d = qdev_create(NULL, TYPE_HEATHROW);
-    qdev_init_nofail(d);
-
-    s = HEATHROW(d);
     /* only 1 CPU */
-    s->irqs = irqs[0];
+    qdev_init_gpio_out(DEVICE(obj), s->irqs, 1);
 
-    *pic_irqs = qemu_allocate_irqs(heathrow_set_irq, s, HEATHROW_NUM_IRQS);
+    qdev_init_gpio_in(DEVICE(obj), heathrow_set_irq, HEATHROW_NUM_IRQS);
 
-    return d;
+    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
+                          "heathrow-pic", 0x1000);
+    sysbus_init_mmio(sbd, &s->mem);
 }
 
 static void heathrow_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index fcf13cb757..d661515e9d 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -77,10 +77,6 @@ void macio_ide_register_dma(MACIOIDEState *ide);
 void macio_init(PCIDevice *dev,
                 MemoryRegion *pic_mem);
 
-/* Heathrow PIC */
-DeviceState *heathrow_pic_init(int nb_cpus, qemu_irq **irqs,
-                               qemu_irq **pic_irqs);
-
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
 PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 10e291ca22..9bd4ece16d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -84,7 +84,7 @@ static void ppc_heathrow_init(MachineState *machine)
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
-    qemu_irq *pic, **heathrow_irqs;
+    qemu_irq *pic;
     int linux_boot, i;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
@@ -227,16 +227,15 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0xfe000000, isa);
 
     /* XXX: we register only 1 output pin for heathrow PIC */
-    heathrow_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
-    heathrow_irqs[0] =
-        g_malloc0(smp_cpus * sizeof(qemu_irq) * 1);
+    pic_dev = qdev_create(NULL, TYPE_HEATHROW);
+    qdev_init_nofail(pic_dev);
+
     /* Connect the heathrow PIC outputs to the 6xx bus */
     for (i = 0; i < smp_cpus; i++) {
         switch (PPC_INPUT(env)) {
         case PPC_FLAGS_INPUT_6xx:
-            heathrow_irqs[i] = heathrow_irqs[0] + (i * 1);
-            heathrow_irqs[i][0] =
-                ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT];
+            qdev_connect_gpio_out(pic_dev, 0,
+                ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT]);
             break;
         default:
             error_report("Bus model not supported on OldWorld Mac machine");
@@ -244,6 +243,11 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
 
+    pic = g_new0(qemu_irq, HEATHROW_NUM_IRQS);
+    for (i = 0; i < HEATHROW_NUM_IRQS; i++) {
+        pic[i] = qdev_get_gpio_in(pic_dev, i);
+    }
+
     /* Timebase Frequency */
     if (kvm_enabled()) {
         tbfreq = kvmppc_get_tbfreq();
@@ -256,7 +260,7 @@ static void ppc_heathrow_init(MachineState *machine)
         error_report("Only 6xx bus is supported on heathrow machine");
         exit(1);
     }
-    pic_dev = heathrow_pic_init(1, heathrow_irqs, &pic);
+
     pci_bus = pci_grackle_init(0xfec00000, pic,
                                get_system_memory(),
                                get_system_io());
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
index bc3ffaab87..56c2ef339f 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -41,7 +41,7 @@ typedef struct HeathrowState {
 
     MemoryRegion mem;
     HeathrowPICState pics[2];
-    qemu_irq *irqs;
+    qemu_irq irqs[1];
 } HeathrowState;
 
 #define HEATHROW_NUM_IRQS 64
-- 
2.14.3
