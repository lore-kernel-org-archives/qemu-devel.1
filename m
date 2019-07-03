Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FBC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CCC2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2Tc0jV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CCC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihe3-0005ED-L7
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53215)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZS-0002iv-T6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hihZR-0007Co-Lb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hihZQ-0006vZ-JF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:53:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so3385144wru.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=//Wpc08mM5q/cSaFPICPcz9+DodTG0MeCuuW1XebhP8=;
 b=r2Tc0jV3jXYmUHw/XhFIYmFA7bk0IbvAdH+XlCTUwhKfS66u/qbq1WIh2O9aIow4sR
 hmhg8ZobtYV5Hm5XfHqCdh1Qs8QaQ4vv93SQA8gknih9AdeOO2rBtkxF2GX9seK+8OuJ
 O0NsaD7VTDG/EOSA4u1mh1kR8fYmuIDfFm3DfvbGCGXeEoHO7tAk7askTTQXxPl/GNjr
 tzIEILwygns2ATK8pwOevtuo3yaTwoB2jIONF26EPhP/zPS70pXl1nUTCbBx54Tqk04G
 fZqXY4nllVICnw+y8WWg28T7HB7ZM3m472gHA0U5HkaJZ0C578bkgsVB3OC8RNba1Swl
 rzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=//Wpc08mM5q/cSaFPICPcz9+DodTG0MeCuuW1XebhP8=;
 b=LpRchaEKUPt3TDIoJCM7Bs6y56rELkp0UbDQhkFVZPiaW5/ousX3LAygTymYO1LZ7g
 w1nGXU2fllN5FpCdFLoik+y7ri9EB6Y+eL5zpXDGooHx+BkjM68D50PeKdhfcUel+NkE
 JxhLMc8Cey31+PZAcHuYdX24AdVNkvJq9jkl4YI2tFDhH13YeSBLQSkLyLwAukE22k4I
 vroEMaoyIu34ZYIMdFzv/xDS7dpi2Q8C4ssIBAmy+bKrWLz60qDrcOVHVJqeCvgCUIAS
 SN0m/B1KoSJXW5PGaQe7Qoh5nQHHWudhU5MYYlKnZzKSQLhLSBu43DI9dEySQtDpn7Aj
 5Iig==
X-Gm-Message-State: APjAAAVQ7jMf56Fkodu2PcdXeFL4883momMVJSaJZkyBVExI0aGN10kI
 RlSYZerPYbHSlxtDk7kol0rBEw==
X-Google-Smtp-Source: APXvYqxFmxNFk+kiHEsCjSgIx2+OIGhfbuM2kxAPeB1ApIoA7x/UNsPo08LIAdzgvx0j+/s3PgMk5g==
X-Received: by 2002:adf:aa93:: with SMTP id h19mr27153178wrc.3.1562169165617; 
 Wed, 03 Jul 2019 08:52:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f7sm2450062wrp.55.2019.07.03.08.52.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 08:52:44 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68D361FF8C;
 Wed,  3 Jul 2019 16:52:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 16:52:41 +0100
Message-Id: <20190703155244.28166-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703155244.28166-1-alex.bennee@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 1/4] target/arm: handle M-profile
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c    | 18 ++++++------------
 target/arm/translate.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index df4276f5f6..ad29dc4072 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9692,19 +9692,13 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
index 4750b9fa1b..aaab043636 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10977,6 +10977,24 @@ illegal_op:
                        default_exception_el(s));
 }
 
+/*
+ * Thumb BKPT. On M-profile CPUs this may be a semihosting call which
+ * we can process much the same way as gen_hlt() above.
+ */
+static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm8 == 0xab)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+    gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11605,7 +11623,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+            gen_thumb_bkpt(s, imm8);
             break;
         }
 
-- 
2.20.1


