Received: from eggs.gnu.org ([2001:4830:134:3::10]:47185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQe-00083x-H0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQc-0004DR-Sj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:49 +0100
Message-Id: <1506092407-26985-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/20] target/arm: Don't switch to target stack
 early in v7M exception return
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

Currently our M profile exception return code switches to the
target stack pointer relatively early in the process, before
it tries to pop the exception frame off the stack. This is
awkward for v8M for two reasons:
 * in v8M the process vs main stack pointer is not selected
   purely by the value of CONTROL.SPSEL, so updating SPSEL
   and relying on that to switch to the right stack pointer
   won't work
 * the stack we should be reading the stack frame from and
   the stack we will eventually switch to might not be the
   same if the guest is doing strange things

Change our exception return code to use a 'frame pointer'
to read the exception frame rather than assuming that we
can switch the live stack pointer this early.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 127 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 95 insertions(+), 32 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8be78ea..f13b99d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6040,16 +6040,6 @@ static void v7m_push(CPUARMState *env, uint32_t val)
     stl_phys(cs->as, env->regs[13], val);
 }
 
-static uint32_t v7m_pop(CPUARMState *env)
-{
-    CPUState *cs = CPU(arm_env_get_cpu(env));
-    uint32_t val;
-
-    val = ldl_phys(cs->as, env->regs[13]);
-    env->regs[13] += 4;
-    return val;
-}
-
 /* Return true if we're using the process stack pointer (not the MSP) */
 static bool v7m_using_psp(CPUARMState *env)
 {
@@ -6141,6 +6131,40 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     env->regs[15] = dest & ~1;
 }
 
+static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
+                                bool spsel)
+{
+    /* Return a pointer to the location where we currently store the
+     * stack pointer for the requested security state and thread mode.
+     * This pointer will become invalid if the CPU state is updated
+     * such that the stack pointers are switched around (eg changing
+     * the SPSEL control bit).
+     * Compare the v8M ARM ARM pseudocode LookUpSP_with_security_mode().
+     * Unlike that pseudocode, we require the caller to pass us in the
+     * SPSEL control bit value; this is because we also use this
+     * function in handling of pushing of the callee-saves registers
+     * part of the v8M stack frame, and in that case the SPSEL bit
+     * comes from the exception return magic LR value.
+     */
+    bool want_psp = threadmode && spsel;
+
+    if (secure == env->v7m.secure) {
+        /* Currently switch_v7m_sp switches SP as it updates SPSEL,
+         * so the SP we want is always in regs[13].
+         * When we decouple SPSEL from the actually selected SP
+         * we need to check want_psp against v7m_using_psp()
+         * to see whether we need regs[13] or v7m.other_sp.
+         */
+        return &env->regs[13];
+    } else {
+        if (want_psp) {
+            return &env->v7m.other_ss_psp;
+        } else {
+            return &env->v7m.other_ss_msp;
+        }
+    }
+}
+
 static uint32_t arm_v7m_load_vector(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -6212,6 +6236,7 @@ static void v7m_push_stack(ARMCPU *cpu)
 static void do_v7m_exception_exit(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     uint32_t excret;
     uint32_t xpsr;
     bool ufault = false;
@@ -6219,6 +6244,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool return_to_handler = false;
     bool rettobase = false;
     bool exc_secure = false;
+    bool return_to_secure;
 
     /* We can only get here from an EXCP_EXCEPTION_EXIT, and
      * gen_bx_excret() enforces the architectural rule
@@ -6286,6 +6312,9 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         g_assert_not_reached();
     }
 
+    return_to_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+        (excret & R_V7M_EXCRET_S_MASK);
+
     switch (excret & 0xf) {
     case 1: /* Return to Handler */
         return_to_handler = true;
@@ -6315,32 +6344,66 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
 
-    /* Switch to the target stack.  */
+    /* Set CONTROL.SPSEL from excret.SPSEL. For QEMU this currently
+     * causes us to switch the active SP, but we will change this
+     * later to not do that so we can support v8M.
+     */
     switch_v7m_sp(env, return_to_sp_process);
-    /* Pop registers.  */
-    env->regs[0] = v7m_pop(env);
-    env->regs[1] = v7m_pop(env);
-    env->regs[2] = v7m_pop(env);
-    env->regs[3] = v7m_pop(env);
-    env->regs[12] = v7m_pop(env);
-    env->regs[14] = v7m_pop(env);
-    env->regs[15] = v7m_pop(env);
-    if (env->regs[15] & 1) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "M profile return from interrupt with misaligned "
-                      "PC is UNPREDICTABLE\n");
-        /* Actual hardware seems to ignore the lsbit, and there are several
-         * RTOSes out there which incorrectly assume the r15 in the stack
-         * frame should be a Thumb-style "lsbit indicates ARM/Thumb" value.
+
+    {
+        /* The stack pointer we should be reading the exception frame from
+         * depends on bits in the magic exception return type value (and
+         * for v8M isn't necessarily the stack pointer we will eventually
+         * end up resuming execution with). Get a pointer to the location
+         * in the CPU state struct where the SP we need is currently being
+         * stored; we will use and modify it in place.
+         * We use this limited C variable scope so we don't accidentally
+         * use 'frame_sp_p' after we do something that makes it invalid.
+         */
+        uint32_t *frame_sp_p = get_v7m_sp_ptr(env,
+                                              return_to_secure,
+                                              !return_to_handler,
+                                              return_to_sp_process);
+        uint32_t frameptr = *frame_sp_p;
+
+        /* Pop registers. TODO: make these accesses use the correct
+         * attributes and address space (S/NS, priv/unpriv) and handle
+         * memory transaction failures.
          */
-        env->regs[15] &= ~1U;
+        env->regs[0] = ldl_phys(cs->as, frameptr);
+        env->regs[1] = ldl_phys(cs->as, frameptr + 0x4);
+        env->regs[2] = ldl_phys(cs->as, frameptr + 0x8);
+        env->regs[3] = ldl_phys(cs->as, frameptr + 0xc);
+        env->regs[12] = ldl_phys(cs->as, frameptr + 0x10);
+        env->regs[14] = ldl_phys(cs->as, frameptr + 0x14);
+        env->regs[15] = ldl_phys(cs->as, frameptr + 0x18);
+        if (env->regs[15] & 1) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M profile return from interrupt with misaligned "
+                          "PC is UNPREDICTABLE\n");
+            /* Actual hardware seems to ignore the lsbit, and there are several
+             * RTOSes out there which incorrectly assume the r15 in the stack
+             * frame should be a Thumb-style "lsbit indicates ARM/Thumb" value.
+             */
+            env->regs[15] &= ~1U;
+        }
+        xpsr = ldl_phys(cs->as, frameptr + 0x1c);
+
+        /* Commit to consuming the stack frame */
+        frameptr += 0x20;
+        /* Undo stack alignment (the SPREALIGN bit indicates that the original
+         * pre-exception SP was not 8-aligned and we added a padding word to
+         * align it, so we undo this by ORing in the bit that increases it
+         * from the current 8-aligned value to the 8-unaligned value. (Adding 4
+         * would work too but a logical OR is how the pseudocode specifies it.)
+         */
+        if (xpsr & XPSR_SPREALIGN) {
+            frameptr |= 4;
+        }
+        *frame_sp_p = frameptr;
     }
-    xpsr = v7m_pop(env);
+    /* This xpsr_write() will invalidate frame_sp_p as it may switch stack */
     xpsr_write(env, xpsr, ~XPSR_SPREALIGN);
-    /* Undo stack alignment.  */
-    if (xpsr & XPSR_SPREALIGN) {
-        env->regs[13] |= 4;
-    }
 
     /* The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
-- 
2.7.4
