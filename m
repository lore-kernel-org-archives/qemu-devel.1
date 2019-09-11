Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ABCC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D04F2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6wfyfdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D04F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85tB-0003Ht-QO
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i85oj-0006Uc-57
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i85oh-00048K-Ry
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i85oh-00047m-Lf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so13226334wrn.11
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uRjmOsEbXk15ydPmEJ99gd5DAhkd0VbLE+A+syxTleE=;
 b=i6wfyfdHclxGEDVmHLKAronMHhWnsi68fRV8yW7768Cwv6sjVsiIsU6ev0HN1/OJGQ
 8zw7UiLInPgXcFW97vv1wqe+CyWfs6bZ3eU92iGB8HcTig4odYz6hqNMiy4HsLiHvKhT
 QIe3f9BSAlS7syrbFtwA96e9adlBDQ8WHM75IXfrYmiHoScqG87nIk5lr6ncJ4oWAwyY
 uXbIkp7LIE4AL44io5OIKcou4EulLMDcEMeqfdN9vRfzjrHJ1XAu+SkKlALLAhj52N5/
 gpJQjQg5qgNe33f3Uve8W0gJod59kAQ6s05ouM/1+gaV0dlo11jyXMS6/F9y9/Xl3D7u
 M6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uRjmOsEbXk15ydPmEJ99gd5DAhkd0VbLE+A+syxTleE=;
 b=SxeAtpvEZJjBFLD0IGF+j6nWwy38/mlhfkzVEnR/WRM7/voS6ll2QAkvBKRCQOdFUz
 Ska94hQ1IMgcgKkwyyJ0mlI5g+1++KY+Uxyb4DOfpjBne0vwBOF+aJ97GNdyXwujXsHH
 NDKyqlhnTKUWqiRnEb2LDutT3RUDkbOIl3rm5VzO1x8f+6lLe/xb3CpWzxEaNrLNhZiS
 VMCUH/04h1FFWl5r3DE6XLf+TwBQA3cD7Oji+6bojMcEnHUgENqve7dOJVd3Pi5b6FMA
 Vrl0M38uc4ccbEhJRDyI++s727mx1W74eQ5veXe0bfgtZYUo8x8GIRUXKkukqQQ5TYEO
 EQvA==
X-Gm-Message-State: APjAAAXdvPDz2jurcT6f/jyqUVarcCssnb4zcdqqM2gG8yWRMh6CItRM
 ywWaRKp0w2Lm4f8ejAgDeaPaPg==
X-Google-Smtp-Source: APXvYqzhhFT+a0Lqumc+NnIE86x9yxntEZNQzMWxoWNlHeRPWVyjo/6fbuuq0VkBP7SDH04N86a0JA==
X-Received: by 2002:a05:6000:b:: with SMTP id
 h11mr1957174wrx.270.1568220602581; 
 Wed, 11 Sep 2019 09:50:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h21sm16378463wrc.71.2019.09.11.09.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 09:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A1F71FF8F;
 Wed, 11 Sep 2019 17:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 11 Sep 2019 17:49:56 +0100
Message-Id: <20190911164959.11003-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911164959.11003-1-alex.bennee@linaro.org>
References: <20190911164959.11003-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
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


