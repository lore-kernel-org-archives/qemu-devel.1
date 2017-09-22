Received: from eggs.gnu.org ([2001:4830:134:3::10]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQf-00085I-Jd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQd-0004Eu-PV
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:59 +0100
Message-Id: <1506092407-26985-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/20] target/arm: Add v8M support to exception
 entry code
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

Add support for v8M and in particular the security extension
to the exception entry code. This requires changes to:
 * calculation of the exception-return magic LR value
 * push the callee-saves registers in certain cases
 * clear registers when taking non-secure exceptions to avoid
   leaking information from the interrupted secure code
 * switch to the correct security state on entry
 * use the vector table for the security state we're targeting

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 145 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 25f5675..7511566 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6200,12 +6200,12 @@ static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
     }
 }
 
-static uint32_t arm_v7m_load_vector(ARMCPU *cpu)
+static uint32_t arm_v7m_load_vector(ARMCPU *cpu, bool targets_secure)
 {
     CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
     MemTxResult result;
-    hwaddr vec = env->v7m.vecbase[env->v7m.secure] + env->v7m.exception * 4;
+    hwaddr vec = env->v7m.vecbase[targets_secure] + env->v7m.exception * 4;
     uint32_t addr;
 
     addr = address_space_ldl(cs->as, vec,
@@ -6217,13 +6217,48 @@ static uint32_t arm_v7m_load_vector(ARMCPU *cpu)
          * Since we don't model Lockup, we just report this guest error
          * via cpu_abort().
          */
-        cpu_abort(cs, "Failed to read from exception vector table "
-                  "entry %08x\n", (unsigned)vec);
+        cpu_abort(cs, "Failed to read from %s exception vector table "
+                  "entry %08x\n", targets_secure ? "secure" : "nonsecure",
+                  (unsigned)vec);
     }
     return addr;
 }
 
-static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr)
+static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain)
+{
+    /* For v8M, push the callee-saves register part of the stack frame.
+     * Compare the v8M pseudocode PushCalleeStack().
+     * In the tailchaining case this may not be the current stack.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    uint32_t *frame_sp_p;
+    uint32_t frameptr;
+
+    if (dotailchain) {
+        frame_sp_p = get_v7m_sp_ptr(env, true,
+                                    lr & R_V7M_EXCRET_MODE_MASK,
+                                    lr & R_V7M_EXCRET_SPSEL_MASK);
+    } else {
+        frame_sp_p = &env->regs[13];
+    }
+
+    frameptr = *frame_sp_p - 0x28;
+
+    stl_phys(cs->as, frameptr, 0xfefa125b);
+    stl_phys(cs->as, frameptr + 0x8, env->regs[4]);
+    stl_phys(cs->as, frameptr + 0xc, env->regs[5]);
+    stl_phys(cs->as, frameptr + 0x10, env->regs[6]);
+    stl_phys(cs->as, frameptr + 0x14, env->regs[7]);
+    stl_phys(cs->as, frameptr + 0x18, env->regs[8]);
+    stl_phys(cs->as, frameptr + 0x1c, env->regs[9]);
+    stl_phys(cs->as, frameptr + 0x20, env->regs[10]);
+    stl_phys(cs->as, frameptr + 0x24, env->regs[11]);
+
+    *frame_sp_p = frameptr;
+}
+
+static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
 {
     /* Do the "take the exception" parts of exception entry,
      * but not the pushing of state to the stack. This is
@@ -6231,14 +6266,84 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr)
      */
     CPUARMState *env = &cpu->env;
     uint32_t addr;
+    bool targets_secure;
+
+    targets_secure = armv7m_nvic_acknowledge_irq(env->nvic);
 
-    armv7m_nvic_acknowledge_irq(env->nvic);
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+            (lr & R_V7M_EXCRET_S_MASK)) {
+            /* The background code (the owner of the registers in the
+             * exception frame) is Secure. This means it may either already
+             * have or now needs to push callee-saves registers.
+             */
+            if (targets_secure) {
+                if (dotailchain && !(lr & R_V7M_EXCRET_ES_MASK)) {
+                    /* We took an exception from Secure to NonSecure
+                     * (which means the callee-saved registers got stacked)
+                     * and are now tailchaining to a Secure exception.
+                     * Clear DCRS so eventual return from this Secure
+                     * exception unstacks the callee-saved registers.
+                     */
+                    lr &= ~R_V7M_EXCRET_DCRS_MASK;
+                }
+            } else {
+                /* We're going to a non-secure exception; push the
+                 * callee-saves registers to the stack now, if they're
+                 * not already saved.
+                 */
+                if (lr & R_V7M_EXCRET_DCRS_MASK &&
+                    !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
+                    v7m_push_callee_stack(cpu, lr, dotailchain);
+                }
+                lr |= R_V7M_EXCRET_DCRS_MASK;
+            }
+        }
+
+        lr &= ~R_V7M_EXCRET_ES_MASK;
+        if (targets_secure || !arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            lr |= R_V7M_EXCRET_ES_MASK;
+        }
+        lr &= ~R_V7M_EXCRET_SPSEL_MASK;
+        if (env->v7m.control[targets_secure] & R_V7M_CONTROL_SPSEL_MASK) {
+            lr |= R_V7M_EXCRET_SPSEL_MASK;
+        }
+
+        /* Clear registers if necessary to prevent non-secure exception
+         * code being able to see register values from secure code.
+         * Where register values become architecturally UNKNOWN we leave
+         * them with their previous values.
+         */
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            if (!targets_secure) {
+                /* Always clear the caller-saved registers (they have been
+                 * pushed to the stack earlier in v7m_push_stack()).
+                 * Clear callee-saved registers if the background code is
+                 * Secure (in which case these regs were saved in
+                 * v7m_push_callee_stack()).
+                 */
+                int i;
+
+                for (i = 0; i < 13; i++) {
+                    /* r4..r11 are callee-saves, zero only if EXCRET.S == 1 */
+                    if (i < 4 || i > 11 || (lr & R_V7M_EXCRET_S_MASK)) {
+                        env->regs[i] = 0;
+                    }
+                }
+                /* Clear EAPSR */
+                xpsr_write(env, 0, XPSR_NZCV | XPSR_Q | XPSR_GE | XPSR_IT);
+            }
+        }
+    }
+
+    /* Switch to target security state -- must do this before writing SPSEL */
+    switch_v7m_security_state(env, targets_secure);
     write_v7m_control_spsel(env, 0);
     arm_clear_exclusive(env);
     /* Clear IT bits */
     env->condexec_bits = 0;
     env->regs[14] = lr;
-    addr = arm_v7m_load_vector(cpu);
+    addr = arm_v7m_load_vector(cpu, targets_secure);
     env->regs[15] = addr & 0xfffffffe;
     env->thumb = addr & 1;
 }
@@ -6404,7 +6509,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     if (sfault) {
         env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-        v7m_exception_taken(cpu, excret);
+        v7m_exception_taken(cpu, excret, true);
         qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
                       "stackframe: failed EXC_RETURN.ES validity check\n");
         return;
@@ -6416,7 +6521,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
-        v7m_exception_taken(cpu, excret);
+        v7m_exception_taken(cpu, excret, true);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                       "stackframe: failed exception return integrity check\n");
         return;
@@ -6464,7 +6569,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 /* Take a SecureFault on the current stack */
                 env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-                v7m_exception_taken(cpu, excret);
+                v7m_exception_taken(cpu, excret, true);
                 qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
                               "stackframe: failed exception return integrity "
                               "signature check\n");
@@ -6527,7 +6632,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
                                         env->v7m.secure);
                 env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
-                v7m_exception_taken(cpu, excret);
+                v7m_exception_taken(cpu, excret, true);
                 qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                               "stackframe: failed exception return integrity "
                               "check\n");
@@ -6564,7 +6669,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, false);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         v7m_push_stack(cpu);
-        v7m_exception_taken(cpu, excret);
+        v7m_exception_taken(cpu, excret, false);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
                       "failed exception return integrity check\n");
         return;
@@ -6708,20 +6813,40 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         return; /* Never happens.  Keep compiler happy.  */
     }
 
-    lr = R_V7M_EXCRET_RES1_MASK |
-        R_V7M_EXCRET_S_MASK |
-        R_V7M_EXCRET_DCRS_MASK |
-        R_V7M_EXCRET_FTYPE_MASK |
-        R_V7M_EXCRET_ES_MASK;
-    if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK) {
-        lr |= R_V7M_EXCRET_SPSEL_MASK;
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        lr = R_V7M_EXCRET_RES1_MASK |
+            R_V7M_EXCRET_DCRS_MASK |
+            R_V7M_EXCRET_FTYPE_MASK;
+        /* The S bit indicates whether we should return to Secure
+         * or NonSecure (ie our current state).
+         * The ES bit indicates whether we're taking this exception
+         * to Secure or NonSecure (ie our target state). We set it
+         * later, in v7m_exception_taken().
+         * The SPSEL bit is also set in v7m_exception_taken() for v8M.
+         * This corresponds to the ARM ARM pseudocode for v8M setting
+         * some LR bits in PushStack() and some in ExceptionTaken();
+         * the distinction matters for the tailchain cases where we
+         * can take an exception without pushing the stack.
+         */
+        if (env->v7m.secure) {
+            lr |= R_V7M_EXCRET_S_MASK;
+        }
+    } else {
+        lr = R_V7M_EXCRET_RES1_MASK |
+            R_V7M_EXCRET_S_MASK |
+            R_V7M_EXCRET_DCRS_MASK |
+            R_V7M_EXCRET_FTYPE_MASK |
+            R_V7M_EXCRET_ES_MASK;
+        if (env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK) {
+            lr |= R_V7M_EXCRET_SPSEL_MASK;
+        }
     }
     if (!arm_v7m_is_handler_mode(env)) {
         lr |= R_V7M_EXCRET_MODE_MASK;
     }
 
     v7m_push_stack(cpu);
-    v7m_exception_taken(cpu, lr);
+    v7m_exception_taken(cpu, lr, false);
     qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
 }
 
-- 
2.7.4
