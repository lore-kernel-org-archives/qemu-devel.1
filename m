Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F7ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E396720650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sz4rEsZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E396720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgdQ-0001K7-AT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxj-0007J1-Qn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxi-0000lA-CT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxi-0000km-6D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id p21so2099344wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yfXT1kAIXINflleiLaCvqElRIW5XZjl76Cc6V+HbJs0=;
 b=sz4rEsZC5067Tcw1a5qKvZXNWGWTTmlooa7k91VU7loXEdPnmyu6UWlaXdlFI8nwCo
 ZoSyoDi+t1JbjlfcQqypZN/g5THsHORvqyL0gV0CWUS291ShQSm5Sqp+DYfpJ94ecmtI
 3+UBgB726qW33k08B+UmXfanT6X9J0pyIe5n/XznkgLTY7DjIwGQWuOwkIceRPuEACI3
 fCBeTBNimppdZeCVM3jjgE5UOo+sPPCYPx9ZwBqzIPm+74tNhoBNC3Y9wg7yGuZWeZ5q
 DXkxhAdxljg1m3gc7ocM3xc0DhqM7/E7s7cI5pq95iHHCQFP9HZopTxJ82XElgmI3eFx
 jujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfXT1kAIXINflleiLaCvqElRIW5XZjl76Cc6V+HbJs0=;
 b=ijCY2+A+IJwl6Db57IImyKP9mYUenW0PCIMbmgip16TK5mWrKtLj1scFSjbgU+RqlO
 crAtc0Jxp27edaCkP3WwrSYLQ05FZF4uwKzMndhi9MZsrVN0W9YzOEcG7QDm0an9LBxU
 Q+oe++9bKSaHmRmqTMUOgUgH/OsSTvME7xzI644KnDVSJtdjiSuO3P+8zxrV1oyKhBXQ
 9lBPEjk3Y518WX3VdMW81RCUJeJ0uNiubRWSIPt6c4wJfmj76ZQYk99BYq14nKlsEHwN
 puvM4RSI+N5EBL8DDe0pJVhbix/LJQZNFwlyl23CZiwJx1WOmOxrwCNX1wKyGSCbVskM
 I/qQ==
X-Gm-Message-State: APjAAAV2BTsW7BXSaGO/pOsG66Lk78hCdZCTs30EYcdHYiho4XAtzLWC
 LVayEVI8BSGdIGq6NshcZGtoCOTImn0=
X-Google-Smtp-Source: APXvYqwwOH2gG1+LoDgTUXxisSYjLfVoW1HkUhpi6kwugrO1WbNsD7OzhsfCQFB15w1grmM8J8Js9Q==
X-Received: by 2002:a1c:1b07:: with SMTP id b7mr5674683wmb.111.1571934464753; 
 Thu, 24 Oct 2019 09:27:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/51] target/arm: Add arm_rebuild_hflags
Date: Thu, 24 Oct 2019 17:26:47 +0100
Message-Id: <20191024162724.31675-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

This function assumes nothing about the current state of the cpu,
and writes the computed value to env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  6 ++++++
 target/arm/helper.c | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9909ff89d4f..d844ea21d8d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3297,6 +3297,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_rebuild_hflags:
+ * Rebuild the cached TBFLAGS for arbitrary changed processor state.
+ */
+void arm_rebuild_hflags(CPUARMState *env);
+
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 89aa6fd9339..85de96d071a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11198,17 +11198,35 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_internal(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    if (is_a64(env)) {
+        return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
+    } else if (arm_feature(env, ARM_FEATURE_M)) {
+        return rebuild_hflags_m32(env, fp_el, mmu_idx);
+    } else {
+        return rebuild_hflags_a32(env, fp_el, mmu_idx);
+    }
+}
+
+void arm_rebuild_hflags(CPUARMState *env)
+{
+    env->hflags = rebuild_hflags_internal(env);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    int current_el = arm_current_el(env);
-    int fp_el = fp_exception_el(env, current_el);
     uint32_t flags, pstate_for_ss;
 
+    flags = rebuild_hflags_internal(env);
+
     if (is_a64(env)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
@@ -11217,8 +11235,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         *pc = env->regs[15];
 
         if (arm_feature(env, ARM_FEATURE_M)) {
-            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
-
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
@@ -11242,8 +11258,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
-
             /*
              * Note that XSCALE_CPAR shares bits with VECSTRIDE.
              * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
-- 
2.20.1


