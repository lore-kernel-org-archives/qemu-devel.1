Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814BDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A41720661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pC7WypnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A41720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYkK-0001RU-2d
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeb-0001En-Lz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeZ-0006Qq-5T
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeY-0006La-Qt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id u2so3030816wmc.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=skC1xQJE1iTwhjpFkifipqVLdATCtmsaetFYoD3Tnvc=;
 b=pC7WypnPork5nUe6N10FrfXuf9T+GinIA+3EwpGVEGZRxx1Qqo/P3BTvdV5p78fjp+
 oTWBhkcU48E1bnZS+5qOnaXGZKeQ2vGk3l8zgPS0kfa9F5CXZxg4sUM+fNaAEY/gpe4P
 IYIcb8qX+sbkOZ0Ee5wTALNYkkAFGghf9oj7wQHTZYEir4T7+bTary9zxkJvf6Qui1+z
 ovzhbu2txIzbUVTYo/CO6TJWMX3GD8XbIVXKOsNPWyFZ4ASYAt4kzHIoU/q2jxa2Xdhu
 jtkeQao0McvCPs1QNPPkQNZyFjm2vPEdfGI1UGXqBryTuEjBWLJKKcIkp0DCpXhdr8iM
 7mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=skC1xQJE1iTwhjpFkifipqVLdATCtmsaetFYoD3Tnvc=;
 b=q97y9dVMhsY0vSB/bpXZK8cfcF+BVv8DKsNX4/56AcPJ2SFSls0du0Ef0GrcUThRJx
 ACogv0/nDTOq+j8JRZHycTuZ6nVUa2kaKipoD5mv64DRCXkjg+x38mAe9K6MNj3gQr5M
 V3/w8+5p3aDgLD2LbsD1ZP7bKXCtanVeVg5Db0UbwYusfke9uEOmDJrNSDiU8nYZJ74+
 T1/naEAFYrdp5F7G2Kd134wFVgfwB8JYJo17g6cp1AkVblVRjNCnXjVZS4urJHy7ygbS
 uD+Pv8u0h38+hZeldvqSbVR7T6SjBIf4DfijySc0VxqIDZulebdk0kyC8YoehrrBHhfN
 o58w==
X-Gm-Message-State: APjAAAVLh7ewpE/vfmJMAcE1IP32J63Jtrfqc6RXkemWj19n8WGACHs7
 eeg1zwoH1M1rLPHni1YNKMknIQ==
X-Google-Smtp-Source: APXvYqxhCQf/6WOMx4+Aj7gq0INziyZbSzpCQFyxp7qBAfh/D32+jBsA3c6DTjtgtZEue/14Y142Fg==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr5116829wmi.118.1578579553686; 
 Thu, 09 Jan 2020 06:19:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x16sm3005183wmk.35.2020.01.09.06.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4D581FF9A;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 10/14] target/arm: only update pc after semihosting completes
Date: Thu,  9 Jan 2020 14:18:54 +0000
Message-Id: <20200109141858.14376-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
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
Cc: Keith Packard <keithp@keithp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before we introduce blocking semihosting calls we need to ensure we
can restart the system on semi hosting exception. To be able to do
this the EXCP_SEMIHOST operation should be idempotent until it finally
completes. Practically this means ensureing we only update the pc
after the semihosting call has completed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Keith Packard <keithp@keithp.com>
Tested-by: Keith Packard <keithp@keithp.com>

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 31c845a70d4..bbe9fefca81 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -130,6 +130,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_SEMIHOST:
             env->xregs[0] = do_arm_semihosting(env);
+            env->pc += 4;
             break;
         case EXCP_YIELD:
             /* nothing to do here for user-mode, just resume guest code */
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 7be40717518..1fae90c6dfc 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -377,6 +377,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_SEMIHOST:
             env->regs[0] = do_arm_semihosting(env);
+            env->regs[15] += env->thumb ? 2 : 4;
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index da22c198006..19a57a17da5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8614,11 +8614,13 @@ static void handle_semihosting(CPUState *cs)
                       "...handling as semihosting call 0x%" PRIx64 "\n",
                       env->xregs[0]);
         env->xregs[0] = do_arm_semihosting(env);
+        env->pc += 4;
     } else {
         qemu_log_mask(CPU_LOG_INT,
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
+        env->regs[15] += env->thumb ? 2 : 4;
     }
 }
 #endif
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 76de317e6af..33d414a684b 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2185,6 +2185,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
+        env->regs[15] += env->thumb ? 2 : 4;
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe6295..972c28c3c95 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1937,7 +1937,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 break;
             }
 #endif
-            gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+            gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
         } else {
             unsupported_encoding(s, insn);
         }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf9..5185e08641b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1124,7 +1124,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         s->current_el != 0 &&
 #endif
         (imm == (s->thumb ? 0x3c : 0xf000))) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
         return;
     }
 
@@ -8457,7 +8457,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
         !IS_USER(s) &&
 #endif
         (a->imm == 0xab)) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
     } else {
         gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
     }
@@ -10266,7 +10266,7 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
         !IS_USER(s) &&
 #endif
         (a->imm == semihost_imm)) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
     } else {
         gen_set_pc_im(s, s->base.pc_next);
         s->svc_imm = a->imm;
-- 
2.20.1


