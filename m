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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB848C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DE122DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyHnQpkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DE122DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VcE-0008Ms-JI
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US0-0001vD-Lx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0000B2-1A
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:12 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36]:44077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URy-00009w-SL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:10 -0400
Received: by mail-yb1-xb36.google.com with SMTP id y21so1330164ybi.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+6EW2oIxZaioHGi13+b0hflo+B7lUb7Q/oz7jaljYbw=;
 b=tyHnQpkwuUUAzoHre2jedUy+2BFTXYBPFUW+0NaHzNyYjUfk0Atp81UtO766Rq52iX
 pqOadzCJJM1yPLX6UG2X6QQJqTT1sP4nM7/TWDSx8G994mAng/S0vdgVAB/fpZc1cqEI
 58+vaQQydBydvDg7nbvXB82TA2wPHsXH7P4ycrfA27pqmQfFa/8He5GVxHGpTW2Wz+3a
 11xFA0VCAEZbIe+4heqwrAsw/uAQB4u+jBiWBCVxu6TSx9OscQgNOVxXRYqNU/v0gJfR
 OJRCsRrB+kaD1L8uo0UJn4wrDIN4DGNrVJffXTdJ3WdKQ7eSdLeeCFpO9PjagBngzc7X
 INvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+6EW2oIxZaioHGi13+b0hflo+B7lUb7Q/oz7jaljYbw=;
 b=Okxdqwzd1eS1F+B5gzgCuK0mrBfHNPTx/ugFvEL4kE1O/fIvXBBS4XKa660NKXgiWU
 /u8SgV2zOG1lCrE4/9wRk5TYp6fNtCznxi6VRX7l2tr5XD+A6ra5UwlkXCyFPUgZFimi
 0wsUOwncxYQD0EpczhWIp33osxFCVwxRxLNyIkf17ONba3dae7cE9eEArwR2o5kgIZRb
 oeyF84BAyLcnPkZ/5r+ZsvNruApWa2z5fFtdPbqjghKWQsEGQZs93aTLoj/cqK7jxv8Z
 ++VVe9/oEO44CnK1MrhD1mel3xrcKXW8RR0yN5FfH6p4oGmalSs+ekcwmzl2C3IB3CZ7
 H4eA==
X-Gm-Message-State: APjAAAVhElFOwfEBAndx++Kz4D/Kgj42ogEl23Hlr//1+jGzNJ6TbqD3
 qEMwOzOmeswW21sv/PVAIIW1KiJt
X-Google-Smtp-Source: APXvYqzTuaURNH2cJ9Yg2VPgeqUk7PcsbH+52L/zN1/cVKZE7VHjSnhTddjd8VMfBK3sicPYAb8a4w==
X-Received: by 2002:a25:ccd7:: with SMTP id
 l206mr24413541ybf.165.1566408669908; 
 Wed, 21 Aug 2019 10:31:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:48 -0400
Message-Id: <20190821172951.15333-73-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b36
Subject: [Qemu-devel] [RFC PATCH v4 72/75] target/i386: convert psadbw
 helper to gvec style
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
 target/i386/ops_sse.h        | 64 +++++++++++++++---------------------
 target/i386/ops_sse_header.h |  2 +-
 target/i386/translate.c      |  9 +++--
 3 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 384a835662..b866ead1c8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -412,6 +412,15 @@ static inline int satsw(int x)
     }
 }
 
+static inline int abs1(int x)
+{
+    if (x < 0) {
+        return -x;
+    } else {
+        return x;
+    }
+}
+
 #define FMULHRW(a, b) (((int16_t)(a) * (int16_t)(b) + 0x8000) >> 16)
 #endif
 
@@ -510,52 +519,33 @@ void glue(helper_pmaddwd, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
     glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-#if SHIFT == 0
-static inline int abs1(int a)
+void glue(helper_psadbw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    if (a < 0) {
-        return -a;
-    } else {
-        return a;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        const uint64_t t0 = abs1(a->B(8 * i + 0) - b->B(8 * i + 0));
+        const uint64_t t1 = abs1(a->B(8 * i + 1) - b->B(8 * i + 1));
+        const uint64_t t2 = abs1(a->B(8 * i + 2) - b->B(8 * i + 2));
+        const uint64_t t3 = abs1(a->B(8 * i + 3) - b->B(8 * i + 3));
+        const uint64_t t4 = abs1(a->B(8 * i + 4) - b->B(8 * i + 4));
+        const uint64_t t5 = abs1(a->B(8 * i + 5) - b->B(8 * i + 5));
+        const uint64_t t6 = abs1(a->B(8 * i + 6) - b->B(8 * i + 6));
+        const uint64_t t7 = abs1(a->B(8 * i + 7) - b->B(8 * i + 7));
+        d->Q(i) = t0 + t1 + t2 + t3 + t4 + t5 + t6 + t7;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
-#endif
-void glue(helper_psadbw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
-{
-    unsigned int val;
 
-    val = 0;
-    val += abs1(d->B(0) - s->B(0));
-    val += abs1(d->B(1) - s->B(1));
-    val += abs1(d->B(2) - s->B(2));
-    val += abs1(d->B(3) - s->B(3));
-    val += abs1(d->B(4) - s->B(4));
-    val += abs1(d->B(5) - s->B(5));
-    val += abs1(d->B(6) - s->B(6));
-    val += abs1(d->B(7) - s->B(7));
-    d->Q(0) = val;
-#if SHIFT == 1
-    val = 0;
-    val += abs1(d->B(8) - s->B(8));
-    val += abs1(d->B(9) - s->B(9));
-    val += abs1(d->B(10) - s->B(10));
-    val += abs1(d->B(11) - s->B(11));
-    val += abs1(d->B(12) - s->B(12));
-    val += abs1(d->B(13) - s->B(13));
-    val += abs1(d->B(14) - s->B(14));
-    val += abs1(d->B(15) - s->B(15));
-    d->Q(1) = val;
-#endif
-}
-
-void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *a, Reg *b,
                                   target_ulong a0)
 {
     int i;
 
     for (i = 0; i < (8 << SHIFT); i++) {
-        if (s->B(i) & 0x80) {
-            cpu_stb_data_ra(env, a0 + i, d->B(i), GETPC());
+        if (b->B(i) & 0x80) {
+            cpu_stb_data_ra(env, a0 + i, a->B(i), GETPC());
         }
     }
 }
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 18d39ca649..ec7d1fc686 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -74,7 +74,7 @@ DEF_HELPER_4(glue(pavgw, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(pmuludq, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(pmaddwd, SUFFIX), void, Reg, Reg, Reg, i32)
 
-DEF_HELPER_3(glue(psadbw, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(psadbw, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(maskmov, SUFFIX), void, env, Reg, Reg, tl)
 DEF_HELPER_2(glue(movl_mm_T0, SUFFIX), void, Reg, i32)
 #ifdef TARGET_X86_64
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 55607db09c..6bffbaee4c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2806,7 +2806,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
-    [0xf6] = MMX_OP2(psadbw),
     [0xf7] = { (SSEFunc_0_epp)gen_helper_maskmov_mmx,
                (SSEFunc_0_epp)gen_helper_maskmov_xmm }, /* XXX: casts */
 };
@@ -6256,10 +6255,10 @@ DEF_GEN_INSN3_GVEC(pavgw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pavgw_mmx)
 DEF_GEN_INSN3_GVEC(pavgw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
 DEF_GEN_INSN3_GVEC(vpavgw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
 DEF_GEN_INSN3_GVEC(vpavgw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
-DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(psadbw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, psadbw_mmx)
+DEF_GEN_INSN3_GVEC(psadbw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psadbw_xmm)
+DEF_GEN_INSN3_GVEC(vpsadbw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psadbw_xmm)
+DEF_GEN_INSN3_GVEC(vpsadbw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, psadbw_xmm)
 DEF_GEN_INSN4_HELPER_EPPI(mpsadbw, mpsadbw_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vmpsadbw, mpsadbw_xmm, Vdq, Hdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(vmpsadbw, mpsadbw_xmm, Vqq, Hqq, Wqq, Ib)
-- 
2.20.1


