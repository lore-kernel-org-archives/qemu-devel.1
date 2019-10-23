Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B172064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frskiv1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B172064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIle-0000TX-DK
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8v-0008Ch-Nn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001HQ-Vo
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:45 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:36062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-0001Ao-OP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x829.google.com with SMTP id d17so18127102qto.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rIJBgOSYgiSfbsgLfenw64t9SfwWSxf6NKjgwJPoM10=;
 b=frskiv1cbSK/QFp9mvPnqe39foJ3Ph/2NYWRWQAhw5vwrxgHkTZs8OQtUGuUDycBoY
 qC2BVSmn16ygtuj2O2gXSphi+X+giZSnaUhcREJFRnmwGCkxSctLw78NcoZm8Tc03spC
 6hzLa258VaaKGrj5CbvQ7SCuP6gfoPlu7h9BInwYw6VcscN+raxdZj1s7l31cOKaXAVA
 AbibaTBkcJKkNl9t7NKMBUTbyoJatTt+aotOMQ+h5c0pd3AX1WsATHm9gCiR+jc0uUnI
 cOt19ZxpbTWYEbp2NhvQRJv4U7fOqvh33rFx8+lDmzSpjLU0lF0gxjgbRVd8AWMPrutR
 y03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rIJBgOSYgiSfbsgLfenw64t9SfwWSxf6NKjgwJPoM10=;
 b=KdRH4aEVeMwpN+pasXPukl3Zd5yiPEbKBgZPFOUI3r3ak2gwC5ntcfT7KecyTMQlTc
 gg7Gr88pOtNPy5t0Zkg50WaJ9sAK/t12bfsmaIBb7PiT85/EeErypEknsrgjZ2JeSfU4
 vH/0hXP9nsFyhS5LPzNHPcuoqrZAtz2MW/jOHMGWfBvMT+Obmsu1Ut/2LGRMzzQNTu/w
 nLiceOAsYjXl7nMzXFChQZyYs7lmqteE7QtJ5GmypG4YS5ZqOcuoVpe0Q7NSDl3n6JkV
 IzBbBUJ3YPU7IS3kcl99KydLhuyb/Z8Hi+YFNtFSRO7LaLpn9c4mypmH6E/oUyTKeIzG
 /WeA==
X-Gm-Message-State: APjAAAXoTY6EbYaY0IoNkxD3tZK6VPFD5qmUMCgnd2VGbJvcNcJvqT+u
 AvGKsn8W14rcU+L+ecVbkOc3iw8wZvA=
X-Google-Smtp-Source: APXvYqwlUhkfOB7ndu61aKy7GnC2pEneL3MSqsrZOXmf5+eXToC+SeWgBt/+IX/oDmKaQUCA9K965A==
X-Received: by 2002:ac8:5214:: with SMTP id r20mr8820861qtn.140.1571842889292; 
 Wed, 23 Oct 2019 08:01:29 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 20/24] target/arm: Rebuild hflags for M-profile
Date: Wed, 23 Oct 2019 11:00:53 -0400
Message-Id: <20191023150057.25731-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v7: Add rebuilds for v7m_msr and nvic_writel to v7m.ccr.
v8: Split nvic update to a new patch and generalize location.
---
 target/arm/m_helper.c  | 6 ++++++
 target/arm/translate.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 27cd2f3f96..f2512e448e 100644
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
index 46a0bf51c9..2ea9da7637 100644
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
2.17.1


