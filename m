Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhp-0002Na-4s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhm-0000T8-1j
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:09 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOhl-0000Sx-R7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:05 -0500
Received: by mail-pf0-x242.google.com with SMTP id 23so534528pfp.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:55:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:36 -0800
Message-Id: <20180119045438.28582-15-richard.henderson@linaro.org>
In-Reply-To: <20180119045438.28582-1-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 14/16] target/arm: Hoist store to flags
 output in cpu_get_tb_cpu_state
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9e673bb672..c0e5f321c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11768,34 +11768,36 @@ static inline int fp_exception_el(CPUARMState *env)
 }
 
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *flags)
+                          target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    uint32_t flags;
+
     if (is_a64(env)) {
         *pc = env->pc;
-        *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
+        flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
-        *flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
-        *flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+        flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
+        flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
     } else {
         *pc = env->regs[15];
-        *flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
+        flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
             | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
             | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
             | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
             | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
         if (!(access_secure_reg(env))) {
-            *flags |= ARM_TBFLAG_NS_MASK;
+            flags |= ARM_TBFLAG_NS_MASK;
         }
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1)) {
-            *flags |= ARM_TBFLAG_VFPEN_MASK;
+            flags |= ARM_TBFLAG_VFPEN_MASK;
         }
-        *flags |= (extract32(env->cp15.c15_cpar, 0, 2)
-                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
+        flags |= (extract32(env->cp15.c15_cpar, 0, 2)
+                  << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
     }
 
-    *flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
+    flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
@@ -11805,25 +11807,26 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      */
     if (arm_singlestep_active(env)) {
-        *flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
+        flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
         if (is_a64(env)) {
             if (env->pstate & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
             }
         } else {
             if (env->uncached_cpsr & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
             }
         }
     }
     if (arm_cpu_data_is_big_endian(env)) {
-        *flags |= ARM_TBFLAG_BE_DATA_MASK;
+        flags |= ARM_TBFLAG_BE_DATA_MASK;
     }
-    *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
+    flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
     if (arm_v7m_is_handler_mode(env)) {
-        *flags |= ARM_TBFLAG_HANDLER_MASK;
+        flags |= ARM_TBFLAG_HANDLER_MASK;
     }
 
+    *pflags = flags;
     *cs_base = 0;
 }
-- 
2.14.3
