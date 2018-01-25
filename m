Received: from eggs.gnu.org ([2001:4830:134:3::10]:33649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehof-0003DI-3a
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoe-00037R-2G
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehod-00030M-Lb
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehob-0006uB-G2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:20 +0000
Message-Id: <1516887809-6265-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/21] target/arm: Hoist store to flags output
 in cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180119045438.28582-15-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e64bb9..e0c139d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11688,34 +11688,36 @@ static inline int fp_exception_el(CPUARMState *env)
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
@@ -11725,25 +11727,26 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
2.7.4
