Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05381C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF68320684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cv1FX3uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF68320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby7A-0005io-Ls
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwt-0003Bu-1j
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwq-00089r-Tq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:58 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwo-00087P-RD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:55 -0500
Received: by mail-pg1-x543.google.com with SMTP id k25so866647pgt.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tLWF7lZ5KzCCuuF9ZSK7qlYg+vYwOMe91hFIJnibsig=;
 b=cv1FX3uMvtISefHU/db2SHYp5V2kJNZD/M/5R6xfRx1rUKiL7VKZJWfAR4OqABkEE2
 T9WkT5hn+iVjcqyiONq3BrZmJ9IiRqBLsDMnE2WT925386RB7b9y39opJS9i7lDnoa5o
 yJpJ3lqloKLfxAgc5BvUWgn1Bf2Bvmh13FfLyde+PHhbhjS9K3AoEFPfKtCyu24ndLyS
 OxCrdeg3bNKb+Yf4rGwV34tQnYxNxwj8EbZWSpfhFrWjzWTTp1RNq8bRz/U7ITlqokD1
 Bp/DsxPvqMSRmhOJwK09Q6Ksd3uCpJHBGJ157XbwisV8e1f88xwfO5zt/WoKvjwxbzmQ
 pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tLWF7lZ5KzCCuuF9ZSK7qlYg+vYwOMe91hFIJnibsig=;
 b=JriqLp6+Z4eLlkNlUf61xofLZt2bF/V8qJ91PtbKnD4XdPIltcbJhAI1TVu+PkR2kR
 bQkbFgsVZT4g9G0yWrFg2ihewlX+0vKZe/C7wsmcDZNxZBzRwm15dea1rHpsTdWxtjLV
 SnSQAMnDlxtvVBOJ+3B51YcbrilHaYruQA75xtBOC/gI48xXzN8WJQ4H3IFzvs5dC8mh
 YBfsfAdtaXk+n2usKgNon+yYqKU0LdNEE60amiXSvB+3cLbGcU6mNCCTK1e7AZCaQ6NS
 SxasYi8SEBxgSKlgvfUkpKSodJHnz+J7/RJFh+wlFycaJBqgaKMDyvyMIVdD+2jJLJck
 T1AQ==
X-Gm-Message-State: APjAAAVESpbWywANusHvbU/JFVQS+YOzeY1OwB8ENM5LY011Mf/kReEG
 16NEvzEThIo+kP7NfjnaQTWEXQeZ940=
X-Google-Smtp-Source: APXvYqzIEUUPt6YRBzWZg1w/aImc1i7a/bsVIbifT6qIAVVOsO37jhM62WzUJn6KYRY7WadyRbxb1A==
X-Received: by 2002:a63:483:: with SMTP id 125mr2782929pge.217.1575340192352; 
 Mon, 02 Dec 2019 18:29:52 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/40] target/arm: Rename ARMMMUIdx_S1NSE* to
 ARMMMUIdx_Stage1_E*
Date: Mon,  2 Dec 2019 18:29:07 -0800
Message-Id: <20191203022937.1474-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
The EL1&0 regime is the only one that uses 2-stage translation.
Spelling out Stage avoids confusion with Secure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  6 +++---
 target/arm/helper.c    | 27 ++++++++++++++-------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fdb868f2e9..0714c52176 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2882,8 +2882,8 @@ typedef enum ARMMMUIdx {
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-    ARMMMUIdx_S1NSE0 = 0 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_S1NSE1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
 } ARMMMUIdx;
 
 /* Bit macros for the core-mmu-index values for each index,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ca8be78bbf..3fd1518f3b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -810,8 +810,8 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_S1E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
@@ -975,7 +975,7 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env);
 #ifdef CONFIG_USER_ONLY
 static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 {
-    return ARMMMUIdx_S1NSE0;
+    return ARMMMUIdx_Stage1_E0;
 }
 #else
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97677f8482..a34accec20 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2992,7 +2992,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_S1NSE1 || mmu_idx == ARMMMUIdx_S1NSE0)) {
+            && (mmu_idx == ARMMMUIdx_Stage1_E1
+                || mmu_idx == ARMMMUIdx_Stage1_E0)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -3140,10 +3141,10 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_S1E3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE1;
+            mmu_idx = ARMMMUIdx_Stage1_E1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
             break;
         default:
             g_assert_not_reached();
@@ -3156,10 +3157,10 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_S1SE0;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE0;
+            mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3213,7 +3214,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_S1E2;
@@ -3226,7 +3227,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
         mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
@@ -8571,8 +8572,8 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1SE0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
     case ARMMMUIdx_S1SE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -8630,7 +8631,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
     }
 
     if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
+        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -8675,7 +8676,7 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
     if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_EL10_0);
+        mmu_idx += (ARMMMUIdx_Stage1_E0 - ARMMMUIdx_EL10_0);
     }
     return mmu_idx;
 }
@@ -8710,7 +8711,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
     case ARMMMUIdx_MUserNegPri:
@@ -8941,7 +8942,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
+    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.17.1


