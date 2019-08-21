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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EFC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC05D22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG5BTREc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC05D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V4i-0004uK-T0
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URK-0001Cr-68
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URJ-0007YP-4u
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:30 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URI-0007UH-Em
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:29 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 1so900343ybj.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TLzq0TMAhLaEkuTNtNrEWRG0fHFI+G4R8X7EvD7Djs=;
 b=XG5BTREcHbSuvT0PguwR95kWOrgeFXm8Pn00oawGdsTyeZ1HBNS8LV9IDWfMDM9PHU
 4uI5Jfciw/3eDQTtTBrm4bf270X8XHRAp7xsz1JZzV9VlgISSAVcsF+it5Uneqvo1eP+
 87kLZv9piYjl1/sdpP1HKXFCwZiqnSlXWk93lxx3nwUswtSJbvXlQkLQ80SFqauu/3NI
 RwTPoLaErvNQz73BKW+RAvmTrbe3lyQqJCHT0WynHLav9Hc2nC6lmHuarcamyagS1OtY
 df4pGY35ItVr3lzzaMgQwpI/uRfnPQXgdpy3VwF5189uC1fg8GQsMmnDawPmZObUewCt
 J5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TLzq0TMAhLaEkuTNtNrEWRG0fHFI+G4R8X7EvD7Djs=;
 b=h/fg9qf9iIFizEpH8S6/uBkyg3oCW408JSxibxeKCb5vvEnQkiV5AxTrQwnE4UrJRw
 Bk/q9D04CuULGZOozN3d/0ECja+SBSPIvFTAiwakCFFdnZUTRCQTjF8XXH3v7Y3HiEUP
 Z3HFZy+PXIeFlSbWoSnDFl4PuACCFh2oS/CMlN6lT+udHvPFJ/KuMpm6utNaOF/MkZTp
 873bIxjinKf2wcFiXzRptdFc5ClbgGdAcug+FNSlHe7dRfH5oP+8ro3f98g4gd11+zYf
 RzVsIUVZJuI6mJe/0b99ru9x8IEwqd3vjgoa/UW+4OYWplbR4srl6XpzP1rwZIM2f+26
 CSjQ==
X-Gm-Message-State: APjAAAU9YJgVEGyZ05Fr72ZEkaGP4a4HazunR7PqpgPeyJ4kdv5jXHtr
 2AjbA8JwUW9YyKXVy+MRmDM7c+JK
X-Google-Smtp-Source: APXvYqzaCqobI1pjh63OSj43KhG+mcsTg5aFYqdODo+TE7hDxjD30Wb4R7jM7FRwznbyCqfe18yc6Q==
X-Received: by 2002:a25:6b43:: with SMTP id o3mr24801627ybm.295.1566408626611; 
 Wed, 21 Aug 2019 10:30:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:02 -0400
Message-Id: <20190821172951.15333-27-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 26/75] target/i386: introduce M*
 (memptr) operands
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

The memory-pointer operand decodes the indirect form of ModR/M byte,
loads the effective address into a register and passes that register
as the operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9f02ea58d1..46c41cc3be 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4908,6 +4908,42 @@ INSNOP_FINALIZE(Ib)
 {
 }
 
+/*
+ * Memory-pointer operand
+ */
+typedef TCGv insnop_arg_t(M);
+typedef struct {} insnop_ctxt_t(M);
+
+INSNOP_INIT(M)
+{
+    bool ret;
+    insnop_ctxt_t(modrm_mod) modctxt;
+
+    ret = insnop_init(modrm_mod)(&modctxt, env, s, modrm, is_write);
+    if (ret) {
+        const int mod =
+            insnop_prepare(modrm_mod)(&modctxt, env, s, modrm, is_write);
+        ret = (mod != 3);
+        insnop_finalize(modrm_mod)(&modctxt, env, s, modrm, is_write, mod);
+    }
+    return ret;
+}
+INSNOP_PREPARE(M)
+{
+    gen_lea_modrm(env, s, modrm);
+    return s->A0;
+}
+INSNOP_FINALIZE(M)
+{
+}
+
+DEF_INSNOP_ALIAS(Mb, M)
+DEF_INSNOP_ALIAS(Mw, M)
+DEF_INSNOP_ALIAS(Md, M)
+DEF_INSNOP_ALIAS(Mq, M)
+DEF_INSNOP_ALIAS(Mdq, M)
+DEF_INSNOP_ALIAS(Mqq, M)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


