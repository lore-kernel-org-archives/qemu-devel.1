Received: from eggs.gnu.org ([2001:4830:134:3::10]:43572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph6-0003Wv-4D
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph4-0006Ue-Ro
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:14:03 +0100
Message-Id: <1505240046-11454-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 16/19] target/arm: Handle banking in
 negative-execution-priority check in cpu_mmu_index()
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

Now that we have a banked FAULTMASK register and banked exceptions,
we can implement the correct check in cpu_mmu_index() for whether
the MPU_CTRL.HFNMIENA bit's effect should apply. This bit causes
handlers which have requested a negative execution priority to run
with the MPU disabled. In v8M the test has to check this for the
current security state and so takes account of banking.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 21 ++++++++++++++++-----
 hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7a93354..02be3ca 100644
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
@@ -2280,11 +2295,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
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
index b13327d..5e5aecd 100644
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
