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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89615C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512C9217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtjTjbxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512C9217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIve-0006ss-JX
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl6-0006Np-L3
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl5-0004UN-HH
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl5-0004TO-CT
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id q20so140362397otl.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DbrkzDutmrfs4okVyFu2tN+4UZ2g6EPa+UzGILusqVI=;
 b=GtjTjbxW2yqhUhv/aEGer1DGfWbJBqq2IyQqiDpYj6Q/+oZWxGc6cCxGKk3FjJHbXL
 1NypyHX55VFw3W91i20CBHGvAMH4wd3C+ojTPqW9JRgjYNuO+TNe8Ah6tRds3JnCZJ2e
 PsxADAfz/rKQpgpFqYQwPC7Y5ChHVYXtCJlVli61X7hbVi+HcnU+A7ek9vMNJB8tQ33B
 SUM+ikFKRq8XjqBr4/7JheTy+vK1NsR7jAWTyKSqDhC7290Nwe+Ltfg6HzXja9VtXbhr
 eujNn6CBm7UM7PUWhsuhdDFcXVq8ipLqLmoFDL/F2oqVP+pLXT7QBvOsuLicxr+mlUpl
 WKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DbrkzDutmrfs4okVyFu2tN+4UZ2g6EPa+UzGILusqVI=;
 b=Ytu/WbJO9azT7Vc7d06sfyRmp9lO8z9qMhK39Ve6B1YC3Ek+ar1eI4l0Icqe4irnfj
 eXIuWMr2N6ENOScM8WH7C7xd15F0LDVEWGfpO8GzNqv20N8Qj5xksa+nVHi2hmAhzce+
 tOZctyhYIY+eServGmKG6/v0pKgilymFo7ccugot/QbW/Rva008E4H2aj5QObJQuvj3f
 fB2zDnvAcIIFqjL74NcELebJJA7bKeNtzmUCFLDWtjIaCACTo4OlcHXh601xvwpJjW/d
 NLeidMiNcuC8AbsxuxzFfLvtgZ1n+hA4FiAFCMRWb4DUDef05sdr0+OSLIEQRqvoqPd5
 Q1Sw==
X-Gm-Message-State: APjAAAXlxafTlJie30GdfS4Ts5Mu+xA7u/+R3NvUi6kz88Z9uU7j4O0A
 1FUGiQ+s21ionob9qvS1N6U2BbV2
X-Google-Smtp-Source: APXvYqx208iXeiIncB/eWHiUinL3yo4oqlq4NI64+auF1uozo47xCmgUhMgY8N9rDEY+Dabg4vM5IA==
X-Received: by 2002:a54:4f09:: with SMTP id e9mr8499793oiy.89.1565410414527;
 Fri, 09 Aug 2019 21:13:34 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:34 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:44 -0400
Message-Id: <20190810041255.6820-29-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 28/39] target/i386: introduce P*, N*,
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
 target/i386/translate.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9896f1c99e..19b92d61f6 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4801,6 +4801,43 @@ INSNOP_LDST(RqMq, Rq, Mq, NULL,
 INSNOP_LDST_UNIFY(Ed, Rd, RdMd)
 INSNOP_LDST_UNIFY(Eq, Rq, RqMq)
 
+/*
+ * MMX registers
+ */
+#define INSNOP_INIT_MM(mmid_fp)                                         \
+    do {                                                                \
+        const int mmid = mmid_fp(env, s, modrm);                        \
+        INSNOP_INIT_OK(offsetof(CPUX86State, fpregs[mmid].mmx));        \
+    } while (0)
+
+#define INSNOP_MM(opT, init_stmt)      \
+    INSNOP(opT, uint32_t,              \
+           init_stmt,                  \
+           INSNOP_PREPARE_NOOP,        \
+           INSNOP_FINALIZE_NOOP)
+
+INSNOP_MM(P, INSNOP_INIT_MM(decode_modrm_reg_norexr))
+INSNOP_ALIAS(Pd, P)
+INSNOP_ALIAS(Pq, P)
+
+INSNOP_MM(N, INSNOP_INIT_DIRECT_ONLY(INSNOP_INIT_MM(decode_modrm_rm_norexb)))
+INSNOP_ALIAS(Nd, N)
+INSNOP_ALIAS(Nq, N)
+
+INSNOP_LDST(NdMd, Nd, Md, offsetof(CPUX86State, mmx_t0),
+            (assert(ptr == s->A0),
+             gen_ldd_env_A0(s, reg + offsetof(MMXReg, MMX_L(0)))),
+            (assert(ptr == s->A0),
+             gen_std_env_A0(s, reg + offsetof(MMXReg, MMX_L(0)))))
+INSNOP_LDST(NqMq, Nq, Mq, offsetof(CPUX86State, mmx_t0),
+            (assert(ptr == s->A0),
+             gen_ldq_env_A0(s, reg + offsetof(MMXReg, MMX_Q(0)))),
+            (assert(ptr == s->A0),
+             gen_stq_env_A0(s, reg + offsetof(MMXReg, MMX_Q(0)))))
+
+INSNOP_LDST_UNIFY(Qd, Nd, NdMd)
+INSNOP_LDST_UNIFY(Qq, Nq, NqMq)
+
 /*
  * Code generators
  */
-- 
2.20.1


