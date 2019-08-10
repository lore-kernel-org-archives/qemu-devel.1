Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A27DC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B8B2166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8o5cMtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B8B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIsy-0000Dj-Ih
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIku-0005iE-LW
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkt-0004M8-Ik
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkt-0004M1-Dn
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so140564862otk.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3geIlGl84SmXsN7QLZGdQ5xDPB0CYHN009O2rh5GH0=;
 b=g8o5cMtwLH/3rlUo8P0+TXPoJMsUmbiNrTLPhapYZKgJ9YLvLE/krKeaimB9bxNRud
 7qyfG6ZUadnCZFUzG/9zl/nasFliH9J3XKCRTZ1U/PdN53+5u7zgz7mP37XWb7XLKQBc
 PE2hM4tXyYncpdPzYznvAjVz8anHu+i43d5/Q1ZNLK+uD+MVwlpS5sVZkFDrh9Gzi7lX
 KV6GFOQfN68xYdtOpsU/yfyVVymYT4aWwdFuxNzh9JcUounXIIQSh0Uax6B6SP+ABLRq
 p4J/nOaPVDkr22G1J28QLEDEtxceb2Axru8G6iIvUgIFWbBuX317o6rc0Cyc3zPrUkpd
 YW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3geIlGl84SmXsN7QLZGdQ5xDPB0CYHN009O2rh5GH0=;
 b=rkHSNF2W+EvP4khV4IhJSyd1QkHoOOTIDROv77Gv1Ob9dJpzTBJF0FmSnVs/ZWDiXN
 anbJlKLS2QN6oDhIZGgW0VhjBtSX1ZnYqUq9MxXalj6J9HXy9Csi0SE6FqHvSBo63DRv
 HaAxr1BXE0CRChk1q2JLGXJSwDgJEZYtamfRnIbT3Q0lif3DKADzI6XZFuzbOEY+BYfu
 WjAzO7qgf1oe72xnrd4satTmpd0VR0ekU1mNrfaMdPv5c0ZbaRl99HiUdfLhsms2ycPr
 gZVvvJvoaLmgZAJAL6LZeX1P8jvt1h8JYjsAVeh7gTyTULhdtnVK1s6mREbwkC5PFf1i
 1HuA==
X-Gm-Message-State: APjAAAXtocdKeQ96A4Vr9tcnzl0em9ph19SnB6hdSww1NzXuDOLz2Xej
 g6aKIdNY5rA4s5hXgvPxNmVe2Yxo
X-Google-Smtp-Source: APXvYqzScN9WhUzRUZVxpJv+A+dva6x4oQEDJ5m46Z6y3Od7aRZ5I6cYiApdcyI27ne1MxFaijcMBQ==
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr18680189otl.330.1565410402661; 
 Fri, 09 Aug 2019 21:13:22 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:32 -0400
Message-Id: <20190810041255.6820-17-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 16/39] target/i386: introduce
 instruction operand infrastructure
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

insnop_t and the init, prepare and finalize functions form the basis
of instruction operand decoding. Introduce macros for defining a
generic instruction operand; use cases for operand decoding will be
introduced later with instruction translators.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 508d584584..109e4922eb 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4545,6 +4545,47 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
     }
 }
 
+/*
+ * Core instruction operand infrastructure
+ */
+#define insnop_t(opT)        insnop_ ## opT ## _t
+#define insnop_init(opT)     insnop_ ## opT ## _init
+#define insnop_prepare(opT)  insnop_ ## opT ## _prepare
+#define insnop_finalize(opT) insnop_ ## opT ## _finalize
+
+#define TYPEDEF_INSNOP_T(opT, type)             \
+    typedef type insnop_t(opT);
+#define INSNOP_INIT(opT, init_stmt)                                \
+    static int insnop_init(opT)(CPUX86State *env, DisasContext *s, \
+                                int modrm, insnop_t(opT) *op)      \
+    {                                                              \
+        init_stmt;                                                 \
+    }
+#define INSNOP_PREPARE(opT, prepare_stmt)                               \
+    static void insnop_prepare(opT)(CPUX86State *env, DisasContext *s,  \
+                                    int modrm, insnop_t(opT) *op)       \
+    {                                                                   \
+        prepare_stmt;                                                   \
+    }
+#define INSNOP_FINALIZE(opT, finalize_stmt)                             \
+    static void insnop_finalize(opT)(CPUX86State *env, DisasContext *s, \
+                                     int modrm, insnop_t(opT) *op)      \
+    {                                                                   \
+        finalize_stmt;                                                  \
+    }
+#define INSNOP(opT, type, init_stmt, prepare_stmt, finalize_stmt)       \
+    TYPEDEF_INSNOP_T(opT, type)                                         \
+    INSNOP_INIT(opT, init_stmt)                                         \
+    INSNOP_PREPARE(opT, prepare_stmt)                                   \
+    INSNOP_FINALIZE(opT, finalize_stmt)
+
+#define INSNOP_INIT_FAIL        return 1
+#define INSNOP_INIT_OK(x)       return ((*(op) = (x)), 0)
+#define INSNOP_PREPARE_NOOP     /* no-op */
+#define INSNOP_PREPARE_INVALID  g_assert_not_reached()
+#define INSNOP_FINALIZE_NOOP    /* no-op */
+#define INSNOP_FINALIZE_INVALID g_assert_not_reached()
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


