Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB31C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C441922D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOXPwq+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C441922D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UfO-00045a-Qd
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR7-0000qL-Iu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR6-0007Cv-7x
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:17 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR6-0007CV-3D
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:16 -0400
Received: by mail-yw1-xc43.google.com with SMTP id e65so1253136ywh.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=unvBXoZP2PhE77vw3JAkXue/pIkYAU2oPlhgBYzDV70=;
 b=kOXPwq+1l+eLfNz2tbh2rWvgooSbH6IbqCBCTaVTtD35AUhtXwOYSD385X6oJKybiO
 sEoLcfcgClRH0mI4n/sWf6dzCoVJwi+8O7lYXh/hSRjKAivrUKehQ1J0ZTJ6JXchX2YX
 tn3rLU8aWbOkTice8EjQhpJHE9pTd+830EOVGwMTy/49uVNf4dJ8tyhqRmWhNR2CKa4s
 Ku7UhsfeN4RXYXD4or+/4E/2s7oTMrB1P80xlzFPsFyeuCznN9dNXqSULY+/hneuzSpN
 3WSiCPjiCgFn+1zDBUpbLjIsoWBWg6MhGDvXJZatGgo+tCZDwLYpVpdLPD/GibrenwNF
 e0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=unvBXoZP2PhE77vw3JAkXue/pIkYAU2oPlhgBYzDV70=;
 b=MNy65gledYUBaQhEFGFS2mzbTJg7Cdx9N5MEMLFRl6wrooMBNE4WyP/fd27GQClTnO
 PxelM2tK0PgKSVNl9/XBebOwiHkXNmWH5ahPRv0BiDyKQ5dfvYSbVA1Qmymr9VRhZF61
 KQYE7JlU96nCZwAmMIuPWBsB+/Kelg/fYbV+hrZOQS3z19va8PupuYwKL+1s66WXfQZC
 nIIoMs7ZDJCKKXGTV/KRiNw9MfgtsrNtF+K3JDkouoFUKmwwsnLZkDReQW75iDSYtPDA
 1pPmFtH5RCysa0GKfBo1b1SCQCcsG0XZnp85Lj+dgp9uvMRzr1CsZfbVCieU/TBXNzB4
 qDEA==
X-Gm-Message-State: APjAAAUjmdCEGs3aRFXnygW6khmF0BPmxN2/+/uwA18AB4+4MosGn29T
 XWmzFNhnWguGT+qRH6w9g0y8TeT+
X-Google-Smtp-Source: APXvYqwZwSlmHCjmiidmDNs9eKtYtaPFcWRFIjIGZtrB09C75u0OBo/o9bldwxqS3bj/Jrr2EdWMlA==
X-Received: by 2002:a81:33cd:: with SMTP id
 z196mr23203716ywz.213.1566408615432; 
 Wed, 21 Aug 2019 10:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:14 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:50 -0400
Message-Id: <20190821172951.15333-15-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 14/75] target/i386: introduce aliases
 for some tcg_gvec operations
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

The aliases create a thin layer above the raw tcg_gvec functions,
making room for us to permute the arguments, pass additional constant
values etc., which will prove highly useful later.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index bd9c62dc54..467ecf15ba 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "tcg-gvec-desc.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
@@ -4477,6 +4478,44 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+#define gen_gvec_mov(dofs, aofs, oprsz, maxsz, vece)    \
+    tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz)
+
+#define gen_gvec_add(dofs, aofs, bofs, oprsz, maxsz, vece)      \
+    tcg_gen_gvec_add(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_sub(dofs, aofs, bofs, oprsz, maxsz, vece)      \
+    tcg_gen_gvec_sub(vece, dofs, aofs, bofs, oprsz, maxsz)
+
+#define gen_gvec_ssadd(dofs, aofs, bofs, oprsz, maxsz, vece)    \
+    tcg_gen_gvec_ssadd(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_sssub(dofs, aofs, bofs, oprsz, maxsz, vece)    \
+    tcg_gen_gvec_sssub(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_usadd(dofs, aofs, bofs, oprsz, maxsz, vece)    \
+    tcg_gen_gvec_usadd(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_ussub(dofs, aofs, bofs, oprsz, maxsz, vece)    \
+    tcg_gen_gvec_ussub(vece, dofs, aofs, bofs, oprsz, maxsz)
+
+#define gen_gvec_smin(dofs, aofs, bofs, oprsz, maxsz, vece)     \
+    tcg_gen_gvec_smin(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_umin(dofs, aofs, bofs, oprsz, maxsz, vece)     \
+    tcg_gen_gvec_umin(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_smax(dofs, aofs, bofs, oprsz, maxsz, vece)     \
+    tcg_gen_gvec_smax(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_umax(dofs, aofs, bofs, oprsz, maxsz, vece)     \
+    tcg_gen_gvec_umax(vece, dofs, aofs, bofs, oprsz, maxsz)
+
+#define gen_gvec_and(dofs, aofs, bofs, oprsz, maxsz, vece)      \
+    tcg_gen_gvec_and(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_andn(dofs, aofs, bofs, oprsz, maxsz, vece)     \
+    tcg_gen_gvec_andc(vece, dofs, bofs, aofs, oprsz, maxsz)
+#define gen_gvec_or(dofs, aofs, bofs, oprsz, maxsz, vece)       \
+    tcg_gen_gvec_or(vece, dofs, aofs, bofs, oprsz, maxsz)
+#define gen_gvec_xor(dofs, aofs, bofs, oprsz, maxsz, vece)      \
+    tcg_gen_gvec_xor(vece, dofs, aofs, bofs, oprsz, maxsz)
+
+#define gen_gvec_cmp(dofs, aofs, bofs, oprsz, maxsz, vece, cond)        \
+    tcg_gen_gvec_cmp(cond, vece, dofs, aofs, bofs, oprsz, maxsz)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


