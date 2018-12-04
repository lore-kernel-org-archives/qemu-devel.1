Received: from eggs.gnu.org ([2001:4830:134:3::10]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmC-0007ph-OZ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmB-00019H-4X
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:12 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Dec 2018 13:29:52 +0000
Message-Id: <20181204132952.2601-6-peter.maydell@linaro.org>
In-Reply-To: <20181204132952.2601-1-peter.maydell@linaro.org>
References: <20181204132952.2601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] target/arm: Create timers in realize,
 not init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The timer_new() function allocates memory; this means that
if we call it in the CPU's init method we would need
to provide an instance_finalize method to free it. Defer
the timer creation to the realize function instead.

This fixes a memory leak spotted by clang LeakSanitizer
when a CPU object is created for introspection.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b84a6c0e678..0e7138c9bfb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -679,14 +679,6 @@ static void arm_cpu_initfn(Object *obj)
         qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
     }
 
-    cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                                arm_gt_ptimer_cb, cpu);
-    cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                                arm_gt_vtimer_cb, cpu);
-    cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                                arm_gt_htimer_cb, cpu);
-    cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
-                                                arm_gt_stimer_cb, cpu);
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
                        ARRAY_SIZE(cpu->gt_timer_outputs));
 
@@ -882,6 +874,15 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                           arm_gt_ptimer_cb, cpu);
+    cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                           arm_gt_vtimer_cb, cpu);
+    cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                          arm_gt_htimer_cb, cpu);
+    cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
+                                          arm_gt_stimer_cb, cpu);
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
-- 
2.19.2
