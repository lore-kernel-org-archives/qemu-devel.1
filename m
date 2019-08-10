Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93262217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtvzrO5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93262217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIuJ-0003Y3-Er
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIky-0005vn-FN
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkx-0004Nf-Cf
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkx-0004NU-7v
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id l15so140514689otn.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uta9ArntGI4TyKGIhn9+xSKs0zFnFU+lVjX12nvNzmE=;
 b=MtvzrO5m//97TpKLwJ8WbiaNGE2Gvl99knQ59BLDZ4TsvRkCOjbxXhq8CsAIfgfjCa
 y82rxFSKpKOdyNSQob5mH0e0gV+0tTC32iuIqDSFTYAb6VLBP3A2L2lpp29XaBnYydAh
 AXUB175pCcEUkAUTvo5l53cg3H3nBo2oC+4WYm7i8i2JjKcUHTkL9uK3lzxeqXqe9r6E
 vANn8q1bInaQ+hPpos0gOwQHYHPpODC57ae0H0E7QhT8BflYYFWFJo0ENLQ+w39Ora/T
 q9jKRACRyGw3O/9adR3G87m2+RBSrGI40un7WoGejxLqSk7+HLOmaaxJSrbyY4roi7VA
 mpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uta9ArntGI4TyKGIhn9+xSKs0zFnFU+lVjX12nvNzmE=;
 b=LqXfgcRpG7pkl0ulnsQBuJuEpePoGWXoIAbOa22W71hQJtYvbsslBLIrK/JCzWfw4a
 oxTj5PMdBuTiriHGzYaXlyzpjXTBkNYYbUDE6RoNtAO0pw1d5eCWRhgZMMhUYLE0j5Zw
 e2i7Ea3POgfu8L+drn8cN331AvmVgzAc4sjGp9Hez0wW5XRXiWPb9l8tkMyquZhA3j1W
 GlGxUxpEupYspNowUi2eYeUc6EjZDJmR0qacvW0oZ5YuKTUUZOnxgPJixRWPl5Bo4f7n
 czoO6J8XIe1np85DajY3EJUAHuVb4E/I8VFQkzjs4AG4dMfpnfKfhDrhEKyeH8Mto/zi
 u3VQ==
X-Gm-Message-State: APjAAAUIeYM9xyGE1BOl6sr0QXE12dpIV1d7JA8VJdKpzCzZpoDjRcfs
 In4Js39hERhlwiZ4vujXFJFchL7V
X-Google-Smtp-Source: APXvYqyUdkZSbEp1tbpwmXREPxct8h0ydApSHG4PjJI2SECNU5Z5Bz49MEu9KmK9zgIqsvEtiIzm1g==
X-Received: by 2002:a05:6830:11d7:: with SMTP id
 v23mr10443218otq.58.1565410406542; 
 Fri, 09 Aug 2019 21:13:26 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:26 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:36 -0400
Message-Id: <20190810041255.6820-21-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 20/39] target/i386: introduce generic
 load-store operand
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

This operand attempts to capture the "indirect" or "memory" operand in
a generic way. It significatly reduces the amount code that needs to
be written in order to read operands from memory to temporary storage
and write them back.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 78 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index cd2467e6a5..ebb68fef0b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4619,6 +4619,84 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
            insnop_prepare(opT2)(env, s, modrm, op),           \
            insnop_finalize(opT2)(env, s, modrm, op))
 
+/*
+ * "Load-store" operand helper
+ */
+#define INSNOP_LDST(opT, opTr, opTm, scratch_op, ld_stmt, st_stmt)      \
+    INSNOP(                                                             \
+        opT,                                                            \
+        struct {                                                        \
+            bool is_mem;                                                \
+            insnop_t(opTr) op_reg;                                      \
+        },                                                              \
+        do {                                                            \
+            insnop_t(opTr) reg;                                         \
+            insnop_t(opTm) ptr;                                         \
+            if (!insnop_init(opTr)(env, s, modrm, &reg)) {              \
+                op->is_mem = 0;                                         \
+                op->op_reg = reg;                                       \
+                INSNOP_INIT_OK(*op);                                    \
+            } else if (!insnop_init(opTm)(env, s, modrm, &ptr)) {       \
+                op->is_mem = 1;                                         \
+                op->op_reg = (scratch_op);                              \
+                INSNOP_INIT_OK(*op);                                    \
+            }                                                           \
+            INSNOP_INIT_FAIL;                                           \
+        } while (0),                                                    \
+        do {                                                            \
+            insnop_t(opTr) reg = op->op_reg;                            \
+            if (op->is_mem) {                                           \
+                insnop_t(opTm) ptr;                                     \
+                const int ret = insnop_init(opTm)(env, s, modrm, &ptr); \
+                assert(!ret);                                           \
+                                                                        \
+                insnop_prepare(opTm)(env, s, modrm, &ptr);              \
+                ld_stmt;                                                \
+            } else {                                                    \
+                insnop_prepare(opTr)(env, s, modrm, &reg);              \
+            }                                                           \
+        } while (0),                                                    \
+        do {                                                            \
+            insnop_t(opTr) reg = op->op_reg;                            \
+            if (op->is_mem) {                                           \
+                insnop_t(opTm) ptr;                                     \
+                const int ret = insnop_init(opTm)(env, s, modrm, &ptr); \
+                assert(!ret);                                           \
+                                                                        \
+                insnop_prepare(opTm)(env, s, modrm, &ptr);              \
+                st_stmt;                                                \
+            } else {                                                    \
+                insnop_finalize(opTr)(env, s, modrm, &reg);             \
+            }                                                           \
+        } while (0))
+
+#define INSNOP_LDST_UNIFY(opT, opTr, opTrm)                             \
+    INSNOP(                                                             \
+        opT, insnop_t(opTr),                                            \
+        do {                                                            \
+            insnop_t(opTrm) rm;                                         \
+            if (!insnop_init(opTrm)(env, s, modrm, &rm)) {              \
+                INSNOP_INIT_OK(rm.op_reg);                              \
+            }                                                           \
+            INSNOP_INIT_FAIL;                                           \
+        } while (0),                                                    \
+        do {                                                            \
+            insnop_t(opTrm) rm;                                         \
+            const int ret = insnop_init(opTrm)(env, s, modrm, &rm);     \
+            assert(!ret);                                               \
+                                                                        \
+            rm.op_reg = *op;                                            \
+            insnop_prepare(opTrm)(env, s, modrm, &rm);                  \
+        } while (0),                                                    \
+        do {                                                            \
+            insnop_t(opTrm) rm;                                         \
+            const int ret = insnop_init(opTrm)(env, s, modrm, &rm);     \
+            assert(!ret);                                               \
+                                                                        \
+            rm.op_reg = *op;                                            \
+            insnop_finalize(opTrm)(env, s, modrm, &rm);                 \
+        } while (0))
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


