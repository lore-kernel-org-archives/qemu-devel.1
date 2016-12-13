Received: from eggs.gnu.org ([2001:4830:134:3::10]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cGkSs-0005cn-GL
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cGkSr-0000Ay-EA
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:37:42 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 10:36:12 +0000
Message-Id: <1481625384-15077-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/23] hw/arm/virt: Wire VIRQ, VFIQ,
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
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>

Wire the new VIRQ, VFIQ and maintenance interrupt lines from the
GIC to each CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9650193..b805b76 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,6 +36,8 @@
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
 
+#define ARCH_GICV3_MAINT_IRQ  9
+
 #define ARCH_TIMER_VIRT_IRQ   11
 #define ARCH_TIMER_S_EL1_IRQ  13
 #define ARCH_TIMER_NS_EL1_IRQ 14
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2ca9527..7adb58b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -583,9 +583,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
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
@@ -607,9 +607,17 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
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
