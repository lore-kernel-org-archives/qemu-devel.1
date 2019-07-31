Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5894208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0ex1P+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5894208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrAg-0003yn-S2
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8O-00021z-8B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8N-0000be-72
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8M-0000aF-TY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id r1so70281970wrl.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qkiw3jBwg/vICATtfRTry9vznckLVpbUV1wDKMXT5GE=;
 b=j0ex1P+VZmKuzOcUzLHFA1DkvDrTWj0nCyfYZqB2dcoD7k6OGXFl+1CPQDgL4BnlMP
 dhsWZuOD3zK9OAGjVmWpqF7y0EM7RUqGIHfCY2Tn/WgN4/11+QvKtz0jFGVNMxzNTlbl
 NQTfFeVuGO6jHkwmzAsoKHG57r74kDXgpKrLFv6g9n/vBlPRJ9OFySx8F8nbc0hieCCv
 6sgXTSO5ItUEOXIZwTEha34BLvT3y1Lj9OnFrSbzv2t5ldiBMEUWYwF6BAkon/NSaJQm
 5nHMGW26Zc1SakGWOAusGgqtXHGrZD7lzBqJDmAuIteCKa8foFZmcwmeI7rmW88BxoNp
 x8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qkiw3jBwg/vICATtfRTry9vznckLVpbUV1wDKMXT5GE=;
 b=dD+91ttFZbTicfaXNq0v462UGGY+a55o0AYK3T/lrNOjtLwwV9YI+H7CMoOIHLaZ3h
 Mhogk/a02ZpqZmv98fsLfS6SvPVjriyn2gsmdh2wQITVdV571XnoHq99v8DaDNvNj987
 dzmqWfmPj8T3sq8zuXu/ZT4OUck7zUwC8/aJc/FfoQeWR/45oMqArHwVGCv5UkGBoy0w
 Vr7rb2KYDeyVtUF8eEod6fcy8WscEATpNgaep+JcZ/Q/0TeuwL8K9R6uUGhrzETj7PcM
 6rAEKZ9TWuD67tWuCJguBnIhJeLrdPvIHZjuPc319gVEzPuLbkKZuNWiR88GeB9JZNOe
 ek9g==
X-Gm-Message-State: APjAAAVSKvoJfybS84kW0A/XAojY2GF90tRaFfOwO63sjL+t1BtdJvSg
 tnBuUXYDuo1nAioF7cUH1rFBwQ==
X-Google-Smtp-Source: APXvYqw1zRVEORnd48ZvKdvz/39bCPB0QF5U9Omhd6pI/uOrZl3ZpZJV7Xl6K8hn/GHq4yH9WYwRQw==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr13439910wrw.64.1564589240911; 
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n9sm114495893wrp.54.2019.07.31.09.07.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1B441FF8F;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:27 +0100
Message-Id: <20190731160719.11396-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 02/54] target/arm: handle A-profile T32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 bobby.prani@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0b02c520395..662d6f49115 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10994,6 +10994,24 @@ static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
     gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
 }
 
+/*
+ * Thumb SWI. On A-profile CPUs this may be a semihosting call.
+ */
+static inline void gen_thumb_swi(DisasContext *s, int imm8)
+{
+    if (semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm8 == 0xab)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+    gen_set_pc_im(s, s->pc);
+    s->svc_imm = imm8;
+    s->base.is_jmp = DISAS_SWI;
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11758,10 +11776,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             goto undef;
 
         if (cond == 0xf) {
-            /* swi */
-            gen_set_pc_im(s, s->pc);
-            s->svc_imm = extract32(insn, 0, 8);
-            s->base.is_jmp = DISAS_SWI;
+            /* swi/svc  */
+            gen_thumb_swi(s, extract32(insn, 0, 8));
             break;
         }
         /* generate a conditional jump to next instruction */
-- 
2.20.1


