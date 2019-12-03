Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D211AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4BF20684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8CKV3jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4BF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyD8-0005TF-2q
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxC-0003Is-Tz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxA-0008Ql-Se
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:18 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008Hw-HD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id k13so875864pgh.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AIS/DQiMYw3p+zAAk8FWlKdfeq2a/nHlVUG1M8AUF24=;
 b=n8CKV3jQVf6vF2bbZS7GnPdy0QfEO83Z2HdqtkOrzZoDdCe9HqWG1zRJfp3D4mixJ9
 kvkVxWQTOXi5nVCesT2AzZlUXZPVw23gDmXurc4jehYbW4ERkgN9DuSM9SUbz7M8kk8O
 hcafwkZMiQH7epvgW3KzM3elPJqA52v2PZffxQhukP/5oJbdgj3qNB7N40ndGF/c+kV6
 MRAH5a21RRKcELDpolvV64Gjn+nQmFpkKucaZJysA9FgXwM34eYXKQmuNN7aslfzcL7m
 SJQe/wxWvZA+8dc1d+famOjE9NjFxJTo8sScxwugWTl5SJquFA3niVl2iIDPMUhPXYl1
 SdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AIS/DQiMYw3p+zAAk8FWlKdfeq2a/nHlVUG1M8AUF24=;
 b=uEHzVvpxBRAyHhSe9PLLnh2XW1U09ncWH1g9BRYYSsd3d1kMKIIjQAWgfJdJrbpGAT
 RAUZMJvc4LGOBRIof5KuS+GLKcQfOtB+XJEno1uHwru7BVV4taFvIYSKq6XZTm0sJj+Y
 nqTGtK1NTOSRGdZ6Hh89sdiQBKF6SxvtFVDu1ha49X+Hc+VGy8ZCE95cEgiTAcrAELVx
 W+Hw/wn5Ve1Y+feqJtOqJiBsWnrm539i+WMamfA9q96x/oLEqc1AAp7R00xkBT248KSg
 /z9MrMfghazeyRiPzIVOiuBazA7ftj3bez84ZJj+bKgZinNxlCOPrUADpgkt5iAoSW6E
 5f/Q==
X-Gm-Message-State: APjAAAX11+rvA/ImUl9hoNbdo+kN3rzp2wobWQdV4AmvLPpbFxyyxlSP
 2Fkdyt80+Ti7UuEx4AHW6dBZK1AiD6w=
X-Google-Smtp-Source: APXvYqwn/SJcN3t5svXfg0GPSAVBBtn8XrHwqjRD4U8m5ozXUIbO+T2h9VL0dv+UXhCTTSRn+pfBSA==
X-Received: by 2002:a63:f658:: with SMTP id u24mr2704651pgj.129.1575340206684; 
 Mon, 02 Dec 2019 18:30:06 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/40] target/arm: Update arm_sctlr for VHE
Date: Mon,  2 Dec 2019 18:29:18 -0800
Message-Id: <20191203022937.1474-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
 target/arm/cpu.h          | 10 +---------
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 20 +++++++++++++++-----
 target/arm/pauth_helper.c |  9 +--------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bf8eb57e3a..8aa625734f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3100,15 +3100,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
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
index b4cd680fc4..abf15cdd3f 100644
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
index c6b4c0a25f..4f5e0b656c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3863,7 +3863,7 @@ static void aa64_fpsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -3882,7 +3882,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
      * SCTLR_EL1.UCI is set.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCI)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -8592,14 +8592,24 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+uint64_t arm_sctlr(CPUARMState *env, int el)
+{
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    if (el == 0) {
+        ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
+        el = (mmu_idx == ARMMMUIdx_EL20_0 ? 2 : 1);
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
@@ -11332,7 +11342,7 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
     }
 
-    sctlr = arm_sctlr(env, el);
+    sctlr = regime_sctlr(env, stage1);
 
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index d3194f2043..42c9141bb7 100644
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
2.17.1


