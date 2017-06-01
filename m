Received: from eggs.gnu.org ([2001:4830:134:3::10]:35116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcV-00014m-V9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcU-00068v-P4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcU-00064g-Gg
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcQ-0007Pb-7d
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:42 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:17 +0100
Message-Id: <1496337035-30213-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/27] arm: Use different ARMMMUIdx values for M
 profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make M profile use completely separate ARMMMUIdx values from
those that A profile CPUs use. This is a prelude to adding
support for the MPU and for v8M, which together will require
6 MMU indexes which don't map cleanly onto the A profile
uses:
 non secure User
 non secure Privileged
 non secure Privileged, execution priority < 0
 secure User
 secure Privileged
 secure Privileged, execution priority < 0

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1493122030-32191-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 21 +++++++++++++++++++--
 target/arm/helper.c    |  5 +++++
 target/arm/translate.c |  3 +++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4b1e982..cadec09 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2057,8 +2057,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * of the AT/ATS operations.
  * The values used are carefully arranged to make mmu_idx => EL lookup easy.
  */
-#define ARM_MMU_IDX_A 0x10 /* A profile (and M profile, for the moment) */
+#define ARM_MMU_IDX_A 0x10 /* A profile */
 #define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
+#define ARM_MMU_IDX_M 0x40 /* M profile */
 
 #define ARM_MMU_IDX_TYPE_MASK (~0x7)
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
@@ -2071,6 +2072,8 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
@@ -2089,6 +2092,8 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
     ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_MUser = 1 << 0,
+    ARMMMUIdxBit_MPriv = 1 << 1,
 } ARMMMUIdxBit;
 
 #define MMU_USER_IDX 0
@@ -2100,7 +2105,11 @@ static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
 
 static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
 {
-    return mmu_idx | ARM_MMU_IDX_A;
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return mmu_idx | ARM_MMU_IDX_M;
+    } else {
+        return mmu_idx | ARM_MMU_IDX_A;
+    }
 }
 
 /* Return the exception level we're running at if this is our mmu_idx */
@@ -2109,6 +2118,8 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
     case ARM_MMU_IDX_A:
         return mmu_idx & 3;
+    case ARM_MMU_IDX_M:
+        return mmu_idx & 1;
     default:
         g_assert_not_reached();
     }
@@ -2119,6 +2130,12 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
     int el = arm_current_el(env);
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        ARMMMUIdx mmu_idx = el == 0 ? ARMMMUIdx_MUser : ARMMMUIdx_MPriv;
+
+        return arm_to_core_mmu_idx(mmu_idx);
+    }
+
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0 + el);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 520adcc..791332c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6992,6 +6992,8 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1SE1:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MUser:
         return 1;
     default:
         g_assert_not_reached();
@@ -7008,6 +7010,8 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
     case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MUser:
         return false;
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
@@ -7146,6 +7150,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_MUser:
         return true;
     default:
         return false;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8d509a2..ac905dd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -161,6 +161,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
         return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
+    case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MPriv:
+        return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
     case ARMMMUIdx_S2NS:
     default:
         g_assert_not_reached();
-- 
2.7.4
