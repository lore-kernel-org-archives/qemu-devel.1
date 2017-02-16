Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2b-0008Hl-HE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2a-0007eT-2A
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:36:01 +0000
Message-Id: <1487262963-11519-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 11/13] armv7m: Check exception return
 consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Implement the exception return consistency checks
described in the v7M pseudocode ExceptionReturn().

Inspired by a patch from Michael Davidsaver's series, but
this is a reimplementation from scratch based on the
ARM ARM pseudocode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  12 +++++-
 hw/intc/armv7m_nvic.c |  12 +++++-
 target/arm/helper.c   | 112 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab46c0c..017e301 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1352,7 +1352,17 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
 #endif
 void armv7m_nvic_set_pending(void *opaque, int irq);
 void armv7m_nvic_acknowledge_irq(void *opaque);
-void armv7m_nvic_complete_irq(void *opaque, int irq);
+/**
+ * armv7m_nvic_complete_irq: complete specified interrupt or exception
+ * @opaque: the NVIC
+ * @irq: the exception number to complete
+ *
+ * Returns: -1 if the irq was not active
+ *           1 if completing this irq brought us back to base (no active irqs)
+ *           0 if there is still an irq active after this one was completed
+ * (Ignoring -1, this is the same as the RETTOBASE value before completion.)
+ */
+int armv7m_nvic_complete_irq(void *opaque, int irq);
 
 /* Interface for defining coprocessor registers.
  * Registers are defined in tables of arm_cp_reginfo structs
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index ca4fb49..a8c5a9e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -441,10 +441,11 @@ void armv7m_nvic_acknowledge_irq(void *opaque)
     nvic_irq_update(s);
 }
 
-void armv7m_nvic_complete_irq(void *opaque, int irq)
+int armv7m_nvic_complete_irq(void *opaque, int irq)
 {
     NVICState *s = (NVICState *)opaque;
     VecInfo *vec;
+    int ret;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
 
@@ -452,6 +453,13 @@ void armv7m_nvic_complete_irq(void *opaque, int irq)
 
     trace_nvic_complete_irq(irq);
 
+    if (!vec->active) {
+        /* Tell the caller this was an illegal exception return */
+        return -1;
+    }
+
+    ret = nvic_rettobase(s);
+
     vec->active = 0;
     if (vec->level) {
         /* Re-pend the exception if it's still held high; only
@@ -462,6 +470,8 @@ void armv7m_nvic_complete_irq(void *opaque, int irq)
     }
 
     nvic_irq_update(s);
+
+    return ret;
 }
 
 /* callback when external interrupt line is changed */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f94d1c7..6a476b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6067,22 +6067,99 @@ static void v7m_push_stack(ARMCPU *cpu)
     v7m_push(env, env->regs[0]);
 }
 
-static void do_v7m_exception_exit(CPUARMState *env)
+static void do_v7m_exception_exit(ARMCPU *cpu)
 {
+    CPUARMState *env = &cpu->env;
     uint32_t type;
     uint32_t xpsr;
-
+    bool ufault = false;
+    bool return_to_sp_process = false;
+    bool return_to_handler = false;
+    bool rettobase = false;
+
+    /* We can only get here from an EXCP_EXCEPTION_EXIT, and
+     * arm_v7m_do_unassigned_access() enforces the architectural rule
+     * that jumps to magic addresses don't have magic behaviour unless
+     * we're in Handler mode (compare pseudocode BXWritePC()).
+     */
+    assert(env->v7m.exception != 0);
+
+    /* In the spec pseudocode ExceptionReturn() is called directly
+     * from BXWritePC() and gets the full target PC value including
+     * bit zero. In QEMU's implementation we treat it as a normal
+     * jump-to-register (which is then caught later on), and so split
+     * the target value up between env->regs[15] and env->thumb in
+     * gen_bx(). Reconstitute it.
+     */
     type = env->regs[15];
+    if (env->thumb) {
+        type |= 1;
+    }
+
+    qemu_log_mask(CPU_LOG_INT, "Exception return: magic PC %" PRIx32
+                  " previous exception %d\n",
+                  type, env->v7m.exception);
+
+    if (extract32(type, 5, 23) != extract32(-1, 5, 23)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero high bits in exception "
+                      "exit PC value 0x%" PRIx32 " are UNPREDICTABLE\n", type);
+    }
+
     if (env->v7m.exception != ARMV7M_EXCP_NMI) {
         /* Auto-clear FAULTMASK on return from other than NMI */
         env->daif &= ~PSTATE_F;
     }
-    if (env->v7m.exception != 0) {
-        armv7m_nvic_complete_irq(env->nvic, env->v7m.exception);
+
+    switch (armv7m_nvic_complete_irq(env->nvic, env->v7m.exception)) {
+    case -1:
+        /* attempt to exit an exception that isn't active */
+        ufault = true;
+        break;
+    case 0:
+        /* still an irq active now */
+        break;
+    case 1:
+        /* we returned to base exception level, no nesting.
+         * (In the pseudocode this is written using "NestedActivation != 1"
+         * where we have 'rettobase == false'.)
+         */
+        rettobase = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    switch (type & 0xf) {
+    case 1: /* Return to Handler */
+        return_to_handler = true;
+        break;
+    case 13: /* Return to Thread using Process stack */
+        return_to_sp_process = true;
+        /* fall through */
+    case 9: /* Return to Thread using Main stack */
+        if (!rettobase &&
+            !(env->v7m.ccr & R_V7M_CCR_NONBASETHRDENA_MASK)) {
+            ufault = true;
+        }
+        break;
+    default:
+        ufault = true;
+    }
+
+    if (ufault) {
+        /* Bad exception return: instead of popping the exception
+         * stack, directly take a usage fault on the current stack.
+         */
+        env->v7m.cfsr |= R_V7M_CFSR_INVPC_MASK;
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        v7m_exception_taken(cpu, type | 0xf0000000);
+        qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
+                      "stackframe: failed exception return integrity check\n");
+        return;
     }
 
     /* Switch to the target stack.  */
-    switch_v7m_sp(env, (type & 4) != 0);
+    switch_v7m_sp(env, return_to_sp_process);
     /* Pop registers.  */
     env->regs[0] = v7m_pop(env);
     env->regs[1] = v7m_pop(env);
@@ -6106,11 +6183,24 @@ static void do_v7m_exception_exit(CPUARMState *env)
     /* Undo stack alignment.  */
     if (xpsr & 0x200)
         env->regs[13] |= 4;
-    /* ??? The exception return type specifies Thread/Handler mode.  However
-       this is also implied by the xPSR value. Not sure what to do
-       if there is a mismatch.  */
-    /* ??? Likewise for mismatches between the CONTROL register and the stack
-       pointer.  */
+
+    /* The restored xPSR exception field will be zero if we're
+     * resuming in Thread mode. If that doesn't match what the
+     * exception return type specified then this is a UsageFault.
+     */
+    if (return_to_handler == (env->v7m.exception == 0)) {
+        /* Take an INVPC UsageFault by pushing the stack again. */
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        env->v7m.cfsr |= R_V7M_CFSR_INVPC_MASK;
+        v7m_push_stack(cpu);
+        v7m_exception_taken(cpu, type | 0xf0000000);
+        qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
+                      "failed exception return integrity check\n");
+        return;
+    }
+
+    /* Otherwise, we have a successful exception exit. */
+    qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
 static void arm_log_exception(int idx)
@@ -6183,7 +6273,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     case EXCP_IRQ:
         break;
     case EXCP_EXCEPTION_EXIT:
-        do_v7m_exception_exit(env);
+        do_v7m_exception_exit(cpu);
         return;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
-- 
2.7.4
