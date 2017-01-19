Received: from eggs.gnu.org ([2001:4830:134:3::10]:47296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPm-0000qv-3f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPl-00054z-53
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPk-0004w9-Ub
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPh-0003B8-Pf
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:40 +0000
Message-Id: <1484834995-26826-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/36] target-arm: Expose output GPIO line for
 VCPU maintenance interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The GICv3 support for virtualization includes an outbound
maintenance interrupt signal which is asserted when the
CPU interface wants to signal to the hypervisor that it
needs attention. Expose this as an outbound GPIO line from
the CPU object which can be wired up as a physical interrupt
line by the board code (as we do already for the CPU timers).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1483977924-14522-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h | 2 ++
 target/arm/cpu.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7bd16ee..fa09498 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -558,6 +558,8 @@ struct ARMCPU {
     QEMUTimer *gt_timer[NUM_GTIMERS];
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
+    /* GPIO output for GICv3 maintenance interrupt signal */
+    qemu_irq gicv3_maintenance_interrupt;
 
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9104611..93ebbc9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -465,6 +465,9 @@ static void arm_cpu_initfn(Object *obj)
                                                 arm_gt_stimer_cb, cpu);
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
                        ARRAY_SIZE(cpu->gt_timer_outputs));
+
+    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->gicv3_maintenance_interrupt,
+                             "gicv3-maintenance-interrupt", 1);
 #endif
 
     /* DTB consumers generally don't in fact care what the 'compatible'
-- 
2.7.4
