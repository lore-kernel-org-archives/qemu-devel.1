Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9515BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E28220659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQhur7zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E28220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izev5-00070W-Fh
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoT-0003En-Vn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoR-0007XO-VK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoQ-0007Ms-4y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:10 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so5800741wmc.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RuSOk2zlMrtb2eSC90BO/Fbk/n728DIo3vxwWr/kGGY=;
 b=HQhur7zxE3McIt8eMtxPUQyGYg8asinfelKlxgEYZR3f2DBClg3PycDY8N9UwhQD/p
 cAgt1oJoZP5W0Bv4GUYYlnZ0qfRDQRrpet2eshGji22XTAdvrHREOhthzyS2cWuF0eQm
 sToRJr2N+zhBVsCFIsWF1Tv5xNam0c41R+2wwcMMLhd2HGFk05U7mAPal3aERqT5dy+U
 GXBSHoinxoV+hz23OeqPiElBXjn5fWVA8qT/CUzFxflRi+QMBfAlAdCa16cju35MZtvN
 5p05yKxFKQYq3+qEk7BTjjN0cgSqRHEP1KBLPrd21XLvdubklrf4uro+Cfb1ucqWwe9p
 rFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RuSOk2zlMrtb2eSC90BO/Fbk/n728DIo3vxwWr/kGGY=;
 b=Rm2iVLkMzBjmF6PukgM4MbbtwbUUfwE7moa5OpgGfhEGKPu+bGP5ydvgZK+jZbiIG3
 7jQAxAgm0DzxNdH1WBj8djeoaP1vfBhzFs3SzxHfA8lW8M7TkEZ+TrnXZp1BM8CAbVbp
 pAriID1Zdxet1jGTFzJc6jv+ovM81wCn8xoi10E4ba+4ad2BRInG1lwzx6Ag/eB4ZtMC
 xzSNeXQANQBG2TtXWWvSZj2HoWj0zeW+lGXRy0kf+i5B0a91hVirJjhkCaTjYkCKFYRp
 CW8GrbkJADJ2mCsxiZOc6jDCwCm9IwWQ9/aJMLGILlJk3z7yMoXxv7Z7XaNcyWYKMt49
 PIWQ==
X-Gm-Message-State: APjAAAWvbYd0ceoEI/ogYx6bz9zwjVZ9/WC8lxKt5g/CV9pvKrQ7fTGj
 klX/yYjPIUH3MNTIF0gJyYAGERciO3sYGA==
X-Google-Smtp-Source: APXvYqycs1WieXaAotHU3fkpxGe5Ub1HBzxkHu5IQCGSv8ol8lLdz7uUbCI0ILj0hwIAdQvFLbDlIA==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr3704424wml.47.1580986508723; 
 Thu, 06 Feb 2020 02:55:08 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 22/41] target/arm: Update arm_sctlr for VHE
Date: Thu,  6 Feb 2020 10:54:29 +0000
Message-Id: <20200206105448.4726-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the correct sctlr for EL2&0 regime.  Due to header ordering,
and where arm_mmu_idx_el is declared, we need to move the function
out of line.  Use the function in many more places in order to
select the correct control.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
index 3fc0e6e746..68e11f0eda 100644
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
index 9f8d7ca1f3..e4f368d96b 100644
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


