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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04D022DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfOlwbAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04D022DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VP7-0003H9-IA
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URx-0001rB-Nx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URv-00007N-Iz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:09 -0400
Received: from mail-yw1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:45486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URv-00006r-CX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:07 -0400
Received: by mail-yw1-xc2c.google.com with SMTP id n69so1222877ywd.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6zlv0Nn+Ag8qhtIVP8TUS2cQxcEx2U/vv+75yRgZWxs=;
 b=qfOlwbAN2bqlZMVMeN1i6OXfb5+fpo6vIjJyNwJxijHO+j0aWRUhtaHHD962lMn42A
 MnRvF93ieYqrK0KCmr9X9T2z6wFu1OHRFEm396XAVheCFgihm6Fou+pBCpxkC3uQdXga
 K1GrTPK+JFDmUn5PL2GgFKUBDCj3+YJ8y+NyYIt6aa+foA6/abzgNNuxYXooe2ubryvA
 /xrmpghehoF9yoDYIHDOo3RyNzXhqJ91nhVfkdEsNsfTEO6ctsfaLzLkiq138Hh3T2lY
 uo5QA94TqjGIrtjM2YP7bQP0SM2rahJFqRSkZKso8iVecPhTi/ipcInIRhZ7XIyHEbtj
 DG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6zlv0Nn+Ag8qhtIVP8TUS2cQxcEx2U/vv+75yRgZWxs=;
 b=iPTYKf0ycW/tSJh6ufTu7OLX0kWCdSqPhQLhUdDtVpxoQ/N/pIoziLQCObm/O6ac4h
 rSYD/H2QM81m/GKoAZNQlw7X7Q7L5YnZTku/5QsK0B9M6bLBzwQVX1Gf9Xo9q8tdA+X2
 6n1MZ3hA15suu3WdfoN9Hzj8lIf7jmEfFTiWEM12jb9HZYfdPwstFec9+krdaa0tILZI
 euV4//6OYvFvvdjzXdbIEviZ8xOddgt0FTELwgLLP78qdKqPCtb14GrWxj+X4BKYSO0w
 QH/rM0JbEJP5FAS3x77kQpqFuSTvqzMyl0W5uPBEpFoO+F3AsrOXeMSW4IRR6epclwxE
 USfQ==
X-Gm-Message-State: APjAAAVjj18MBmMkcMJIQuIqgfmDeFnspT9l/Hw5as5QcJ0TsplIoSna
 VanKu67NqElJPNqhL7X5PS3/NMNn
X-Google-Smtp-Source: APXvYqzyvq4bCBXe1ZJNk6jq4uEFEPGFynARs2y2g+teRJ0d37OsisacC1mXqDDKWJl5olsDyRMLjA==
X-Received: by 2002:a81:30d7:: with SMTP id
 w206mr23732266yww.498.1566408666553; 
 Wed, 21 Aug 2019 10:31:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:05 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:45 -0400
Message-Id: <20190821172951.15333-70-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2c
Subject: [Qemu-devel] [RFC PATCH v4 69/75] target/i386: convert
 pmullw/pmulhw/pmulhuw helpers to gvec style
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
 target/i386/ops_sse.h        | 42 ++++++++++++++++++++++++++++++------
 target/i386/ops_sse_header.h |  6 +++---
 target/i386/translate.c      | 27 +++++++++++------------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 168e581c0c..6ec116573b 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -412,20 +412,50 @@ static inline int satsw(int x)
     }
 }
 
-#define FMULLW(a, b) ((a) * (b))
 #define FMULHRW(a, b) (((int16_t)(a) * (int16_t)(b) + 0x8000) >> 16)
-#define FMULHUW(a, b) ((a) * (b) >> 16)
-#define FMULHW(a, b) ((int16_t)(a) * (int16_t)(b) >> 16)
 
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_W(helper_pmullw, FMULLW)
+void glue(helper_pmullw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        const uint32_t t = (uint32_t)a->W(i) * (uint32_t)b->W(i);
+        d->W(i) = t;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
 #if SHIFT == 0
 SSE_HELPER_W(helper_pmulhrw, FMULHRW)
 #endif
-SSE_HELPER_W(helper_pmulhuw, FMULHUW)
-SSE_HELPER_W(helper_pmulhw, FMULHW)
+
+void glue(helper_pmulhuw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        const uint32_t t = (uint32_t)a->W(i) * (uint32_t)b->W(i);
+        d->W(i) = t >> 16;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+void glue(helper_pmulhw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        const int32_t t = (int32_t)a->W(i) * (int32_t)b->W(i);
+        d->W(i) = t >> 16;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
 
 SSE_HELPER_B(helper_pavgb, FAVG)
 SSE_HELPER_W(helper_pavgw, FAVG)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 724692a689..7e6411fc82 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -58,12 +58,12 @@ DEF_HELPER_3(glue(pslldqi, SUFFIX), void, Reg, Reg, i32)
 DEF_HELPER_3(glue(psrldqi, SUFFIX), void, Reg, Reg, i32)
 #endif
 
-DEF_HELPER_3(glue(pmullw, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(pmullw, SUFFIX), void, Reg, Reg, Reg, i32)
 #if SHIFT == 0
 DEF_HELPER_3(glue(pmulhrw, SUFFIX), void, env, Reg, Reg)
 #endif
-DEF_HELPER_3(glue(pmulhuw, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(pmulhw, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(pmulhuw, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(pmulhw, SUFFIX), void, Reg, Reg, Reg, i32)
 
 DEF_HELPER_3(glue(pavgb, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(pavgw, SUFFIX), void, env, Reg, Reg)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03f7c6e450..79f8c1ddac 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2801,13 +2801,10 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xc4] = { SSE_SPECIAL, SSE_SPECIAL }, /* pinsrw */
     [0xc5] = { SSE_SPECIAL, SSE_SPECIAL }, /* pextrw */
     [0xd0] = { NULL, gen_helper_addsubpd, NULL, gen_helper_addsubps },
-    [0xd5] = MMX_OP2(pmullw),
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
     [0xe0] = MMX_OP2(pavgb),
     [0xe3] = MMX_OP2(pavgw),
-    [0xe4] = MMX_OP2(pmulhuw),
-    [0xe5] = MMX_OP2(pmulhw),
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
@@ -6116,21 +6113,21 @@ DEF_GEN_INSN3_HELPER_EPP(addsubpd, addsubpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vaddsubpd, addsubpd, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vaddsubpd, addsubpd, Vqq, Hqq, Wqq)
 
-DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmullw, pmullw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmullw, pmullw_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(pmullw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pmullw_mmx)
+DEF_GEN_INSN3_GVEC(pmullw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmullw_xmm)
+DEF_GEN_INSN3_GVEC(vpmullw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmullw_xmm)
+DEF_GEN_INSN3_GVEC(vpmullw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmullw_xmm)
 DEF_GEN_INSN3_HELPER_EPP(pmulld, pmulld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulld, pmulld_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulld, pmulld_xmm, Vqq, Hqq, Wqq)
-DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmulhw, pmulhw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmulhw, pmulhw_xmm, Vqq, Hqq, Wqq)
-DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmulhuw, pmulhuw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmulhuw, pmulhuw_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(pmulhw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pmulhw_mmx)
+DEF_GEN_INSN3_GVEC(pmulhw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhw_xmm)
+DEF_GEN_INSN3_GVEC(vpmulhw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhw_xmm)
+DEF_GEN_INSN3_GVEC(vpmulhw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhw_xmm)
+DEF_GEN_INSN3_GVEC(pmulhuw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pmulhuw_mmx)
+DEF_GEN_INSN3_GVEC(pmulhuw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhuw_xmm)
+DEF_GEN_INSN3_GVEC(vpmulhuw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhuw_xmm)
+DEF_GEN_INSN3_GVEC(vpmulhuw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhuw_xmm)
 DEF_GEN_INSN3_HELPER_EPP(pmuldq, pmuldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vqq, Hqq, Wqq)
-- 
2.20.1


