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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C62C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77882082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/adDrch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77882082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uyc-000437-Qe
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URC-00010V-55
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URA-0007JI-SP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:21 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:36299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URA-0007Io-Ml
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:20 -0400
Received: by mail-yb1-xb41.google.com with SMTP id m9so1348549ybm.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OvlCr4Wc0c1/xk8kLuYNb9twi6LI6UWMtiWdSenUQkk=;
 b=h/adDrchKBkmZ4ZEIGetv9Kiqj4y8CrBXpH3MOsPGs1wDMTiphC+QeM+E+7LgBQKQV
 p8cRXC7QaVTVtB+vlXOgtrGATjnEhto0ycR6NOY3YMDxOjb+tjYuC0Bk1/VJGEt5LNJV
 270AMsYgSTzW3hr0XBxPjWgPHKO2zCpKdz5mtJySkqhyYvHxNX5PV+CFIw1ptw5CFjwr
 AhNeSxAyf6xhJCmSmkVnRjWjQPqt4sTP+W5iQR/9mHcu0Y1JcDXfzXAokciXPHaetNoW
 dCgqWOcK4iOX1ZkEBMv/2YzDao/hihCah3+qtodzaryldUevLNWm+GytAghg4q6CGOmP
 XQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OvlCr4Wc0c1/xk8kLuYNb9twi6LI6UWMtiWdSenUQkk=;
 b=oXM5fyXs/DdKVexjnPfuBemT83yzCxBUgunWu+dSUuM0E+Eu6yXPKqQ+faxB7Ouh0H
 AfgNfgn4L/7REFQYrjfLrjyX4oyY0QESVfBKjAkRLawvn9LwQQaGAXXEs26/rX4cMX46
 L8vbSzGFjZwqnuU8Tj5gj2pL3Wqcjj4LZDo3tD4719I2SeDFJzEiXvr1MMS9yt5ibEem
 uSYCSK32CCDeEVyfSjFopBNm/PI/RBk+/SWICrAogTz6o2+qdlDxbPZw8V4f5gQC6/+c
 GAxqrm5sFYjQB2lmdk6tmaXXBu95RdVkhM65HWpBbyc5hsnN7FUWiVAQ2PeSsmBlkDOU
 cQaw==
X-Gm-Message-State: APjAAAUsvcVHnWHUqclF6yP9VPcykqkbk6Pu9gBKecu6kL5UNR40yd6W
 RCJTamWXhWwjEUN9lHIlLJwSjUGw
X-Google-Smtp-Source: APXvYqxhpWvTkDuBKP3wUwfM8duau9BLvQh6Hy1AbFW78p1WS+z7Psx/JhZWlH2BGBa1u8XV6c83Tg==
X-Received: by 2002:a25:8001:: with SMTP id m1mr22787580ybk.66.1566408620088; 
 Wed, 21 Aug 2019 10:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:19 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:55 -0400
Message-Id: <20190821172951.15333-20-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 19/75] target/i386: introduce generic
 either-or operand
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

The either-or operand attempts to decode one operand, and if it fails,
it falls back to a second operand. It is unifying, meaning that
insnop_arg_t of the second operand must be implicitly castable to
insnop_arg_t of the first operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a6f23bae4e..68c6b7d16b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4626,6 +4626,50 @@ static bool check_cpuid(CPUX86State *env, DisasContext *s, CheckCpuidFeat feat)
         insnop_finalize(opT2)(ctxt, env, s, modrm, is_write, arg);      \
     }
 
+/*
+ * Generic unifying either-or operand
+ */
+#define DEF_INSNOP_EITHER(opT, opT1, opT2)                              \
+    typedef insnop_arg_t(opT1) insnop_arg_t(opT);                       \
+    typedef struct {                                                    \
+        bool is_ ## opT1;                                               \
+        union {                                                         \
+            insnop_ctxt_t(opT1) ctxt_ ## opT1;                          \
+            insnop_ctxt_t(opT2) ctxt_ ## opT2;                          \
+        };                                                              \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        if (insnop_init(opT1)(&ctxt->ctxt_ ## opT1,                     \
+                              env, s, modrm, is_write)) {               \
+            ctxt->is_ ## opT1 = true;                                   \
+            return true;                                                \
+        }                                                               \
+        if (insnop_init(opT2)(&ctxt->ctxt_ ## opT2,                     \
+                              env, s, modrm, is_write)) {               \
+            ctxt->is_ ## opT1 = false;                                  \
+            return true;                                                \
+        }                                                               \
+        return false;                                                   \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        return (ctxt->is_ ## opT1                                       \
+                ? insnop_prepare(opT1)(&ctxt->ctxt_ ## opT1,            \
+                                       env, s, modrm, is_write)         \
+                : insnop_prepare(opT2)(&ctxt->ctxt_ ## opT2,            \
+                                       env, s, modrm, is_write));       \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+        (ctxt->is_ ## opT1                                              \
+         ? insnop_finalize(opT1)(&ctxt->ctxt_ ## opT1,                  \
+                                 env, s, modrm, is_write, arg)          \
+         : insnop_finalize(opT2)(&ctxt->ctxt_ ## opT2,                  \
+                                 env, s, modrm, is_write, arg));        \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


