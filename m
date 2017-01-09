Received: from eggs.gnu.org ([2001:4830:134:3::10]:40450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcSF-00084Y-FD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcSB-0003q8-Ig
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:51 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 16:05:09 +0000
Message-Id: <1483977924-14522-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/18] target-arm: Expose output GPIO line
 for VCPU maintenance interrupt
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

The GICv3 support for virtualization includes an outbound
maintenance interrupt signal which is asserted when the
CPU interface wants to signal to the hypervisor that it
needs attention. Expose this as an outbound GPIO line from
the CPU object which can be wired up as a physical interrupt
line by the board code (as we do already for the CPU timers).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/cpu.h | 2 ++
 target/arm/cpu.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab119e6..764b511 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -555,6 +555,8 @@ struct ARMCPU {
     QEMUTimer *gt_timer[NUM_GTIMERS];
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
+    /* GPIO output for GICv3 maintenance interrupt signal */
+    qemu_irq gicv3_maintenance_interrupt;
 
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f5cb30a..8932086 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -466,6 +466,9 @@ static void arm_cpu_initfn(Object *obj)
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
