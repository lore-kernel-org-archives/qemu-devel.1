Received: from eggs.gnu.org ([2001:4830:134:3::10]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTca-00017g-27
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-0006D6-Gt
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcY-0006BY-8H
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcX-0007Sx-8C
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:27 +0100
Message-Id: <1496337035-30213-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/27] arm: Implement HFNMIENA support for M
 profile MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement HFNMIENA support for the M profile MPU. This bit controls
whether the MPU is treated as enabled when executing at execution
priorities of less than zero (in NMI, HardFault or with the FAULTMASK
bit set).

Doing this requires us to use a different MMU index for "running
at execution priority < 0", because we will have different
access permissions for that case versus the normal case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1493122030-32191-14-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 24 +++++++++++++++++++++++-
 target/arm/helper.c    | 18 +++++++++++++++++-
 target/arm/translate.c |  1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5c46c48..13da503 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2045,6 +2045,18 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * for the accesses done as part of a stage 1 page table walk, rather than
  * having to walk the stage 2 page table over and over.)
  *
+ * R profile CPUs have an MPU, but can use the same set of MMU indexes
+ * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
+ * NS EL2 if we ever model a Cortex-R52).
+ *
+ * M profile CPUs are rather different as they do not have a true MMU.
+ * They have the following different MMU indexes:
+ *  User
+ *  Privileged
+ *  Execution priority negative (this is like privileged, but the
+ *  MPU HFNMIENA bit means that it may have different access permission
+ *  check results to normal privileged code, so can't share a TLB).
+ *
  * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
  * are not quite the same -- different CPU types (most notably M profile
  * vs A/R profile) would like to use MMU indexes with different semantics,
@@ -2080,6 +2092,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MNegPri = 2 | ARM_MMU_IDX_M,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
@@ -2100,6 +2113,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S2NS = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
+    ARMMMUIdxBit_MNegPri = 1 << 2,
 } ARMMMUIdxBit;
 
 #define MMU_USER_IDX 0
@@ -2125,7 +2139,7 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARM_MMU_IDX_A:
         return mmu_idx & 3;
     case ARM_MMU_IDX_M:
-        return mmu_idx & 1;
+        return mmu_idx == ARMMMUIdx_MUser ? 0 : 1;
     default:
         g_assert_not_reached();
     }
@@ -2139,6 +2153,14 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
     if (arm_feature(env, ARM_FEATURE_M)) {
         ARMMMUIdx mmu_idx = el == 0 ? ARMMMUIdx_MUser : ARMMMUIdx_MPriv;
 
+        /* Execution priority is negative if FAULTMASK is set or
+         * we're in a HardFault or NMI handler.
+         */
+        if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
+            || env->daif & PSTATE_F) {
+            return arm_to_core_mmu_idx(ARMMMUIdx_MNegPri);
+        }
+
         return arm_to_core_mmu_idx(mmu_idx);
     }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 674b52d..2594faa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7037,6 +7037,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MNegPri:
     case ARMMMUIdx_MUser:
         return 1;
     default:
@@ -7055,6 +7056,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1E2:
     case ARMMMUIdx_S2NS:
     case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MNegPri:
     case ARMMMUIdx_MUser:
         return false;
     case ARMMMUIdx_S1E3:
@@ -7077,7 +7079,21 @@ static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
 {
     if (arm_feature(env, ARM_FEATURE_M)) {
-        return !(env->v7m.mpu_ctrl & R_V7M_MPU_CTRL_ENABLE_MASK);
+        switch (env->v7m.mpu_ctrl &
+                (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
+        case R_V7M_MPU_CTRL_ENABLE_MASK:
+            /* Enabled, but not for HardFault and NMI */
+            return mmu_idx == ARMMMUIdx_MNegPri;
+        case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
+            /* Enabled for all cases */
+            return false;
+        case 0:
+        default:
+            /* HFNMIENA set and ENABLE clear is UNPREDICTABLE, but
+             * we warned about that in armv7m_nvic.c when the guest set it.
+             */
+            return true;
+        }
     }
 
     if (mmu_idx == ARMMMUIdx_S2NS) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ac905dd..ae6646c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -163,6 +163,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
         return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
     case ARMMMUIdx_S2NS:
     default:
-- 
2.7.4
