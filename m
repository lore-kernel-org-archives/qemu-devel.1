Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FCF2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/sFKPvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FCF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRliw-0007yS-W5
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:53:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbN-0001MK-IO
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbM-0005ij-9O
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:21 -0400
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbM-0005hI-4s
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:20 -0400
Received: by mail-yw1-xc2d.google.com with SMTP id b74so3350117ywe.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BNGYBuGPGNDuM5xfMmUkjPf3rGoNf3wcZlgZaC2W07g=;
	b=o/sFKPvCPiXhtp8moSTYrqmPC/qvA2UDkS42YPHJot7mg9IU8/lff1NHf/88bobMfN
	UDCXiNl6TZuxOx3QXqdQVKlrYq4Wbbi87JRfG3WJ+edxQv1oDQ1IHEpOPxHoYS2dD9BL
	nwg1TPqYnQB0x5GHl8zJlu7GI2RHooP5G0+NX4mpQnJnozbjA/QG9gDzL7qb2XFkon9t
	+xYBEWblOSrnchcp7IqYr4be+lqzdNyF3JOQYlOHBUjP4g4SWgQSbZb4U97Yx9qd4l4G
	G1nCYMhQPvHHarWC8uTSfBBOCvudTET19ZG0JkNDyZLJfFIkraKs9MzSu0rMYLiTybNh
	Y0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BNGYBuGPGNDuM5xfMmUkjPf3rGoNf3wcZlgZaC2W07g=;
	b=BppBW/7WIYEJFB0aCZTd1pXfy8OjFaAn+T0tQK1pNNnnmEhUUs/8qHjsnZfsVUBVpd
	HrQ4Xs09IqhqRJskdgp4vP7n0Yox+KdXM0fTPBQFp9r21RtQybYNtdTQPCyc6sQPE+a2
	A5bvdGFTyPPtbLM2DrNEQOuGh1LaHf0c4E84KUdDF74Hc+hl5ms3RnQakIPuqESUhsbw
	+bpJi1f5KMStivpZplzeI0zIWHKKd9Fbyl58EsghbvDQhmHnpKhNlj3W8PUf1ni37CtZ
	Sx8/3wp26VXUa/Ss2EtWRHDjopud2JTHDGB8NPWYPhEooMLADgyodgnprpqZY9vwdgiq
	SuXw==
X-Gm-Message-State: APjAAAWl6m309NuP1X37iiQ+YQ0bXA/TXC7sjKypxq4r/CeJWiY189Hm
	r+y505vL6yEFr24wZzLgk6j08w+hiceVxg==
X-Google-Smtp-Source: APXvYqxZCzrkj1AkbJZrOmNHQ7CEQ9gXYQ8+k0F2rn+zaGGvD28PrY09XHkbQ2+1+xkz4otqG2I+6A==
X-Received: by 2002:a81:6d88:: with SMTP id i130mr1902890ywc.266.1558133119377;
	Fri, 17 May 2019 15:45:19 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:49 -0400
Message-Id: <20190517224450.15566-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
Subject: [Qemu-devel] [RISU v2 10/11] risu_reginfo_i386: replace xfeature
 constants with symbolic names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

The original code used "magic numbers", which made it unclear in
some places. Include a reference to the Intel manual where the
constants' meaning is discussed.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 35ff7c8..aba5ae3 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -22,7 +22,25 @@
 
 #include <asm/sigcontext.h>
 
-static uint64_t xfeatures = 3;  /* SSE */
+/*
+ * Refer to "Intel(R) 64 and IA-32 Architectures Software Developer's
+ * Manual", Volume 1, Section 13.1 "XSAVE-Supported Features and
+ * State-Component Bitmaps" for detailed discussion of these constants
+ * and their meaning.
+ */
+enum {
+    XFEAT_X87              = 1 << 0,
+    XFEAT_SSE              = 1 << 1,
+    XFEAT_AVX              = 1 << 2,
+    XFEAT_AVX512_OPMASK    = 1 << 5,
+    XFEAT_AVX512_ZMM_HI256 = 1 << 6,
+    XFEAT_AVX512_HI16_ZMM  = 1 << 7,
+    XFEAT_AVX512           = XFEAT_AVX512_OPMASK
+                           | XFEAT_AVX512_ZMM_HI256
+                           | XFEAT_AVX512_HI16_ZMM
+};
+
+static uint64_t xfeatures = XFEAT_X87 | XFEAT_SSE;
 
 static const struct option extra_ops[] = {
     {"xfeatures", required_argument, NULL, FIRST_ARCH_OPT },
@@ -160,34 +178,34 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
      * Now we know that _fpstate contains XSAVE data.
      */
 
-    if (features & (1 << 2)) {
+    if (features & XFEAT_AVX) {
         /* YMM_Hi128 state */
-        void *buf = xsave_feature_buf(xs, 2);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX);
         for (i = 0; i < nvecregs; ++i) {
             memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
         }
     }
 
-    if (features & (1 << 5)) {
+    if (features & XFEAT_AVX512_OPMASK) {
         /* Opmask state */
-        uint64_t *buf = xsave_feature_buf(xs, 5);
+        uint64_t *buf = xsave_feature_buf(xs, XFEAT_AVX512_OPMASK);
         for (i = 0; i < 8; ++i) {
             ri->kregs[i] = buf[i];
         }
     }
 
-    if (features & (1 << 6)) {
+    if (features & XFEAT_AVX512_ZMM_HI256) {
         /* ZMM_Hi256 state */
-        void *buf = xsave_feature_buf(xs, 6);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX512_ZMM_HI256);
         for (i = 0; i < nvecregs; ++i) {
             memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
         }
     }
 
 #ifdef __x86_64__
-    if (features & (1 << 7)) {
+    if (features & XFEAT_AVX512_HI16_ZMM) {
         /* Hi16_ZMM state */
-        void *buf = xsave_feature_buf(xs, 7);
+        void *buf = xsave_feature_buf(xs, XFEAT_AVX512_HI16_ZMM);
         for (i = 0; i < 16; ++i) {
             memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
         }
@@ -243,7 +261,7 @@ static const char *const regname[NGREG] = {
 static int get_nvecregs(uint64_t features)
 {
 #ifdef __x86_64__
-    return features & (1 << 7) ? 32 : 16;
+    return features & XFEAT_AVX512_HI16_ZMM ? 32 : 16;
 #else
     return 8;
 #endif
@@ -251,9 +269,9 @@ static int get_nvecregs(uint64_t features)
 
 static int get_nvecquads(uint64_t features)
 {
-    if (features & (1 << 6)) {
+    if (features & XFEAT_AVX512_ZMM_HI256) {
         return 8;
-    } else if (features & (1 << 2)) {
+    } else if (features & XFEAT_AVX) {
         return 4;
     } else {
         return 2;
@@ -262,9 +280,9 @@ static int get_nvecquads(uint64_t features)
 
 static char get_vecletter(uint64_t features)
 {
-    if (features & (1 << 6 | 1 << 7)) {
+    if (features & (XFEAT_AVX512_ZMM_HI256 | XFEAT_AVX512_HI16_ZMM)) {
         return 'z';
-    } else if (features & (1 << 2)) {
+    } else if (features & XFEAT_AVX) {
         return 'y';
     } else {
         return 'x';
@@ -301,7 +319,7 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
         }
     }
 
-    if (features & (1 << 5)) {
+    if (features & XFEAT_AVX512_OPMASK) {
         for (i = 0; i < 8; i++) {
             fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
         }
-- 
2.20.1


