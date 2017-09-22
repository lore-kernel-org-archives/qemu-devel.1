Received: from eggs.gnu.org ([2001:4830:134:3::10]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQZ-0007x4-34
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQX-00045M-O3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:50 +0100
Message-Id: <1506092407-26985-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/20] target/arm: Prepare for CONTROL.SPSEL
 being nonzero in Handler mode
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

In the v7M architecture, there is an invariant that if the CPU is
in Handler mode then the CONTROL.SPSEL bit cannot be nonzero.
This in turn means that the current stack pointer is always
indicated by CONTROL.SPSEL, even though Handler mode always uses
the Main stack pointer.

In v8M, this invariant is removed, and CONTROL.SPSEL may now
be nonzero in Handler mode (though Handler mode still always
uses the Main stack pointer). In preparation for this change,
change how we handle this bit: rename switch_v7m_sp() to
the now more accurate write_v7m_control_spsel(), and make it
check both the handler mode state and the SPSEL bit.

Note that this implicitly changes the point at which we switch
active SP on exception exit from before we pop the exception
frame to after it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  8 ++++++-
 hw/intc/armv7m_nvic.c |  2 +-
 target/arm/helper.c   | 65 ++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8afceca..ad6eff4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -991,6 +991,11 @@ void pmccntr_sync(CPUARMState *env);
 #define PSTATE_MODE_EL1t 4
 #define PSTATE_MODE_EL0t 0
 
+/* Write a new value to v7m.exception, thus transitioning into or out
+ * of Handler mode; this may result in a change of active stack pointer.
+ */
+void write_v7m_exception(CPUARMState *env, uint32_t new_exc);
+
 /* Map EL and handler into a PSTATE_MODE.  */
 static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
 {
@@ -1071,7 +1076,8 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
         env->condexec_bits |= (val >> 8) & 0xfc;
     }
     if (mask & XPSR_EXCP) {
-        env->v7m.exception = val & XPSR_EXCP;
+        /* Note that this only happens on exception exit */
+        write_v7m_exception(env, val & XPSR_EXCP);
     }
 }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index bc7b66d..a1041c2 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -616,7 +616,7 @@ bool armv7m_nvic_acknowledge_irq(void *opaque)
     vec->active = 1;
     vec->pending = 0;
 
-    env->v7m.exception = s->vectpending;
+    write_v7m_exception(env, s->vectpending);
 
     nvic_irq_update(s);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f13b99d..509a1aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6052,21 +6052,44 @@ static bool v7m_using_psp(CPUARMState *env)
         env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK;
 }
 
-/* Switch to V7M main or process stack pointer.  */
-static void switch_v7m_sp(CPUARMState *env, bool new_spsel)
+/* Write to v7M CONTROL.SPSEL bit. This may change the current
+ * stack pointer between Main and Process stack pointers.
+ */
+static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
 {
     uint32_t tmp;
-    uint32_t old_control = env->v7m.control[env->v7m.secure];
-    bool old_spsel = old_control & R_V7M_CONTROL_SPSEL_MASK;
+    bool new_is_psp, old_is_psp = v7m_using_psp(env);
+
+    env->v7m.control[env->v7m.secure] =
+        deposit32(env->v7m.control[env->v7m.secure],
+                  R_V7M_CONTROL_SPSEL_SHIFT,
+                  R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
+
+    new_is_psp = v7m_using_psp(env);
 
-    if (old_spsel != new_spsel) {
+    if (old_is_psp != new_is_psp) {
         tmp = env->v7m.other_sp;
         env->v7m.other_sp = env->regs[13];
         env->regs[13] = tmp;
+    }
+}
+
+void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
+{
+    /* Write a new value to v7m.exception, thus transitioning into or out
+     * of Handler mode; this may result in a change of active stack pointer.
+     */
+    bool new_is_psp, old_is_psp = v7m_using_psp(env);
+    uint32_t tmp;
 
-        env->v7m.control[env->v7m.secure] = deposit32(old_control,
-                                     R_V7M_CONTROL_SPSEL_SHIFT,
-                                     R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
+    env->v7m.exception = new_exc;
+
+    new_is_psp = v7m_using_psp(env);
+
+    if (old_is_psp != new_is_psp) {
+        tmp = env->v7m.other_sp;
+        env->v7m.other_sp = env->regs[13];
+        env->regs[13] = tmp;
     }
 }
 
@@ -6149,13 +6172,11 @@ static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
     bool want_psp = threadmode && spsel;
 
     if (secure == env->v7m.secure) {
-        /* Currently switch_v7m_sp switches SP as it updates SPSEL,
-         * so the SP we want is always in regs[13].
-         * When we decouple SPSEL from the actually selected SP
-         * we need to check want_psp against v7m_using_psp()
-         * to see whether we need regs[13] or v7m.other_sp.
-         */
-        return &env->regs[13];
+        if (want_psp == v7m_using_psp(env)) {
+            return &env->regs[13];
+        } else {
+            return &env->v7m.other_sp;
+        }
     } else {
         if (want_psp) {
             return &env->v7m.other_ss_psp;
@@ -6198,7 +6219,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr)
     uint32_t addr;
 
     armv7m_nvic_acknowledge_irq(env->nvic);
-    switch_v7m_sp(env, 0);
+    write_v7m_control_spsel(env, 0);
     arm_clear_exclusive(env);
     /* Clear IT bits */
     env->condexec_bits = 0;
@@ -6344,11 +6365,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
 
-    /* Set CONTROL.SPSEL from excret.SPSEL. For QEMU this currently
-     * causes us to switch the active SP, but we will change this
-     * later to not do that so we can support v8M.
+    /* Set CONTROL.SPSEL from excret.SPSEL. Since we're still in
+     * Handler mode (and will be until we write the new XPSR.Interrupt
+     * field) this does not switch around the current stack pointer.
      */
-    switch_v7m_sp(env, return_to_sp_process);
+    write_v7m_control_spsel(env, return_to_sp_process);
 
     {
         /* The stack pointer we should be reading the exception frame from
@@ -9163,11 +9184,11 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
     case 20: /* CONTROL */
         /* Writing to the SPSEL bit only has an effect if we are in
          * thread mode; other bits can be updated by any privileged code.
-         * switch_v7m_sp() deals with updating the SPSEL bit in
+         * write_v7m_control_spsel() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
          */
         if (!arm_v7m_is_handler_mode(env)) {
-            switch_v7m_sp(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
+            write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
         env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
         env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
-- 
2.7.4
