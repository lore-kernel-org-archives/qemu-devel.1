Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E1AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED36320716
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJgpWUgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED36320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxIA-0004FJ-4h
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCU-0004C7-SM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCT-0008Er-BS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:50 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCQ-00083Q-0R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:46 -0500
Received: by mail-pg1-x543.google.com with SMTP id s64so634171pgb.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E+y6HWdl2U001U/VZ427NDJPsIEPggJ6/fdI3PWplGA=;
 b=sJgpWUgvpp/KcKKxFsKeaY43AyVidANOjPjB1mRlXU94IPvi04opifotzimkeXciRM
 wKfjtuqmE2rEnjK5g05pWcx7Fq+EJiS8aUj6p9X1FxW6moedQWIDqeRiZJPXjjpJlPt5
 XgVp/z1OSlWhAOrBjjdop0f8kmduLpBGCr65aX88Cw48ZE1d4YW378WwklsU0cfqAJhc
 EyBCCI0f5z4lYQre0jGAk28uCCGxLCvUWiQ/Gsw2XFitxREboCgrU9Di2L69g5/HPPkF
 BAgr96n9r8oXo172DR864auaz8ztGNifys/Au3sRiX2gpUkzpF9hUakfgrWhmgPHtmyD
 V4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E+y6HWdl2U001U/VZ427NDJPsIEPggJ6/fdI3PWplGA=;
 b=LE0hLeSwuq3BDlFDPM7r8FvMZDxgZKUZ+VXIU8SXLcrndOLQg28xEheblIBrKplOmS
 yz76PI2OW4zAvC/qfYI0gSxZGBv10bIQHdWiBEXH1F6FlKeE7v53hWf9PjKNazTLes52
 IVNKIi5pAgZp7VQyOBDyD9MiOPhrQ1+NKetV0q/q8xb33n/WB+GM1CbxMnddvuakX2V+
 9Yx3BMmBwRfOnAYtASAM5cYPn1Ja3jTQB0fu+zQQ/jyfOHM3vag9SzHMjPRuc9e/KeOH
 agk94c4Mu54gzjUrxUZADjNCjLfxq0ju0FuODSauBogNpOnyVo+Sw/WojZiIHuI1PaqI
 pCtA==
X-Gm-Message-State: APjAAAUiy1YHU8sYLAUt0cfvywgtDWWHcgEr2/7MheMLs/VhRvO1hH8v
 23yE1gAYstXf6WyIiQ5q+umASHX8vlY=
X-Google-Smtp-Source: APXvYqw7h9dVHhQ4KYw7sy4cXHMOL5o4p8VlesJvSl0oszaE3wyBDcMfbqdaAixGG7a7g/ppMm1Ueg==
X-Received: by 2002:a63:2808:: with SMTP id o8mr1693070pgo.39.1580342203716;
 Wed, 29 Jan 2020 15:56:43 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 22/41] target/arm: Update arm_sctlr for VHE
Date: Wed, 29 Jan 2020 15:55:55 -0800
Message-Id: <20200129235614.29829-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Use the correct sctlr for EL2&0 regime.  Due to header ordering,
and where arm_mmu_idx_el is declared, we need to move the function
out of line.  Use the function in many more places in order to
select the correct control.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use arm_mmu_idx() to avoid incorrectly replicating the el2&0
    condition therein.  Drop the change to cpu_get_dump_info, as
    that needs a more significant rethink of hard-coded oddness.
v4: Use arm_mmu_idx_el().
---
 target/arm/cpu.h          | 10 +---------
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 20 +++++++++++++++-----
 target/arm/pauth_helper.c |  9 +--------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1312046b45..703071bada 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3134,15 +3134,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
-static inline uint64_t arm_sctlr(CPUARMState *env, int el)
-{
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        return env->cp15.sctlr_el[1];
-    } else {
-        return env->cp15.sctlr_el[el];
-    }
-}
+uint64_t arm_sctlr(CPUARMState *env, int el);
 
 static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
                                                   bool sctlr_b)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 36aa6badfd..bf45f8a785 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -70,7 +70,7 @@ static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
     /* DAIF update to PSTATE. This is OK from EL0 only if UMA is set.  */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         raise_exception_ra(env, EXCP_UDEF,
                            syn_aa64_sysregtrap(0, extract32(op, 0, 3),
                                                extract32(op, 3, 3), 4,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 128a400011..37ea382050 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3913,7 +3913,7 @@ static void aa64_fpsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -3932,7 +3932,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
      * SCTLR_EL1.UCI is set.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCI)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -8737,14 +8737,24 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+uint64_t arm_sctlr(CPUARMState *env, int el)
+{
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    if (el == 0) {
+        ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
+        el = (mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1);
+    }
+    return env->cp15.sctlr_el[el];
+}
 
 /* Return the SCTLR value which controls this address translation regime */
-static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
 }
 
+#ifndef CONFIG_USER_ONLY
+
 /* Return true if the specified stage of address translation is disabled */
 static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
@@ -11483,7 +11493,7 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
     }
 
-    sctlr = arm_sctlr(env, el);
+    sctlr = regime_sctlr(env, stage1);
 
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 0a5f41e10c..e0c401c4a9 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -386,14 +386,7 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
 
 static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
 {
-    uint32_t sctlr;
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        sctlr = env->cp15.sctlr_el[1];
-    } else {
-        sctlr = env->cp15.sctlr_el[el];
-    }
-    return (sctlr & bit) != 0;
+    return (arm_sctlr(env, el) & bit) != 0;
 }
 
 uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
-- 
2.20.1


