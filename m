Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984DC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A8722CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6FI0Ztt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TP6-0001xu-Tv
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLe-00075u-0V
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLc-0007CP-E4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5TLc-0007Ap-5Q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id g7so20864871wrx.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Ge+XWvDG5sVV+m6AqlxOZT4JsJcjtpuvEGkiH2jJk8=;
 b=O6FI0ZttUEpi5a4oug0HoQfV6DRGdNK+GZszcdX5dQF7NiZt0pYxYhxgVbqMM7szEh
 frWqJBi/TEbAPrEojO2s3c2R1Xly5GoLYZMl8KpSkwPBxWnPH9V5DCzPc5067bijH+7k
 3pqZnv1W3FkdEVv9Nl3fshQRD/btVt+4ODDYxm5uxoY4SfGFzp3GNEweO5rZPOWyamXJ
 /pcBveE8CUAS4k8IhfBL+5Z77kfRE4WXsXK622CTPiOrHxuOt9dr1WX5qcyiR9NB7kq6
 jDNpOdas04QvODYmb/QNgcsawpvCA/hl2B8DL1swVHIbhPO9f5yXIoXd+dqMqHrfAUYc
 Xz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Ge+XWvDG5sVV+m6AqlxOZT4JsJcjtpuvEGkiH2jJk8=;
 b=I9/X7Aj7VFV+g6sp4eH2hNUBxe0sXIkFMqL85WhN9053SfAIhl5jett1Ez6/NrvFhW
 UOuPkvbfqxwVcMH/GVfQLzUM20jg++7j407dsMnPvzzS+JL6djWhM2QyEkIe7FGSKLXV
 dxzPYDJnxPHsouKWkzpAJtzhmEbIU83lROkBTK6Mxs+hnogWrURkgDl/c+umQ+s58U3C
 FDV6nqTZ2dSA72eDhSjAcAQUdBWSSY0zXbpdomISPuCCLzAO7TSRYZYm4Zvl9b8ckHOL
 UHrMydPWJmXT/BGPKIbXkQwXdiXFscvMLbD00qx9sb6mgjqs8MnPDolh39k3Yy3op3uZ
 qULw==
X-Gm-Message-State: APjAAAVjrCP5Z0Z9lKAFtKyrO/oEzrtREXjZtiXRDaXKu/JhIRdhIhEx
 mjvTtoDxAWsXt1jabcMy8lJ6JQ==
X-Google-Smtp-Source: APXvYqwlKadfVsjIOAoPStal5zo8aeWOPbDSSAco0c4AsV8rkYUNhaYEksSW8u9OyBsklS1yC6nylw==
X-Received: by 2002:adf:a382:: with SMTP id l2mr46472685wrb.194.1567596070494; 
 Wed, 04 Sep 2019 04:21:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm27729634wrh.28.2019.09.04.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:21:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 388951FF8F;
 Wed,  4 Sep 2019 12:21:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:21:05 +0100
Message-Id: <20190904112108.2341-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904112108.2341-1-alex.bennee@linaro.org>
References: <20190904112108.2341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 2/5] target/arm: handle A-profile T32
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
---
 target/arm/translate.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 816d46b2205..673994ed1a1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10949,6 +10949,24 @@ static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
     gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm8, true));
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
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        return;
+    }
+    gen_set_pc_im(s, s->base.pc_next);
+    s->svc_imm = imm8;
+    s->base.is_jmp = DISAS_SWI;
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11700,10 +11718,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             goto undef;
 
         if (cond == 0xf) {
-            /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 8);
-            s->base.is_jmp = DISAS_SWI;
+            /* swi/svc  */
+            gen_thumb_swi(s, extract32(insn, 0, 8));
             break;
         }
         /* generate a conditional jump to next instruction */
-- 
2.20.1


