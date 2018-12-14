Received: from eggs.gnu.org ([2001:4830:134:3::10]:55754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxi-0004TP-Fh
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxe-0005QF-Ct
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:32 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxe-0005Q1-6c
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:30 -0500
Received: by mail-oi1-x241.google.com with SMTP id y23so3631501oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:57 -0600
Message-Id: <20181214052410.11863-15-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 14/27] target/arm: Move cpu_mmu_index out of
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This function is, or will shortly become, too big to inline.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 48 +++++----------------------------------------
 target/arm/helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 898243c93e..6435997111 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2739,54 +2739,16 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
 }
 
 /* Return the MMU index for a v7M CPU in the specified security and
- * privilege state
+ * privilege state.
  */
-static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                              bool secstate,
-                                                              bool priv)
-{
-    ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
-
-    if (priv) {
-        mmu_idx |= ARM_MMU_IDX_M_PRIV;
-    }
-
-    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
-        mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
-    }
-
-    if (secstate) {
-        mmu_idx |= ARM_MMU_IDX_M_S;
-    }
-
-    return mmu_idx;
-}
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                bool secstate, bool priv);
 
 /* Return the MMU index for a v7M CPU in the specified security state */
-static inline ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env,
-                                                     bool secstate)
-{
-    bool priv = arm_current_el(env) != 0;
-
-    return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
-}
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
 
 /* Determine the current mmu_idx to use for normal loads/stores */
-static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    int el = arm_current_el(env);
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        ARMMMUIdx mmu_idx = arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
-
-        return arm_to_core_mmu_idx(mmu_idx);
-    }
-
-    if (el < 2 && arm_is_secure_below_el3(env)) {
-        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0 + el);
-    }
-    return el;
-}
+int cpu_mmu_index(CPUARMState *env, bool ifetch);
 
 /* Indexes used when registering address spaces with cpu_address_space_init */
 typedef enum ARMASIdx {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bd0cff5c27..56960411e3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12949,6 +12949,50 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                bool secstate, bool priv)
+{
+    ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
+
+    if (priv) {
+        mmu_idx |= ARM_MMU_IDX_M_PRIV;
+    }
+
+    if (armv7m_nvic_neg_prio_requested(env->nvic, secstate)) {
+        mmu_idx |= ARM_MMU_IDX_M_NEGPRI;
+    }
+
+    if (secstate) {
+        mmu_idx |= ARM_MMU_IDX_M_S;
+    }
+
+    return mmu_idx;
+}
+
+/* Return the MMU index for a v7M CPU in the specified security state */
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+{
+    bool priv = arm_current_el(env) != 0;
+
+    return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
+}
+
+int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    int el = arm_current_el(env);
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        ARMMMUIdx mmu_idx = arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
+
+        return arm_to_core_mmu_idx(mmu_idx);
+    }
+
+    if (el < 2 && arm_is_secure_below_el3(env)) {
+        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0 + el);
+    }
+    return el;
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-- 
2.17.2
