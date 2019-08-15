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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD375C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97234208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/JjnCGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97234208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5fO-0008Hp-6Q
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0006HV-0r
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Db-0000CA-33
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:24 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DZ-00009Z-5W
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: by mail-yb1-xb43.google.com with SMTP id x10so388132ybs.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KTZS4tJ/LSxPvJ6feZUj0bPHzSOsx4OeZQC9Z8aW7OI=;
 b=s/JjnCGu7gTqBtb8b9W5KNiFaJ8lDMBoYNolIyiCDx4ECgyerucFHVKSmPKYiw4JRW
 hnVJHR4tSZe/VuMaEOrC8QvACDx5Q1+3RlapamAbpHCc3U6f3BKNxcO/c/EDeV1j/qRi
 g5Sd5hvO/phf+HuM+Ar04lRnUzOWHuX3va3ulYzV24Cb6hTJAPZbfiRaQyyJpYaeYVLE
 c7/bDTxVojEuLkgUPPF49n+Jv61v+h+nnKMUfswQ90L9n079aFt69ZuQQSWChF46D4KO
 KjlnVUtdGNtoBtzNnSLAgZwsDmRasOJwkJUfo3Nha3wTCMH4ui9MGNorFhSGRHVLutRC
 DmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KTZS4tJ/LSxPvJ6feZUj0bPHzSOsx4OeZQC9Z8aW7OI=;
 b=gvmG/0wB9/M7u6KGMlDNWbj8pMxnhyFNLhHBkMI2xRTnvWYpol5/PtuhCrRnlZvlko
 BhHYK0pIEHIoOsEFfb7LzdFje4wUmSN6LrJt9RTsUaYG/FkYXkwTKEX53gkGTJcQwHct
 ZLmdKdtJTSwd1AMO0jxOJy8pOaziXcpCUJEvWrWmzhTpu+gTjrO62GVIseEjfZEyV7g7
 gVCdNAbcRvPMAbVlWGBWDhjyLB1jhL1Cn0cP4GpY0RqsJRdTv7g3fETc6d7IfESH/6D7
 GoyZuJH+qe9NbYgP/hVxrDKySTDJ4lyigd9lCH6AfJ4gDd/nPi3Hc0GQYDy2VtqxgQwT
 04Wg==
X-Gm-Message-State: APjAAAWx+evZ+rFr3SMCl7gtO6RlfUwflCfyBTPDVwdy0o3J8HrUwLMz
 Gshnua+MwR+F/I72NAxnbmeiysxd
X-Google-Smtp-Source: APXvYqyWdLgsGoSKBSLs0/fiRBsVYDjbcZNnvIhxHsY8u9bxNHNjn60uYKS2EOqlIUpzv/FOlKd1jQ==
X-Received: by 2002:a5b:642:: with SMTP id o2mr2107309ybq.70.1565835020296;
 Wed, 14 Aug 2019 19:10:20 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:19 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:10 -0400
Message-Id: <20190815020928.9679-29-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v3 28/46] target/i386: introduce P*, N*,
 Q* (MMX) operands
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

These address the MMX-technology register file; the corresponding
cpu_env offset is passed as the operand value. Notably, offset of the
entire register is pased at all times, regardless of the operand-size
suffix.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 79 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 779b692942..bd3c7f9356 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5011,6 +5011,85 @@ INSNOP_LDST(tcg_temp_i64, Mq)
     }
 }
 
+/*
+ * MMX-technology register operands
+ */
+#define DEF_INSNOP_MM(opT, opTmmid)                                     \
+    typedef unsigned int insnop_arg_t(opT);                             \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTmmid) mmid;                                    \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        return insnop_init(opTmmid)(&ctxt->mmid, env, s, modrm, is_write); \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTmmid) mmid =                              \
+            insnop_prepare(opTmmid)(&ctxt->mmid, env, s, modrm, is_write); \
+        const insnop_arg_t(opT) arg =                                   \
+            offsetof(CPUX86State, fpregs[mmid & 7].mmx);                \
+        insnop_finalize(opTmmid)(&ctxt->mmid, env, s, modrm, is_write, mmid); \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+    }
+
+typedef unsigned int insnop_arg_t(mm_t0);
+typedef struct {} insnop_ctxt_t(mm_t0);
+
+INSNOP_INIT(mm_t0)
+{
+    return 0;
+}
+INSNOP_PREPARE(mm_t0)
+{
+    return offsetof(CPUX86State, mmx_t0);
+}
+INSNOP_FINALIZE(mm_t0)
+{
+}
+
+DEF_INSNOP_MM(P, modrm_reg)
+DEF_INSNOP_ALIAS(Pd, P)
+DEF_INSNOP_ALIAS(Pq, P)
+
+DEF_INSNOP_MM(N, modrm_rm_direct)
+DEF_INSNOP_ALIAS(Nd, N)
+DEF_INSNOP_ALIAS(Nq, N)
+
+DEF_INSNOP_LDST(MQd, mm_t0, Md)
+DEF_INSNOP_LDST(MQq, mm_t0, Mq)
+DEF_INSNOP_EITHER(Qd, Nd, MQd)
+DEF_INSNOP_EITHER(Qq, Nq, MQq)
+
+INSNOP_LDST(mm_t0, Md)
+{
+    const insnop_arg_t(mm_t0) ofs =
+        offsetof(MMXReg, MMX_L(0));
+
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_std_env_A0(s, arg + ofs);
+    } else {
+        gen_ldd_env_A0(s, arg + ofs);
+    }
+}
+INSNOP_LDST(mm_t0, Mq)
+{
+    const insnop_arg_t(mm_t0) ofs =
+        offsetof(MMXReg, MMX_Q(0));
+
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_stq_env_A0(s, arg + ofs);
+    } else {
+        gen_ldq_env_A0(s, arg + ofs);
+    }
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


