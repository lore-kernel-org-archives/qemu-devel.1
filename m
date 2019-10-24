Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0752D205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFin8SZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0752D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48155 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgSI-0005U0-Kh
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxu-0007aD-Ef
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxt-0000r0-33
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxr-0000qL-Sy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id v6so3231251wmj.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9fEeMZ9uPtcAifoblXjrkL5Kbv7QSQTtSjC/i1CHC68=;
 b=dFin8SZeX0EBItnbFV28EO9KDRWx+gs8o2T0sZkHUwvta+LqUaqdxM6mPtoQew6VBB
 l/heKWlVzWwkbVd7rwOnlcZebOUliUihfCmquo0SXq1gnkrD/Th9cJnRs9+7n3clLboy
 spIfAm9hYlhIcSBmQ0q7etGhMdV8TBv/3PAlyy7Fj6KCjNoFN4Ru0sJ3eDOqctgbeSWR
 UF3fxbpVVCfat0YeXh/4sNLgRD+8xyWm8w+GmLp+gKcofaaT+Irp+9CqZkesn8Wr63+f
 29TIVMGZ4JGZLTbKUrAaGfNZdtcyGBUqXxDLJbKU4TtP3rdaKngQQ2Jbh/5xlkfm36V/
 BA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9fEeMZ9uPtcAifoblXjrkL5Kbv7QSQTtSjC/i1CHC68=;
 b=d6moqV3FyUik+ALP0ZoR24X3eDWmakK5SDlyB4643GF4bZuW2jjUXfb4ccOF7w/kDw
 LGJL++m04TZnkus6DmoZTa2RzFUnTJWlOtsrioON/peePwygjoDfiwx0H6CuWXHXzMje
 UzhNweOYtmoqwtjGJABiu5M6hdmp/rG52j/cLNYX3SiBPofvxOw7QVaJ518Vur/x3KqD
 hfe46kLGzbBiPVtzZ9XmDqE35ypISjF2xy9lQOug5TqJ1CH0dkexmmPPex0d6nLwHpZS
 a3JIQeRKdDZAwuVUS2BuOARpMtvefoxBTawI/wD/ddeu0iAj2RLN2Hlz8kru3LVwEoKx
 T1+w==
X-Gm-Message-State: APjAAAWyf62ZGPj9CLvoAuYX11KmrT/yqVYyFH+vZ9dcNgU51RIvqcu4
 piGumdNf8XXcmO0jMfqclPyWaUa7gdA=
X-Google-Smtp-Source: APXvYqx5IkEDI6iB7EEmJuq1ORfpvOgZkACmNw0H15pHar99ripxlMCG2VyO6uXqCyjAUmt2QVV2lw==
X-Received: by 2002:a1c:1bcd:: with SMTP id b196mr5699960wmb.12.1571934474705; 
 Thu, 24 Oct 2019 09:27:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/51] target/arm: Rebuild hflags for M-profile
Date: Thu, 24 Oct 2019 17:26:55 +0100
Message-Id: <20191024162724.31675-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/m_helper.c  | 6 ++++++
 target/arm/translate.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 27cd2f3f964..f2512e448e2 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -494,6 +494,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     switch_v7m_security_state(env, dest & 1);
     env->thumb = 1;
     env->regs[15] = dest & ~1;
+    arm_rebuild_hflags(env);
 }
 
 void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
@@ -555,6 +556,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     switch_v7m_security_state(env, 0);
     env->thumb = 1;
     env->regs[15] = dest;
+    arm_rebuild_hflags(env);
 }
 
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
@@ -895,6 +897,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     env->regs[14] = lr;
     env->regs[15] = addr & 0xfffffffe;
     env->thumb = addr & 1;
+    arm_rebuild_hflags(env);
 }
 
 static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
@@ -1765,6 +1768,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     /* Otherwise, we have a successful exception exit. */
     arm_clear_exclusive(env);
+    arm_rebuild_hflags(env);
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
@@ -1837,6 +1841,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     xpsr_write(env, 0, XPSR_IT);
     env->thumb = newpc & 1;
     env->regs[15] = newpc & ~1;
+    arm_rebuild_hflags(env);
 
     qemu_log_mask(CPU_LOG_INT, "...function return successful\n");
     return true;
@@ -1959,6 +1964,7 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     switch_v7m_security_state(env, true);
     xpsr_write(env, 0, XPSR_IT);
     env->regs[15] += 4;
+    arm_rebuild_hflags(env);
     return true;
 
 gen_invep:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46a0bf51c95..2ea9da7637b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8327,7 +8327,7 @@ static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
 
 static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
 {
-    TCGv_i32 addr, reg;
+    TCGv_i32 addr, reg, el;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -8337,6 +8337,9 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     gen_helper_v7m_msr(cpu_env, addr, reg);
     tcg_temp_free_i32(addr);
     tcg_temp_free_i32(reg);
+    el = tcg_const_i32(s->current_el);
+    gen_helper_rebuild_hflags_m32(cpu_env, el);
+    tcg_temp_free_i32(el);
     gen_lookup_tb(s);
     return true;
 }
-- 
2.20.1


