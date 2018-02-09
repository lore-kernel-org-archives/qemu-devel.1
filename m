Received: from eggs.gnu.org ([2001:4830:134:3::10]:39755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6So-000102-Gq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sm-0001we-T4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sm-0001sW-K4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sb-0002Y4-Kr
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:17 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:47 +0000
Message-Id: <20180209110314.11766-4-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/30] target/arm: Add ignore_stackfaults
 argument to v7m_exception_taken()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the v8M architecture, if the process of taking an exception
results in a further exception this is called a derived exception
(for example, an MPU exception when writing the exception frame to
memory). If the derived exception happens while pushing the initial
stack frame, we must ignore any subsequent possible exception
pushing the callee-saves registers.

In preparation for making the stack writes check for exceptions,
add a return value from v7m_push_stack() and a new parameter to
v7m_exception_taken(), so that the former can tell the latter that
it needs to ignore failures to write to the stack. We also plumb
the argument through to v7m_push_callee_stack(), which is where
the code to ignore the failures will be.

(Note that the v8M ARM pseudocode structures this slightly differently:
derived exceptions cause the attempt to process the original
exception to be abandoned; then at the top level it calls
DerivedLateArrival to prioritize the derived exception and call
TakeException from there. We choose to let the NVIC do the prioritization
and continue forward with a call to TakeException which will then
take either the original or the derived exception. The effect is
the same, but this structure works better for QEMU because we don't
have a convenient top level place to do the abandon-and-retry logic.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1517324542-6607-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6062f380d4..c713eea424 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6419,7 +6419,8 @@ static uint32_t arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure)
     return addr;
 }
 
-static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain)
+static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
+                                  bool ignore_faults)
 {
     /* For v8M, push the callee-saves register part of the stack frame.
      * Compare the v8M pseudocode PushCalleeStack().
@@ -6453,7 +6454,8 @@ static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain)
     *frame_sp_p = frameptr;
 }
 
-static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
+static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
+                                bool ignore_stackfaults)
 {
     /* Do the "take the exception" parts of exception entry,
      * but not the pushing of state to the stack. This is
@@ -6490,7 +6492,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
                  */
                 if (lr & R_V7M_EXCRET_DCRS_MASK &&
                     !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
-                    v7m_push_callee_stack(cpu, lr, dotailchain);
+                    v7m_push_callee_stack(cpu, lr, dotailchain,
+                                          ignore_stackfaults);
                 }
                 lr |= R_V7M_EXCRET_DCRS_MASK;
             }
@@ -6551,10 +6554,13 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain)
     env->thumb = addr & 1;
 }
 
-static void v7m_push_stack(ARMCPU *cpu)
+static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
      * similar to pseudocode PushStack().
+     * Return true if we generate a derived exception (and so
+     * should ignore further stack faults trying to process
+     * that derived exception.)
      */
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
@@ -6574,6 +6580,8 @@ static void v7m_push_stack(ARMCPU *cpu)
     v7m_push(env, env->regs[2]);
     v7m_push(env, env->regs[1]);
     v7m_push(env, env->regs[0]);
+
+    return false;
 }
 
 static void do_v7m_exception_exit(ARMCPU *cpu)
@@ -6719,7 +6727,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     if (sfault) {
         env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-        v7m_exception_taken(cpu, excret, true);
+        v7m_exception_taken(cpu, excret, true, false);
         qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
                       "stackframe: failed EXC_RETURN.ES validity check\n");
         return;
@@ -6731,7 +6739,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
-        v7m_exception_taken(cpu, excret, true);
+        v7m_exception_taken(cpu, excret, true, false);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                       "stackframe: failed exception return integrity check\n");
         return;
@@ -6779,7 +6787,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 /* Take a SecureFault on the current stack */
                 env->v7m.sfsr |= R_V7M_SFSR_INVIS_MASK;
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
-                v7m_exception_taken(cpu, excret, true);
+                v7m_exception_taken(cpu, excret, true, false);
                 qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
                               "stackframe: failed exception return integrity "
                               "signature check\n");
@@ -6844,7 +6852,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
                                         env->v7m.secure);
                 env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
-                v7m_exception_taken(cpu, excret, true);
+                v7m_exception_taken(cpu, excret, true, false);
                 qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                               "stackframe: failed exception return integrity "
                               "check\n");
@@ -6877,11 +6885,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         /* Take an INVPC UsageFault by pushing the stack again;
          * we know we're v7M so this is never a Secure UsageFault.
          */
+        bool ignore_stackfaults;
+
         assert(!arm_feature(env, ARM_FEATURE_V8));
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, false);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
-        v7m_push_stack(cpu);
-        v7m_exception_taken(cpu, excret, false);
+        ignore_stackfaults = v7m_push_stack(cpu);
+        v7m_exception_taken(cpu, excret, false, ignore_stackfaults);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
                       "failed exception return integrity check\n");
         return;
@@ -7122,6 +7132,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t lr;
+    bool ignore_stackfaults;
 
     arm_log_exception(cs->exception_index);
 
@@ -7296,8 +7307,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         lr |= R_V7M_EXCRET_MODE_MASK;
     }
 
-    v7m_push_stack(cpu);
-    v7m_exception_taken(cpu, lr, false);
+    ignore_stackfaults = v7m_push_stack(cpu);
+    v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
     qemu_log_mask(CPU_LOG_INT, "... as %d\n", env->v7m.exception);
 }
 
-- 
2.16.1
