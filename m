Received: from eggs.gnu.org ([2001:4830:134:3::10]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph6-0003Xa-MJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph4-0006Tm-1E
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:56 +0100
Message-Id: <1505240046-11454-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/19] nvic: Make set_pending and clear_pending
 take a secure parameter
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

Make the armv7m_nvic_set_pending() and armv7m_nvic_clear_pending()
functions take a bool indicating whether to pend the secure
or non-secure version of a banked interrupt, and update the
callsites accordingly.

In most callsites we can simply pass the correct security
state in; in a couple of cases we use TODO comments to indicate
that we will return the code in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 14 ++++++++++-
 hw/intc/armv7m_nvic.c | 64 ++++++++++++++++++++++++++++++++++++++-------------
 target/arm/helper.c   | 24 +++++++++++--------
 hw/intc/trace-events  |  4 ++--
 4 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7e661c8..7a93354 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1463,7 +1463,19 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
     return true;
 }
 #endif
-void armv7m_nvic_set_pending(void *opaque, int irq);
+/**
+ * armv7m_nvic_set_pending: mark the specified exception as pending
+ * @opaque: the NVIC
+ * @irq: the exception number to mark pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Marks the specified exception as pending. Note that we will assert()
+ * if @secure is true and @irq does not specify one of the fixed set
+ * of architecturally banked exceptions.
+ */
+void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
 void armv7m_nvic_acknowledge_irq(void *opaque);
 /**
  * armv7m_nvic_complete_irq: complete specified interrupt or exception
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index fb824e6..852db11 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -384,31 +384,50 @@ static void nvic_irq_update(NVICState *s)
     qemu_set_irq(s->excpout, lvl);
 }
 
-static void armv7m_nvic_clear_pending(void *opaque, int irq)
+/**
+ * armv7m_nvic_clear_pending: mark the specified exception as not pending
+ * @opaque: the NVIC
+ * @irq: the exception number to mark as not pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Marks the specified exception as not pending. Note that we will assert()
+ * if @secure is true and @irq does not specify one of the fixed set
+ * of architecturally banked exceptions.
+ */
+static void armv7m_nvic_clear_pending(void *opaque, int irq, bool secure)
 {
     NVICState *s = (NVICState *)opaque;
     VecInfo *vec;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
 
-    vec = &s->vectors[irq];
-    trace_nvic_clear_pending(irq, vec->enabled, vec->prio);
+    if (secure) {
+        assert(exc_is_banked(irq));
+        vec = &s->sec_vectors[irq];
+    } else {
+        vec = &s->vectors[irq];
+    }
+    trace_nvic_clear_pending(irq, secure, vec->enabled, vec->prio);
     if (vec->pending) {
         vec->pending = 0;
         nvic_irq_update(s);
     }
 }
 
-void armv7m_nvic_set_pending(void *opaque, int irq)
+void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
 {
     NVICState *s = (NVICState *)opaque;
+    bool banked = exc_is_banked(irq);
     VecInfo *vec;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
+    assert(!secure || banked);
 
-    vec = &s->vectors[irq];
-    trace_nvic_set_pending(irq, vec->enabled, vec->prio);
+    vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
 
+    trace_nvic_set_pending(irq, secure, vec->enabled, vec->prio);
 
     if (irq >= ARMV7M_EXCP_HARD && irq < ARMV7M_EXCP_PENDSV) {
         /* If a synchronous exception is pending then it may be
@@ -454,9 +473,20 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
                           "(current priority %d)\n", irq, running);
             }
 
-            /* We can do the escalation, so we take HardFault instead */
+            /* We can do the escalation, so we take HardFault instead.
+             * If BFHFNMINS is set then we escalate to the banked HF for
+             * the target security state of the original exception; otherwise
+             * we take a Secure HardFault.
+             */
             irq = ARMV7M_EXCP_HARD;
-            vec = &s->vectors[irq];
+            if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY) &&
+                (secure ||
+                 !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK))) {
+                vec = &s->sec_vectors[irq];
+            } else {
+                vec = &s->vectors[irq];
+            }
+            /* HF may be banked but there is only one shared HFSR */
             s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
         }
     }
@@ -551,7 +581,7 @@ static void set_irq_level(void *opaque, int n, int level)
     if (level != vec->level) {
         vec->level = level;
         if (level) {
-            armv7m_nvic_set_pending(s, n);
+            armv7m_nvic_set_pending(s, n, false);
         }
     }
 }
@@ -837,17 +867,17 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     }
     case 0xd04: /* Interrupt Control State.  */
         if (value & (1 << 31)) {
-            armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI);
+            armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
         }
         if (value & (1 << 28)) {
-            armv7m_nvic_set_pending(s, ARMV7M_EXCP_PENDSV);
+            armv7m_nvic_set_pending(s, ARMV7M_EXCP_PENDSV, attrs.secure);
         } else if (value & (1 << 27)) {
-            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_PENDSV);
+            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_PENDSV, attrs.secure);
         }
         if (value & (1 << 26)) {
-            armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK);
+            armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK, attrs.secure);
         } else if (value & (1 << 25)) {
-            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_SYSTICK);
+            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_SYSTICK, attrs.secure);
         }
         break;
     case 0xd08: /* Vector Table Offset.  */
@@ -1093,7 +1123,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
     {
         int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
         if (excnum < s->num_irq) {
-            armv7m_nvic_set_pending(s, excnum);
+            armv7m_nvic_set_pending(s, excnum, false);
         }
         break;
     }
@@ -1495,8 +1525,10 @@ static void nvic_systick_trigger(void *opaque, int n, int level)
         /* SysTick just asked us to pend its exception.
          * (This is different from an external interrupt line's
          * behaviour.)
+         * TODO: when we implement the banked systicks we must make
+         * this pend the correct banked exception.
          */
-        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK);
+        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK, false);
     }
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f4f2a87..b64acd8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6306,7 +6306,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          * stack, directly take a usage fault on the current stack.
          */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         v7m_exception_taken(cpu, excret);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                       "stackframe: failed exception return integrity check\n");
@@ -6345,8 +6345,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      * exception return excret specified then this is a UsageFault.
      */
     if (return_to_handler != arm_v7m_is_handler_mode(env)) {
-        /* Take an INVPC UsageFault by pushing the stack again. */
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        /* Take an INVPC UsageFault by pushing the stack again.
+         * TODO: the v8M version of this code should target the
+         * background state for this exception.
+         */
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, false);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         v7m_push_stack(cpu);
         v7m_exception_taken(cpu, excret);
@@ -6406,20 +6409,20 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
        handle it.  */
     switch (cs->exception_index) {
     case EXCP_UDEF:
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_UNDEFINSTR_MASK;
         break;
     case EXCP_NOCP:
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_NOCP_MASK;
         break;
     case EXCP_INVSTATE:
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVSTATE_MASK;
         break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC, env->v7m.secure);
         break;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
@@ -6443,7 +6446,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
                               env->v7m.bfar);
                 break;
             }
-            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS);
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
             break;
         default:
             /* All other FSR values are either MPU faults or "can't happen
@@ -6463,7 +6466,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
                               env->v7m.mmfar[env->v7m.secure]);
                 break;
             }
-            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM);
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM,
+                                    env->v7m.secure);
             break;
         }
         break;
@@ -6480,7 +6484,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
                 return;
             }
         }
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
         break;
     case EXCP_IRQ:
         break;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 0b1fba3..94038b6 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -173,8 +173,8 @@ nvic_set_prio(int irq, uint8_t prio) "NVIC set irq %d priority %d"
 nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
 nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
 nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-nvic_set_pending(int irq, int en, int prio) "NVIC set pending irq %d (enabled: %d priority %d)"
-nvic_clear_pending(int irq, int en, int prio) "NVIC clear pending irq %d (enabled: %d priority %d)"
+nvic_set_pending(int irq, bool secure, int en, int prio) "NVIC set pending irq %d secure-bank %d (enabled: %d priority %d)"
+nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
 nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
 nvic_complete_irq(int irq) "NVIC complete IRQ %d"
-- 
2.7.4
