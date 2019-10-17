Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073FCECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C655F21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plktUL/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C655F21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBEG-0002fm-VT
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs9-0001Kg-IC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs7-0000yB-DC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAs7-0000xU-6j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id t3so1856230pga.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eUg5dM9Fl5udLxVDhP9VJ17zdeIkUx+G/V/inFv6c0s=;
 b=plktUL/OsfHIGQTbgv0X3YO7e7GgHsi4/sTMO3i0hTBtLAFWayLFBBXrCg2KCOYB4e
 IVwa5buvG7B7V6ahOYA8IAekltI8cezmKCEPuoX6J4tBr/Jh2Hdaoe9wKDzJYo6tQIZ4
 nrN8TZtLgdTiBBpxz7M/7p3xn8qxfQ0alezjVwoCQoj2xW1PCRdMkyfJnt5xEEnMK3jY
 F44+AnTW71P+aLuzaYE9wFZwuqlVUl8D6/cVDF/xUvGFKK2iHLclAJJSpH9TfYl7lGt4
 k3rkHNGwLYWmJasTco8OyFMlnmYnCr5f+DqO6mbFD7PKh0SW0iaWHV0Z//ejOYZ3jryp
 s/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUg5dM9Fl5udLxVDhP9VJ17zdeIkUx+G/V/inFv6c0s=;
 b=Ky/qx8gO0NlSdSou4PuGQwyU7Kmb8FB39l2y4zZgYeq190c7L+wYBYhmUprLiZHPTe
 lg6n37ZBP0W9vJRpWYhRh3npnN7/i1TA07lX0vbXYThxo5RCmDMQaTIW4hUz0JuwtaA4
 KZTmND0PWB474jD/MfiDksRzBhnXdz6tNRJWBDrH7Tazypgqgo4dUdcaOhvilqYJ7EAW
 OFDwfk7bWCaze/3JYfqMlBbrGpz/nv2QpAAUkkrQl5GgqNg64dJnTf3pFbT3ld62t2x6
 IHGyzeIDxaFi3ZMk4V7VhXVa+uu1KJwl3po3A4tqvXmaIgJI/k1K2fKhbuG31b8/qXzn
 WzFA==
X-Gm-Message-State: APjAAAVOFUT6gyQhS3+cPYfMw+RJfXh3puShzILb7TCJ7BnRCn/tx8su
 hZdaLmn+f/6uA6eLJY87vCrkLmt00yM=
X-Google-Smtp-Source: APXvYqwgAZSqu8+zKDyQqKZ4EZcAxIaznyaMZwruY0Tp85QjPtBRmaecT1I6mZxcdIUDTIDYNkiIqw==
X-Received: by 2002:a63:e20c:: with SMTP id q12mr5659220pgh.275.1571338297696; 
 Thu, 17 Oct 2019 11:51:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 19/20] target/arm: Rebuild hflags for M-profile.
Date: Thu, 17 Oct 2019 11:51:09 -0700
Message-Id: <20191017185110.539-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
---
 hw/intc/armv7m_nvic.c  | 1 +
 target/arm/m_helper.c  | 6 ++++++
 target/arm/translate.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e81..a3993e7b72 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1604,6 +1604,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
 
         cpu->env.v7m.ccr[attrs.secure] = value;
+        arm_rebuild_hflags(&cpu->env);
         break;
     case 0xd24: /* System Handler Control and State (SHCSR) */
         if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
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
index cb47cd9744..b3720cd59b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8325,7 +8325,7 @@ static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
 
 static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
 {
-    TCGv_i32 addr, reg;
+    TCGv_i32 addr, reg, el;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -8335,6 +8335,9 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
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


