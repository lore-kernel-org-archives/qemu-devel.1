Received: from eggs.gnu.org ([2001:4830:134:3::10]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqz-0000zi-Vf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqu-0007bb-QF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqu-0007Xf-Hf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqp-0001a8-Rr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:05 +0100
Message-Id: <1504790904-17018-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/31] target/arm: Add MMU indexes for secure v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that MPU lookups can return different results for v8M
when the CPU is in secure vs non-secure state, we need to
have separate MMU indexes; add the secure counterparts
to the existing three M profile MMU indexes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 19 +++++++++++++++++--
 target/arm/helper.c |  9 ++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 02919a3..d93fe96 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2103,6 +2103,10 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  *  Execution priority negative (this is like privileged, but the
  *  MPU HFNMIENA bit means that it may have different access permission
  *  check results to normal privileged code, so can't share a TLB).
+ * If the CPU supports the v8M Security Extension then there are also:
+ *  Secure User
+ *  Secure Privileged
+ *  Secure, execution priority negative
  *
  * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
  * are not quite the same -- different CPU types (most notably M profile
@@ -2140,6 +2144,9 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MNegPri = 2 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSUser = 3 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSPriv = 4 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSNegPri = 5 | ARM_MMU_IDX_M,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
@@ -2161,6 +2168,9 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MNegPri = 1 << 2,
+    ARMMMUIdxBit_MSUser = 1 << 3,
+    ARMMMUIdxBit_MSPriv = 1 << 4,
+    ARMMMUIdxBit_MSNegPri = 1 << 5,
 } ARMMMUIdxBit;
 
 #define MMU_USER_IDX 0
@@ -2186,7 +2196,8 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARM_MMU_IDX_A:
         return mmu_idx & 3;
     case ARM_MMU_IDX_M:
-        return mmu_idx == ARMMMUIdx_MUser ? 0 : 1;
+        return (mmu_idx == ARMMMUIdx_MUser || mmu_idx == ARMMMUIdx_MSUser)
+            ? 0 : 1;
     default:
         g_assert_not_reached();
     }
@@ -2205,7 +2216,11 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
          */
         if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
             || env->v7m.faultmask) {
-            return arm_to_core_mmu_idx(ARMMMUIdx_MNegPri);
+            mmu_idx = ARMMMUIdx_MNegPri;
+        }
+
+        if (env->v7m.secure) {
+            mmu_idx += ARMMMUIdx_MSUser;
         }
 
         return arm_to_core_mmu_idx(mmu_idx);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bab3848..3062c47 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7032,6 +7032,9 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_MPriv:
     case ARMMMUIdx_MNegPri:
     case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSNegPri:
+    case ARMMMUIdx_MSUser:
         return 1;
     default:
         g_assert_not_reached();
@@ -7055,6 +7058,9 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSNegPri:
+    case ARMMMUIdx_MSUser:
         return true;
     default:
         g_assert_not_reached();
@@ -7076,7 +7082,8 @@ static inline bool regime_translation_disabled(CPUARMState *env,
                 (R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK)) {
         case R_V7M_MPU_CTRL_ENABLE_MASK:
             /* Enabled, but not for HardFault and NMI */
-            return mmu_idx == ARMMMUIdx_MNegPri;
+            return mmu_idx == ARMMMUIdx_MNegPri ||
+                mmu_idx == ARMMMUIdx_MSNegPri;
         case R_V7M_MPU_CTRL_ENABLE_MASK | R_V7M_MPU_CTRL_HFNMIENA_MASK:
             /* Enabled for all cases */
             return false;
-- 
2.7.4
