Received: from eggs.gnu.org ([2001:4830:134:3::10]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-00033Y-10
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XK-0002wG-QM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XK-0002sG-In
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XJ-00058o-IK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:24 +0100
Message-Id: <1506012099-13605-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/31] target/arm: Handle banking in
 negative-execution-priority check in cpu_mmu_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that we have a banked FAULTMASK register and banked exceptions,
we can implement the correct check in cpu_mmu_index() for whether
the MPU_CTRL.HFNMIENA bit's effect should apply. This bit causes
handlers which have requested a negative execution priority to run
with the MPU disabled. In v8M the test has to check this for the
current security state and so takes account of banking.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-17-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 21 ++++++++++++++++-----
 hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b67c29b..c21c592 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1498,6 +1498,21 @@ int armv7m_nvic_complete_irq(void *opaque, int irq);
  * (v8M ARM ARM I_PKLD.)
  */
 int armv7m_nvic_raw_execution_priority(void *opaque);
+/**
+ * armv7m_nvic_neg_prio_requested: return true if the requested execution
+ * priority is negative for the specified security state.
+ * @opaque: the NVIC
+ * @secure: the security state to test
+ * This corresponds to the pseudocode IsReqExecPriNeg().
+ */
+#ifndef CONFIG_USER_ONLY
+bool armv7m_nvic_neg_prio_requested(void *opaque, bool secure);
+#else
+static inline bool armv7m_nvic_neg_prio_requested(void *opaque, bool secure)
+{
+    return false;
+}
+#endif
 
 /* Interface for defining coprocessor registers.
  * Registers are defined in tables of arm_cp_reginfo structs
@@ -2283,11 +2298,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
     if (arm_feature(env, ARM_FEATURE_M)) {
         ARMMMUIdx mmu_idx = el == 0 ? ARMMMUIdx_MUser : ARMMMUIdx_MPriv;
 
-        /* Execution priority is negative if FAULTMASK is set or
-         * we're in a HardFault or NMI handler.
-         */
-        if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
-            || env->v7m.faultmask[env->v7m.secure]) {
+        if (armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
             mmu_idx = ARMMMUIdx_MNegPri;
         }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 1f9e1aa..1aa925b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -368,6 +368,35 @@ static inline int nvic_exec_prio(NVICState *s)
     return MIN(running, s->exception_prio);
 }
 
+bool armv7m_nvic_neg_prio_requested(void *opaque, bool secure)
+{
+    /* Return true if the requested execution priority is negative
+     * for the specified security state, ie that security state
+     * has an active NMI or HardFault or has set its FAULTMASK.
+     * Note that this is not the same as whether the execution
+     * priority is actually negative (for instance AIRCR.PRIS may
+     * mean we don't allow FAULTMASK_NS to actually make the execution
+     * priority negative). Compare pseudocode IsReqExcPriNeg().
+     */
+    NVICState *s = opaque;
+
+    if (s->cpu->env.v7m.faultmask[secure]) {
+        return true;
+    }
+
+    if (secure ? s->sec_vectors[ARMV7M_EXCP_HARD].active :
+        s->vectors[ARMV7M_EXCP_HARD].active) {
+        return true;
+    }
+
+    if (s->vectors[ARMV7M_EXCP_NMI].active &&
+        exc_targets_secure(s, ARMV7M_EXCP_NMI) == secure) {
+        return true;
+    }
+
+    return false;
+}
+
 bool armv7m_nvic_can_take_pending_exception(void *opaque)
 {
     NVICState *s = opaque;
-- 
2.7.4
