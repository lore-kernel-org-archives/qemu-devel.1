Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQx-0000QZ-4a
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1egXQn-0005d6-CE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:02:51 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 15:02:20 +0000
Message-Id: <1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] target/arm: Make v7m_push_callee_stack()
 honour MPU
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

Make v7m_push_callee_stack() honour the MPU by using the
new v7m_stack_write() function. We return a flag to indicate
whether the pushes failed, which we can then use in
v7m_exception_taken() to cause us to handle the derived
exception correctly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 64 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 007e760..de0031b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6473,7 +6473,7 @@ static uint32_t arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure)
     return addr;
 }
 
-static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
+static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                                   bool ignore_faults)
 {
     /* For v8M, push the callee-saves register part of the stack frame.
@@ -6481,31 +6481,55 @@ static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
      * In the tailchaining case this may not be the current stack.
      */
     CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
     uint32_t *frame_sp_p;
     uint32_t frameptr;
+    ARMMMUIdx mmu_idx;
+    bool stacked_ok;
 
     if (dotailchain) {
-        frame_sp_p = get_v7m_sp_ptr(env, true,
-                                    lr & R_V7M_EXCRET_MODE_MASK,
+        bool mode = lr & R_V7M_EXCRET_MODE_MASK;
+        bool priv = !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_NPRIV_MASK) ||
+            !mode;
+
+        mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, M_REG_S, priv);
+        frame_sp_p = get_v7m_sp_ptr(env, M_REG_S, mode,
                                     lr & R_V7M_EXCRET_SPSEL_MASK);
     } else {
+        mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
         frame_sp_p = &env->regs[13];
     }
 
     frameptr = *frame_sp_p - 0x28;
 
-    stl_phys(cs->as, frameptr, 0xfefa125b);
-    stl_phys(cs->as, frameptr + 0x8, env->regs[4]);
-    stl_phys(cs->as, frameptr + 0xc, env->regs[5]);
-    stl_phys(cs->as, frameptr + 0x10, env->regs[6]);
-    stl_phys(cs->as, frameptr + 0x14, env->regs[7]);
-    stl_phys(cs->as, frameptr + 0x18, env->regs[8]);
-    stl_phys(cs->as, frameptr + 0x1c, env->regs[9]);
-    stl_phys(cs->as, frameptr + 0x20, env->regs[10]);
-    stl_phys(cs->as, frameptr + 0x24, env->regs[11]);
+    /* Write as much of the stack frame as we can. A write failure may
+     * cause us to pend a derived exception.
+     */
+    stacked_ok =
+        v7m_stack_write(cpu, frameptr, 0xfefa125b, mmu_idx, ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x10, env->regs[6], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x14, env->regs[7], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x18, env->regs[8], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x1c, env->regs[9], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x20, env->regs[10], mmu_idx,
+                        ignore_faults) &&
+        v7m_stack_write(cpu, frameptr + 0x24, env->regs[11], mmu_idx,
+                        ignore_faults);
 
+    /* Update SP regardless of whether any of the stack accesses failed.
+     * When we implement v8M stack limit checking then this attempt to
+     * update SP might also fail and result in a derived exception.
+     */
     *frame_sp_p = frameptr;
+
+    return !stacked_ok;
 }
 
 static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
@@ -6519,6 +6543,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     uint32_t addr;
     bool targets_secure;
     int exc;
+    bool push_failed = false;
 
     armv7m_nvic_get_pending_irq_info(env->nvic, &exc, &targets_secure);
 
@@ -6546,8 +6571,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                  */
                 if (lr & R_V7M_EXCRET_DCRS_MASK &&
                     !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
-                    v7m_push_callee_stack(cpu, lr, dotailchain,
-                                          ignore_stackfaults);
+                    push_failed = v7m_push_callee_stack(cpu, lr, dotailchain,
+                                                        ignore_stackfaults);
                 }
                 lr |= R_V7M_EXCRET_DCRS_MASK;
             }
@@ -6589,6 +6614,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
         }
     }
 
+    if (push_failed && !ignore_stackfaults) {
+        /* Derived exception on callee-saves register stacking:
+         * we might now want to take a different exception which
+         * targets a different security state, so try again from the top.
+         */
+        v7m_exception_taken(cpu, lr, true, true);
+        return;
+    }
+
     addr = arm_v7m_load_vector(cpu, exc, targets_secure);
 
     /* Now we've done everything that might cause a derived exception
-- 
2.7.4
