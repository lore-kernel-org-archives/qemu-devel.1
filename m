Received: from eggs.gnu.org ([2001:4830:134:3::10]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2h-0008Ob-G9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2g-0007iq-Iu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:27 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:35:56 +0000
Message-Id: <1487262963-11519-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/13] armv7m: Escalate exceptions to
 HardFault if necessary
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

From: Michael Davidsaver <mdavidsaver@gmail.com>

The v7M exception architecture requires that if a synchronous
exception cannot be taken immediately (because it is disabled
or at too low a priority) then it should be escalated to
HardFault (and the HardFault exception is then taken).
Implement this escalation logic.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: extracted from another patch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/armv7m_nvic.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c   |  2 --
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index e0fce3e..d9b9a43 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -352,6 +352,59 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
 
     vec = &s->vectors[irq];
     trace_nvic_set_pending(irq, vec->enabled, vec->prio);
+
+
+    if (irq >= ARMV7M_EXCP_HARD && irq < ARMV7M_EXCP_PENDSV) {
+        /* If a synchronous exception is pending then it may be
+         * escalated to HardFault if:
+         *  * it is equal or lower priority to current execution
+         *  * it is disabled
+         * (ie we need to take it immediately but we can't do so).
+         * Asynchronous exceptions (and interrupts) simply remain pending.
+         *
+         * For QEMU, we don't have any imprecise (asynchronous) faults,
+         * so we can assume that PREFETCH_ABORT and DATA_ABORT are always
+         * synchronous.
+         * Debug exceptions are awkward because only Debug exceptions
+         * resulting from the BKPT instruction should be escalated,
+         * but we don't currently implement any Debug exceptions other
+         * than those that result from BKPT, so we treat all debug exceptions
+         * as needing escalation.
+         *
+         * This all means we can identify whether to escalate based only on
+         * the exception number and don't (yet) need the caller to explicitly
+         * tell us whether this exception is synchronous or not.
+         */
+        int running = nvic_exec_prio(s);
+        bool escalate = false;
+
+        if (vec->prio >= running) {
+            trace_nvic_escalate_prio(irq, vec->prio, running);
+            escalate = true;
+        } else if (!vec->enabled) {
+            trace_nvic_escalate_disabled(irq);
+            escalate = true;
+        }
+
+        if (escalate) {
+            if (running < 0) {
+                /* We want to escalate to HardFault but we can't take a
+                 * synchronous HardFault at this point either. This is a
+                 * Lockup condition due to a guest bug. We don't model
+                 * Lockup, so report via cpu_abort() instead.
+                 */
+                cpu_abort(&s->cpu->parent_obj,
+                          "Lockup: can't escalate %d to HardFault "
+                          "(current priority %d)\n", irq, running);
+            }
+
+            /* We can do the escalation, so we take HardFault instead */
+            irq = ARMV7M_EXCP_HARD;
+            vec = &s->vectors[irq];
+            s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
+        }
+    }
+
     if (!vec->pending) {
         vec->pending = 1;
         nvic_irq_update(s);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 47250bc..bac1718 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6105,8 +6105,6 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     /* For exceptions we just mark as pending on the NVIC, and let that
        handle it.  */
-    /* TODO: Need to escalate if the current priority is higher than the
-       one we're raising.  */
     switch (cs->exception_index) {
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-- 
2.7.4
