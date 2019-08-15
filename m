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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE0C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19F5206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dha9cR2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Za-0007xN-TB
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DU-00069h-UK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-0008Qa-Lq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:16 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:44238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DR-0008Ob-1S
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:13 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l79so286292ywe.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dl8bYnb0udmn0qx43U7Smy53dg0Al6b+NL/33M408sA=;
 b=dha9cR2TPgyGZWAykDdhOIz2SBCbV+XqlGBsd6MJw0FwFjQICs2htrVPhrnT4AGvj/
 CflOKsE67JiCmhHWNsgjj9r9kesr+S4EdiM6m/c+d2pJ9mMM3c5ZXr9bC5HkaQi4gi1C
 +ow9e+bk1GSITSm6Lbz7n3FB0FTEaNoqVyndv4ip2HTFhe9ZakqNvQwftxpGHqG9Zukx
 P+cDLru/ydFhEVyggTgyLTXkrDkQjcediBdKfM1x7IQLOBm7BjPC9fTAjgaIiVYuYk8F
 TMiF9OY79SUBxd6xFtN7L2YicO+x7vmgmezttS0+hNVtYw/SXJbLmS6UoatEacARgeAo
 IWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dl8bYnb0udmn0qx43U7Smy53dg0Al6b+NL/33M408sA=;
 b=VIeCFLM/9+2y0icdXzfzCdUzkHJR8rk8gkJKfu/NOl9J+jXl07Do0/Jra05lIbXoW7
 n78QFhC1dw3mnYFGszB66gTxbVSuKkqYCgF7Wrw3WIWTHeE1y8dvqCd7sgSN8rkmkXGe
 /n8mzkqt0xdpda+sNMzJFRlKVq9FvzW0401X06WNUe0aYeU42ygvNXoVffLLspjetGIj
 OBSzTG60AonWyrGq/nmXKemF/Xwqi5fy0xq0QfKBDHN5kXAIoWtJrvZ7gcoWj1sTtF3x
 CxlB+GXPYkMljlRXGltfaM0JiGIwj/6OBXDMc4UaB7tZWV0xjFLVq/rJ66NFqoirTYtV
 tqcA==
X-Gm-Message-State: APjAAAUK6FVWj9IMlQ3LH541R2Vv6xWzPFvjhYR3nzN6wIi+7IyS0ep5
 1ALCrdSQ3Va58vO57vgIBIkbaSyO
X-Google-Smtp-Source: APXvYqyh58TKjwViBS5L+7g+o/wt0EAnCTT5KvrNoaHtJ+lblJxOjnZ8buTQdDYWY3z1anv6Dk10CQ==
X-Received: by 2002:a81:9889:: with SMTP id p131mr1559360ywg.127.1565835012370; 
 Wed, 14 Aug 2019 19:10:12 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:11 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:01 -0400
Message-Id: <20190815020928.9679-20-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 19/46] target/i386: introduce generic
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
 target/i386/translate.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a0b883c680..99f46be34e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4642,6 +4642,60 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
                                  env, s, modrm, is_write, arg));        \
     }
 
+/*
+ * Generic load-store operand
+ */
+#define insnop_ldst(opTarg, opTptr)             \
+    insnop_ldst_ ## opTarg ## opTptr
+
+#define INSNOP_LDST(opTarg, opTptr)                                     \
+    static void insnop_ldst(opTarg, opTptr)(CPUX86State *env,           \
+                                            DisasContext *s,            \
+                                            int modrm, bool is_write,   \
+                                            insnop_arg_t(opTarg) arg,   \
+                                            insnop_arg_t(opTptr) ptr)
+
+#define DEF_INSNOP_LDST(opT, opTarg, opTptr)                            \
+    typedef insnop_arg_t(opTarg) insnop_arg_t(opT);                     \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTarg) arg;                                      \
+        insnop_ctxt_t(opTptr) ptr;                                      \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    /* forward declaration */                                           \
+    INSNOP_LDST(opTarg, opTptr);                                        \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        int ret = insnop_init(opTarg)(&ctxt->arg, env, s, modrm, is_write); \
+        if (!ret) {                                                     \
+            ret = insnop_init(opTptr)(&ctxt->ptr, env, s, modrm, is_write); \
+        }                                                               \
+        return ret;                                                     \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTarg) arg =                                \
+            insnop_prepare(opTarg)(&ctxt->arg, env, s, modrm, is_write); \
+        if (!is_write) {                                                \
+            const insnop_arg_t(opTptr) ptr =                            \
+                insnop_prepare(opTptr)(&ctxt->ptr, env, s, modrm, is_write); \
+            insnop_ldst(opTarg, opTptr)(env, s, modrm, is_write, arg, ptr); \
+            insnop_finalize(opTptr)(&ctxt->ptr, env, s, modrm, is_write, ptr); \
+        }                                                               \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+        if (is_write) {                                                 \
+            const insnop_arg_t(opTptr) ptr =                            \
+                insnop_prepare(opTptr)(&ctxt->ptr, env, s, modrm, is_write); \
+            insnop_ldst(opTarg, opTptr)(env, s, modrm, is_write, arg, ptr); \
+            insnop_finalize(opTptr)(&ctxt->ptr, env, s, modrm, is_write, ptr); \
+        }                                                               \
+        insnop_finalize(opTarg)(&ctxt->arg, env, s, modrm, is_write, arg); \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


