Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E5C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51D820644
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHIEQqOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51D820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqbV-0007hZ-2M
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0J-00076Y-QM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0H-0003ys-2l
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0F-0003jW-Ks
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id k11so3378355wrl.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2raPXKCjQecpuTN9hXy4UgLzVxLUbna9Nio0I94YsC8=;
 b=fHIEQqOlAsL5rWVjXzym6dN6zDbrXls9Ad0tWpiamMdIHCeBDhehwQM/onGIjLq4m2
 YNC6nufwMJcnOj4D5dH+sMeN4GMK7j7mQol6WPeniyBIg7z1so8YsgGTrzJNrMpYbrYN
 lexy/IINpQf58DDF9AGoWrkwpZXoFwfOGgiS1RL2C1vUutiH9zVuf8MfIrbQVzLmqeIB
 F4l1x5FZ1EfLFPtSIvdfUBQ/LMHu8/CPngMfbIZN1rZ/6/HgJPsSEP15mMpmVqR2vagX
 gdn7PN1qZRHGge7SlAXuvEBpmVIAJxjLa+aiB/LkiYjCnGyFEMAQe6p+xupGvFbh7t9L
 /7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2raPXKCjQecpuTN9hXy4UgLzVxLUbna9Nio0I94YsC8=;
 b=D6/sKpDvjVHJFLLTH7qqY4vSD6JxF0SBNJf78jREg1ysbV/8H+8QybItuic2yO7fTL
 GB0g/4bIDB8M04MsuUkHRf8dUNh7uJlrZDYBEVP9a58GSDsPF03DvmIRmm5BRr+hibZj
 Awk9w4MGTtYexmGSTEtHJkw8jgCV+MUKWRcHhsZMGsufckumu5s9EcgRrRz8tn/DXuws
 UiVOCElY/twah3K6PTybAqXnmhPP5XWZnVvbFWG7IY5hvhKoLqOEOWUawwxHRjF1Q2lR
 jotzOq6nl5rrDTkvDXKjz5FOMgTNf7lkbbWTMlVumHpB5KiGlO+YIHAodd80gh63kILw
 6QxQ==
X-Gm-Message-State: APjAAAWInd5rF/X8/6UUrpm1u5Ef0nu/t83k2TDK7yMan5fj19szNmpl
 8532ipT+bTUKoIevuhqBy1jBvA==
X-Google-Smtp-Source: APXvYqwnaio8xVQcNsHUv+78CcU6eKcEB8NBS8/nX+NRzLijLQJSNwdA/EcA/aoTP6K7C0NLtVWaeA==
X-Received: by 2002:adf:a201:: with SMTP id p1mr33627107wra.113.1560533307829; 
 Fri, 14 Jun 2019 10:28:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l19sm2196683wmj.33.2019.06.14.10.28.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D06BC1FFAF;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:36 +0100
Message-Id: <20190614171200.21078-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PATCH v3 26/50] target/arm: call
 qemu_plugin_insn_append
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

I considered using translator_ld* from arm_ldl_code
et al. However, note that there's a helper that also calls
arm_ldl_code, so we'd have to change that caller.

In thumb's case I'm also calling plugin_insn_append directly,
since we can't assume that all instructions are 16 bits long.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 2 ++
 target/arm/translate.c     | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ae739f6575..25dd34a745 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -39,6 +39,7 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 #include "qemu/atomic128.h"
+#include "qemu/plugin.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -14205,6 +14206,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     uint32_t insn;
 
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    plugin_insn_append(&insn, sizeof(insn));
     s->insn = insn;
     s->pc += 4;
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c274c8b460..d049844b4a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12122,6 +12122,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    plugin_insn_append(&insn, sizeof(insn));
     dc->insn = insn;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
@@ -12192,11 +12193,16 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
-    if (!is_16bit) {
+    if (is_16bit) {
+        uint16_t insn16 = insn;
+
+        plugin_insn_append(&insn16, sizeof(insn16));
+    } else {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
         dc->pc += 2;
+        plugin_insn_append(&insn, sizeof(insn));
     }
     dc->insn = insn;
 
-- 
2.20.1


