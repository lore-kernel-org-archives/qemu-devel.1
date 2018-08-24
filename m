Received: from eggs.gnu.org ([2001:4830:134:3::10]:49894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftCqL-0002Dd-Ce
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftCqK-0000ye-B7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:13:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 15:13:33 +0100
Message-Id: <20180824141333.24903-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Don't calculate zcr_len for TB
 flags in non-SVE CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>

Skip calculation of the zcr_len part of TB flags if the CPU
doesn't have SVE. This fixes a bug where for a non-SVE CPU
we might end up with a bogus zcr_len value of -1, which then
trashes other TB flags when it is ORed into the flags word,
resulting in a QEMU crash later due to a bogus mmu_idx field.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not entirely sure why this doesn't cause us problems more often.
I saw it with an AArch32 setup with an A57 with EL2 but not EL3.

 target/arm/helper.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 088f452716e..89767f55a1e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12597,26 +12597,28 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
         flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
 
-        /* If SVE is disabled, but FP is enabled,
-           then the effective len is 0.  */
-        if (sve_el != 0 && fp_el == 0) {
-            zcr_len = 0;
-        } else {
-            int current_el = arm_current_el(env);
-            ARMCPU *cpu = arm_env_get_cpu(env);
+        if (arm_feature(env, ARM_FEATURE_SVE)) {
+            /* If SVE is disabled, but FP is enabled,
+               then the effective len is 0.  */
+            if (sve_el != 0 && fp_el == 0) {
+                zcr_len = 0;
+            } else {
+                int current_el = arm_current_el(env);
+                ARMCPU *cpu = arm_env_get_cpu(env);
 
-            zcr_len = cpu->sve_max_vq - 1;
-            if (current_el <= 1) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
-            }
-            if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
-            }
-            if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
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
+            flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
         }
-        flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
-- 
2.18.0
