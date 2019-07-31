Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE477C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13C22171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFowufDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C22171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvVU-0000Wl-Ua
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMu-0004y6-PQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMt-0003Zm-AS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMt-0003Z2-3L
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id y15so32523189pfn.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w216qTj/BYqjTL2Y/6Uaoyzbe1vK0P5jhQZ1rUoxx+c=;
 b=bFowufDLex3H542SkfQ/bQfosy6tn/Ojv7bEXbY1EhtXRJAI0Yag/bDa1cTuPTKsUq
 LD7aOQuSu/jBfGclXdekQzO7eqIfz1wPJ91ienNMn66WTSe4irTJct2M5WXU797+Qo6Y
 i1Y8hhktqRE56EVYsqVrkmLd+BnsSWbHGqilQRWkOL9+egErfjUpPo+kOPtZM9eTGj5J
 heqdcvAU48DMFyWeHjeFHCXRd+OOBfICYus7b2ZpSoIvq8UZ20CTqxXYHZpwxY9uNEVG
 QwDzM3ZbPJxF7iL4oA6wXOtyzf7j4Fjb4qUNd+nf0dXD8onxc0rP9hLXzbQnEUSLp+/m
 +ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w216qTj/BYqjTL2Y/6Uaoyzbe1vK0P5jhQZ1rUoxx+c=;
 b=E+3wKyfh17oFW8DNREcf5M94pLri1XwU3fMp5lZ/fmHdN638cwnRZGKmZZUULNZ9Z2
 PqQcSZXX7vpdiNLYT8PQCwM7URoxmPdQKgBUZ/uMEVgkAwsRz0IgoR5y4PTlAyzSt21K
 E5lbSNx1Gkq223O4hxa3o0LWTa3k/g425fw5kfVBxsl1BSwP0i2cAjdvFNHLpLhGSxnA
 3gpzzKzm7LVYHc/7b8CNAAjWzBSA6u912y2Lfu0xRw2MFYo2sL0rSxzwUArQQnav4JGg
 xxRqqjp8JQeB6qrUQGf/v0xtPe1gmgWsyTiyb30ek56hpTVo0C1iF90HbvoREsLhNNAq
 X6Yg==
X-Gm-Message-State: APjAAAXjRVbXOS1XLb7Mba72efWhmHgIs7thzAWOU+L78odsezaxTRaE
 NSundOC9wSijkQv+CaLpGuA6xETWUf4=
X-Google-Smtp-Source: APXvYqxOKj1em8qaxP4nENdgwpqNQLtSy2kyj09wLKnKozdmiiBMFB86q6HXPLNEXDoLR1HWjB0siw==
X-Received: by 2002:a17:90a:d343:: with SMTP id
 i3mr4902091pjx.15.1564605517824; 
 Wed, 31 Jul 2019 13:38:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:59 -0700
Message-Id: <20190731203813.30765-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 18/32] target/arm: Rename ARMMMUIdx_S1SE* to
 ARMMMUIdx_SE*
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
The Secure regimes all have a single stage translation;
there is no point in pointing out that the idx is for stage1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 ++++----
 target/arm/internals.h     |  4 ++--
 target/arm/translate.h     |  2 +-
 target/arm/helper.c        | 30 +++++++++++++++---------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ade558f63c..c7ce8a4da5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2854,8 +2854,8 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE0 = 4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
@@ -2880,8 +2880,8 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_EL10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
-    ARMMMUIdxBit_S1SE0 = 1 << 4,
-    ARMMMUIdxBit_S1SE1 = 1 << 5,
+    ARMMMUIdxBit_SE0 = 1 << 4,
+    ARMMMUIdxBit_SE1 = 1 << 5,
     ARMMMUIdxBit_Stage2 = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index cd9b1acb20..c505cae30c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -820,8 +820,8 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_MUser:
         return false;
     case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_SE0:
+    case ARMMMUIdx_SE1:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e2056..715fa08e3b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -122,7 +122,7 @@ static inline int default_exception_el(DisasContext *s)
      * exceptions can only be routed to ELs above 1, so we target the higher of
      * 1 or the current EL.
      */
-    return (s->mmu_idx == ARMMMUIdx_S1SE0 && s->secure_routed_to_el3)
+    return (s->mmu_idx == ARMMMUIdx_SE0 && s->secure_routed_to_el3)
             ? 3 : MAX(1, s->current_el);
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4c0c314c1a..e0d4f33026 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -566,7 +566,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
         switch (ri->secure) {
         case ARM_CP_SECSTATE_S:
-            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            idxmask = ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
             break;
         case ARM_CP_SECSTATE_NS:
             idxmask = ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
@@ -3122,7 +3122,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_Stage1_E1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
+            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
             break;
         default:
             g_assert_not_reached();
@@ -3132,13 +3132,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1SE0;
+            mmu_idx = ARMMMUIdx_SE0;
             break;
         case 2:
             mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
+            mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3192,7 +3192,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
+            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_S1E2;
@@ -3205,13 +3205,13 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
+        mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
+        mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_EL10_0;
+        mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3424,7 +3424,7 @@ static void update_lpae_el1_asid(CPUARMState *env, int secure)
         ttcr = env->cp15.tcr_el[3].raw_tcr;
         /* Note that cp15.ttbr0_s == cp15.ttbr0_el[3], so S1E3 is affected.  */
         /* ??? Secure EL3 really using the ASID field?  Doesn't make sense.  */
-        idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 | ARMMMUIdxBit_S1E3;
+        idxmask = ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0 | ARMMMUIdxBit_S1E3;
         break;
     case ARM_CP_SECSTATE_NS:
         ttbr0 = env->cp15.ttbr0_ns;
@@ -3899,7 +3899,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 static int vae1_tlbmask(CPUARMState *env)
 {
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
@@ -3935,7 +3935,7 @@ static int vmalle1_tlbmask(CPUARMState *env)
      * stage 1 translations.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
     } else {
@@ -8695,9 +8695,9 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
         return 2;
     case ARMMMUIdx_S1E3:
         return 3;
-    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_SE0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_SE1:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_MPrivNegPri:
@@ -8836,7 +8836,7 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_SE0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
@@ -11279,7 +11279,7 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
 
     el = arm_current_el(env);
     if (el < 2 && arm_is_secure_below_el3(env)) {
-        return ARMMMUIdx_S1SE0 + el;
+        return ARMMMUIdx_SE0 + el;
     } else {
         return ARMMMUIdx_EL10_0 + el;
     }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 73801c5df7..dbe2189e51 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -116,8 +116,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     case ARMMMUIdx_EL10_1:
         useridx = ARMMMUIdx_EL10_0;
         break;
-    case ARMMMUIdx_S1SE1:
-        useridx = ARMMMUIdx_S1SE0;
+    case ARMMMUIdx_SE1:
+        useridx = ARMMMUIdx_SE0;
         break;
     case ARMMMUIdx_Stage2:
         g_assert_not_reached();
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 995010834f..1fc2bf8a52 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -157,9 +157,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_EL10_1:
         return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
     case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
+    case ARMMMUIdx_SE0:
+    case ARMMMUIdx_SE1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_SE0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
         return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
-- 
2.17.1


