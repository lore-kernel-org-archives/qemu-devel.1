Received: from eggs.gnu.org ([209.51.188.92]:52732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv7-0000Ch-AI
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv5-0004mk-8d
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:25 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzv4-0004fC-KU
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:22 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so2595014pfd.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:13 +1000
Message-Id: <20190108223129.5570-16-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 15/31] target/arm: Move cpu_mmu_index out of
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
index 9ad7b2d11e..eb83a71b67 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2741,54 +2741,16 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
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
index f23555b1dc..56d0b60b74 100644
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
