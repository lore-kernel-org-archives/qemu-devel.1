Received: from eggs.gnu.org ([2001:4830:134:3::10]:38857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fha3X-0005LF-G0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fha3W-00068X-FW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:35:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 13:34:57 +0100
Message-Id: <20180723123457.2038-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Escalate to correct HardFault when
 AIRCR.BFHFNMINS is set
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

When we escalate a v8M exception to HardFault, if AIRCR.BFHFNMINNS is
set then we need to decide whether it should become a secure HardFault
or a nonsecure HardFault. We should always escalate to the same
target security state as the original exception. The current code
tries to test this using the 'secure' bool, which is not right because
that flag indicates whether the target security state only for
banked exceptions; the effect was that we were incorrectly escalating
always-secure exceptions like SecureFault to a nonsecure HardFault.

Fix this by defining, logging and using a new 'targets_secure' bool
which tracks the condition we actually want.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 8 ++++++--
 hw/intc/trace-events  | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index bf92fe0972c..e160b02eab4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -529,13 +529,17 @@ static void do_armv7m_nvic_set_pending(void *opaque, int irq, bool secure,
     NVICState *s = (NVICState *)opaque;
     bool banked = exc_is_banked(irq);
     VecInfo *vec;
+    bool targets_secure;
 
     assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
     assert(!secure || banked);
 
     vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
 
-    trace_nvic_set_pending(irq, secure, derived, vec->enabled, vec->prio);
+    targets_secure = banked ? secure : exc_targets_secure(s, irq);
+
+    trace_nvic_set_pending(irq, secure, targets_secure,
+                           derived, vec->enabled, vec->prio);
 
     if (derived) {
         /* Derived exceptions are always synchronous. */
@@ -615,7 +619,7 @@ static void do_armv7m_nvic_set_pending(void *opaque, int irq, bool secure,
              */
             irq = ARMV7M_EXCP_HARD;
             if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY) &&
-                (secure ||
+                (targets_secure ||
                  !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK))) {
                 vec = &s->sec_vectors[irq];
             } else {
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index b6cb5e6048d..33e932fb918 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -177,7 +177,7 @@ nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %
 nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
 nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
 nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-nvic_set_pending(int irq, bool secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d derived %d (enabled: %d priority %d)"
+nvic_set_pending(int irq, bool secure, bool targets_secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d targets_secure %d derived %d (enabled: %d priority %d)"
 nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
 nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
 nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
-- 
2.17.1
