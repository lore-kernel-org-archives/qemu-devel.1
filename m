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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD36216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQHIe3qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD36216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VPJ-0003a3-PQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URy-0001rk-5g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URw-00007v-B7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:10 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URw-00007d-5p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:08 -0400
Received: by mail-yb1-xb44.google.com with SMTP id j199so1343304ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GgH8nUWn4/ATpKN8BOE+DhOwRl+PR6wW9XuCGiyh5qE=;
 b=mQHIe3qtxEWa21brJCcaMKDwmSPmPePpbQSmmhW2W8wWDawzaUlPJd91hikgv8zFDi
 i330gNocWm8iPbz0/7QrgZNPV5VVSl3kIOkSlBc9o33H9lRBL58LxVnTJYLer0XlLFm4
 LFTTnGMG/s78ifS5Yx9hhbUd++SPDO5xC6Q5jQ20NN+O9iG2mKqsWjrm5PmY9NIDd+qd
 b9mlhhjCamqJ+2WmKRpeBMrd5IorHYIFLW+QOX7Pc2nIhrNwS9u7XvMbFnDrgcFgoQ+b
 3bxRF1aQqqjnIuq1tjFO/SKRxEI0yCRT/L1WXkCzbdao+dNFxUh+GQx3wZEsRBrPIznA
 wb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GgH8nUWn4/ATpKN8BOE+DhOwRl+PR6wW9XuCGiyh5qE=;
 b=iJ60C1TxvDJumVOLQoA5oAJpNJj7LyifoCLGIcKkKWD4QIsfzXxtyaN6b7XadDdBfw
 S8a3qT6akyvCFBXg01fPjjEi5d+WN4LWdcHL71VpvYEoMgaXJM3YZ/NxQxD3FJG19h1S
 enjhpCJH3y1OmhGOOPTB+/WdQ6s+TmLCP4GVSUECL1GKdIGr7SAoCmuSU1VPZmE46vOS
 VBDyF+IK6peff+PSKwgrdZgMwR0ZEAmY0EuAsVoQh0A2nfabC+uiIbEckX0vGmvbCNsU
 RIhW07pXavDUYVgYxMbhORQ1SAVMWtm683+ijvhEkntS7bwhxm/FZAXM/we9GfHy4O50
 KDZg==
X-Gm-Message-State: APjAAAXpEzsRYq0mluG1lFoAUlqkJlRy4xMYl69+mw81hDxImb+5zod0
 jkl2fEZJejM15vSLz0rzfozzbG7S
X-Google-Smtp-Source: APXvYqwegk5Zd8ecA7WwxS++iPkZ4TNjbtvcQbzL6GGQ+dTjjxv3y0rMePl8jjn1KrPZUyhvvNSPMg==
X-Received: by 2002:a25:90f:: with SMTP id 15mr1280286ybj.344.1566408667449;
 Wed, 21 Aug 2019 10:31:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:46 -0400
Message-Id: <20190821172951.15333-71-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 70/75] target/i386: convert pavgb/pavgw
 helpers to gvec style
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
 target/i386/ops_sse.h        | 33 +++++++++++++++++++++++++++++----
 target/i386/ops_sse_header.h |  7 +++++--
 target/i386/translate.c      | 20 +++++++++-----------
 3 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 6ec116573b..1661bd7c64 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -413,8 +413,6 @@ static inline int satsw(int x)
 }
 
 #define FMULHRW(a, b) (((int16_t)(a) * (int16_t)(b) + 0x8000) >> 16)
-
-#define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
 void glue(helper_pmullw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
@@ -457,8 +455,35 @@ void glue(helper_pmulhw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
     glue(clear_high, SUFFIX)(d, oprsz, maxsz);
 }
 
-SSE_HELPER_B(helper_pavgb, FAVG)
-SSE_HELPER_W(helper_pavgw, FAVG)
+void glue(helper_pavgb, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint8_t) < oprsz; ++i) {
+        d->B(i) = (a->B(i) + b->B(i) + 1) >> 1;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
+
+#if SHIFT == 0
+void glue(helper_pavgusb, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+{
+    const uint32_t desc = simd_desc(sizeof(Reg), sizeof(Reg), 0);
+    glue(helper_pavgb, SUFFIX)(d, s, s, desc);
+}
+#endif
+
+void glue(helper_pavgw, SUFFIX)(Reg *d, Reg *a, Reg *b, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
+    const intptr_t maxsz = simd_maxsz(desc);
+
+    for (intptr_t i = 0; i * sizeof(uint16_t) < oprsz; ++i) {
+        d->W(i) = (a->W(i) + b->W(i) + 1) >> 1;
+    }
+    glue(clear_high, SUFFIX)(d, oprsz, maxsz);
+}
 
 void glue(helper_pmuludq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 7e6411fc82..b5e8aae897 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -65,8 +65,11 @@ DEF_HELPER_3(glue(pmulhrw, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_4(glue(pmulhuw, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(pmulhw, SUFFIX), void, Reg, Reg, Reg, i32)
 
-DEF_HELPER_3(glue(pavgb, SUFFIX), void, env, Reg, Reg)
-DEF_HELPER_3(glue(pavgw, SUFFIX), void, env, Reg, Reg)
+DEF_HELPER_4(glue(pavgb, SUFFIX), void, Reg, Reg, Reg, i32)
+#if SHIFT == 0
+DEF_HELPER_3(glue(pavgusb, SUFFIX), void, env, Reg, Reg)
+#endif
+DEF_HELPER_4(glue(pavgw, SUFFIX), void, Reg, Reg, Reg, i32)
 
 DEF_HELPER_3(glue(pmuludq, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(pmaddwd, SUFFIX), void, env, Reg, Reg)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 79f8c1ddac..77b2e18f34 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2803,8 +2803,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd0] = { NULL, gen_helper_addsubpd, NULL, gen_helper_addsubps },
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
-    [0xe0] = MMX_OP2(pavgb),
-    [0xe3] = MMX_OP2(pavgw),
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
@@ -2878,7 +2876,7 @@ static const SSEFunc_0_epp sse_op_table5[256] = {
     [0xb6] = gen_helper_movq, /* pfrcpit2 */
     [0xb7] = gen_helper_pmulhrw_mmx,
     [0xbb] = gen_helper_pswapd,
-    [0xbf] = gen_helper_pavgb_mmx /* pavgusb */
+    [0xbf] = gen_helper_pavgusb_mmx
 };
 
 struct SSEOpHelper_epp {
@@ -6252,14 +6250,14 @@ DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(vmaxss, maxss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(maxsd, maxsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(vmaxsd, maxsd, Vq, Hq, Wq)
-DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpavgb, pavgb_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpavgb, pavgb_xmm, Vqq, Hqq, Wqq)
-DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
-DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpavgw, pavgw_xmm, Vdq, Hdq, Wdq)
-DEF_GEN_INSN3_HELPER_EPP(vpavgw, pavgw_xmm, Vqq, Hqq, Wqq)
+DEF_GEN_INSN3_GVEC(pavgb, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pavgb_mmx)
+DEF_GEN_INSN3_GVEC(pavgb, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgb_xmm)
+DEF_GEN_INSN3_GVEC(vpavgb, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgb_xmm)
+DEF_GEN_INSN3_GVEC(vpavgb, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgb_xmm)
+DEF_GEN_INSN3_GVEC(pavgw, Pq, Pq, Qq, 3_ool, MM_OPRSZ, MM_MAXSZ, pavgw_mmx)
+DEF_GEN_INSN3_GVEC(pavgw, Vdq, Vdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
+DEF_GEN_INSN3_GVEC(vpavgw, Vdq, Hdq, Wdq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
+DEF_GEN_INSN3_GVEC(vpavgw, Vqq, Hqq, Wqq, 3_ool, XMM_OPRSZ, XMM_MAXSZ, pavgw_xmm)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vdq, Hdq, Wdq)
-- 
2.20.1


