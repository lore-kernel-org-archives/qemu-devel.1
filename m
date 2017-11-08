Received: from eggs.gnu.org ([2001:4830:134:3::10]:40648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTX-0005vu-5Y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTU-0000RH-1E
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 Nov 2017 19:12:32 +1100
Message-Id: <20171108081232.28322-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171108081232.28322-1-david@gibson.dropbear.id.au>
References: <20171108081232.28322-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/3] e500: ppce500_init_mpic() return device
 instead of IRQ array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, Michael Davidsaver <mdavidsaver@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Davidsaver <mdavidsaver@gmail.com>

Actual number of interrupt pins isn't known
in ppce500_init_mpic() so a hardcoded number
was used, which causes a crash with older openpic.

Instead, return the DeviceState* and change ppce500_init()
to call qdev_get_gpio_in() to get only the irq pins
which are needed.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 9178e70132..5cf0dabef3 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -729,15 +729,13 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
     return dev;
 }
 
-static qemu_irq *ppce500_init_mpic(MachineState *machine, PPCE500Params *params,
-                                   MemoryRegion *ccsr, qemu_irq **irqs)
+static DeviceState *ppce500_init_mpic(MachineState *machine,
+                                      PPCE500Params *params,
+                                      MemoryRegion *ccsr,
+                                      qemu_irq **irqs)
 {
-    qemu_irq *mpic;
     DeviceState *dev = NULL;
     SysBusDevice *s;
-    int i;
-
-    mpic = g_new0(qemu_irq, 256);
 
     if (kvm_enabled()) {
         Error *err = NULL;
@@ -756,15 +754,11 @@ static qemu_irq *ppce500_init_mpic(MachineState *machine, PPCE500Params *params,
         dev = ppce500_init_mpic_qemu(params, irqs);
     }
 
-    for (i = 0; i < 256; i++) {
-        mpic[i] = qdev_get_gpio_in(dev, i);
-    }
-
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(ccsr, MPC8544_MPIC_REGS_OFFSET,
                                 s->mmio[0].memory);
 
-    return mpic;
+    return dev;
 }
 
 static void ppce500_power_off(void *opaque, int line, int on)
@@ -796,8 +790,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
      * 4 respectively */
     unsigned int pci_irq_nrs[PCI_NUM_PINS] = {1, 2, 3, 4};
-    qemu_irq **irqs, *mpic;
-    DeviceState *dev;
+    qemu_irq **irqs;
+    DeviceState *dev, *mpicdev;
     CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
@@ -866,18 +860,18 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     memory_region_add_subregion(address_space_mem, params->ccsrbar_base,
                                 ccsr_addr_space);
 
-    mpic = ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
+    mpicdev = ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
 
     /* Serial */
     if (serial_hds[0]) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
-                       0, mpic[42], 399193,
+                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hds[0], DEVICE_BIG_ENDIAN);
     }
 
     if (serial_hds[1]) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
-                       0, mpic[42], 399193,
+                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hds[1], DEVICE_BIG_ENDIAN);
     }
 
@@ -895,7 +889,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        sysbus_connect_irq(s, i, mpic[pci_irq_nrs[i]]);
+        sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i]));
     }
 
     memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
@@ -926,7 +920,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         dev = qdev_create(NULL, "mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
         qdev_init_nofail(dev);
-        sysbus_connect_irq(s, 0, mpic[MPC8XXX_GPIO_IRQ]);
+        sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_IRQ));
         memory_region_add_subregion(ccsr_addr_space, MPC8XXX_GPIO_OFFSET,
                                     sysbus_mmio_get_region(s, 0));
 
@@ -946,7 +940,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
 
         for (i = 0; i < params->platform_bus_num_irqs; i++) {
             int irqn = params->platform_bus_first_irq + i;
-            sysbus_connect_irq(s, i, mpic[irqn]);
+            sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
         }
 
         memory_region_add_subregion(address_space_mem,
-- 
2.13.6
