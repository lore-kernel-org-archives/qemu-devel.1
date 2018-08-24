Received: from eggs.gnu.org ([2001:4830:134:3::10]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftCrF-0002eD-8D
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftCrA-0001mb-Ae
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:14:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftCr9-0001lH-UC
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:14:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id c6-v6so1156761pls.4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:14:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 24 Aug 2018 07:14:28 -0700
Message-Id: <20180824141428.27268-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix cpu_get_tb_cpu_flags vs !sve
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

Not only are the sve-related tb_flags fields unused when SVE is
disabled, but not all of the cpu registers are initialized properly
for computing same.  This can corrupt other fields by oring in -1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 088f452716..64b1564594 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12587,36 +12587,39 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t flags;
 
     if (is_a64(env)) {
-        int sve_el = sve_exception_el(env);
-        uint32_t zcr_len;
-
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
         flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
-        flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
 
-        /* If SVE is disabled, but FP is enabled,
-           then the effective len is 0.  */
-        if (sve_el != 0 && fp_el == 0) {
-            zcr_len = 0;
-        } else {
-            int current_el = arm_current_el(env);
-            ARMCPU *cpu = arm_env_get_cpu(env);
+        if (arm_feature(env, ARM_FEATURE_SVE)) {
+            int sve_el = sve_exception_el(env);
+            uint32_t zcr_len;
 
-            zcr_len = cpu->sve_max_vq - 1;
-            if (current_el <= 1) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
-            }
-            if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
-            }
-            if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+            /* If SVE is disabled, but FP is enabled,
+             * then the effective len is 0.
+             */
+            if (sve_el != 0 && fp_el == 0) {
+                zcr_len = 0;
+            } else {
+                int current_el = arm_current_el(env);
+                ARMCPU *cpu = arm_env_get_cpu(env);
+
+                zcr_len = cpu->sve_max_vq - 1;
+                if (current_el <= 1) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
+                }
+                if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
+                }
+                if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+                }
             }
+            flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
+            flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
         }
-        flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
-- 
2.17.1
