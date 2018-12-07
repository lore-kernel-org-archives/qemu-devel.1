Received: from eggs.gnu.org ([2001:4830:134:3::10]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVD-0008Bu-7N
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVC-0007kc-0c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:59 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVB-0007ht-Qj
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so3309703otm.13
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:19 -0600
Message-Id: <20181207103631.28193-15-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/26] target/arm: Move cpu_mmu_index out of
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
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

This function is, or will shortly become, too big to inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 48 +++++----------------------------------------
 target/arm/helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f70eff8bcf..18f2378b87 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2731,54 +2731,16 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
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
index 158c550fab..eaa9e60e7b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12959,6 +12959,50 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
