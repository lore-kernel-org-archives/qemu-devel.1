Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D0C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017E3214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2KklF31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017E3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58403 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04yn-0003qJ-4H
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hx-0000at-Cy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hw-00032n-05
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hv-00031o-P3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id s10so2805086wmh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=G+MxqxWR/Edh/Sxqd1wEWTpixKklZzQmoKRQBEOIBYk=;
 b=J2KklF31sqninIocxcIX2ukeetlAe+831diKMFd35dcBiu5QRmpa1aXCeW/CdYrV+J
 A3Xukhro+CReGXkyrH3QKnuMriCNxzDmoUZ7ubEShfYjCBGr+fFeqFTx3JWnvtVL6QRj
 aAiisTCxgy3Zo62SLvul60H650s/o5aKWwj/hZO6tKo4P0A7ViODYvJfSF774/13L/yE
 3b93usd8I+Q8xZcyS4MCHD2vb9b/ONrglSWNyEhp7bGzrOoXG6aYMyNc0bkIgyCgh2GN
 wGL+avwjxivD5sJ57myjK9zx8rC5LSr7dPfRimPSzLwj7VA7zthjKDAcxB3Kypbdj3rj
 mymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G+MxqxWR/Edh/Sxqd1wEWTpixKklZzQmoKRQBEOIBYk=;
 b=XNYmdgjJ0XITtyim1ciV+4Pu4hv0SB7hZnR8lPVhsxJTiI9mEDaSmNANNSiLIY0iaM
 5KebxLyuJhTvKhft7QbRNlPv4pPlGjXgW8KRAQwwYImSAdHgnsQNpW4MqfzD0huXECBD
 pJTnVU1NZKvQ0WDOSHSobxH6F7CHNH5R4x3ddwcnswDUm/xbmj7/5lKDGILEB1C+34mJ
 7GDMWNVyRQbYld+pCP+AmrNnQGW0oPnQAqqX0obXGsnKLAl3TkDkftjmjlD2ua8bNilb
 tiWwtAwj5pqHh7F2sf3Yl1nElan+NOH999fGYso6Fo6m5hO8RdyRcxuuEUAxNv/bl1po
 tF2Q==
X-Gm-Message-State: APjAAAVgL8d+l6rqLbWcuW6RUVtou1YKKR4I10bIwEAiIip6shQyL2Af
 dS7tMMwTNKIzcChIzvf4nE7/Q55qaK8=
X-Google-Smtp-Source: APXvYqznKFnDYoYxicAnQlvQ9aaaRNPSb/aj9AoHU6e+jQPfzPTvLkAfKRuwY/SxEpC3fhnLzUQ9qQ==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr4931608wml.83.1581086050519; 
 Fri, 07 Feb 2020 06:34:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/48] target/arm: Update arm_sctlr for VHE
Date: Fri,  7 Feb 2020 14:33:18 +0000
Message-Id: <20200207143343.30322-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use the correct sctlr for EL2&0 regime.  Due to header ordering,
and where arm_mmu_idx_el is declared, we need to move the function
out of line.  Use the function in many more places in order to
select the correct control.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          | 10 +---------
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 20 +++++++++++++++-----
 target/arm/pauth_helper.c |  9 +--------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3fc0e6e7465..68e11f0eda3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3141,15 +3141,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
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
index 36aa6badfd9..bf45f8a785e 100644
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
index 9f8d7ca1f36..e4f368d96b6 100644
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
@@ -8738,14 +8738,24 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
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
@@ -11484,7 +11494,7 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
     }
 
-    sctlr = arm_sctlr(env, el);
+    sctlr = regime_sctlr(env, stage1);
 
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 0a5f41e10c5..e0c401c4a9e 100644
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


