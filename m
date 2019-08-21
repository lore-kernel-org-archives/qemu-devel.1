Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37140C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B1C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWiBNTd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B1C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V7v-0000IP-EG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URN-0001Hm-Lb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URM-0007fO-Cs
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:33 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URM-0007er-8n
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:32 -0400
Received: by mail-yb1-xb43.google.com with SMTP id j199so1342652ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dia+2E+EwYAIeEy7FxR5qqk5fG2xeAyDdIAC0jw1NTM=;
 b=JWiBNTd16MADRhgW46cOm2MlooHPX4hMZYubOZ0ugPdCwCLiQDIK+L9jUX6L6QkpgP
 OrtIWwFSeQqKNITmUifj40UgILJNZX8er6iWkzeYwaJ5FcynEf+ZlCHUE3vyb7P86W30
 mAWpYHBxMd1SwyZEVvEVVCzgDQrft2r1I6YBijQWLnaLq9HtBcRY1G9RVaqRXVdIZXZ3
 KgKsP64HwxhRepHk8neERUmq4NFvbeocLL4j7QgjA/mDA/320WuwE9O9Ih7AXvED7SZP
 HtljJu9CWQ+j4gXnZjAyNHcDMRDx9iiMx9b/+mYTl5zJQwCmloHx6BmKsvqzZQ8akfc1
 HZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dia+2E+EwYAIeEy7FxR5qqk5fG2xeAyDdIAC0jw1NTM=;
 b=HQ0Mr13ThTai7wUic7qpLdWILxqNt1PsnJX6CgxplLpu1X4dM4yr3di3IB88Msk0fW
 T7ubBshh2qtDPuyoXI7UFK4A1PDsJl28Phdw6eBeFBwXBJF/fOvzDSxzduxVlMbv0NFB
 WK86+6EEqlW/5OzBc1f2mtr2iPSsEYlaUa6D7R7WjtMVxpCwtbr4CwKBt6s+W7EBntk5
 kxPawHXEzJwN5ZJnQ+5rlHbLY2Z5WEBe7sGxdYvcipziGuUD2zZbb8qXNF/5VAZNPqpL
 WbH8gpcL364GOj7klmJbPRNxcbFKfsqKTpv/81e1cecb2ER7Cwio9HUj4xMmZeUgORDk
 KfCg==
X-Gm-Message-State: APjAAAV36Q2ox+VA3biv9XIaz0xMfdFrhyMBPrZTZQ5sNw/OQ3zD+4GN
 hll6L+6ufhnkROcS8wogi49fUhCN
X-Google-Smtp-Source: APXvYqw6yLoc8zhpFYnYp9nTixCzdjKR9JpvyHtwfv8WcGn3geWfP6pV0pRHWybs4BqmoexZHD24Ng==
X-Received: by 2002:a25:587:: with SMTP id 129mr25651564ybf.121.1566408631621; 
 Wed, 21 Aug 2019 10:30:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:31 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:07 -0400
Message-Id: <20190821172951.15333-32-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 31/75] target/i386: introduce code
 generators
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

In this context, "code generators" are functions that receive decoded
instruction operands and emit TCG ops implementing the correct
instruction functionality. Introduce the naming macros first, actual
generator macros will be added later.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 2e78bed78f..603a5b80a1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5331,6 +5331,52 @@ INSNOP_LDST(xmm, Mhq)
     tcg_temp_free_i64(r64);
 }
 
+/*
+ * Code generators
+ */
+#define gen_insn(mnem, argc, ...)               \
+    glue(gen_insn, argc)(mnem, ## __VA_ARGS__)
+#define gen_insn0(mnem)                         \
+    gen_ ## mnem ## _0
+#define gen_insn1(mnem, opT1)                   \
+    gen_ ## mnem ## _1 ## opT1
+#define gen_insn2(mnem, opT1, opT2)             \
+    gen_ ## mnem ## _2 ## opT1 ## opT2
+#define gen_insn3(mnem, opT1, opT2, opT3)       \
+    gen_ ## mnem ## _3 ## opT1 ## opT2 ## opT3
+#define gen_insn4(mnem, opT1, opT2, opT3, opT4)         \
+    gen_ ## mnem ## _4 ## opT1 ## opT2 ## opT3 ## opT4
+#define gen_insn5(mnem, opT1, opT2, opT3, opT4, opT5)           \
+    gen_ ## mnem ## _5 ## opT1 ## opT2 ## opT3 ## opT4 ## opT5
+
+#define GEN_INSN0(mnem)                         \
+    static void gen_insn0(mnem)(                \
+        CPUX86State *env, DisasContext *s)
+#define GEN_INSN1(mnem, opT1)                   \
+    static void gen_insn1(mnem, opT1)(          \
+        CPUX86State *env, DisasContext *s,      \
+        insnop_arg_t(opT1) arg1)
+#define GEN_INSN2(mnem, opT1, opT2)                             \
+    static void gen_insn2(mnem, opT1, opT2)(                    \
+        CPUX86State *env, DisasContext *s,                      \
+        insnop_arg_t(opT1) arg1, insnop_arg_t(opT2) arg2)
+#define GEN_INSN3(mnem, opT1, opT2, opT3)                       \
+    static void gen_insn3(mnem, opT1, opT2, opT3)(              \
+        CPUX86State *env, DisasContext *s,                      \
+        insnop_arg_t(opT1) arg1, insnop_arg_t(opT2) arg2,       \
+        insnop_arg_t(opT3) arg3)
+#define GEN_INSN4(mnem, opT1, opT2, opT3, opT4)                 \
+    static void gen_insn4(mnem, opT1, opT2, opT3, opT4)(        \
+        CPUX86State *env, DisasContext *s,                      \
+        insnop_arg_t(opT1) arg1, insnop_arg_t(opT2) arg2,       \
+        insnop_arg_t(opT3) arg3, insnop_arg_t(opT4) arg4)
+#define GEN_INSN5(mnem, opT1, opT2, opT3, opT4, opT5)           \
+    static void gen_insn5(mnem, opT1, opT2, opT3, opT4, opT5)(  \
+        CPUX86State *env, DisasContext *s,                      \
+        insnop_arg_t(opT1) arg1, insnop_arg_t(opT2) arg2,       \
+        insnop_arg_t(opT3) arg3, insnop_arg_t(opT4) arg4,       \
+        insnop_arg_t(opT5) arg5)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


