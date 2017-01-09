Received: from eggs.gnu.org ([2001:4830:134:3::10]:40438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcSE-00083a-Jf
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcS9-0003p4-Vc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 16:05:10 +0000
Message-Id: <1483977924-14522-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/18] hw/arm/virt: Wire VIRQ, VFIQ,
 maintenance irq lines from GIC to CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

Wire the new VIRQ, VFIQ and maintenance interrupt lines from the
GIC to each CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index eb1c63d..b8a19ec 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -39,6 +39,8 @@
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
 
+#define ARCH_GICV3_MAINT_IRQ  9
+
 #define ARCH_TIMER_VIRT_IRQ   11
 #define ARCH_TIMER_S_EL1_IRQ  13
 #define ARCH_TIMER_NS_EL1_IRQ 14
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..b31d302 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -547,9 +547,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
     }
 
-    /* Wire the outputs from each CPU's generic timer to the
-     * appropriate GIC PPI inputs, and the GIC's IRQ output to
-     * the CPU's IRQ input.
+    /* Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
@@ -571,9 +571,17 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
                                                    ppibase + timer_irq[irq]));
         }
 
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev, ppibase
+                                                     + ARCH_GICV3_MAINT_IRQ));
+
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(gicbusdev, i + smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
     for (i = 0; i < NUM_IRQS; i++) {
-- 
2.7.4
