Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0486AC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4732E20674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4732E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Aq-0008SR-W9
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7sj-0003Pf-RQ; Mon, 09 Nov 2020 09:10:53 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60192
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7sf-0002qN-FD; Mon, 09 Nov 2020 09:10:53 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id D71DC6053E;
 Mon,  9 Nov 2020 15:10:23 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 12/17] target/arm: secure stage 2 translation regime
Date: Mon,  9 Nov 2020 16:10:15 +0200
Message-Id: <20201109141020.27234-12-remi.denis.courmont@huawei.com>
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

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h       | 11 ++++-
 target/arm/helper.c    | 96 ++++++++++++++++++++++++++++++++----------
 target/arm/internals.h | 24 +++++++++++
 3 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7a03869d26..c5535716c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -168,6 +168,11 @@ typedef struct {
     uint32_t base_mask;
 } TCR;
 
+#define VTCR_NSW	(1u << 29)
+#define VTCR_NSA	(1u << 30)
+#define VSTCR_SW	VTCR_NSW
+#define VSTCR_SA	VTCR_NSA
+
 /* Define a maximum sized vector register.
  * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
  * For 64-bit, this is a 2048-bit SVE register.
@@ -2988,6 +2993,9 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_SE0 = 3 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_SE1 = 4 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_SE1_PAN = 5 | ARM_MMU_IDX_NOTLB,
     /*
      * Not allocated a TLB: used only for second stage of an S12 page
      * table walk, or for descriptor loads during first stage of an S1
@@ -2995,7 +3003,8 @@ typedef enum ARMMMUIdx {
      * then various TLB flush insns which currently are no-ops or flush
      * only stage 1 MMU indexes will need to change to flush stage 2.
      */
-    ARMMMUIdx_Stage2     = 3 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage2     = 6 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage2_S   = 7 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90967771b6..aae22847bb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3429,7 +3429,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         uint32_t syn, fsr, fsc;
         bool take_exc = false;
 
-        if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
+        if (fi.s1ptw && current_el == 1
             && arm_mmu_idx_is_stage1_of_2(mmu_idx, NULL)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
@@ -3586,10 +3586,10 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             /* fall through */
         case 1:
             if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
-                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                mmu_idx = (secure ? ARMMMUIdx_Stage1_SE1_PAN
                            : ARMMMUIdx_Stage1_E1_PAN);
             } else {
-                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+                mmu_idx = secure ? ARMMMUIdx_Stage1_SE1 : ARMMMUIdx_Stage1_E1;
             }
             break;
         default:
@@ -3603,10 +3603,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_SE10_0;
             break;
         case 2:
+            g_assert(!secure);  /* ARMv8.4-SecEL2 is 64-bit only */
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_SE10_0 : ARMMMUIdx_Stage1_E0;
+            mmu_idx = secure ? ARMMMUIdx_Stage1_SE0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3671,10 +3672,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
             if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
-                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                mmu_idx = (secure ? ARMMMUIdx_Stage1_SE1_PAN
                            : ARMMMUIdx_Stage1_E1_PAN);
             } else {
-                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+                mmu_idx = secure ? ARMMMUIdx_Stage1_SE1 : ARMMMUIdx_Stage1_E1;
             }
             break;
         case 4: /* AT S1E2R, AT S1E2W */
@@ -3688,7 +3689,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_SE10_0 : ARMMMUIdx_Stage1_E0;
+        mmu_idx = secure ? ARMMMUIdx_Stage1_SE0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
         mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_E10_1;
@@ -10049,7 +10050,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
 
     hcr_el2 = arm_hcr_el2_eff(env);
 
-    if (mmu_idx == ARMMMUIdx_Stage2) {
+    if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
         /* HCR.DC means HCR.VM behaves as 1 */
         return (hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
@@ -10082,6 +10083,9 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
     if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vttbr_el2;
     }
+    if (mmu_idx == ARMMMUIdx_Stage2_S) {
+        return env->cp15.vsttbr_el2;
+    }
     if (ttbrn == 0) {
         return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
     } else {
@@ -10097,6 +10101,12 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_SE10_0:
+        return ARMMMUIdx_Stage1_SE0;
+    case ARMMMUIdx_SE10_1:
+        return ARMMMUIdx_Stage1_SE1;
+    case ARMMMUIdx_SE10_1_PAN:
+        return ARMMMUIdx_Stage1_SE1_PAN;
     case ARMMMUIdx_E10_0:
         return ARMMMUIdx_Stage1_E0;
     case ARMMMUIdx_E10_1:
@@ -10141,6 +10151,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_SE20_0:
     case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_SE0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
     case ARMMMUIdx_MUserNegPri:
@@ -10306,6 +10317,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     int wxn = 0;
 
     assert(mmu_idx != ARMMMUIdx_Stage2);
+    assert(mmu_idx != ARMMMUIdx_Stage2_S);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -10405,7 +10417,21 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         ARMCacheAttrs cacheattrs = {};
         MemTxAttrs txattrs = {};
 
-        assert(!*is_secure); /* TODO: S-EL2 */
+        if (s2_mmu_idx == ARMMMUIdx_Stage2_S) {
+            /* Check if page table walk is to secure or non-secure PA space. */
+            if (*is_secure) {
+                *is_secure = !(env->cp15.vstcr_el2.raw_tcr & VSTCR_SW);
+            } else {
+                *is_secure = !(env->cp15.vtcr_el2.raw_tcr & VTCR_NSW);
+            }
+            if (*is_secure) {
+                txattrs.secure = true;
+            } else {
+                s2_mmu_idx = ARMMMUIdx_Stage2;
+            }
+        } else {
+            assert(!*is_secure);
+        }
 
         ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, s2_mmu_idx, false,
                                  &s2pa, &txattrs, &s2prot, &s2size, fi,
@@ -10870,7 +10896,7 @@ static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
 {
     if (regime_has_2_ranges(mmu_idx)) {
         return extract64(tcr, 37, 2);
-    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+    } else if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
         return 0; /* VTCR_EL2 */
     } else {
         /* Replicate the single TBI bit so we always have 2 bits.  */
@@ -10882,7 +10908,7 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
 {
     if (regime_has_2_ranges(mmu_idx)) {
         return extract64(tcr, 51, 2);
-    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+    } else if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
         return 0; /* VTCR_EL2 */
     } else {
         /* Replicate the single TBID bit so we always have 2 bits.  */
@@ -10912,7 +10938,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        if (mmu_idx == ARMMMUIdx_Stage2) {
+        if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
             /* VTCR_EL2 */
             hpd = false;
         } else {
@@ -10970,6 +10996,8 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     int select, tsz;
     bool epd, hpd;
 
+    assert(mmu_idx != ARMMMUIdx_Stage2_S);
+
     if (mmu_idx == ARMMMUIdx_Stage2) {
         /* VTCR */
         bool sext = extract32(tcr, 4, 1);
@@ -11135,7 +11163,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_Stage2) {
+    if (mmu_idx != ARMMMUIdx_Stage2 && mmu_idx != ARMMMUIdx_Stage2_S) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -11239,7 +11267,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_Stage2) {
+        if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -11269,8 +11297,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
     ap = extract32(attrs, 4, 2);
 
-    if (mmu_idx == ARMMMUIdx_Stage2) {
-        ns = true;
+    if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
+            ns = true;
+        }
         xn = extract32(attrs, 11, 2);
         *prot = get_S2prot(env, ap, xn, s1_is_el0);
     } else {
@@ -11297,7 +11327,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         arm_tlb_bti_gp(txattrs) = true;
     }
 
-    if (mmu_idx == ARMMMUIdx_Stage2) {
+    if (mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S) {
         cacheattrs->attrs = convert_stage2_attrs(env, extract32(attrs, 0, 4));
     } else {
         /* Index into MAIR registers for cache attributes */
@@ -11316,7 +11346,8 @@ do_fault:
     fi->type = fault_type;
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2);
+    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2 ||
+                               mmu_idx == ARMMMUIdx_Stage2_S);
     return true;
 }
 
@@ -12132,7 +12163,10 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
 {
     if (mmu_idx == ARMMMUIdx_E10_0 ||
         mmu_idx == ARMMMUIdx_E10_1 ||
-        mmu_idx == ARMMMUIdx_E10_1_PAN) {
+        mmu_idx == ARMMMUIdx_E10_1_PAN ||
+        mmu_idx == ARMMMUIdx_SE10_0 ||
+        mmu_idx == ARMMMUIdx_SE10_1 ||
+        mmu_idx == ARMMMUIdx_SE10_1_PAN) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -12140,21 +12174,25 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
             hwaddr ipa;
             int s2_prot;
             int ret;
+            ARMMMUIdx s2_mmu_idx;
+            bool is_el0;
             ARMCacheAttrs cacheattrs2 = {};
 
             ret = get_phys_addr(env, address, access_type,
                                 stage_1_mmu_idx(mmu_idx), &ipa, attrs,
                                 prot, page_size, fi, cacheattrs);
 
+            s2_mmu_idx = attrs->secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
+            is_el0 = mmu_idx == ARMMMUIdx_SE10_0 || mmu_idx == ARMMMUIdx_E10_0;
+
             /* If S1 fails or S2 is disabled, return early.  */
-            if (ret || regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
+            if (ret || regime_translation_disabled(env, s2_mmu_idx)) {
                 *phys_ptr = ipa;
                 return ret;
             }
 
             /* S1 is done. Now do S2 translation.  */
-            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_Stage2,
-                                     mmu_idx == ARMMMUIdx_E10_0,
+            ret = get_phys_addr_lpae(env, ipa, access_type, s2_mmu_idx, is_el0,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fi, &cacheattrs2);
             fi->s2addr = ipa;
@@ -12166,6 +12204,18 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                 return ret;
             }
 
+            /* Check if IPA translates to secure or non-secure PA space. */
+            if (arm_is_secure_below_el3(env)) {
+                if (attrs->secure) {
+                    attrs->secure =
+                        !(env->cp15.vstcr_el2.raw_tcr & (VSTCR_SA | VSTCR_SW));
+                } else {
+                    attrs->secure =
+                        !((env->cp15.vtcr_el2.raw_tcr & (VTCR_NSA | VTCR_NSW))
+                        || (env->cp15.vstcr_el2.raw_tcr & VSTCR_SA));
+                }
+            }
+
             /* Combine the S1 and S2 cache attributes. */
             if (arm_hcr_el2_eff(env) & HCR_DC) {
                 /*
@@ -12249,7 +12299,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
          * MMU disabled.  S1 addresses within aa64 translation regimes are
          * still checked for bounds -- see AArch64.TranslateAddressS1Off.
          */
-        if (mmu_idx != ARMMMUIdx_Stage2) {
+        if (mmu_idx != ARMMMUIdx_Stage2 && mmu_idx != ARMMMUIdx_Stage2_S) {
             int r_el = regime_el(env, mmu_idx);
             if (arm_el_is_aa64(env, r_el)) {
                 int pamax = arm_pamax(env_archcpu(env));
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ec6d6dd733..04f71e0601 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -851,6 +851,9 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_Stage1_SE0:
+    case ARMMMUIdx_Stage1_SE1:
+    case ARMMMUIdx_Stage1_SE1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
@@ -896,7 +899,11 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE20_0:
     case ARMMMUIdx_SE20_2:
     case ARMMMUIdx_SE20_2_PAN:
+    case ARMMMUIdx_Stage1_SE0:
+    case ARMMMUIdx_Stage1_SE1:
+    case ARMMMUIdx_Stage1_SE1_PAN:
     case ARMMMUIdx_SE2:
+    case ARMMMUIdx_Stage2_S:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
@@ -911,6 +918,7 @@ static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_Stage1_SE1_PAN:
     case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_SE10_1_PAN:
@@ -932,6 +940,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_Stage2_S:
     case ARMMMUIdx_SE2:
     case ARMMMUIdx_E2:
         return 2;
@@ -944,6 +953,9 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_Stage1_SE0:
+    case ARMMMUIdx_Stage1_SE1:
+    case ARMMMUIdx_Stage1_SE1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
@@ -967,6 +979,12 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
     if (mmu_idx == ARMMMUIdx_Stage2) {
         return &env->cp15.vtcr_el2;
     }
+    if (mmu_idx == ARMMMUIdx_Stage2_S) {
+        /* Note: Secure stage 2 nominally shares fields from VTCR_EL2, but
+         * those are not currently used by QEMU, so just return VSTCR_EL2.
+         */
+        return &env->cp15.vstcr_el2;
+    }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
 }
 
@@ -1176,6 +1194,12 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx s1_mmu_idx,
             *s2_mmu_idx = ARMMMUIdx_Stage2;
         }
         return true;
+    case ARMMMUIdx_Stage1_SE0:
+    case ARMMMUIdx_Stage1_SE1:
+    case ARMMMUIdx_Stage1_SE1_PAN:
+        if (s2_mmu_idx != NULL)
+            *s2_mmu_idx = ARMMMUIdx_Stage2_S;
+        return true;
     default:
         return false;
     }
-- 
2.29.2


