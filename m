Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB88C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA454206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA454206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc80N-0003yf-Vu
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7sN-00036X-Te; Mon, 09 Nov 2020 09:10:32 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60186
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7sL-0002oy-57; Mon, 09 Nov 2020 09:10:31 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 1255060362;
 Mon,  9 Nov 2020 15:10:23 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 09/17] target/arm: add MMU stage 1 for Secure EL2
Date: Mon,  9 Nov 2020 16:10:12 +0200
Message-Id: <20201109141020.27234-9-remi.denis.courmont@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <5554493.MhkbZ0Pkbq@basile.remlab.net>
References: <5554493.MhkbZ0Pkbq@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:56:07
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

This adds the MMU indices for EL2 stage 1 in secure mode.

To keep code contained, which is largelly identical between secure and
non-secure modes, the MMU indices are reassigned. The new assignments
provide a systematic pattern with a non-secure bit.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.h           |  37 +++++++----
 target/arm/helper.c        | 127 ++++++++++++++++++++++++-------------
 target/arm/internals.h     |  12 ++++
 target/arm/translate-a64.c |   4 ++
 5 files changed, 124 insertions(+), 58 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 6321385b46..00e7d9e937 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,6 +29,6 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif
 
-#define NB_MMU_MODES 11
+#define NB_MMU_MODES 15
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a74055df22..c7f17fc099 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2946,6 +2946,9 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
 #define ARM_MMU_IDX_M     0x40  /* M profile */
 
+/* Meanings of the bits for A profile mmu idx values */
+#define ARM_MMU_IDX_A_NS     0x8
+
 /* Meanings of the bits for M profile mmu idx values */
 #define ARM_MMU_IDX_M_PRIV   0x1
 #define ARM_MMU_IDX_M_NEGPRI 0x2
@@ -2959,20 +2962,22 @@ typedef enum ARMMMUIdx {
     /*
      * A-profile.
      */
-    ARMMMUIdx_E10_0      =  0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_0      =  1 | ARM_MMU_IDX_A,
-
-    ARMMMUIdx_E10_1      =  2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E10_1_PAN  =  3 | ARM_MMU_IDX_A,
-
-    ARMMMUIdx_E2         =  4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2      =  5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2_PAN  =  6 | ARM_MMU_IDX_A,
-
-    ARMMMUIdx_SE10_0     = 7 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE10_1     = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE10_1_PAN = 9 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE3        = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_0     =  0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE20_0     =  1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1     =  2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE20_2     =  3 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1_PAN =  4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE20_2_PAN =  5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE2        =  6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3        =  7 | ARM_MMU_IDX_A,
+
+    ARMMMUIdx_E10_0     = ARMMMUIdx_SE10_0 | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E20_0     = ARMMMUIdx_SE20_0 | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E10_1     = ARMMMUIdx_SE10_1 | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E20_2     = ARMMMUIdx_SE20_2 | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E10_1_PAN = ARMMMUIdx_SE10_1_PAN | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E20_2_PAN = ARMMMUIdx_SE20_2_PAN | ARM_MMU_IDX_A_NS,
+    ARMMMUIdx_E2        = ARMMMUIdx_SE2 | ARM_MMU_IDX_A_NS,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -3019,8 +3024,12 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(E20_2),
     TO_CORE_BIT(E20_2_PAN),
     TO_CORE_BIT(SE10_0),
+    TO_CORE_BIT(SE20_0),
     TO_CORE_BIT(SE10_1),
+    TO_CORE_BIT(SE20_2),
     TO_CORE_BIT(SE10_1_PAN),
+    TO_CORE_BIT(SE20_2_PAN),
+    TO_CORE_BIT(SE2),
     TO_CORE_BIT(SE3),
 
     TO_CORE_BIT(MUser),
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 14eb0b4719..3df007a5dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2861,6 +2861,9 @@ static int gt_phys_redir_timeridx(CPUARMState *env)
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_SE20_0:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
         return GTIMER_HYP;
     default:
         return GTIMER_PHYS;
@@ -2873,6 +2876,9 @@ static int gt_virt_redir_timeridx(CPUARMState *env)
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_SE20_0:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
         return GTIMER_HYPVIRT;
     default:
         return GTIMER_VIRT;
@@ -3576,7 +3582,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_SE3;
             break;
         case 2:
-            g_assert(!secure);  /* TODO: ARMv8.4-SecEL2 */
+            g_assert(!secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             /* fall through */
         case 1:
             if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
@@ -3672,7 +3678,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
             }
             break;
         case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = ARMMMUIdx_E2;
+            mmu_idx = secure ? ARMMMUIdx_SE2 : ARMMMUIdx_E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
             mmu_idx = ARMMMUIdx_SE3;
@@ -3987,10 +3993,15 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
-        tlb_flush_by_mmuidx(env_cpu(env),
-                            ARMMMUIdxBit_E20_2 |
-                            ARMMMUIdxBit_E20_2_PAN |
-                            ARMMMUIdxBit_E20_0);
+        uint16_t mask = ARMMMUIdxBit_E20_2 |
+                        ARMMMUIdxBit_E20_2_PAN |
+                        ARMMMUIdxBit_E20_0;
+
+        if (arm_is_secure_below_el3(env)) {
+            mask >>= ARM_MMU_IDX_A_NS;
+        }
+
+        tlb_flush_by_mmuidx(env_cpu(env), mask);
     }
     raw_write(env, ri, value);
 }
@@ -4441,9 +4452,15 @@ static int vae1_tlbmask(CPUARMState *env)
     uint64_t hcr = arm_hcr_el2_eff(env);
 
     if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-        return ARMMMUIdxBit_E20_2 |
-               ARMMMUIdxBit_E20_2_PAN |
-               ARMMMUIdxBit_E20_0;
+        uint16_t mask = ARMMMUIdxBit_E20_2 |
+                        ARMMMUIdxBit_E20_2_PAN |
+                        ARMMMUIdxBit_E20_0;
+
+        if (arm_is_secure_below_el3(env)) {
+            mask >>= ARM_MMU_IDX_A_NS;
+        }
+
+        return mask;
     } else if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE10_1 |
                ARMMMUIdxBit_SE10_1_PAN |
@@ -4468,17 +4485,20 @@ static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
 
 static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
 {
+    uint64_t hcr = arm_hcr_el2_eff(env);
     ARMMMUIdx mmu_idx;
 
     /* Only the regime of the mmu_idx below is significant. */
-    if (arm_is_secure_below_el3(env)) {
-        mmu_idx = ARMMMUIdx_SE10_0;
-    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
-               == (HCR_E2H | HCR_TGE)) {
+    if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
         mmu_idx = ARMMMUIdx_E20_0;
     } else {
         mmu_idx = ARMMMUIdx_E10_0;
     }
+
+    if (arm_is_secure_below_el3(env)) {
+        mmu_idx &= ~ARM_MMU_IDX_A_NS;
+    }
+
     return tlbbits_for_regime(env, mmu_idx, addr);
 }
 
@@ -4524,11 +4544,17 @@ static int alle1_tlbmask(CPUARMState *env)
 
 static int e2_tlbmask(CPUARMState *env)
 {
-    /* TODO: ARMv8.4-SecEL2 */
-    return ARMMMUIdxBit_E20_0 |
-           ARMMMUIdxBit_E20_2 |
-           ARMMMUIdxBit_E20_2_PAN |
-           ARMMMUIdxBit_E2;
+    if (arm_is_secure_below_el3(env)) {
+        return ARMMMUIdxBit_SE20_0 |
+               ARMMMUIdxBit_SE20_2 |
+               ARMMMUIdxBit_SE20_2_PAN |
+               ARMMMUIdxBit_SE2;
+    } else {
+        return ARMMMUIdxBit_E20_0 |
+               ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E2;
+    }
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4648,10 +4674,12 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = tlbbits_for_regime(env, ARMMMUIdx_E2, pageaddr);
+    bool secure = arm_is_secure_below_el3(env);
+    int mask = secure ? ARMMMUIdxBit_SE2 : ARMMMUIdxBit_E2;
+    int bits = tlbbits_for_regime(env, secure ? ARMMMUIdx_E2 : ARMMMUIdx_SE2,
+                                  pageaddr);
 
-    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                  ARMMMUIdxBit_E2, bits);
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -9957,7 +9985,8 @@ uint64_t arm_sctlr(CPUARMState *env, int el)
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
     if (el == 0) {
         ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
-        el = (mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1);
+        el = (mmu_idx == ARMMMUIdx_E20_0 || mmu_idx == ARMMMUIdx_SE20_0)
+             ? 2 : 1;
     }
     return env->cp15.sctlr_el[el];
 }
@@ -10086,6 +10115,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_SE20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
@@ -12663,6 +12693,7 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_SE10_0:
+    case ARMMMUIdx_SE20_0:
         return 0;
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
@@ -12672,6 +12703,9 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_SE2:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
@@ -12689,6 +12723,9 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 
 ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
 {
+    ARMMMUIdx idx;
+    uint64_t hcr;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
@@ -12696,40 +12733,43 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        if (arm_is_secure_below_el3(env)) {
-            return ARMMMUIdx_SE10_0;
-        }
-        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
-            && arm_el_is_aa64(env, 2)) {
-            return ARMMMUIdx_E20_0;
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            idx = ARMMMUIdx_E20_0;
+        } else {
+            idx = ARMMMUIdx_E10_0;
         }
-        return ARMMMUIdx_E10_0;
+        break;
     case 1:
-        if (arm_is_secure_below_el3(env)) {
-            if (env->pstate & PSTATE_PAN) {
-                return ARMMMUIdx_SE10_1_PAN;
-            }
-            return ARMMMUIdx_SE10_1;
-        }
         if (env->pstate & PSTATE_PAN) {
-            return ARMMMUIdx_E10_1_PAN;
+            idx = ARMMMUIdx_E10_1_PAN;
+        } else {
+            idx = ARMMMUIdx_E10_1;
         }
-        return ARMMMUIdx_E10_1;
+        break;
     case 2:
-        /* TODO: ARMv8.4-SecEL2 */
         /* Note that TGE does not apply at EL2.  */
-        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+        if (arm_hcr_el2_eff(env) & HCR_E2H) {
             if (env->pstate & PSTATE_PAN) {
-                return ARMMMUIdx_E20_2_PAN;
+                idx = ARMMMUIdx_E20_2_PAN;
+            } else {
+                idx = ARMMMUIdx_E20_2;
             }
-            return ARMMMUIdx_E20_2;
+        } else {
+            idx = ARMMMUIdx_E2;
         }
-        return ARMMMUIdx_E2;
+        break;
     case 3:
         return ARMMMUIdx_SE3;
     default:
         g_assert_not_reached();
     }
+
+    if (arm_is_secure_below_el3(env)) {
+        idx &= ~ARM_MMU_IDX_A_NS;
+    }
+
+    return idx;
 }
 
 ARMMMUIdx arm_mmu_idx(CPUARMState *env)
@@ -12894,7 +12934,8 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             break;
         case ARMMMUIdx_E20_2:
         case ARMMMUIdx_E20_2_PAN:
-            /* TODO: ARMv8.4-SecEL2 */
+        case ARMMMUIdx_SE20_2:
+        case ARMMMUIdx_SE20_2_PAN:
             /*
              * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
              * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4e4798574b..ec6d6dd733 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -860,6 +860,9 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
     case ARMMMUIdx_SE10_1_PAN:
+    case ARMMMUIdx_SE20_0:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
         return true;
     default:
         return false;
@@ -890,6 +893,10 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
     case ARMMMUIdx_SE10_1_PAN:
+    case ARMMMUIdx_SE20_0:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
+    case ARMMMUIdx_SE2:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
@@ -907,6 +914,7 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_SE10_1_PAN:
+    case ARMMMUIdx_SE20_2_PAN:
         return true;
     default:
         return false;
@@ -917,10 +925,14 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_SE20_0:
+    case ARMMMUIdx_SE20_2:
+    case ARMMMUIdx_SE20_2_PAN:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_SE2:
     case ARMMMUIdx_E2:
         return 2;
     case ARMMMUIdx_SE3:
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 072754fa24..ca820e8ecd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -118,6 +118,10 @@ static int get_a64_user_mem_index(DisasContext *s)
         case ARMMMUIdx_SE10_1_PAN:
             useridx = ARMMMUIdx_SE10_0;
             break;
+        case ARMMMUIdx_SE20_2:
+        case ARMMMUIdx_SE20_2_PAN:
+            useridx = ARMMMUIdx_SE20_0;
+            break;
         default:
             g_assert_not_reached();
         }
-- 
2.29.2


