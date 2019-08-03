Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7FC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2F82087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrWV5HYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2F82087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzAl-0002TX-3X
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4s-0006KG-2u
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4q-0007G5-4N
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4o-0007E5-0l
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so34862567plr.11
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L2jEAM4PPhyK6Ibom5dDULaexJ8i3bjGCqHj/DqEM+k=;
 b=DrWV5HYmYrILTnszRc7SWWXnMDSCK9TjQWMUqtZcIS3qnAy1MVBqu56h0FMD9ua6ip
 w064mHBVtFFeUl47kLOzXm2YlF9HMrPgv0kCGvYrh9phW/wkDtcIasoeYQrrbSShFsp6
 tAaVAfqgwdTAobxCLKfRXbK2i79u8JbvfX7I/2io3OOaH0lAbneJawgy9J3OAQhp81oN
 3pqSCpwKanee3JKDI48RDv4d4sTyBMnBSnyNVY73qlTh2u5PjTs6bnF6RTReIFFS6Npe
 3ZkUK3aqendnGS0MhL+rif1+lhUmfQxg3yFCu3YQC/rmIgTkIzNF9iMVSZxK+dWyBpZs
 kzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L2jEAM4PPhyK6Ibom5dDULaexJ8i3bjGCqHj/DqEM+k=;
 b=kQrkuEyKSRfbgK8EJhGsdRrkuFLIZBXGzb+gMmuxYZXK8mClfa+w17JFA8O0wy+HC/
 xF+Ed5ntOh3+E07KtMIgM25zC2TEfWmbi77DG6vgFOC7J3aRk82tfP7GB+noecbzNEfN
 M4K7NTzgM9tZLAeUNGfk5U7x+wW12aMeAo9ZoVDKG0RuyHu2G3JYQA12GTRCnvic30l4
 /5xoOoXAOqE36HcfNgYeEq3vKSidlEJwM2adYJKCNnbvwkI60Iun8oOypd86uPpwhZI5
 VwRk6OCW4oAl7N6lDGhp55HilfXD1LbHBXqDp6Xh/fSBd5PP36BpxNUIhIsNe+6yOFoj
 lYvg==
X-Gm-Message-State: APjAAAVLW3jtn3u1ltEvilyXIQQ8w+TT1FVEsTK3WO1XG3jqDBNnNyMZ
 l0zf9P2AVhjS/frtTtiEzd28URV8Uu0=
X-Google-Smtp-Source: APXvYqzvYA6FrLwsZMPy7aj9b1OnPdOueAzAXcYNQeKJWnaWv175rq7DPgMY+DfpEH7gtEjabWSFfA==
X-Received: by 2002:a17:902:9b81:: with SMTP id
 y1mr142720478plp.194.1564858100819; 
 Sat, 03 Aug 2019 11:48:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:41 -0700
Message-Id: <20190803184800.8221-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 15/34] target/arm: Rename ARMMMUIdx*_S12NSE*
 to ARMMMUIdx*_E10_*
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a reorganization to the set of mmu_idx.
This emphasizes that they apply to the EL1&0 regime.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 +++----
 target/arm/internals.h     |  4 ++--
 target/arm/helper.c        | 44 +++++++++++++++++++-------------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0f10b60eb..8a3f61bc2c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2850,8 +2850,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
 
 typedef enum ARMMMUIdx {
-    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
@@ -2876,8 +2876,8 @@ typedef enum ARMMMUIdx {
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_S12NSE0 = 1 << 0,
-    ARMMMUIdxBit_S12NSE1 = 1 << 1,
+    ARMMMUIdxBit_EL10_0 = 1 << 0,
+    ARMMMUIdxBit_EL10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..fafefdc59e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -808,8 +808,8 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 185f5e4aea..e391654638 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -569,7 +569,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
             break;
         case ARM_CP_SECSTATE_NS:
-            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            idxmask = ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
             break;
         default:
             g_assert_not_reached();
@@ -682,8 +682,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
-                        ARMMMUIdxBit_S12NSE1 |
-                        ARMMMUIdxBit_S12NSE0 |
+                        ARMMMUIdxBit_EL10_1 |
+                        ARMMMUIdxBit_EL10_0 |
                         ARMMMUIdxBit_S2NS);
 }
 
@@ -693,8 +693,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                        ARMMMUIdxBit_S12NSE1 |
-                                        ARMMMUIdxBit_S12NSE0 |
+                                        ARMMMUIdxBit_EL10_1 |
+                                        ARMMMUIdxBit_EL10_0 |
                                         ARMMMUIdxBit_S2NS);
 }
 
@@ -3047,7 +3047,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+            if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3146,11 +3146,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_S12NSE1;
+        mmu_idx = ARMMMUIdx_EL10_1;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_S12NSE0;
+        mmu_idx = ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3208,10 +3208,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3430,7 +3430,7 @@ static void update_lpae_el1_asid(CPUARMState *env, int secure)
         ttbr0 = env->cp15.ttbr0_ns;
         ttbr1 = env->cp15.ttbr1_ns;
         ttcr = env->cp15.tcr_el[1].raw_tcr;
-        idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        idxmask = ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3540,10 +3540,10 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /*
      * A change in VMID to the stage2 page table (S2NS) invalidates
-     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
+     * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
      */
     tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
-                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
+                            ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0);
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
@@ -3901,7 +3901,7 @@ static int vae1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -3937,9 +3937,9 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_S2NS;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -8801,8 +8801,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
  */
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
+        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_EL10_0);
     }
     return mmu_idx;
 }
@@ -8845,8 +8845,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
         g_assert_not_reached();
     }
 }
@@ -10750,7 +10750,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11281,7 +11281,7 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
-        return ARMMMUIdx_S12NSE0 + el;
+        return ARMMMUIdx_EL10_0 + el;
     }
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a2..ece749fe03 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -113,8 +113,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     ARMMMUIdx useridx;
 
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        useridx = ARMMMUIdx_S12NSE0;
+    case ARMMMUIdx_EL10_1:
+        useridx = ARMMMUIdx_EL10_0;
         break;
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21..afff595726 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -153,9 +153,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      */
     switch (s->mmu_idx) {
     case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
-- 
2.17.1


