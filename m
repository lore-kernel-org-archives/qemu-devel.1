Received: from eggs.gnu.org ([2001:4830:134:3::10]:39790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sp-00011Q-H9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sn-0001xa-Rj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sn-0001td-Io
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sa-0002Xc-9P
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:16 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:45 +0000
Message-Id: <20180209110314.11766-2-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/30] target/arm: Add
 armv7m_nvic_set_pending_derived()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In order to support derived exceptions (exceptions generated in
the course of trying to take an exception), we need to be able
to handle prioritizing whether to take the original exception
or the derived exception.

We do this by introducing a new function
armv7m_nvic_set_pending_derived() which the exception-taking code in
helper.c will call when a derived exception occurs.  Derived
exceptions are dealt with mostly like normal pending exceptions, so
we share the implementation with the armv7m_nvic_set_pending()
function.

Note that the way we structure this is significantly different
from the v8M Arm ARM pseudocode: that does all the prioritization
logic in the DerivedLateArrival() function, whereas we choose to
let the existing "identify highest priority exception" logic
do the prioritization for us. The effect is the same, though.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1517324542-6607-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 13 ++++++++++
 hw/intc/armv7m_nvic.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/intc/trace-events  |  2 +-
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8d41f783dc..b3d4da3048 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1505,6 +1505,19 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
  * of architecturally banked exceptions.
  */
 void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
+/**
+ * armv7m_nvic_set_pending_derived: mark this derived exception as pending
+ * @opaque: the NVIC
+ * @irq: the exception number to mark pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Similar to armv7m_nvic_set_pending(), but specifically for derived
+ * exceptions (exceptions generated in the course of trying to take
+ * a different exception).
+ */
+void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure);
 /**
  * armv7m_nvic_acknowledge_irq: make highest priority pending exception active
  * @opaque: the NVIC
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8ca6ceeb9b..b4a6e7c62e 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -503,8 +503,25 @@ static void armv7m_nvic_clear_pending(void *opaque, int irq, bool secure)
     }
 }
 
-void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
+static void do_armv7m_nvic_set_pending(void *opaque, int irq, bool secure,
+                                       bool derived)
 {
+    /* Pend an exception, including possibly escalating it to HardFault.
+     *
+     * This function handles both "normal" pending of interrupts and
+     * exceptions, and also derived exceptions (ones which occur as
+     * a result of trying to take some other exception).
+     *
+     * If derived == true, the caller guarantees that we are part way through
+     * trying to take an exception (but have not yet called
+     * armv7m_nvic_acknowledge_irq() to make it active), and so:
+     *  - s->vectpending is the "original exception" we were trying to take
+     *  - irq is the "derived exception"
+     *  - nvic_exec_prio(s) gives the priority before exception entry
+     * Here we handle the prioritization logic which the pseudocode puts
+     * in the DerivedLateArrival() function.
+     */
+
     NVICState *s = (NVICState *)opaque;
     bool banked = exc_is_banked(irq);
     VecInfo *vec;
@@ -514,7 +531,44 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
 
     vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
 
-    trace_nvic_set_pending(irq, secure, vec->enabled, vec->prio);
+    trace_nvic_set_pending(irq, secure, derived, vec->enabled, vec->prio);
+
+    if (derived) {
+        /* Derived exceptions are always synchronous. */
+        assert(irq >= ARMV7M_EXCP_HARD && irq < ARMV7M_EXCP_PENDSV);
+
+        if (irq == ARMV7M_EXCP_DEBUG &&
+            exc_group_prio(s, vec->prio, secure) >= nvic_exec_prio(s)) {
+            /* DebugMonitorFault, but its priority is lower than the
+             * preempted exception priority: just ignore it.
+             */
+            return;
+        }
+
+        if (irq == ARMV7M_EXCP_HARD && vec->prio >= s->vectpending_prio) {
+            /* If this is a terminal exception (one which means we cannot
+             * take the original exception, like a failure to read its
+             * vector table entry), then we must take the derived exception.
+             * If the derived exception can't take priority over the
+             * original exception, then we go into Lockup.
+             *
+             * For QEMU, we rely on the fact that a derived exception is
+             * terminal if and only if it's reported to us as HardFault,
+             * which saves having to have an extra argument is_terminal
+             * that we'd only use in one place.
+             */
+            cpu_abort(&s->cpu->parent_obj,
+                      "Lockup: can't take terminal derived exception "
+                      "(original exception priority %d)\n",
+                      s->vectpending_prio);
+        }
+        /* We now continue with the same code as for a normal pending
+         * exception, which will cause us to pend the derived exception.
+         * We'll then take either the original or the derived exception
+         * based on which is higher priority by the usual mechanism
+         * for selecting the highest priority pending interrupt.
+         */
+    }
 
     if (irq >= ARMV7M_EXCP_HARD && irq < ARMV7M_EXCP_PENDSV) {
         /* If a synchronous exception is pending then it may be
@@ -585,6 +639,16 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
     }
 }
 
+void armv7m_nvic_set_pending(void *opaque, int irq, bool secure)
+{
+    do_armv7m_nvic_set_pending(opaque, irq, secure, false);
+}
+
+void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure)
+{
+    do_armv7m_nvic_set_pending(opaque, irq, secure, true);
+}
+
 /* Make pending IRQ active.  */
 bool armv7m_nvic_acknowledge_irq(void *opaque)
 {
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index be769186fc..09e87d14bd 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -177,7 +177,7 @@ nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %
 nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
 nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
 nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-nvic_set_pending(int irq, bool secure, int en, int prio) "NVIC set pending irq %d secure-bank %d (enabled: %d priority %d)"
+nvic_set_pending(int irq, bool secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d derived %d (enabled: %d priority %d)"
 nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
 nvic_acknowledge_irq(int irq, int prio, bool targets_secure) "NVIC acknowledge IRQ: %d now active (prio %d targets_secure %d)"
-- 
2.16.1
