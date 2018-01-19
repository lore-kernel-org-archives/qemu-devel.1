Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhp-0002Nb-JN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOho-0000Wt-Ou
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:09 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOho-0000Vp-Ih
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:08 -0500
Received: by mail-pf0-x244.google.com with SMTP id t5so538424pfi.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:55:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:38 -0800
Message-Id: <20180119045438.28582-17-richard.henderson@linaro.org>
In-Reply-To: <20180119045438.28582-1-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 16/16] target/arm: Add SVE state to TB->FLAGS
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

Add both SVE exception state and vector length.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  4 ++++
 target/arm/helper.c | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2de1afb53a..d7208d56df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2646,6 +2646,10 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #define ARM_TBFLAG_TBI0_MASK (0x1ull << ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1_SHIFT 1        /* TBI1 for EL0/1  */
 #define ARM_TBFLAG_TBI1_MASK (0x1ull << ARM_TBFLAG_TBI1_SHIFT)
+#define ARM_TBFLAG_SVEEXC_EL_SHIFT  2
+#define ARM_TBFLAG_SVEEXC_EL_MASK   (0x3 << ARM_TBFLAG_SVEEXC_EL_SHIFT)
+#define ARM_TBFLAG_ZCR_LEN_SHIFT    4
+#define ARM_TBFLAG_ZCR_LEN_MASK     (0xf << ARM_TBFLAG_ZCR_LEN_SHIFT)
 
 /* some convenience accessor macros */
 #define ARM_TBFLAG_AARCH64_STATE(F) \
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44814af99b..6072634ca8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11772,14 +11772,35 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    int fp_el = fp_exception_el(env);
     uint32_t flags;
 
     if (is_a64(env)) {
+        int sve_el = sve_exception_el(env);
+        uint32_t zcr_len;
+
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
         flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+        flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
+
+        /* If SVE is disabled, but FP is enabled,
+           then the effective len is 0.  */
+        if (sve_el != 0 && fp_el == 0) {
+            zcr_len = 0;
+        } else {
+            int highest_el = arm_highest_el(env);
+            int current_el = arm_current_el(env);
+            int i;
+
+            zcr_len = 0xf & (uint32_t)env->vfp.zcr_el[highest_el];
+            for (i = highest_el - 1; i >= MAX(1, current_el); --i) {
+                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[i]);
+            }
+        }
+        flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
@@ -11822,7 +11843,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (arm_cpu_data_is_big_endian(env)) {
         flags |= ARM_TBFLAG_BE_DATA_MASK;
     }
-    flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
+    flags |= fp_el << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
     if (arm_v7m_is_handler_mode(env)) {
         flags |= ARM_TBFLAG_HANDLER_MASK;
-- 
2.14.3
