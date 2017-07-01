Received: from eggs.gnu.org ([2001:4830:134:3::10]:52802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYN-00084J-2Q
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYM-0000SO-8a
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:27 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Sat,  1 Jul 2017 12:47:15 -0400
Message-Id: <1498927637-14496-2-git-send-email-drjones@redhat.com>
In-Reply-To: <1498927637-14496-1-git-send-email-drjones@redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] hw/arm/virt: add pmu interrupt state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, agraf@suse.de

Mimicking gicv3-maintenance-interrupt, add the PMU's interrupt to
CPU state.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c    | 3 +++
 target/arm/cpu.c | 2 ++
 target/arm/cpu.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 010f7244bf7c..9781e1cc5ed7 100644
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
index 28a914129857..70cc8f4474af 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -499,6 +499,8 @@ static void arm_cpu_initfn(Object *obj)
 
     qdev_init_gpio_out_named(DEVICE(cpu), &cpu->gicv3_maintenance_interrupt,
                              "gicv3-maintenance-interrupt", 1);
+    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
+                             "pmu-interrupt", 1);
 #endif
 
     /* DTB consumers generally don't in fact care what the 'compatible'
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 102c58afac52..8d91166eb97b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -584,6 +584,8 @@ struct ARMCPU {
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
     /* GPIO output for GICv3 maintenance interrupt signal */
     qemu_irq gicv3_maintenance_interrupt;
+    /* GPIO output for the PMU interrupt */
+    qemu_irq pmu_interrupt;
 
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
-- 
1.8.3.1
