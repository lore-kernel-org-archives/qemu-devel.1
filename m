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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5EEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E9A216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8L39zn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E9A216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VRo-0007Ec-PV
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US3-0001yV-12
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US0-0000DA-OP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:14 -0400
Received: from mail-yw1-xc32.google.com ([2607:f8b0:4864:20::c32]:36337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0US0-0000Cl-JL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:12 -0400
Received: by mail-yw1-xc32.google.com with SMTP id m11so1245542ywh.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7bR2HUr7nWzHcbedf2vlhprEYxS2A4qecEYLgRJuH1o=;
 b=e8L39zn42txzDmJPL9b5Udmhr9tEXnYt7xaJdFJ1NGgHsBD+2zLXadlXVdAHjz7cnA
 DOIs+y3i5RhCJOKcXW6nW7VXZg5DqIAMkg/b3JW4Tl9nx2HY1DI/Yp8H8N5hJtT/BXCV
 LJrm93JUiDaj8ydl9eSAOADbzIt83IbFUGnLVxdYS12KRyYfyP0ZE7+9f+V6cSeUXW9K
 Otx7xnel1Avpo8mQiHZeh+R/IwHp7XNfoQ4HxqCRNuVlJrI9h7sWuCmYcb0mkg67tjr0
 vnusbYlzw/hqhcd/EaM6NXzDKDpDSEVSwXs7pPbxLeFeszT4X1vrZszu8FOa9nRmYKrm
 INRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7bR2HUr7nWzHcbedf2vlhprEYxS2A4qecEYLgRJuH1o=;
 b=ZHbFrhfPzONv4RwOCaNwJrRIF5NyNpHuhcGRDyj9qpNfRSh1sgulnaUYOp6PWRyrQs
 J0GCpVVkjkSOk9KTvkWoy7eoYYFOe0U3xdBaW8oIONwv3MuN04Q7mfkSFf1DVrSLMBTF
 jp+r/F/lvfOxOxK8SJP8Q/Z3tlF9tr7ZnLtxaSIbVafVj6XiRJzPLzcSeZPwjEKEV834
 lnLDi13UOO9zwP/Ed4DFhRmpNpE1HTAqaPRF5OAv7jQt0b4OeMivrZjVoCHJhTRnLs1H
 7AW28yPA3qx2q3ytrHzW7cbrAz7sym0fQzohgBqLDrrYAuhqX7AOIiMhWHeDsZypMMb7
 yevA==
X-Gm-Message-State: APjAAAW+hpQf3BPJeeu3qqv6tO1tpySrDe2ZHOFbMti1KnIqya9VWbQj
 kBLep9TCNthSbvWMjgmKvOZvTEX1
X-Google-Smtp-Source: APXvYqybD8U7e3QbwlnX4n4h/LuyPg5LuzMR6sAyYxiGzkidxj3IcmYweVRkrEMw0FgzJj009FTyoQ==
X-Received: by 2002:a81:9293:: with SMTP id
 j141mr25651734ywg.363.1566408671687; 
 Wed, 21 Aug 2019 10:31:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:11 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:50 -0400
Message-Id: <20190821172951.15333-75-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c32
Subject: [Qemu-devel] [RFC PATCH v4 74/75] target/i386: convert pshuf(w, lw,
 hw, d), shuf(pd, ps) helpers to gvec style
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
 target/i386/ops_sse.h        | 141 ++++++++++++++++++++++++-----------
 target/i386/ops_sse_header.h |  12 +--
 target/i386/translate.c      |  34 ++++-----
 3 files changed, 119 insertions(+), 68 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 8172324e34..2e50d91a25 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -551,70 +551,123 @@ void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *a, Reg *b,
 }
 
 #if SHIFT == 0
-void glue(helper_pshufw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(helper_pshufw, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    Reg r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
 
-    r.W(0) = s->W(order & 3);
-    r.W(1) = s->W((order >> 2) & 3);
-    r.W(2) = s->W((order >> 4) & 3);
-    r.W(3) = s->W((order >> 6) & 3);
-    *d = r;
+    for (intptr_t i = 0; 4 * i * sizeof(uint16_t) < oprsz; ++i) {
+        const uint16_t t0 = a->W(4 * i + ((ctrl >> 0) & 3));
+        const uint16_t t1 = a->W(4 * i + ((ctrl >> 2) & 3));
+        const uint16_t t2 = a->W(4 * i + ((ctrl >> 4) & 3));
+        const uint16_t t3 = a->W(4 * i + ((ctrl >> 6) & 3));
+
+        d->W(4 * i + 0) = t0;
+        d->W(4 * i + 1) = t1;
+        d->W(4 * i + 2) = t2;
+        d->W(4 * i + 3) = t3;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 #else
-void helper_shufps(Reg *d, Reg *s, int order)
+void glue(helper_pshuflw, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    Reg r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
 
-    r.L(0) = d->L(order & 3);
-    r.L(1) = d->L((order >> 2) & 3);
-    r.L(2) = s->L((order >> 4) & 3);
-    r.L(3) = s->L((order >> 6) & 3);
-    *d = r;
+    for (intptr_t i = 0; 8 * i * sizeof(uint16_t) < oprsz; ++i) {
+        const uint16_t t0 = a->W(8 * i + ((ctrl >> 0) & 3));
+        const uint16_t t1 = a->W(8 * i + ((ctrl >> 2) & 3));
+        const uint16_t t2 = a->W(8 * i + ((ctrl >> 4) & 3));
+        const uint16_t t3 = a->W(8 * i + ((ctrl >> 6) & 3));
+
+        d->W(8 * i + 0) = t0;
+        d->W(8 * i + 1) = t1;
+        d->W(8 * i + 2) = t2;
+        d->W(8 * i + 3) = t3;
+        d->Q(2 * i + 1) = a->Q(2 * i + 1);
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void helper_shufpd(Reg *d, Reg *s, int order)
+void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    Reg r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
+
+    for (intptr_t i = 0; 8 * i * sizeof(uint16_t) < oprsz; ++i) {
+        const uint16_t t0 = a->W(8 * i + 4 + ((ctrl >> 0) & 3));
+        const uint16_t t1 = a->W(8 * i + 4 + ((ctrl >> 2) & 3));
+        const uint16_t t2 = a->W(8 * i + 4 + ((ctrl >> 4) & 3));
+        const uint16_t t3 = a->W(8 * i + 4 + ((ctrl >> 6) & 3));
 
-    r.Q(0) = d->Q(order & 1);
-    r.Q(1) = s->Q((order >> 1) & 1);
-    *d = r;
+        d->Q(2 * i + 0) = a->Q(2 * i + 0);
+        d->W(8 * i + 4) = t0;
+        d->W(8 * i + 5) = t1;
+        d->W(8 * i + 6) = t2;
+        d->W(8 * i + 7) = t3;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pshufd, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(helper_pshufd, SUFFIX)(Reg *d, Reg *a, uint32_t desc)
 {
-    Reg r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
+
+    for (intptr_t i = 0; 4 * i * sizeof(uint32_t) < oprsz; ++i) {
+        const uint32_t t0 = a->L(4 * i + ((ctrl >> 0) & 3));
+        const uint32_t t1 = a->L(4 * i + ((ctrl >> 2) & 3));
+        const uint32_t t2 = a->L(4 * i + ((ctrl >> 4) & 3));
+        const uint32_t t3 = a->L(4 * i + ((ctrl >> 6) & 3));
+
+        d->L(4 * i + 0) = t0;
+        d->L(4 * i + 1) = t1;
+        d->L(4 * i + 2) = t2;
+        d->L(4 * i + 3) = t3;
 
-    r.L(0) = s->L(order & 3);
-    r.L(1) = s->L((order >> 2) & 3);
-    r.L(2) = s->L((order >> 4) & 3);
-    r.L(3) = s->L((order >> 6) & 3);
-    *d = r;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pshuflw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(helper_shufps, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    Reg r;
-
-    r.W(0) = s->W(order & 3);
-    r.W(1) = s->W((order >> 2) & 3);
-    r.W(2) = s->W((order >> 4) & 3);
-    r.W(3) = s->W((order >> 6) & 3);
-    r.Q(1) = s->Q(1);
-    *d = r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
+
+    for (intptr_t i = 0; 4 * i * sizeof(uint32_t) < oprsz; ++i) {
+        const uint32_t t0 = a->L(4 * i + ((ctrl >> 0) & 3));
+        const uint32_t t1 = a->L(4 * i + ((ctrl >> 2) & 3));
+        const uint32_t t2 = b->L(4 * i + ((ctrl >> 4) & 3));
+        const uint32_t t3 = b->L(4 * i + ((ctrl >> 6) & 3));
+
+        d->W(4 * i + 0) = t0;
+        d->W(4 * i + 1) = t1;
+        d->W(4 * i + 2) = t2;
+        d->W(4 * i + 3) = t3;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(helper_shufpd, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    Reg r;
-
-    r.Q(0) = s->Q(0);
-    r.W(4) = s->W(4 + (order & 3));
-    r.W(5) = s->W(4 + ((order >> 2) & 3));
-    r.W(6) = s->W(4 + ((order >> 4) & 3));
-    r.W(7) = s->W(4 + ((order >> 6) & 3));
-    *d = r;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+    const uint8_t ctrl = simd_data(desc);
+
+    for (intptr_t i = 0; 2 * i * sizeof(uint64_t) < oprsz; ++i) {
+        const uint64_t t0 = a->Q(2 * i + ((ctrl >> 0) & 1));
+        const uint64_t t1 = b->Q(2 * i + ((ctrl >> 1) & 1));
+
+        d->Q(2 * i + 0) = t0;
+        d->Q(2 * i + 1) = t1;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 #endif
 
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index ee8bd4c1af..207d41e248 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -78,13 +78,13 @@ DEF_HELPER_4(glue(psadbw, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(maskmov, SUFFIX), void, env, Reg, Reg, tl)
 
 #if SHIFT == 0
-DEF_HELPER_3(glue(pshufw, SUFFIX), void, Reg, Reg, int)
+DEF_HELPER_3(glue(pshufw, SUFFIX), void, Reg, Reg, i32)
 #else
-DEF_HELPER_3(shufps, void, Reg, Reg, int)
-DEF_HELPER_3(shufpd, void, Reg, Reg, int)
-DEF_HELPER_3(glue(pshufd, SUFFIX), void, Reg, Reg, int)
-DEF_HELPER_3(glue(pshuflw, SUFFIX), void, Reg, Reg, int)
-DEF_HELPER_3(glue(pshufhw, SUFFIX), void, Reg, Reg, int)
+DEF_HELPER_3(glue(pshuflw, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(pshufhw, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_3(glue(pshufd, SUFFIX), void, Reg, Reg, i32)
+DEF_HELPER_4(glue(shufps, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(shufpd, SUFFIX), void, Reg, Reg, Reg, i32)
 #endif
 
 #if SHIFT == 1
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3554086336..bb4120a848 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2763,8 +2763,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x5b] = { gen_helper_cvtdq2ps, gen_helper_cvtps2dq, gen_helper_cvttps2dq },
 
     [0xc2] = SSE_FOP(cmpeq),
-    [0xc6] = { (SSEFunc_0_epp)gen_helper_shufps,
-               (SSEFunc_0_epp)gen_helper_shufpd }, /* XXX: casts */
 
     /* SSSE3, SSE4, MOVBE, CRC32, BMI1, BMI2, ADX.  */
     [0x38] = { SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
@@ -6971,22 +6969,22 @@ DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpshufb, pshufb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpshufb, pshufb_xmm, Vqq, Hqq, Wqq)
-DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshuflw, pshuflw_xmm, Vqq, Wqq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshufhw, pshufhw_xmm, Vqq, Wqq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshufd, pshufd_xmm, Vdq, Wdq, Ib)
-DEF_GEN_INSN3_HELPER_PPI(vpshufd, pshufd_xmm, Vqq, Wqq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vdq, Hdq, Wdq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vqq, Hqq, Wqq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(shufpd, shufpd, Vdq, Vdq, Wdq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(vshufpd, shufpd, Vdq, Hdq, Wdq, Ib)
-DEF_GEN_INSN4_HELPER_PPI(vshufpd, shufpd, Vqq, Hqq, Wqq, Ib)
+DEF_GEN_INSN3_GVEC(pshufw, Pq, Qq, Ib, 2i_ool, MM_OPRSZ, MM_MAXSZ, pshufw_mmx)
+DEF_GEN_INSN3_GVEC(pshuflw, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshuflw_xmm)
+DEF_GEN_INSN3_GVEC(vpshuflw, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshuflw_xmm)
+DEF_GEN_INSN3_GVEC(vpshuflw, Vqq, Wqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshuflw_xmm)
+DEF_GEN_INSN3_GVEC(pshufhw, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufhw_xmm)
+DEF_GEN_INSN3_GVEC(vpshufhw, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufhw_xmm)
+DEF_GEN_INSN3_GVEC(vpshufhw, Vqq, Wqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufhw_xmm)
+DEF_GEN_INSN3_GVEC(pshufd, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufd_xmm)
+DEF_GEN_INSN3_GVEC(vpshufd, Vdq, Wdq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufd_xmm)
+DEF_GEN_INSN3_GVEC(vpshufd, Vqq, Wqq, Ib, 2i_ool, XMM_OPRSZ, XMM_MAXSZ, pshufd_xmm)
+DEF_GEN_INSN4_GVEC(shufps, Vdq, Vdq, Wdq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufps_xmm)
+DEF_GEN_INSN4_GVEC(vshufps, Vdq, Hdq, Wdq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufps_xmm)
+DEF_GEN_INSN4_GVEC(vshufps, Vqq, Hqq, Wqq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufps_xmm)
+DEF_GEN_INSN4_GVEC(shufpd, Vdq, Vdq, Wdq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufpd_xmm)
+DEF_GEN_INSN4_GVEC(vshufpd, Vdq, Hdq, Wdq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufpd_xmm)
+DEF_GEN_INSN4_GVEC(vshufpd, Vqq, Hqq, Wqq, Ib, 3i_ool, XMM_OPRSZ, XMM_MAXSZ, shufpd_xmm)
 
 DEF_GEN_INSN4_HELPER_EPPI(blendps, blendps_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vblendps, blendps_xmm, Vdq, Hdq, Wdq, Ib)
-- 
2.20.1


