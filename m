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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D1222D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpOmLS+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D1222D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VEZ-0001YX-FJ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URk-0001gI-MR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0008EP-MF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:42661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00087A-Mh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:54 -0400
Received: by mail-yw1-xc43.google.com with SMTP id z63so1230585ywz.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1jERwIPIqXMfT3UR8I7azk7/2A3NcFEkOETXPyGFr8o=;
 b=LpOmLS+n0P3+DivJVz2taSpvPj74nEHpRTEh4sCRo6rXU86hfyTSyUaIzt5oeeatT2
 U9O+rT14qwQs9v8ZhOYBmtOaMHXslf6VF3FLhE9hjoV6soMKzzhd1u/A11U/k42ThbwE
 i4Q1fsrD8bkB6JHDWCaLGpO62Sm2t9P38p6cLme2frwNAdfZyAMEQIC4uE83E7dEcQ+3
 H3EX50wAfPuLy7TU0bxVMQ5zr1BDRfZ2Wf5WI+s5R1VV273lgDdjzf1D3XSbZgVeCcBe
 nJRUy+V8kxsbWdm7Gn402t5wJnc5rGXsoy7yzxvY08f0gqTxrN7b9FM6LKPOQJGVY7dp
 0+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1jERwIPIqXMfT3UR8I7azk7/2A3NcFEkOETXPyGFr8o=;
 b=NeMkAAlzh63Oo1xCRMQXqtTgV8RwZCJJcXtKVHgWMeFlRtWVQPMzATq3068rnUyK07
 +UJeVke/uqJRVK5MWkw1yFKOdAE7mjEPe7TXQsXCxSzb7SKpOy6pOKiaiSaVT2B072f0
 7etqjDR5T+Rth54/aIUNZO1QEAVj36sYsPs+lWGgvSDE/e05tZ/MIb+cIZDt+UwMZQN9
 YlpCXvcNOjKWcJK5KDlSWFUi6tAADRTNcAFGJJliglkNUvbI68ZaaJKaMlc+FJEcH2n0
 rP68EmNZliIs0YNfN6/GHnQA1t/drG8Ws8RaAFpbbLZz5Uml1brXeHBBWuqG6Q9b4JJy
 CBDg==
X-Gm-Message-State: APjAAAXKfRRhzCIGMA2Z/HEu0s7QHWlFDgVb1+r6JWbp48vLVHTUCiW3
 UGxWAKqCG3bATv7VMkAyw/kABwqq
X-Google-Smtp-Source: APXvYqxRTQfxe19p5KLnxefQbMair6pwd8TF0o2/y/oNl1shxW2bEeiU1awvbTvfvwVQ66F4Pz30iw==
X-Received: by 2002:a81:918c:: with SMTP id i134mr15564634ywg.65.1566408650130; 
 Wed, 21 Aug 2019 10:30:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:49 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:28 -0400
Message-Id: <20190821172951.15333-53-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 52/75] target/i386: introduce SSE4.1
 code generators
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

Introduce code generators required by SSE4.1 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 101 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 110b963215..3ff063b701 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5919,10 +5919,12 @@ DEF_GEN_INSN3_HELPER_EPP(addsubpd, addsubpd, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmulld, pmulld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmuldq, pmuldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_mmx, Pq, Pq, Qq)
@@ -5952,16 +5954,25 @@ DEF_GEN_INSN2_HELPER_EPP(rsqrtss, rsqrtss, Vd, Wd)
 
 DEF_GEN_INSN3_GVEC(pminub, Pq, Pq, Qq, umin, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminub, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pminuw, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pminud, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(pminsb, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminsw, Pq, Pq, Qq, smin, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminsw, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pminsd, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(minpd, minpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(minsd, minsd, Vq, Vq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(phminposuw, phminposuw_xmm, Vdq, Wdq)
 DEF_GEN_INSN3_GVEC(pmaxub, Pq, Pq, Qq, umax, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxub, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pmaxuw, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pmaxud, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(pmaxsb, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxsw, Pq, Pq, Qq, smax, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxsw, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pmaxsd, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(maxpd, maxpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
@@ -5972,6 +5983,7 @@ DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN4_HELPER_EPPI(mpsadbw, mpsadbw_xmm, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_mmx, Pq, Qq)
@@ -5985,12 +5997,20 @@ DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_xmm, Vdq, Vdq, Wdq)
 
+DEF_GEN_INSN4_HELPER_EPPI(dpps, dpps_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(dppd, dppd_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(roundps, roundps_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(roundpd, roundpd_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(roundss, roundss_xmm, Vd, Wd, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(roundsd, roundsd_xmm, Vq, Wq, Ib)
+
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
@@ -5998,6 +6018,8 @@ DEF_GEN_INSN3_GVEC(pcmpgtw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
 
+DEF_GEN_INSN2_HELPER_EPP(ptest, ptest_xmm, Vdq, Wdq)
+
 DEF_GEN_INSN3_HELPER_EPP(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqpd, cmpeqpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqss, cmpeqss, Vd, Vd, Wd)
@@ -6253,6 +6275,7 @@ DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(packusdw, packusdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
@@ -6282,6 +6305,28 @@ DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufpd, shufpd, Vdq, Vdq, Wdq, Ib)
 
+DEF_GEN_INSN4_HELPER_EPPI(blendps, blendps_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(blendpd, blendpd_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPP(blendvps, blendvps_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(blendvpd, blendvpd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pblendvb, pblendvb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN4_HELPER_EPPI(pblendw, pblendw_xmm, Vdq, Vdq, Wdq, Ib)
+
+GEN_INSN4(insertps, Vdq, Vdq, Wd, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t dofs = offsetof(ZMMReg, ZMM_L(arg4 & 3));
+    const size_t aofs = offsetof(ZMMReg, ZMM_L(0));
+    gen_op_movl(s, arg1 + dofs, arg3 + aofs);
+}
+GEN_INSN4(pinsrb, Vdq, Vdq, RdMb, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t ofs = offsetof(ZMMReg, ZMM_B(arg4 & 15));
+    tcg_gen_st8_i32(arg3, cpu_env, arg1 + ofs);
+}
 GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
 {
     assert(arg1 == arg2);
@@ -6296,7 +6341,46 @@ GEN_INSN4(pinsrw, Vdq, Vdq, RdMw, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_W(arg4 & 7));
     tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(pinsrd, Vdq, Vdq, Ed, Ib)
+{
+    assert(arg1 == arg2);
 
+    const size_t ofs = offsetof(ZMMReg, ZMM_L(arg4 & 3));
+    tcg_gen_st_i32(arg3, cpu_env, arg1 + ofs);
+}
+GEN_INSN4(pinsrq, Vdq, Vdq, Eq, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t ofs = offsetof(ZMMReg, ZMM_Q(arg4 & 1));
+    tcg_gen_st_i64(arg3, cpu_env, arg1 + ofs);
+}
+
+GEN_INSN3(extractps, Ed, Vdq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_L(arg3 & 3));
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
+}
+GEN_INSN3(pextrb, RdMb, Vdq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_B(arg3 & 15));
+    tcg_gen_ld8u_i32(arg1, cpu_env, arg2 + ofs);
+}
+GEN_INSN3(pextrw, RdMw, Vdq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
+    tcg_gen_ld16u_i32(arg1, cpu_env, arg2 + ofs);
+}
+GEN_INSN3(pextrd, Ed, Vdq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_L(arg3 & 3));
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
+}
+GEN_INSN3(pextrq, Eq, Vdq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_Q(arg3 & 1));
+    tcg_gen_ld_i64(arg1, cpu_env, arg2 + ofs);
+}
 GEN_INSN3(pextrw, Gd, Nq, Ib)
 {
     const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
@@ -6318,6 +6402,19 @@ GEN_INSN3(pextrw, Gq, Udq, Ib)
     tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
 }
 
+DEF_GEN_INSN2_HELPER_EPP(pmovsxbw, pmovsxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(pmovsxbd, pmovsxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(pmovsxbq, pmovsxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(pmovsxwd, pmovsxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(pmovsxwq, pmovsxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(pmovsxdq, pmovsxdq_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxbw, pmovzxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxbd, pmovzxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxbq, pmovzxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxwd, pmovzxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxwq, pmovzxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(pmovzxdq, pmovzxdq_xmm, Vdq, Wq)
+
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
 DEF_GEN_INSN2_HELPER_EPQ(cvtsi2ss, cvtsq2ss, Vd, Eq)
@@ -6407,6 +6504,10 @@ GEN_INSN2(movntdq, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(movntdqa, Vdq, Mdq)
+{
+    insnop_ldst(xmm, Mdq)(env, s, 0, arg1, arg2);
+}
 
 GEN_INSN0(pause)
 {
-- 
2.20.1


