Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B08C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FE222CF5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfbUbqj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FE222CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31HI-0004wF-9z
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C7-0007es-HA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C3-0000py-FR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31C3-0000oY-4r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so510795wrd.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AnLfjJ532pnrQLEmB2HlY+ej0qh5jfVOAVC2UPBUj4M=;
 b=WfbUbqj16CnAz/CEkYfPWA1keOmaBBfTX527aWNTS/xEcaL+eD3EYrQ9F19uvOTOzV
 TbCT/0lqk0y1GvwYlFRJH5DxnZV3vLSNsg4od3tmoBWbxN2EKLLB7LL8Njy35/gbWY9E
 L7yF3+X3ViwEw9zgqX6/1TI3bG3mr1dY4PHcy1ako0BTgDu3GjpgL0xWde/e2VJcQX3D
 imJ3inP32Pzg8F2LQX55Yf+o7SrqGXKbNPOmxSZ3gX3/WAd7RT1bKQjIBPL8Mgn4XoAB
 FcRHoZkPtAtGqFTD2egFKK73uYhFDKaKOyQR1RDhmz1CraVk9EoeYIUsabELxkrzpkaJ
 OrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AnLfjJ532pnrQLEmB2HlY+ej0qh5jfVOAVC2UPBUj4M=;
 b=PSrFxH1fwjZby6DjFO/DMFP1DYUBF9ek9jqCn2kXMJxzZ4+FsdqeupO2MIqmZssguM
 jvetFe33/NsK0pSmWwJEIQrH2P1rt0aN0sgm1Gu3XZZ6FxPooVZIY821tI0FuKebgYVn
 pAl19FgFUZc68kPb92Jf5B4Z2d4o9FBUvYc1T8APzrlnpD+0yCzRDQvH/RB9RQCCedSF
 ZQS3kNMekn58yju5+LxwhGi/O7N+12R3kQ+rPuGw/9xWpcBqdDmbUD0zfRGMAsu/7tbh
 19F1N2AidHnxqEkJhJiaMR7VheFlMOHFZ5GZgb8St/jtFQ4xDomiup9aW0WFqsTTjNUl
 psTQ==
X-Gm-Message-State: APjAAAXrtrZn201N6kEAr33nJ+vaDE5CGY9oksBGQlVhXQ3e4WduwIya
 GgmN3qlmK1rUr8cIurrz06I0GQ==
X-Google-Smtp-Source: APXvYqxCAP62wNcILBT5WJZLrIKQRjeW0ovq81NK0fCq5HeidRyR7V2/L2jQkey/QlW/cImFYQ3uAg==
X-Received: by 2002:adf:a415:: with SMTP id d21mr2253900wra.94.1567011190025; 
 Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n12sm3391799wmc.24.2019.08.28.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 908201FF8F;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:53:00 +0100
Message-Id: <20190828165307.18321-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 2/9] target/arm: handle A-profile T32
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
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
 target/arm/translate.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 259c4669b4c..6157e9f52fc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10907,6 +10907,24 @@ static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
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
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
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
@@ -11658,10 +11676,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


