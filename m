Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AAEC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E0B20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUzwKAeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E0B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nQy-0004ju-HI
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLW-0007d1-Lk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLV-0000JY-DN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLV-0000Im-6n
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id l16so32398942wrv.12
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rhh9od3jglb/e8p3pboZpBtMsu6c6uuGIYDm01cfBo0=;
 b=qUzwKAeU+Jx1kEUMYqjScAm/evx7NJWNTK0yla7o58SjttUOAqZmHCtcZJbc71eSVv
 aQjQi+A/5IJygAQZ09Kj7xJWCLliRmUFKshf5hmnFnbTbAnPQdP8jeodrZ6YiJ55QVS+
 peVPVqyVJMSTsbHQy5fY+OW8j+TiBmnD3nwbjVyHfI42BdbqLHMW422fd5c5ADbJCGqj
 EAVezv6QeWxoWHKAqttKKRd0tTb0/q/89wXI3HJI8rDnZBKClCzImZKxqvYY+J6MpK4l
 Q/DQABGLUSd/ZUCtksFMSd/+nu39mTgh6X1LOgvlM3zrKlbZKVPsGbL2AQI9Co6cOB1F
 AdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rhh9od3jglb/e8p3pboZpBtMsu6c6uuGIYDm01cfBo0=;
 b=g/qEqwmOEWcl2TNjFJ9J0epD6MbckOLmvUeeBv+36gdye7xvQc9e0VjpapRO/tFDRn
 Q58/ILMZRT8PsKRSOnLK3J7pFzMtRlF8IsY3TVj0ASqFygXU8/wOQfubL+qZaq5fdbSY
 SCRmweGcUH6OReGv9FWRkoBGV9vqJWlRajJ5msfhYsp5xq8XxlU2zde16n781IljCzxa
 fSszX4N121KbOEvlkqEAtGfZ+SQph2Ns64jHoksCnrGrmM71S6mq/GSUuUU0iWYbZV1Q
 pRlGpnldsGWTR2oyz7NlyxA+K7QLH9B2mpWTcyzCiRiroJpqvFRYKS85yU0lQYY/Pmb0
 2vsg==
X-Gm-Message-State: APjAAAUaLKk/DNOOdv4KoKSEmnGztstDbw/gM5LuE5GcNmKcFVe6xkpz
 PeP92hJ6l8ODRMCzusJgffm8Vg==
X-Google-Smtp-Source: APXvYqyWhhlLW4A4C1CCoIVflvc0topuiUn6ARO5jOSFKddC3qCwWqurSO6o7V7F03owxRQ8R8b1Vw==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr2242639wrv.215.1568387928086; 
 Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm2769685wmm.36.2019.09.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D63F1FF8F;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:41 +0100
Message-Id: <20190913151845.12582-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH v6 2/6] target/arm: handle M-profile
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
v5
  - return #ifndef CONFIG_USER
---
 target/arm/m_helper.c  | 18 ++++++------------
 target/arm/translate.c | 11 ++++++++++-
 2 files changed, 16 insertions(+), 13 deletions(-)

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
index 34bb280e3da..b5272119330 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8424,7 +8424,16 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
     if (!ENABLE_ARCH_5) {
         return false;
     }
-    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        !IS_USER(s) &&
+#endif
+        (a->imm == 0xab)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    }
     return true;
 }
 
-- 
2.20.1


