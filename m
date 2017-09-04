Received: from eggs.gnu.org ([2001:4830:134:3::10]:52685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSX-00055N-0B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSH-0004pv-MX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSH-0004oE-Ew
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSG-0005XN-7H
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:50 +0100
Message-Id: <1504527967-29248-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/36] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
CPU state.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1500471597-2517-2-git-send-email-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 ++
 hw/arm/virt.c    | 3 +++
 target/arm/cpu.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eabef00..92771d3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -585,6 +585,8 @@ struct ARMCPU {
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
     qemu_irq gicv3_maintenance_interrupt;
+    /* GPIO output for the PMU interrupt */
+    qemu_irq pmu_interrupt;
 
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6b7a0fe..a06ec13 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -610,6 +610,9 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
         qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
                                     qdev_get_gpio_in(gicdev, ppibase
                                                      + ARCH_GICV3_MAINT_IRQ));
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev, ppibase
+                                                     + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(gicbusdev, i + smp_cpus,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b241a63..41ae6ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -508,6 +508,8 @@ static void arm_cpu_initfn(Object *obj)
 
     qdev_init_gpio_out_named(DEVICE(cpu), &cpu->gicv3_maintenance_interrupt,
                              "gicv3-maintenance-interrupt", 1);
+    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
+                             "pmu-interrupt", 1);
 #endif
 
     /* DTB consumers generally don't in fact care what the 'compatible'
-- 
2.7.4
