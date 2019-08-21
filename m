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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07F3216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tih6xuJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07F3216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VMt-0008OE-Gr
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URv-0001mG-2c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008VO-IF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:06 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:35838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008Tb-9M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: by mail-yb1-xb29.google.com with SMTP id c9so1353992ybf.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ELavVPAMYOO+nLuOLzE5Zb0NTGmst1FkYCVc53be1Tg=;
 b=Tih6xuJ1W7susXkm9pkwRARV94xQsH8tHUbd7xjXS/BDRjFnHsunhbxVqzdHn0gEqt
 hQwm7iqXdyTMAINMx4ZUimqA+iWyxOF4X34WM/w8oQpvhRV6l0B6Er/FiL+kH47bPZb/
 0tEYGS+7bhpuLtDLxtYcWnsEcSP6YkrHkq/IyHD4w1lnUpWIAKbKpdTtmaE/6JHw3x9Q
 MDFddvZC2SJ0GH0wY/ETq6PHCa1jlZlz2hsFbkAIfNybbC1Clvwhea+lahUOCSaWR+/w
 HtWbQ8J4PFJGjBhsunTYenSPvCZ20tzb2a4uFj2ZvfYZBrOU/1MMdtYQAeDBUWvO0MQO
 VyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ELavVPAMYOO+nLuOLzE5Zb0NTGmst1FkYCVc53be1Tg=;
 b=LmT7yGEKgUvLp2X0x2xfJy0zO1u5EMn7Uigz4I96t2Ae7LjYAyk0SgLBxVnF+G8XBC
 l+MSKlsZ4u6q1kAxdPAIxk/hW1mhSUihT5nyaG23sMZJMimKAJh6X/cd5nux+ZGqSFqR
 OwGfU9dLkLHfm3POCuS49iIWUUeWlPu2MvmRHbJYVrH57/YwY1z3YfCbynmptCaH+n0K
 92DkTYLbJGy6nfNT5M27N1jgk8bH0rn5Ujio9XxDcUZRv2CNSG+eNwiykEMYyREVwyu5
 bCk667ZpR3P1c/m7aVo8MEWg2D6DYg/1HGqCg3M69j6tmnYQhhMMXo6JoFeUBoB+4SYC
 jf9g==
X-Gm-Message-State: APjAAAXPy/h9Ej7Wuf4XCoskavkMTJBUtuXfGuRxGq2ch6IYokIMAxa0
 FGHC+2GLpMoLuNQ6/N5n4dghze5Z
X-Google-Smtp-Source: APXvYqyIr6Tgo9uyPHwQ03ADevURjIWeZ7mupTfUnuoQmr4F2IJJ124UHMYRfcV1q+2FrIlZVyDnUg==
X-Received: by 2002:a25:cb81:: with SMTP id
 b123mr22790424ybg.233.1566408662457; 
 Wed, 21 Aug 2019 10:31:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:01 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:41 -0400
Message-Id: <20190821172951.15333-66-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b29
Subject: [Qemu-devel] [RFC PATCH v4 65/75] target/i386: remove obsoleted
 helpers
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

A number of helpers have been obsoleted by the use of tcg_gen_gvec_*
functions; remove all of them.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        | 65 ------------------------------------
 target/i386/ops_sse_header.h | 39 ----------------------
 target/i386/translate.c      | 38 ---------------------
 3 files changed, 142 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ec1ec745d0..aca6b50f23 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,32 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FADD(a, b) ((a) + (b))
-#define FADDUB(a, b) satub((a) + (b))
-#define FADDUW(a, b) satuw((a) + (b))
-#define FADDSB(a, b) satsb((int8_t)(a) + (int8_t)(b))
-#define FADDSW(a, b) satsw((int16_t)(a) + (int16_t)(b))
-
-#define FSUB(a, b) ((a) - (b))
-#define FSUBUB(a, b) satub((a) - (b))
-#define FSUBUW(a, b) satuw((a) - (b))
-#define FSUBSB(a, b) satsb((int8_t)(a) - (int8_t)(b))
-#define FSUBSW(a, b) satsw((int16_t)(a) - (int16_t)(b))
-#define FMINUB(a, b) ((a) < (b)) ? (a) : (b)
-#define FMINSW(a, b) ((int16_t)(a) < (int16_t)(b)) ? (a) : (b)
-#define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
-#define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
-
-#define FAND(a, b) ((a) & (b))
-#define FANDN(a, b) ((~(a)) & (b))
-#define FOR(a, b) ((a) | (b))
-#define FXOR(a, b) ((a) ^ (b))
-
-#define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
-#define FCMPGTW(a, b) ((int16_t)(a) > (int16_t)(b) ? -1 : 0)
-#define FCMPGTL(a, b) ((int32_t)(a) > (int32_t)(b) ? -1 : 0)
-#define FCMPEQ(a, b) ((a) == (b) ? -1 : 0)
-
 #define FMULLW(a, b) ((a) * (b))
 #define FMULHRW(a, b) (((int16_t)(a) * (int16_t)(b) + 0x8000) >> 16)
 #define FMULHUW(a, b) ((a) * (b) >> 16)
@@ -371,45 +345,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_paddb, FADD)
-SSE_HELPER_W(helper_paddw, FADD)
-SSE_HELPER_L(helper_paddl, FADD)
-SSE_HELPER_Q(helper_paddq, FADD)
-
-SSE_HELPER_B(helper_psubb, FSUB)
-SSE_HELPER_W(helper_psubw, FSUB)
-SSE_HELPER_L(helper_psubl, FSUB)
-SSE_HELPER_Q(helper_psubq, FSUB)
-
-SSE_HELPER_B(helper_paddusb, FADDUB)
-SSE_HELPER_B(helper_paddsb, FADDSB)
-SSE_HELPER_B(helper_psubusb, FSUBUB)
-SSE_HELPER_B(helper_psubsb, FSUBSB)
-
-SSE_HELPER_W(helper_paddusw, FADDUW)
-SSE_HELPER_W(helper_paddsw, FADDSW)
-SSE_HELPER_W(helper_psubusw, FSUBUW)
-SSE_HELPER_W(helper_psubsw, FSUBSW)
-
-SSE_HELPER_B(helper_pminub, FMINUB)
-SSE_HELPER_B(helper_pmaxub, FMAXUB)
-
-SSE_HELPER_W(helper_pminsw, FMINSW)
-SSE_HELPER_W(helper_pmaxsw, FMAXSW)
-
-SSE_HELPER_Q(helper_pand, FAND)
-SSE_HELPER_Q(helper_pandn, FANDN)
-SSE_HELPER_Q(helper_por, FOR)
-SSE_HELPER_Q(helper_pxor, FXOR)
-
-SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
-SSE_HELPER_W(helper_pcmpgtw, FCMPGTW)
-SSE_HELPER_L(helper_pcmpgtl, FCMPGTL)
-
-SSE_HELPER_B(helper_pcmpeqb, FCMPEQ)
-SSE_HELPER_W(helper_pcmpeqw, FCMPEQ)
-SSE_HELPER_L(helper_pcmpeql, FCMPEQ)
-
 SSE_HELPER_W(helper_pmullw, FMULLW)
 #if SHIFT == 0
 SSE_HELPER_W(helper_pmulhrw, FMULHRW)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc573..d8e33dff6b 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,45 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(paddb, FADD)
-SSE_HELPER_W(paddw, FADD)
-SSE_HELPER_L(paddl, FADD)
-SSE_HELPER_Q(paddq, FADD)
-
-SSE_HELPER_B(psubb, FSUB)
-SSE_HELPER_W(psubw, FSUB)
-SSE_HELPER_L(psubl, FSUB)
-SSE_HELPER_Q(psubq, FSUB)
-
-SSE_HELPER_B(paddusb, FADDUB)
-SSE_HELPER_B(paddsb, FADDSB)
-SSE_HELPER_B(psubusb, FSUBUB)
-SSE_HELPER_B(psubsb, FSUBSB)
-
-SSE_HELPER_W(paddusw, FADDUW)
-SSE_HELPER_W(paddsw, FADDSW)
-SSE_HELPER_W(psubusw, FSUBUW)
-SSE_HELPER_W(psubsw, FSUBSW)
-
-SSE_HELPER_B(pminub, FMINUB)
-SSE_HELPER_B(pmaxub, FMAXUB)
-
-SSE_HELPER_W(pminsw, FMINSW)
-SSE_HELPER_W(pmaxsw, FMAXSW)
-
-SSE_HELPER_Q(pand, FAND)
-SSE_HELPER_Q(pandn, FANDN)
-SSE_HELPER_Q(por, FOR)
-SSE_HELPER_Q(pxor, FXOR)
-
-SSE_HELPER_B(pcmpgtb, FCMPGTB)
-SSE_HELPER_W(pcmpgtw, FCMPGTW)
-SSE_HELPER_L(pcmpgtl, FCMPGTL)
-
-SSE_HELPER_B(pcmpeqb, FCMPEQ)
-SSE_HELPER_W(pcmpeqw, FCMPEQ)
-SSE_HELPER_L(pcmpeql, FCMPEQ)
-
 SSE_HELPER_W(pmullw, FMULLW)
 #if SHIFT == 0
 SSE_HELPER_W(pmulhrw, FMULHRW)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3149989d68..78c91a85c9 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2756,19 +2756,11 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x51] = SSE_FOP(sqrt),
     [0x52] = { gen_helper_rsqrtps, NULL, gen_helper_rsqrtss, NULL },
     [0x53] = { gen_helper_rcpps, NULL, gen_helper_rcpss, NULL },
-    [0x54] = { gen_helper_pand_xmm, gen_helper_pand_xmm }, /* andps, andpd */
-    [0x55] = { gen_helper_pandn_xmm, gen_helper_pandn_xmm }, /* andnps, andnpd */
-    [0x56] = { gen_helper_por_xmm, gen_helper_por_xmm }, /* orps, orpd */
-    [0x57] = { gen_helper_pxor_xmm, gen_helper_pxor_xmm }, /* xorps, xorpd */
     [0x58] = SSE_FOP(add),
     [0x59] = SSE_FOP(mul),
     [0x5a] = { gen_helper_cvtps2pd, gen_helper_cvtpd2ps,
                gen_helper_cvtss2sd, gen_helper_cvtsd2ss },
     [0x5b] = { gen_helper_cvtdq2ps, gen_helper_cvtps2dq, gen_helper_cvttps2dq },
-    [0x5c] = SSE_FOP(sub),
-    [0x5d] = SSE_FOP(min),
-    [0x5e] = SSE_FOP(div),
-    [0x5f] = SSE_FOP(max),
 
     [0xc2] = SSE_FOP(cmpeq),
     [0xc6] = { (SSEFunc_0_epp)gen_helper_shufps,
@@ -2783,9 +2775,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x61] = MMX_OP2(punpcklwd),
     [0x62] = MMX_OP2(punpckldq),
     [0x63] = MMX_OP2(packsswb),
-    [0x64] = MMX_OP2(pcmpgtb),
-    [0x65] = MMX_OP2(pcmpgtw),
-    [0x66] = MMX_OP2(pcmpgtl),
     [0x67] = MMX_OP2(packuswb),
     [0x68] = MMX_OP2(punpckhbw),
     [0x69] = MMX_OP2(punpckhwd),
@@ -2802,9 +2791,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x71] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftw */
     [0x72] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftd */
     [0x73] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftq */
-    [0x74] = MMX_OP2(pcmpeqb),
-    [0x75] = MMX_OP2(pcmpeqw),
-    [0x76] = MMX_OP2(pcmpeql),
     [0x77] = { SSE_DUMMY }, /* emms */
     [0x78] = { NULL, SSE_SPECIAL, NULL, SSE_SPECIAL }, /* extrq_i, insertq_i */
     [0x79] = { NULL, gen_helper_extrq_r, NULL, gen_helper_insertq_r },
@@ -2818,18 +2804,9 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd1] = MMX_OP2(psrlw),
     [0xd2] = MMX_OP2(psrld),
     [0xd3] = MMX_OP2(psrlq),
-    [0xd4] = MMX_OP2(paddq),
     [0xd5] = MMX_OP2(pmullw),
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
-    [0xd8] = MMX_OP2(psubusb),
-    [0xd9] = MMX_OP2(psubusw),
-    [0xda] = MMX_OP2(pminub),
-    [0xdb] = MMX_OP2(pand),
-    [0xdc] = MMX_OP2(paddusb),
-    [0xdd] = MMX_OP2(paddusw),
-    [0xde] = MMX_OP2(pmaxub),
-    [0xdf] = MMX_OP2(pandn),
     [0xe0] = MMX_OP2(pavgb),
     [0xe1] = MMX_OP2(psraw),
     [0xe2] = MMX_OP2(psrad),
@@ -2838,14 +2815,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe5] = MMX_OP2(pmulhw),
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
-    [0xe8] = MMX_OP2(psubsb),
-    [0xe9] = MMX_OP2(psubsw),
-    [0xea] = MMX_OP2(pminsw),
-    [0xeb] = MMX_OP2(por),
-    [0xec] = MMX_OP2(paddsb),
-    [0xed] = MMX_OP2(paddsw),
-    [0xee] = MMX_OP2(pmaxsw),
-    [0xef] = MMX_OP2(pxor),
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
     [0xf1] = MMX_OP2(psllw),
     [0xf2] = MMX_OP2(pslld),
@@ -2855,13 +2824,6 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xf6] = MMX_OP2(psadbw),
     [0xf7] = { (SSEFunc_0_epp)gen_helper_maskmov_mmx,
                (SSEFunc_0_epp)gen_helper_maskmov_xmm }, /* XXX: casts */
-    [0xf8] = MMX_OP2(psubb),
-    [0xf9] = MMX_OP2(psubw),
-    [0xfa] = MMX_OP2(psubl),
-    [0xfb] = MMX_OP2(psubq),
-    [0xfc] = MMX_OP2(paddb),
-    [0xfd] = MMX_OP2(paddw),
-    [0xfe] = MMX_OP2(paddl),
 };
 
 static const SSEFunc_0_epp sse_op_table2[3 * 8][2] = {
-- 
2.20.1


