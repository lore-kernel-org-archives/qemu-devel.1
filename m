Received: from eggs.gnu.org ([209.51.188.92]:58965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSY-0006ly-M2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wST-0005Ha-9X
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:26 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wSN-0004pS-D5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:21 -0500
Received: by mail-pg1-x544.google.com with SMTP id i130so11742943pgd.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:05:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:38 -0800
Message-Id: <20190307170440.3113-21-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 20/22] target/arm: Create a TLB entry for
 tag physical address space
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
 target/arm/cpu.h    | 45 ++++++++++++++++++++++++++++++++++++++-------
 target/arm/helper.c | 20 +++++++++++++++++++-
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6d60d2f37d..3647c5bb55 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2758,10 +2758,15 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * S EL0 (aka S PL0)
  * S EL1 (not used if EL3 is 32 bit)
  * NS EL0+1 stage 2
+ * NS physical tag storage
  *
- * (The last of these is an mmu_idx because we want to be able to use the TLB
- * for the accesses done as part of a stage 1 page table walk, rather than
- * having to walk the stage 2 page table over and over.)
+ * (The NS EL0+1 stage 2 is an mmu_idx because we want to be able to use the
+ * TLB for the accesses done as part of a stage 1 page table walk, rather
+ * than having to walk the stage 2 page table over and over.)
+ *
+ * (The NS physical tag storage is an mmu_idx because we want to be able to
+ * use the TLB to avoid replicating the path through the rcu locks, flatview,
+ * and qemu_map_ram_ptr.)
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2819,6 +2824,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_TagNS = 7 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
@@ -2845,6 +2851,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
     ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_TagNS = 1 << 7,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MUserNegPri = 1 << 2,
@@ -2874,11 +2881,29 @@ static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
 /* Return the exception level we're running at if this is our mmu_idx */
 static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
 {
-    switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
-    case ARM_MMU_IDX_A:
+    switch (mmu_idx) {
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_S2NS:
         return mmu_idx & 3;
-    case ARM_MMU_IDX_M:
+
+    case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MPriv:
+    case ARMMMUIdx_MUserNegPri:
+    case ARMMMUIdx_MPrivNegPri:
+    case ARMMMUIdx_MSUser:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSUserNegPri:
+    case ARMMMUIdx_MSPrivNegPri:
         return mmu_idx & ARM_MMU_IDX_M_PRIV;
+
+    case ARMMMUIdx_TagNS:
+    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_S1NSE1:
     default:
         g_assert_not_reached();
     }
@@ -3183,7 +3208,13 @@ enum {
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
-    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
+    if (attrs.target_tlb_bit2) {
+        return ARMASIdx_TAG;
+    } else if (attrs.secure) {
+        return ARMASIdx_S;
+    } else {
+        return ARMASIdx_NS;
+    }
 }
 
 /* Return the AddressSpace to use for a memory access
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fcab7f99be..eb7b719687 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11948,7 +11948,9 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           target_ulong *page_size,
                           ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    switch (mmu_idx) {
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11999,6 +12001,22 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
              */
             mmu_idx = stage_1_mmu_idx(mmu_idx);
         }
+        break;
+
+    case ARMMMUIdx_TagNS:
+        /*
+         * The tag tlb is physically addressed -- pass through 1:1.
+         * The real work is done in arm_asidx_from_attrs, selecting the
+         * address space, based on target_tlb_bit2.
+         */
+        attrs->target_tlb_bit2 = 1;
+        *phys_ptr = address;
+        *prot = PAGE_READ | PAGE_WRITE;
+        *page_size = TARGET_PAGE_SIZE;
+        return 0;
+
+    default:
+        break;
     }
 
     /* The page table entries may downgrade secure to non-secure, but
-- 
2.17.2
