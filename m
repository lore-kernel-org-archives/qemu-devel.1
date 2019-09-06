Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274BBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B252081B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFeW/KPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B252081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Kqi-0004aC-M6
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Koa-00036b-PL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6KoZ-0002Ql-Ku
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6KoZ-0002QG-Cb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p13so8445368wmh.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uRjmOsEbXk15ydPmEJ99gd5DAhkd0VbLE+A+syxTleE=;
 b=cFeW/KPm39yoZlIL/v/yZICYrcxotgsE73fpad1iCm6MLu2U7zzMjmplcmvP1wO9RS
 zcFUXkraLWxi1NbyFGbY1uopjdrSeFnLoihWbUSx5G1gyKM5HkdbMnfryZa89SjhdpuB
 2Urv+c7Irt3ZSzN77A3LIrU0S4BJ746+WZioWzQuROz8u0VkcDh4krgeEdsT3yap0NGo
 2aT9L5FJ6W6Q6S4HUqC41s0eGKQhaTMpDBNI1q91cEYHxUeD6t5ud+UY9TzprwUYl9tm
 BDZ0J/d9S2Cj1KwaMOM2l8M7WbWarB0NilcDwgtJ1z18MNLii+kn9/rUexiMKZbaiVrI
 XNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uRjmOsEbXk15ydPmEJ99gd5DAhkd0VbLE+A+syxTleE=;
 b=CW7xmD/8zqPgBYlieQM3dtYsK00qUzf0LXrPcD6TR4S4Ckv/Z06iXItoS6rbtvwJhT
 zw43yl4y9+xf3jaxDuVIeRDI09O8FS+Av5oAcRP0kx9n172X8rhri+c0jBKz4p9E4ITR
 0qMtDcydlAmB8vbCnZhExfEUUiPPkRiHgo3rapnq+Q4YCio3QQHydmY885V52dJN+lh+
 p3INsPIxC4nGZ+9JVVYGGBaFd+v5KV7lLtKHZujWofzqZ3Hk9ksFWg57vJFwkrkIbIHv
 G8S+zj7PvT1xn/La57g0kJB9zMinIpyZilhZ8hPhAyg35aOFYs9WAzGdjkxQYHjj88Kv
 iaeg==
X-Gm-Message-State: APjAAAWUcEp9SX379vzZbJ4O/vWCDEgqZyf51yztJH0REqnSXAGvra7k
 KgXGtEKwzF2CYZdihdp5iStdkg==
X-Google-Smtp-Source: APXvYqxV1HI9fOrIN2uzQBbN49YlkZqr5gk0FuHFzFM2QcaRUKEb/OJtAWpUvOKcqP0pgULaBoql+w==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr9015976wmg.174.1567801598306; 
 Fri, 06 Sep 2019 13:26:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l62sm8689030wml.13.2019.09.06.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 13:26:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 521711FF8C;
 Fri,  6 Sep 2019 21:26:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 21:26:32 +0100
Message-Id: <20190906202636.28642-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906202636.28642-1-alex.bennee@linaro.org>
References: <20190906202636.28642-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH v4 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
v3
  - update for decode tree
v4
  - use !IS_USER
---
 target/arm/m_helper.c  | 18 ++++++------------
 target/arm/translate.c |  8 +++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 884d35d2b02..27cd2f3f964 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2114,19 +2114,13 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             break;
         }
         break;
+    case EXCP_SEMIHOST:
+        qemu_log_mask(CPU_LOG_INT,
+                      "...handling as semihosting call 0x%x\n",
+                      env->regs[0]);
+        env->regs[0] = do_arm_semihosting(env);
+        return;
     case EXCP_BKPT:
-        if (semihosting_enabled()) {
-            int nr;
-            nr = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env)) & 0xff;
-            if (nr == 0xab) {
-                env->regs[15] += 2;
-                qemu_log_mask(CPU_LOG_INT,
-                              "...handling as semihosting call 0x%x\n",
-                              env->regs[0]);
-                env->regs[0] = do_arm_semihosting(env);
-                return;
-            }
-        }
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
         break;
     case EXCP_IRQ:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 34bb280e3da..6689acc911e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8424,7 +8424,13 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
     if (!ENABLE_ARCH_5) {
         return false;
     }
-    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() && !IS_USER(s) &&
+        (a->imm == 0xab)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    }
     return true;
 }
 
-- 
2.20.1


