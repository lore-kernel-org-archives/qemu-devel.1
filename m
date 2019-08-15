Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFAC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8F22084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkuDXAAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8F22084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Kh-0006gY-QV
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DX-0006Ba-Aj
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DV-0008Vg-8U
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DV-0008S5-4F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:17 -0400
Received: by mail-yb1-xb42.google.com with SMTP id u32so388382ybi.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aji6f42Pqo1laNwakKXwsr+VmwLnCcurcKsMvdCVjcw=;
 b=ZkuDXAAqe9iGdX+lqbUGSqoU6JpHSBfNxV8J8llQJHt7/UD9CduwzV4ITo9iCImT7M
 gdwnL7mHSag65jlGZ5rLSj3l5MGeXQv6yatdK7Bth/kkXZ93HBT1p72lXYsRE/h3SmRp
 hI93KcOHzxvFA4l9GgeTywWRUz6jjr6RGuQXgRytodmbrtrgv7ZndFc24VgWmy4kZQbw
 NoEidRUyXFRP84/uEEEL7QaiKOIyGsHDgWgBGeSQfVa4fFZRKqiResNrzdA1OcoZnIj3
 87mQaI0LRMfY/Wx7/4gmiJiTdY9RWIwGP6h8BrJ+7FUIQrX3GbBqbMIx9d5lYL89Gn1k
 3c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aji6f42Pqo1laNwakKXwsr+VmwLnCcurcKsMvdCVjcw=;
 b=IzQc6AS30Tw0LkjPBCzeXYk4ezNG7KhNdF1gW9OZkMUQUOCT7nsNoTrPsxRLP8ux6X
 +8m7eXEcO0x0jdI40+DKvvqwpOW6/cXuNDi021RKi61cWSY31U+Azpq3FgIO+mTxxs66
 RKYnbRVT3GaD/VyTZJ4IqzMqZOHeEjN0itr833JcqPrRysch+Sc4HInJZpBHoALLBKtk
 LhwiBMNYVjeuBe1+ASy6GrCrlySPmaU+rQ44IfujDTrLQ8hyl0tT3EE2uxdVQ2TPKdpI
 krLPafZ/DiysvQ6qIvU9ez95ABGtd70Dhi1ML+CYY2pawdWAJeLAQAvuI5RYDIkIfSwy
 nfFw==
X-Gm-Message-State: APjAAAXK6WkhAN8Ztd6NWevgeX4EQZXiUyuOfojxPZ48oANt4JgVLBYB
 NRduXC3U31teVCGJQAs7iJ9eoDW4
X-Google-Smtp-Source: APXvYqzBy5nDIj0GpEbjrj9z6rx6ql0Xew8ZwlXsw3Rn3HBj/1nQzgoas+xDtK/vF6c6c9iGnUDCLQ==
X-Received: by 2002:a5b:e87:: with SMTP id z7mr1918014ybr.5.1565835015043;
 Wed, 14 Aug 2019 19:10:15 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:14 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:04 -0400
Message-Id: <20190815020928.9679-23-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 22/46] target/i386: introduce operands
 for decoding modrm fields
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old code uses bitshifts and bitwise-and all over the place for
decoding ModR/M fields. Avoid doing that by introducing proper
decoding operands.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 25c25a30fb..e4515e81df 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4760,6 +4760,68 @@ INSNOP_FINALIZE(modrm)
 {
 }
 
+/*
+ * modrm_mod
+ *
+ * Operand whose value is the MOD field of the ModR/M byte.
+ */
+typedef int insnop_arg_t(modrm_mod);
+typedef struct {} insnop_ctxt_t(modrm_mod);
+
+INSNOP_INIT(modrm_mod)
+{
+    return 0;
+}
+INSNOP_PREPARE(modrm_mod)
+{
+    return (modrm >> 6) & 3;
+}
+INSNOP_FINALIZE(modrm_mod)
+{
+}
+
+/*
+ * modrm_reg
+ *
+ * Operand whose value is the REG field of the ModR/M byte, extended
+ * with the REX.R bit if REX prefix is present.
+ */
+typedef int insnop_arg_t(modrm_reg);
+typedef struct {} insnop_ctxt_t(modrm_reg);
+
+INSNOP_INIT(modrm_reg)
+{
+    return 0;
+}
+INSNOP_PREPARE(modrm_reg)
+{
+    return ((modrm >> 3) & 7) | REX_R(s);
+}
+INSNOP_FINALIZE(modrm_reg)
+{
+}
+
+/*
+ * modrm_rm
+ *
+ * Operand whose value is the RM field of the ModR/M byte, extended
+ * with the REX.B bit if REX prefix is present.
+ */
+typedef int insnop_arg_t(modrm_rm);
+typedef struct {} insnop_ctxt_t(modrm_rm);
+
+INSNOP_INIT(modrm_rm)
+{
+    return 0;
+}
+INSNOP_PREPARE(modrm_rm)
+{
+    return (modrm & 7) | REX_B(s);
+}
+INSNOP_FINALIZE(modrm_rm)
+{
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


