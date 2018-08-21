Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6i4-00060c-FL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6i2-0003qE-RV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 14:28:06 +0100
Message-Id: <20180821132811.17675-5-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-1-peter.maydell@linaro.org>
References: <20180821132811.17675-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/9] hw/arm/highbank: Connect VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>

Connect the VIRQ and VFIQ lines from the GIC to the CPU;
these exist always for both CPU and GIC whether the
virtualization extensions are enabled or not, so we
can just unconditionally connect them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 6d42fce2c37..fb9efa02c35 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -243,6 +243,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     int n;
     qemu_irq cpu_irq[4];
     qemu_irq cpu_fiq[4];
+    qemu_irq cpu_virq[4];
+    qemu_irq cpu_vfiq[4];
     MemoryRegion *sysram;
     MemoryRegion *dram;
     MemoryRegion *sysmem;
@@ -282,6 +284,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
         cpu_fiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ);
+        cpu_virq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VIRQ);
+        cpu_vfiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VFIQ);
     }
 
     sysmem = get_system_memory();
@@ -329,6 +333,8 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     for (n = 0; n < smp_cpus; n++) {
         sysbus_connect_irq(busdev, n, cpu_irq[n]);
         sysbus_connect_irq(busdev, n + smp_cpus, cpu_fiq[n]);
+        sysbus_connect_irq(busdev, n + 2 * smp_cpus, cpu_virq[n]);
+        sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
     }
 
     for (n = 0; n < 128; n++) {
-- 
2.18.0
