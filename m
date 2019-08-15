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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A0C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37057206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzVioL2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37057206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Rz-0007AO-Oy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DO-000642-89
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DN-0008M6-40
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:10 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:37209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DM-0008Lc-WB
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:09 -0400
Received: by mail-yw1-xc41.google.com with SMTP id u141so299473ywe.4
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FGM8eT13pPvn1x4FTXreLbDofICNdY8w6Z3TGTQoeOg=;
 b=VzVioL2CPY4MkLbj0A6n5toJsIfwtgeTuPU9tupBey8tzHrUagYXX8OY4lIciW/XQL
 LZRuMchMJi8x+BVravAIqtXbrgiW+g7uDu7cNN7iQY8AIZFQFRScEQh9bG+37U8Clszz
 zvNaF9QbIG0hf15QcSEE7PoHwVkt0ebeDbqUdMxFrm0TT7bCtku6wdjF64x+L0n5hWoM
 HfcH5Nh6DKvfhP3kjYMQ73UQnF5OZYczaHPmmuFTxZyIR5XL3AIdRipvlV42tP3dKTrc
 OFj6fclAIxRxBrEHFXAtJf3DLoHLlawc15/vkoY5eLE0dSFc9rmIDBi3jXtJ0sQuLDUH
 4RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FGM8eT13pPvn1x4FTXreLbDofICNdY8w6Z3TGTQoeOg=;
 b=rzaBT5YyULNz6drijE0TRwgk7yOxmB98SqROtq6YwpKXygBioTGQXCYAoQjQqZYA3y
 SARBW8DkpPXWeYPslEb59svHb0KLhBb4H1FXLfUHvg75mmQBaQXm/Qur9ydzlTnBzf9a
 9nqBnfYe5GQlO9XM7rYR+eo4njinNu2p5By+RZS0/T0yZCFcj0i7zHD3qbIiX1y70OxG
 0g+48BnbmYEfRlZtLPzI6+hyxpI3gzv7HHaScisxNaH+MfMSxCk0tu2m09eCTLlu2i+d
 /14PBoH3D6C9oABto0e5giRuUe5iaco3e7VG31k/TfmgbUP/mpOIvifNju4Q1iVwB0Ex
 fEFA==
X-Gm-Message-State: APjAAAWXkglj0bisz60iDWhVEev/DhGvqJBRgMMta3e9+zBD2J3ZCGnR
 lDYLJJ8edrQm0lIKyHgQhjQ+StWM
X-Google-Smtp-Source: APXvYqwJtwHKwj9CfQ6A0wXDRKvLyibzb5QuAxa31mdKAXTNaDia8Lsul0j+HRlaBL53ai0F1UqcdA==
X-Received: by 2002:a81:a705:: with SMTP id e5mr1568738ywh.445.1565835008326; 
 Wed, 14 Aug 2019 19:10:08 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:07 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:57 -0400
Message-Id: <20190815020928.9679-16-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v3 15/46] target/i386: introduce function
 ck_cpuid
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

Introduce a helper function to take care of instruction CPUID checks.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 6296a02991..0cffa2226b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4500,6 +4500,54 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 #define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        \
     tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
 
+typedef enum {
+    CK_CPUID_MMX = 1,
+    CK_CPUID_3DNOW,
+    CK_CPUID_SSE,
+    CK_CPUID_SSE2,
+    CK_CPUID_CLFLUSH,
+    CK_CPUID_SSE3,
+    CK_CPUID_SSSE3,
+    CK_CPUID_SSE4_1,
+    CK_CPUID_SSE4_2,
+    CK_CPUID_SSE4A,
+    CK_CPUID_AVX,
+    CK_CPUID_AVX2,
+} CkCpuidFeat;
+
+static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
+{
+    switch (feat) {
+    case CK_CPUID_MMX:
+        return !(s->cpuid_features & CPUID_MMX)
+            || !(s->cpuid_ext2_features & CPUID_EXT2_MMX);
+    case CK_CPUID_3DNOW:
+        return !(s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
+    case CK_CPUID_SSE:
+        return !(s->cpuid_features & CPUID_SSE);
+    case CK_CPUID_SSE2:
+        return !(s->cpuid_features & CPUID_SSE2);
+    case CK_CPUID_CLFLUSH:
+        return !(s->cpuid_features & CPUID_CLFLUSH);
+    case CK_CPUID_SSE3:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE3);
+    case CK_CPUID_SSSE3:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSSE3);
+    case CK_CPUID_SSE4_1:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE41);
+    case CK_CPUID_SSE4_2:
+        return !(s->cpuid_ext_features & CPUID_EXT_SSE42);
+    case CK_CPUID_SSE4A:
+        return !(s->cpuid_ext3_features & CPUID_EXT3_SSE4A);
+    case CK_CPUID_AVX:
+        return !(s->cpuid_ext_features & CPUID_EXT_AVX);
+    case CK_CPUID_AVX2:
+        return !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


