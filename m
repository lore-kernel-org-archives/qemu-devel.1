Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BE2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BFD22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYp3n2j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BFD22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VaT-00045f-2w
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0001tQ-C5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URx-00008h-Gs
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:11 -0400
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:34434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URx-00008S-Cd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:09 -0400
Received: by mail-yw1-xc36.google.com with SMTP id n126so1251859ywf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VFSnIX9oN9KEpZo1ftTHo+xM5MdG+3Q40eSx9SWlUqM=;
 b=HYp3n2j9x6Ejp18qSnf/RSg1E9Oxasa+w5C6043NHEROfQW5j+EXS8HxSymxfG2Sh8
 ftXaGWyVUg5Gn0RR2MYBGsbUsHmH4TkhdtNgeILaGK4PFhWFrWB45O5l7FvM+/iRyFDT
 bwDRfHs4xbgVYxIRLPSM3swKiEhCJejYI/jeE16/OyNnKrH6qxdRrKsEhuQeHrGtROs4
 wq7e3anx9BkMFgQ8xoIrJ0GG5Qg8yl0ynVmdcw6WMHBckjo3v8mvDUh2/Rh/Uehi+OHl
 vqAj5VEw2hsWsEjNHHwKXeEp9btwGFEvw1/p7PVjuxAkPbYzC8qJY6POyyW+oa4YEFhX
 oNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VFSnIX9oN9KEpZo1ftTHo+xM5MdG+3Q40eSx9SWlUqM=;
 b=E2ynyf1H1hN1ruiJmSyjhN/36bMMUCHHGyyGF3cJRm95J5B7jbQAxkS1inQvcxh4cl
 HDDH0lVyKDH3yFg6qOg7WsWiLaSX7vOZsEKV7YTFaAz3xX89ZUhasbfsLphyNlr7GYUC
 SxMGAtIiv0DXHmnPaj3zgyfe7x7/wpmrOltVFDzbySmtCjLfsy8nF5iv+PfRbLy3ttoe
 kufel2vd2FyUBT7UZwlbBmhzr1+PNdV1DsjZrj0RD9ilaUmwPYG/YzjUYAeAzHGKjKzO
 uqcl6pYW0XYfVXkZKbXsG7FNTtk2V+q48Lc8sFGQ3KMjSYLhJvfgpevJig/cuw0E19Ll
 EKhQ==
X-Gm-Message-State: APjAAAVrOduhosXTszeDvCaHa4+Gx63qod6ycsOziNj7V5mAjBGr9Qh/
 TXhoUqgxVgEXqoBYsOt8aL9ZtUih
X-Google-Smtp-Source: APXvYqwwzE9IpclD+OEGaMMkKPqEvuFCqAXlX0hTkFsGuyV6tnc6TPWP/a1/4ZehtfKAw4jdy9U9IQ==
X-Received: by 2002:a81:6b54:: with SMTP id g81mr21947383ywc.283.1566408668571; 
 Wed, 21 Aug 2019 10:31:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:47 -0400
Message-Id: <20190821172951.15333-72-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c36
Subject: [Qemu-devel] [RFC PATCH v4 71/75] target/i386: convert
 pmuludq/pmaddwd helpers to gvec style
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
---
 target/i386/ops_sse.h        | 27 +++++++++++++++++----------
 target/i386/ops_sse_header.h |  4 ++--
 target/i386/translate.c      | 18 ++++++++----------
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 1661bd7c64..384a835662 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -485,22 +485,29 @@ void glue(helper_pavgw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
     glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pmuludq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_pmuludq, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    d->Q(0) = (uint64_t)s->L(0) * (uint64_t)d->L(0);
-#if SHIFT == 1
-    d->Q(1) = (uint64_t)s->L(2) * (uint64_t)d->L(2);
-#endif
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        const uint64_t t = (uint64_t)a->L(2 * i) * (uint64_t)b->L(2 * i);
+        d->Q(i) = t;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-void glue(helper_pmaddwd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(helper_pmaddwd, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
 {
-    int i;
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
 
-    for (i = 0; i < (2 << SHIFT); i++) {
-        d->L(i) = (int16_t)s->W(2 * i) * (int16_t)d->W(2 * i) +
-            (int16_t)s->W(2 * i + 1) * (int16_t)d->W(2 * i + 1);
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        const int32_t t0 = (int32_t)a->W(2 * i + 0) * (int32_t)b->W(2 * i + 0);
+        const int32_t t1 = (int32_t)a->W(2 * i + 1) * (int32_t)b->W(2 * i + 1);
+        d->L(i) = t0 + t1;
     }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
 #if SHIFT == 0
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index b5e8aae897..18d39ca649 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -71,8 +71,8 @@ DEF_HELPER_3(glue(pavgusb, SUFFIX), void, env, Reg, Reg)
 #endif
 DEF_HELPER_4(glue(pavgw, SUFFIX), void, Reg, Reg, Reg, i32)
 
-DEF_HELPER_3(glue(pmuludq, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(pmaddwd, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(pmuludq, SUFFIX), void, Reg, Reg, Reg, i32)
+DEF_HELPER_4(glue(pmaddwd, SUFFIX), void, Reg, Reg, Reg, i32)
 
 DEF_HELPER_3(glue(psadbw, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_4(glue(maskmov, SUFFIX), void, env, Reg, Reg, tl)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 77b2e18f34..55607db09c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2806,8 +2806,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
-    [0xf4] = MMX_OP2(pmuludq),
-    [0xf5] = MMX_OP2(pmaddwd),
     [0xf6] = MMX_OP2(psadbw),
     [0xf7] = { (SSEFunc_0_epp)gen_helper_maskmov_mmx,
                (SSEFunc_0_epp)gen_helper_maskmov_xmm }, /* XXX: casts */
@@ -6129,10 +6127,10 @@ DEF_GEN_INSN3_GVEC(vpmulhuw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmulhuw
 DEF_GEN_INSN3_HELPER_EPP(pmuldq, pmuldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vqq, Hqq, Wqq)
-DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmuludq, pmuludq_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmuludq, pmuludq_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(pmuludq, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pmuludq_mmx)
+DEF_GEN_INSN3_GVEC(pmuludq, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmuludq_xmm)
+DEF_GEN_INSN3_GVEC(vpmuludq, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmuludq_xmm)
+DEF_GEN_INSN3_GVEC(vpmuludq, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmuludq_xmm)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmulhrsw, pmulhrsw_xmm, Vdq, Hdq, Wdq)
@@ -6147,10 +6145,10 @@ DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(vmulss, mulss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(mulsd, mulsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(vmulsd, mulsd, Vq, Hq, Wq)
-DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmaddwd, pmaddwd_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpmaddwd, pmaddwd_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(pmaddwd, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pmaddwd_mmx)
+DEF_GEN_INSN3_GVEC(pmaddwd, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmaddwd_xmm)
+DEF_GEN_INSN3_GVEC(vpmaddwd, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmaddwd_xmm)
+DEF_GEN_INSN3_GVEC(vpmaddwd, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pmaddwd_xmm)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpmaddubsw, pmaddubsw_xmm, Vdq, Hdq, Wdq)
-- 
2.20.1


