Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8FD20716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ms/Y86VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8FD20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxHe-0003bZ-FJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCE-0003hZ-7z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC9-0007HV-1W
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxC8-0007FI-Om
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id x185so495894pfc.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PzNr3SXTC/1TPOqcFpapxuKJox0FUpVht0m7gNG8TTE=;
 b=ms/Y86VKID3cp5mOKjyoFo2ztX+Nu0je4e9vklDbVZH2Bc0aRvvvQifd5TW2cr/xTz
 OJS55N3XxZrwxbS9EGQHit7wDSN3V/ISaOfjSd9IqbKpY+k/LdpkMHdGoakLnDUBq722
 qCZl9+ZthrH6B9QLNxX9PyY4efEnRmBmq3aGYVQZ00KlBlunET4SNy3cOHgBwOFqe3C5
 +YshfTtFGOgnCoiR3CFnDNlvYVcfniNKtDUSc122Lk4zRAjtjc3RfosJGwR1otK3jEgS
 8skdJVqezvobcTkkgG0EQrpjyY3IT689J0fh+38+7S7jpdgt09A4yCIAD+9OAb9xyhEt
 b8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzNr3SXTC/1TPOqcFpapxuKJox0FUpVht0m7gNG8TTE=;
 b=f2w+6LIM7TK24QX3s7XR+OlEzUA/0hvBCDfGr56ycklpb/T37rfJwgMEBmIhGN69G2
 w4x+rvGbIxHXi9nqftsmRnZh0dsm3y88LqmU4XSIUj+5M/IgPfVRrG1hp5sLXOjCAMef
 OzSwP+XzbsP045SO9biIGmMburO2IQmxzWvWNJeMFWS5SXusilalzeXI6qjKj4qDi8o3
 tLUEPYHoWzQKAGBUa6PN/GKXr98C6QZVOlrb6i1l+shtf0SeLuEkl6RQd0CZa4gELJXW
 8TT+Ig8w8B7ZGQ8TRzzTQe7WzbuixCyNMM/IWPHX0a0ARwsfbcJ+DBzFDjJgluSEfQKP
 llow==
X-Gm-Message-State: APjAAAXhQhVSUblyM6WbfQd2U0+ZYFh/XGT896SXpctGkHx5vSU3cWPc
 Qzb0f/VKBiQUzuB12pCSnQEsyzrwjeo=
X-Google-Smtp-Source: APXvYqzdbhrhQ4u/eNFsUCG5LeXFbYc5lNuZ5F/WNc0oFXVhmCmmgTNWQbUqJKnx7gB4HQYyvz23pw==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr1825973pgi.64.1580342187367; 
 Wed, 29 Jan 2020 15:56:27 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/41] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
Date: Wed, 29 Jan 2020 15:55:42 -0800
Message-Id: <20200129235614.29829-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a reorganization to the set of mmu_idx.
This emphasizes that they apply to the EL1&0 regime.

The ultimate goal is

 -- Non-secure regimes:
    ARMMMUIdx_E10_0,
    ARMMMUIdx_E20_0,
    ARMMMUIdx_E10_1,
    ARMMMUIdx_E2,
    ARMMMUIdx_E20_2,

 -- Secure regimes:
    ARMMMUIdx_SE10_0,
    ARMMMUIdx_SE10_1,
    ARMMMUIdx_SE3,

 -- Helper mmu_idx for non-secure EL1&0 stage1 and stage2
    ARMMMUIdx_Stage2,
    ARMMMUIdx_Stage1_E0,
    ARMMMUIdx_Stage1_E1,

The 'S' prefix is reserved for "Secure".  Unless otherwise specified,
each mmu_idx represents all stages of translation.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 ++++----
 target/arm/internals.h     |  4 ++--
 target/arm/helper.c        | 40 +++++++++++++++++++-------------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 239c9eb783..264030ecd7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2898,8 +2898,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
 
 typedef enum ARMMMUIdx {
-    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_0 = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
@@ -2924,8 +2924,8 @@ typedef enum ARMMMUIdx {
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_S12NSE0 = 1 << 0,
-    ARMMMUIdxBit_S12NSE1 = 1 << 1,
+    ARMMMUIdxBit_E10_0 = 1 << 0,
+    ARMMMUIdxBit_E10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5313dd3d4..d4ea6cfe9d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -808,8 +808,8 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d23d1dd6ef..8c13b9e332 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -670,8 +670,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
-                        ARMMMUIdxBit_S12NSE1 |
-                        ARMMMUIdxBit_S12NSE0 |
+                        ARMMMUIdxBit_E10_1 |
+                        ARMMMUIdxBit_E10_0 |
                         ARMMMUIdxBit_S2NS);
 }
 
@@ -681,8 +681,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                        ARMMMUIdxBit_S12NSE1 |
-                                        ARMMMUIdxBit_S12NSE0 |
+                                        ARMMMUIdxBit_E10_1 |
+                                        ARMMMUIdxBit_E10_0 |
                                         ARMMMUIdxBit_S2NS);
 }
 
@@ -3117,7 +3117,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+            if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3216,11 +3216,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_S12NSE1;
+        mmu_idx = ARMMMUIdx_E10_1;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_S12NSE0;
+        mmu_idx = ARMMMUIdx_E10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3278,10 +3278,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_E10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_E10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3581,8 +3581,8 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
+                            ARMMMUIdxBit_E10_1 |
+                            ARMMMUIdxBit_E10_0 |
                             ARMMMUIdxBit_S2NS);
         raw_write(env, ri, value);
     }
@@ -3943,7 +3943,7 @@ static int vae1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -3979,9 +3979,9 @@ static int alle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_S2NS;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -8816,8 +8816,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
  */
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
+    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_E10_0);
     }
     return mmu_idx;
 }
@@ -8860,8 +8860,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
         g_assert_not_reached();
     }
 }
@@ -10765,7 +10765,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11293,7 +11293,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
-        return ARMMMUIdx_S12NSE0 + el;
+        return ARMMMUIdx_E10_0 + el;
     }
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 96a5be2b37..bee2810728 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -113,8 +113,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     ARMMMUIdx useridx;
 
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        useridx = ARMMMUIdx_S12NSE0;
+    case ARMMMUIdx_E10_1:
+        useridx = ARMMMUIdx_E10_0;
         break;
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2f4aea927f..f90f22ef90 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -153,9 +153,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      */
     switch (s->mmu_idx) {
     case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
-- 
2.20.1


