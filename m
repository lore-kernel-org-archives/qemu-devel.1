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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2151AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCD4214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDdemTJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VUl-0002Vc-Ga
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0001t4-1C
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URu-00006M-Jk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:10 -0400
Received: from mail-yw1-xc34.google.com ([2607:f8b0:4864:20::c34]:34432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URu-00005u-CF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:06 -0400
Received: by mail-yw1-xc34.google.com with SMTP id n126so1251796ywf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w6BAbGITg74d88mL6TMorZ/6vn44B+cNvj3di/2/Ocg=;
 b=dDdemTJwGrFhbCl6yk9Ybuln8g2m5VDfVEMj+biZzdoz9R7RbFap0q5b/HBdSsX2oZ
 JRzpfSZiTtAge0UqAarmz1EFZhHGXo3xq+F6lrg/wrl0atu33tKfkwlROW8C5am8DAwQ
 t6zml2MFXU2vXDzEkqBOGitBjQyGSImZPTxZTINwnqZb0uRJiRvQNBTD5NAQeEhJaTl0
 9difrMCJzUSXXtl5nUzWrcuZFbiDq/xJLdiSXnAiBoTGfJQ0AnmNI5QZe2RuRQnatvx1
 /3GDNFZ4O0F4xTC4HRatS/6sVb0jY78xmsOO7yedoOvwRYDnmWZGtbUv/rBVUwrYnJ7e
 x+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w6BAbGITg74d88mL6TMorZ/6vn44B+cNvj3di/2/Ocg=;
 b=d5CvhRlTdQ9I9Jnynn+CDjct6TF/U8pFJMBM9BWcaPCSuSwHHHDSFHo53qdLhkI8Ml
 dVVb7TdkfCyO1DkSpdvnQ1X1QW+0v5XNZWkKyB9hEMMO71f82VXNMmdsi+e57SGb9daT
 Z+SWjcldlODlyxFdkxPSZv62h5zEATBUBUun5n6vfm8jOdltKrgKVGFf2Bq73VZuDX3U
 Yw7ZQgAwwbVguORgAXPimCrEFKz+cuVCHpijpjcsKqD2olT2DEAhnhPU9qok9lUUUpPg
 opHoT7SRQQ4hoKBWu9gmhxyLkoYwGQKqB1dzeJzi+YtFiudAXv3OA4irtfN5befRfAnp
 93ig==
X-Gm-Message-State: APjAAAXsIu/6OXH8zu+p3anxiDhCHfPZ5yMfjuXqzcv7IZu7/8LlpNtF
 QVeFBsh9AJo1yO9c/qG7WMAnilTJ
X-Google-Smtp-Source: APXvYqy5wHxEGGZHctd+cssRplG4F3Dk6O4UUnwPrxPRoD9VX7zxaByH9ZSvTsIWqOHQs2umIWVqNQ==
X-Received: by 2002:a81:2e84:: with SMTP id
 u126mr24493583ywu.398.1566408665072; 
 Wed, 21 Aug 2019 10:31:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:04 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:44 -0400
Message-Id: <20190821172951.15333-69-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c34
Subject: [Qemu-devel] [RFC PATCH v4 68/75] target/i386: convert ps((l, r)l(w,
 d, q), ra(w, d)) to helpers to gvec style
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

Make these helpers suitable for use with tcg_gen_gvec_* functions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        | 357 +++++++++++++++++++++--------------
 target/i386/ops_sse_header.h |  30 ++-
 target/i386/translate.c      | 259 +++++++------------------
 3 files changed, 306 insertions(+), 340 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index aca6b50f23..168e581c0c 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -19,6 +19,7 @@
  */
 
 #include "crypto/aes.h"
+#include "tcg-gvec-desc.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -38,199 +39,273 @@
 #define SUFFIX _xmm
 #endif
 
-void glue(helper_psrlw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+static inline void glue(clear_high, SUFFIX)(Reg *d, intptr_t oprsz,
+                                            intptr_t maxsz)
 {
-    int shift;
+    intptr_t i;
 
-    if (s->Q(0) > 15) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->W(0) >>= shift;
-        d->W(1) >>= shift;
-        d->W(2) >>= shift;
-        d->W(3) >>= shift;
-#if SHIFT == 1
-        d->W(4) >>= shift;
-        d->W(5) >>= shift;
-        d->W(6) >>= shift;
-        d->W(7) >>= shift;
-#endif
+    assert(oprsz % sizeof(uint64_t) == 0);
+    assert(maxsz % sizeof(uint64_t) == 0);
+
+    if (oprsz < maxsz) {
+        i = oprsz / sizeof(uint64_t);
+        for (; i * sizeof(uint64_t) < maxsz; ++i) {
+            d->Q(i) = 0;
+        }
     }
 }
 
-void glue(helper_psraw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psllw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 15 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 15) {
-        shift = 15;
-    } else {
-        shift = s->B(0);
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = a->W(i) << count;
     }
-    d->W(0) = (int16_t)d->W(0) >> shift;
-    d->W(1) = (int16_t)d->W(1) >> shift;
-    d->W(2) = (int16_t)d->W(2) >> shift;
-    d->W(3) = (int16_t)d->W(3) >> shift;
-#if SHIFT == 1
-    d->W(4) = (int16_t)d->W(4) >> shift;
-    d->W(5) = (int16_t)d->W(5) >> shift;
-    d->W(6) = (int16_t)d->W(6) >> shift;
-    d->W(7) = (int16_t)d->W(7) >> shift;
-#endif
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_psllw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_pslld, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 31 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 15) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->W(0) <<= shift;
-        d->W(1) <<= shift;
-        d->W(2) <<= shift;
-        d->W(3) <<= shift;
-#if SHIFT == 1
-        d->W(4) <<= shift;
-        d->W(5) <<= shift;
-        d->W(6) <<= shift;
-        d->W(7) <<= shift;
-#endif
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = a->L(i) << count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_psrld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psllq, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 63 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 31) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->L(0) >>= shift;
-        d->L(1) >>= shift;
-#if SHIFT == 1
-        d->L(2) >>= shift;
-        d->L(3) >>= shift;
-#endif
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        d->Q(i) = a->Q(i) << count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_psrad, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psllwi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 15 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 31) {
-        shift = 31;
-    } else {
-        shift = s->B(0);
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = a->W(i) << count;
     }
-    d->L(0) = (int32_t)d->L(0) >> shift;
-    d->L(1) = (int32_t)d->L(1) >> shift;
-#if SHIFT == 1
-    d->L(2) = (int32_t)d->L(2) >> shift;
-    d->L(3) = (int32_t)d->L(3) >> shift;
-#endif
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pslld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_pslldi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 31 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 31) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->L(0) <<= shift;
-        d->L(1) <<= shift;
-#if SHIFT == 1
-        d->L(2) <<= shift;
-        d->L(3) <<= shift;
-#endif
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = a->L(i) << count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_psrlq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psllqi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 63 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 63) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->Q(0) >>= shift;
-#if SHIFT == 1
-        d->Q(1) >>= shift;
-#endif
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        d->Q(i) = a->Q(i) << count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_psllq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psrlw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    int shift;
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 15 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    if (s->Q(0) > 63) {
-        d->Q(0) = 0;
-#if SHIFT == 1
-        d->Q(1) = 0;
-#endif
-    } else {
-        shift = s->B(0);
-        d->Q(0) <<= shift;
-#if SHIFT == 1
-        d->Q(1) <<= shift;
-#endif
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = a->W(i) >> count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-#if SHIFT == 1
-void glue(helper_psrldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psrld, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 31 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = a->L(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrlq, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const uint64_t count = b->Q(0);
+    const intptr_t oprsz = count > 63 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        d->Q(i) = a->Q(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrlwi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
+{
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 15 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = a->W(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrldi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
+{
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 31 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = a->L(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrlqi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    int shift, i;
+    const uint64_t count = simd_data(desc);
+    const intptr_t oprsz = count > 63 ? 0 : simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    shift = s->L(0);
-    if (shift > 16) {
-        shift = 16;
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        d->Q(i) = a->Q(i) >> count;
     }
-    for (i = 0; i < 16 - shift; i++) {
-        d->B(i) = d->B(i + shift);
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psraw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    uint64_t count = b->Q(0);
+    if (count > 15) {
+        count = 15;
+    }
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = (int16_t)a->W(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrad, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    uint64_t count = b->Q(0);
+    if (count > 31) {
+        count = 31;
     }
-    for (i = 16 - shift; i < 16; i++) {
-        d->B(i) = 0;
+
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = (int32_t)a->L(i) >> count;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pslldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_psrawi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    int shift, i;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    shift = s->L(0);
-    if (shift > 16) {
-        shift = 16;
+    uint64_t count = simd_data(desc);
+    if (count > 15) {
+        count = 15;
     }
-    for (i = 15; i >= shift; i--) {
-        d->B(i) = d->B(i - shift);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = (int16_t)a->W(i) >> count;
     }
-    for (i = 0; i < shift; i++) {
-        d->B(i) = 0;
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psradi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    uint64_t count = simd_data(desc);
+    if (count > 31) {
+        count = 31;
+    }
+
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        d->L(i) = (int32_t)a->L(i) >> count;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+#if SHIFT == 1
+void glue(helper_pslldqi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    unsigned int count = simd_data(desc);
+    if (count > 16) {
+        count = 16;
+    }
+
+    for (intptr_t i = 0; i < oprsz; i += 16) {
+        intptr_t j = 15;
+        for (; count <= j; --j) {
+            d->B(i + j) = a->B(i + j - count);
+        }
+        for (; 0 <= j; --j) {
+            d->B(i + j) = 0;
+        }
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_psrldqi, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    unsigned int count = simd_data(desc);
+    if (count > 16) {
+        count = 16;
+    }
+
+    for (intptr_t i = 0; i < oprsz; i += 16) {
+        intptr_t j = 0;
+        for (; j + count < 16; ++j) {
+            d->B(i + j) = a->B(i + j + count);
+        }
+        for (; j < 16; ++j) {
+            d->B(i + j) = 0;
+        }
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 #endif
 
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index afa0ad0938..724692a689 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -34,18 +34,28 @@
 #define dh_is_signed_ZMMReg dh_is_signed_ptr
 #define dh_is_signed_MMXReg dh_is_signed_ptr
 
-DEF_HELPER_3(glue(psrlw, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psraw, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psllw, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psrld, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psrad, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(pslld, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psrlq, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(psllq, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(psllw, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(pslld, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(psllq, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_3(glue(psllwi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(pslldi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(psllqi, SUFFIX), void, Reg, Reg, i32)
+
+DEF_HELPER_4(glue(psrlw, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(psrld, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(psrlq, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_3(glue(psrlwi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(psrldi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(psrlqi, SUFFIX), void, Reg, Reg, i32)
+
+DEF_HELPER_4(glue(psraw, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(psrad, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_3(glue(psrawi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(psradi, SUFFIX), void, Reg, Reg, i32)
 
 #if SHIFT == 1
-DEF_HELPER_3(glue(psrldq, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_3(glue(pslldqi, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(psrldqi, SUFFIX), void, Reg, Reg, i32)
 #endif
 
 DEF_HELPER_3(glue(pmullw, SUFFIX), void, env, Reg, Reg)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index c7e664e798..03f7c6e450 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2801,24 +2801,16 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xc4] = { SSE_SPECIAL, SSE_SPECIAL }, /* pinsrw */
     [0xc5] = { SSE_SPECIAL, SSE_SPECIAL }, /* pextrw */
     [0xd0] = { NULL, gen_helper_addsubpd, NULL, gen_helper_addsubps },
-    [0xd1] = MMX_OP2(psrlw),
-    [0xd2] = MMX_OP2(psrld),
-    [0xd3] = MMX_OP2(psrlq),
     [0xd5] = MMX_OP2(pmullw),
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
     [0xe0] = MMX_OP2(pavgb),
-    [0xe1] = MMX_OP2(psraw),
-    [0xe2] = MMX_OP2(psrad),
     [0xe3] = MMX_OP2(pavgw),
     [0xe4] = MMX_OP2(pmulhuw),
     [0xe5] = MMX_OP2(pmulhw),
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
-    [0xf1] = MMX_OP2(psllw),
-    [0xf2] = MMX_OP2(pslld),
-    [0xf3] = MMX_OP2(psllq),
     [0xf4] = MMX_OP2(pmuludq),
     [0xf5] = MMX_OP2(pmaddwd),
     [0xf6] = MMX_OP2(psadbw),
@@ -2826,19 +2818,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
                (SSEFunc_0_epp)gen_helper_maskmov_xmm }, /* XXX: casts */
 };
 
-static const SSEFunc_0_epp sse_op_table2[3 * 8][2] = {
-    [0 + 2] = MMX_OP2(psrlw),
-    [0 + 4] = MMX_OP2(psraw),
-    [0 + 6] = MMX_OP2(psllw),
-    [8 + 2] = MMX_OP2(psrld),
-    [8 + 4] = MMX_OP2(psrad),
-    [8 + 6] = MMX_OP2(pslld),
-    [16 + 2] = MMX_OP2(psrlq),
-    [16 + 3] = { NULL, gen_helper_psrldq_xmm },
-    [16 + 6] = MMX_OP2(psllq),
-    [16 + 7] = { NULL, gen_helper_pslldq_xmm },
-};
-
 static const SSEFunc_0_epi sse_op_table3ai[] = {
     gen_helper_cvtsi2ss,
     gen_helper_cvtsi2sd
@@ -3403,49 +3382,6 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
                 goto illegal_op;
             }
             break;
-        case 0x71: /* shift mm, im */
-        case 0x72:
-        case 0x73:
-        case 0x171: /* shift xmm, im */
-        case 0x172:
-        case 0x173:
-            if (b1 >= 2) {
-                goto unknown_op;
-            }
-            val = x86_ldub_code(env, s);
-            if (is_xmm) {
-                tcg_gen_movi_tl(s->T0, val);
-                tcg_gen_st32_tl(s->T0, cpu_env,
-                                offsetof(CPUX86State, xmm_t0.ZMM_L(0)));
-                tcg_gen_movi_tl(s->T0, 0);
-                tcg_gen_st32_tl(s->T0, cpu_env,
-                                offsetof(CPUX86State, xmm_t0.ZMM_L(1)));
-                op1_offset = offsetof(CPUX86State,xmm_t0);
-            } else {
-                tcg_gen_movi_tl(s->T0, val);
-                tcg_gen_st32_tl(s->T0, cpu_env,
-                                offsetof(CPUX86State, mmx_t0.MMX_L(0)));
-                tcg_gen_movi_tl(s->T0, 0);
-                tcg_gen_st32_tl(s->T0, cpu_env,
-                                offsetof(CPUX86State, mmx_t0.MMX_L(1)));
-                op1_offset = offsetof(CPUX86State,mmx_t0);
-            }
-            sse_fn_epp = sse_op_table2[((b - 1) & 3) * 8 +
-                                       (((modrm >> 3)) & 7)][b1];
-            if (!sse_fn_epp) {
-                goto unknown_op;
-            }
-            if (is_xmm) {
-                rm = (modrm & 7) | REX_B(s);
-                op2_offset = offsetof(CPUX86State,xmm_regs[rm]);
-            } else {
-                rm = (modrm & 7);
-                op2_offset = offsetof(CPUX86State,fpregs[rm].mmx);
-            }
-            tcg_gen_addi_ptr(s->ptr0, cpu_env, op2_offset);
-            tcg_gen_addi_ptr(s->ptr1, cpu_env, op1_offset);
-            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
-            break;
         case 0x050: /* movmskps */
             rm = (modrm & 7) | REX_B(s);
             tcg_gen_addi_ptr(s->ptr0, cpu_env,
@@ -6889,18 +6825,18 @@ DEF_GEN_INSN3_GVEC(xorpd, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vxorpd, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(vxorpd, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
-DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsllw, psllw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsllw, psllw_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpslld, pslld_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpslld, pslld_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsllq, psllq_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsllq, psllq_xmm, Vqq, Hqq, Wdq)
+DEF_GEN_INSN3_GVEC(psllw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psllw_mmx)
+DEF_GEN_INSN3_GVEC(psllw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllw_xmm)
+DEF_GEN_INSN3_GVEC(vpsllw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllw_xmm)
+DEF_GEN_INSN3_GVEC(vpsllw, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllw_xmm)
+DEF_GEN_INSN3_GVEC(pslld, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pslld_mmx)
+DEF_GEN_INSN3_GVEC(pslld, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pslld_xmm)
+DEF_GEN_INSN3_GVEC(vpslld, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pslld_xmm)
+DEF_GEN_INSN3_GVEC(vpslld, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pslld_xmm)
+DEF_GEN_INSN3_GVEC(psllq, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psllq_mmx)
+DEF_GEN_INSN3_GVEC(psllq, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllq_xmm)
+DEF_GEN_INSN3_GVEC(vpsllq, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllq_xmm)
+DEF_GEN_INSN3_GVEC(vpsllq, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psllq_xmm)
 
 GEN_INSN3(vpsllvd, Vdq, Hdq, Wdq)
 {
@@ -6920,21 +6856,18 @@ GEN_INSN3(vpsllvq, Vqq, Hqq, Wqq)
     /* XXX TODO implement this */
 }
 
-DEF_GEN_INSN3_HELPER_EPP(pslldq, pslldq_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpslldq, pslldq_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpslldq, pslldq_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrlw, psrlw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrlw, psrlw_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrld, psrld_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrld, psrld_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrlq, psrlq_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrlq, psrlq_xmm, Vqq, Hqq, Wdq)
+DEF_GEN_INSN3_GVEC(psrlw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psrlw_mmx)
+DEF_GEN_INSN3_GVEC(psrlw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlw_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlw_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlw, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlw_xmm)
+DEF_GEN_INSN3_GVEC(psrld, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psrld_mmx)
+DEF_GEN_INSN3_GVEC(psrld, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrld_xmm)
+DEF_GEN_INSN3_GVEC(vpsrld, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrld_xmm)
+DEF_GEN_INSN3_GVEC(vpsrld, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrld_xmm)
+DEF_GEN_INSN3_GVEC(psrlq, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psrlq_mmx)
+DEF_GEN_INSN3_GVEC(psrlq, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlq_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlq, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlq_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlq, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrlq_xmm)
 
 GEN_INSN3(vpsrlvd, Vdq, Hdq, Wdq)
 {
@@ -6954,17 +6887,14 @@ GEN_INSN3(vpsrlvq, Vqq, Hqq, Wqq)
     /* XXX TODO implement this */
 }
 
-DEF_GEN_INSN3_HELPER_EPP(psrldq, psrldq_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrldq, psrldq_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrldq, psrldq_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsraw, psraw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsraw, psraw_xmm, Vqq, Hqq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vqq, Hqq, Wdq)
+DEF_GEN_INSN3_GVEC(psraw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psraw_mmx)
+DEF_GEN_INSN3_GVEC(psraw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psraw_xmm)
+DEF_GEN_INSN3_GVEC(vpsraw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psraw_xmm)
+DEF_GEN_INSN3_GVEC(vpsraw, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psraw_xmm)
+DEF_GEN_INSN3_GVEC(psrad, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psrad_mmx)
+DEF_GEN_INSN3_GVEC(psrad, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrad_xmm)
+DEF_GEN_INSN3_GVEC(vpsrad, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrad_xmm)
+DEF_GEN_INSN3_GVEC(vpsrad, Vqq, Hqq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psrad_xmm)
 
 GEN_INSN3(vpsravd, Vdq, Hdq, Wdq)
 {
@@ -6975,93 +6905,44 @@ GEN_INSN3(vpsravd, Vqq, Hqq, Wqq)
     /* XXX TODO implement this */
 }
 
-#define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
-    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
-    {                                                                   \
-        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
-        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
-        const insnop_arg_t(Qq) arg3_mm =                                \
-            offsetof(CPUX86State, mmx_t0.MMX_Q(0));                     \
-                                                                        \
-        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
-        gen_insn2(movq, Pq, Eq)(env, s, arg3_mm, arg3_r64);             \
-        gen_insn3(mnem, Pq, Pq, Qq)(env, s, arg1, arg2, arg3_mm);       \
-    }
-#define DEF_GEN_PSHIFT_IMM_XMM(mnem, opT1, opT2)                        \
-    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
-    {                                                                   \
-        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
-        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
-        const insnop_arg_t(Wdq) arg3_xmm =                              \
-            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
-                                                                        \
-        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
-        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
-        gen_insn3(mnem, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3_xmm);   \
-    }
-#define DEF_GEN_VPSHIFT_IMM_XMM(mnem, opT1, opT2)                       \
-    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
-    {                                                                   \
-        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
-        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
-        const insnop_arg_t(Wdq) arg3_xmm =                              \
-            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
-                                                                        \
-        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
-        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
-        gen_insn3(mnem, Vdq, Hdq, Wdq)(env, s, arg2, arg2, arg3_xmm);   \
-    }
-#define DEF_GEN_VPSHIFT_IMM_YMM(mnem, opT1, opT2)                       \
-    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
-    {                                                                   \
-        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
-        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
-        const insnop_arg_t(Wdq) arg3_xmm =                              \
-            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
-                                                                        \
-        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
-        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
-        gen_insn3(mnem, Vqq, Hqq, Wdq)(env, s, arg2, arg2, arg3_xmm);   \
-    }
-
-DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psllw, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsllw, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsllw, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(pslld, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpslld, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpslld, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psllq, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsllq, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsllq, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_XMM(pslldq, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpslldq, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpslldq, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psrlw, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrlw, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsrlw, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psrld, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrld, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsrld, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psrlq, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrlq, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsrlq, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_XMM(psrldq, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrldq, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_YMM(vpsrldq, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsraw, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsraw, Hqq, Uqq)
-DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
-DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrad, Hdq, Udq)
-DEF_GEN_VPSHIFT_IMM_XMM(vpsrad, Hqq, Uqq)
+DEF_GEN_INSN3_GVEC(psllw, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psllwi_xmm)
+DEF_GEN_INSN3_GVEC(psllw, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllwi_xmm)
+DEF_GEN_INSN3_GVEC(vpsllw, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllwi_xmm)
+DEF_GEN_INSN3_GVEC(vpsllw, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllwi_xmm)
+DEF_GEN_INSN3_GVEC(pslld, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, pslldi_xmm)
+DEF_GEN_INSN3_GVEC(pslld, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldi_xmm)
+DEF_GEN_INSN3_GVEC(vpslld, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldi_xmm)
+DEF_GEN_INSN3_GVEC(vpslld, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldi_xmm)
+DEF_GEN_INSN3_GVEC(psllq, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psllqi_xmm)
+DEF_GEN_INSN3_GVEC(psllq, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsllq, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsllq, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psllqi_xmm)
+DEF_GEN_INSN3_GVEC(pslldq, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldqi_xmm)
+DEF_GEN_INSN3_GVEC(vpslldq, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldqi_xmm)
+DEF_GEN_INSN3_GVEC(vpslldq, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pslldqi_xmm)
+DEF_GEN_INSN3_GVEC(psrlw, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psrlwi_xmm)
+DEF_GEN_INSN3_GVEC(psrlw, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlwi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlw, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlwi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlw, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlwi_xmm)
+DEF_GEN_INSN3_GVEC(psrld, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psrldi_xmm)
+DEF_GEN_INSN3_GVEC(psrld, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrld, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrld, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldi_xmm)
+DEF_GEN_INSN3_GVEC(psrlq, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psrlqi_xmm)
+DEF_GEN_INSN3_GVEC(psrlq, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlq, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrlq, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrlqi_xmm)
+DEF_GEN_INSN3_GVEC(psrldq, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrldq, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldqi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrldq, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrldqi_xmm)
+DEF_GEN_INSN3_GVEC(psraw, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psrawi_xmm)
+DEF_GEN_INSN3_GVEC(psraw, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrawi_xmm)
+DEF_GEN_INSN3_GVEC(vpsraw, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrawi_xmm)
+DEF_GEN_INSN3_GVEC(vpsraw, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psrawi_xmm)
+DEF_GEN_INSN3_GVEC(psrad, Nq, Nq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, psradi_xmm)
+DEF_GEN_INSN3_GVEC(psrad, Udq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psradi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrad, Hdq, Udq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psradi_xmm)
+DEF_GEN_INSN3_GVEC(vpsrad, Hqq, Uqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, psradi_xmm)
 
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_mmx, Pq, Pq, Qq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_xmm, Vdq, Vdq, Wdq, Ib)
-- 
2.20.1


