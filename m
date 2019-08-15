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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19FF208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH4GXcGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19FF208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5lA-00072S-H1
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dl-0006UA-1o
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Di-0000Oe-Qi
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:32 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Di-0000Nx-Lf
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:30 -0400
Received: by mail-yw1-xc42.google.com with SMTP id z63so290727ywz.9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7BueW4Yx+T+QYuOxbWUj1eJfzlDzg85DNPgtbyCQMpY=;
 b=nH4GXcGmmTrPc2hqWZkwKCCEhJJXVMj+RVI2Zg+CF3U2Tx6lWI7Xf4/ORf86fKNcRk
 CPYOELCAHUJQMlGw98hYIUo8UqIHPuHS9QkF7stpK9phDb1FjRMUFdGPdAbwWaLjOAFb
 0ZD0tzer1hvK1YJGixA+ZacJtr3C2N91MTaI0H0fGzy2FncCK0gOX5QjWvBwyfal8Pim
 GYrJnhtoeeT1CIcCqOPrcARwa0B1QFtIprg2OSS+UJmZMr+KBjIVeIZpPuaOHwCgbZ8/
 YG2Tmxgu44LS4CGOV74MG+om9Q3D4/84zcNnnb18gafSIEuPWmejx+MnXq2ZqpJ1SJog
 s/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7BueW4Yx+T+QYuOxbWUj1eJfzlDzg85DNPgtbyCQMpY=;
 b=LkDK9AJIp3xYH0NxgQnSz9JyR+V0XZW+r78tFSpVw72CJwJF24oHjTilRT1uLYwJGA
 h4XFqYm7zRfQ/QFGuOx02kTx4XPgtqKo3xA+4nGZ7kdV9dzJpgldnQ92hPiuuxjNo2gu
 5t82FEJ5LCXeLp2kWzgkADIkUXPxRLrF8ixnhLt+LZN0JN9h1d3GV2uAUKJ/4+9zM0e1
 FYuX/9OZRH6Qrx411VJKEqwlkddDtqxolIZFINdPLD6UsK2YH+NVTrQ1Vx+8jR+GpxEE
 goMLQDJamXbQlECkDLbsPikAasqXlKKLStxkR+8bpuFTBK1Qlxl5QAkcd7TakzcM6jY1
 FjZw==
X-Gm-Message-State: APjAAAVtAXw4bWbJJtjwhgnnt9qE9thCqSEpqCQ+Ha262lXmUpY43kRl
 iFiY65Krz7I34d8iY9PyTRCBjprj
X-Google-Smtp-Source: APXvYqw99ag4zX/gcb5x5FTG9AHEL6/mnH+SE9KfopBaGA7lK8OZ2FvPeuDtm5I8itwz9KPpW9b/Gw==
X-Received: by 2002:a81:8706:: with SMTP id x6mr1590510ywf.512.1565835029907; 
 Wed, 14 Aug 2019 19:10:29 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:29 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:21 -0400
Message-Id: <20190815020928.9679-40-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v3 39/46] target/i386: introduce SSE code
 generators
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

Introduce code generators required by SSE instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 319 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ef64fe606f..3d526ee470 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5360,6 +5360,9 @@ INSNOP_LDST(xmm_t0, Mhq)
 #define DEF_GEN_INSN2_GVEC_MM(mnem, gvec, opT1, opT2, vece)       \
     DEF_GEN_INSN2_GVEC(mnem, gvec, opT1, opT2, vece,              \
                        sizeof(MMXReg), sizeof(MMXReg))
+#define DEF_GEN_INSN2_GVEC_XMM(mnem, gvec, opT1, opT2, vece)      \
+    DEF_GEN_INSN2_GVEC(mnem, gvec, opT1, opT2, vece,              \
+                       sizeof(XMMReg), sizeof(XMMReg))
 
 #define DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece, oprsz, maxsz) \
     GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
@@ -5369,6 +5372,9 @@ INSNOP_LDST(xmm_t0, Mhq)
 #define DEF_GEN_INSN3_GVEC_MM(mnem, gvec, opT1, opT2, opT3, vece)   \
     DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece,          \
                        sizeof(MMXReg), sizeof(MMXReg))
+#define DEF_GEN_INSN3_GVEC_XMM(mnem, gvec, opT1, opT2, opT3, vece)  \
+    DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece,          \
+                       sizeof(XMMReg), sizeof(XMMReg))
 
 GEN_INSN2(movq, Pq, Eq);        /* forward declaration */
 GEN_INSN2(movd, Pq, Ed)
@@ -5399,6 +5405,90 @@ GEN_INSN2(movq, Eq, Pq)
 
 DEF_GEN_INSN2_GVEC_MM(movq, mov, Pq, Qq, MO_64)
 DEF_GEN_INSN2_GVEC_MM(movq, mov, Qq, Pq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movaps, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movaps, mov, Wdq, Vdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movups, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movups, mov, Wdq, Vdq, MO_64)
+
+GEN_INSN2(movss, Wd, Vd);       /* forward declaration */
+GEN_INSN4(movss, Vdq, Vdq, Wd, modrm_mod)
+{
+    assert(arg1 == arg2);
+
+    if (arg4 == 3) {
+        /* merging movss */
+        gen_insn2(movss, Wd, Vd)(env, s, arg1, arg3);
+    } else {
+        /* zero-extending movss */
+        const TCGv_i32 r32 = tcg_temp_new_i32();
+        const TCGv_i64 r64 = tcg_temp_new_i64();
+
+        tcg_gen_ld_i32(r32, cpu_env, arg3 + offsetof(ZMMReg, ZMM_L(0)));
+        tcg_gen_extu_i32_i64(r64, r32);
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+
+        tcg_gen_movi_i64(r64, 0);
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+
+        tcg_temp_free_i32(r32);
+        tcg_temp_free_i64(r64);
+    }
+}
+
+GEN_INSN2(movss, Wd, Vd)
+{
+    const insnop_arg_t(Wd) dofs = offsetof(ZMMReg, ZMM_L(0));
+    const insnop_arg_t(Vd) aofs = offsetof(ZMMReg, ZMM_L(0));
+    gen_op_movl(s, arg1 + dofs, arg2 + aofs);
+}
+
+GEN_INSN2(movhlps, Vq, UdqMhq)
+{
+    const size_t dofs = offsetof(ZMMReg, ZMM_Q(0));
+    const size_t aofs = offsetof(ZMMReg, ZMM_Q(1));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+}
+
+GEN_INSN2(movlps, Mq, Vq)
+{
+    assert(arg1 == s->A0);
+    gen_stq_env_A0(s, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+}
+
+GEN_INSN3(movlhps, Vdq, Vq, Wq)
+{
+    assert(arg1 == arg2);
+
+    const size_t dofs = offsetof(ZMMReg, ZMM_Q(1));
+    const size_t aofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg3 + aofs);
+}
+
+GEN_INSN2(movhps, Mq, Vdq)
+{
+    assert(arg1 == s->A0);
+    gen_stq_env_A0(s, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
+}
+
+DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
+
+GEN_INSN2(pmovmskb, Gq, Nq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(pmovmskb, Gd, Nq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+
+DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
+
+GEN_INSN2(movmskps, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(movmskps, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN3_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
@@ -5407,6 +5497,8 @@ DEF_GEN_INSN3_GVEC_MM(paddsb, ssadd, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddsw, ssadd, Pq, Pq, Qq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(paddusb, usadd, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddusw, usadd, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
 
 DEF_GEN_INSN3_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubw, sub, Pq, Pq, Qq, MO_16)
@@ -5415,11 +5507,38 @@ DEF_GEN_INSN3_GVEC_MM(psubsb, sssub, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubsw, sssub, Pq, Pq, Qq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(psubusb, ussub, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubusw, ussub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
 
+DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(divss, divss, Vd, Vd, Wd)
+
+DEF_GEN_INSN2_HELPER_EPP(rcpps, rcpps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(rcpss, rcpss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(sqrtps, sqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(sqrtss, sqrtss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(rsqrtps, rsqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(rsqrtss, rsqrtss, Vd, Wd)
+
+DEF_GEN_INSN3_GVEC_MM(pminub, umin, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(pminsw, smin, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
+DEF_GEN_INSN3_GVEC_MM(pmaxub, umax, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(pmaxsw, smax, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
+
 DEF_GEN_INSN3_GVEC_MM(pcmpeqb, cmpeq, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pcmpeqw, cmpeq, Pq, Pq, Qq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(pcmpeqd, cmpeq, Pq, Pq, Qq, MO_32)
@@ -5427,10 +5546,98 @@ DEF_GEN_INSN3_GVEC_MM(pcmpgtb, cmpgt, Pq, Pq, Qq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pcmpgtw, cmpgt, Pq, Pq, Qq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(pcmpgtd, cmpgt, Pq, Pq, Qq, MO_32)
 
+DEF_GEN_INSN3_HELPER_EPP(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpeqss, cmpeqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpltps, cmpltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpltss, cmpltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpleps, cmpleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpless, cmpless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordps, cmpunordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordss, cmpunordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqps, cmpneqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqss, cmpneqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltps, cmpnltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltss, cmpnltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnleps, cmpnleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnless, cmpnless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpordps, cmpordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpordss, cmpordss, Vd, Vd, Wd)
+
+GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmpleps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnleps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmpless, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnless, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordss, Vd, Vd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+DEF_GEN_INSN2_HELPER_EPP(comiss, comiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(ucomiss, ucomiss, Vd, Wd)
+
 DEF_GEN_INSN3_GVEC_MM(pand, and, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(andps, and, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(pandn, andn, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(andnps, andn, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(por, or, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(orps, or, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(pxor, xor, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(xorps, xor, Vdq, Vdq, Wdq, MO_64)
 
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
@@ -5473,8 +5680,120 @@ DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
 
+DEF_GEN_INSN3_HELPER_EPP(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
+
+DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
+
+GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg4 & 3));
+    tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
+}
+
+GEN_INSN3(pextrw, Gd, Nq, Ib)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
+    tcg_gen_ld16u_i32(arg1, cpu_env, arg2 + ofs);
+}
+
+GEN_INSN3(pextrw, Gq, Nq, Ib)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
+    tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
+}
+
+DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
+DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
+DEF_GEN_INSN2_HELPER_EPQ(cvtsi2ss, cvtsq2ss, Vd, Eq)
+DEF_GEN_INSN2_HELPER_EPP(cvtps2pi, cvtps2pi, Pq, Wq)
+DEF_GEN_INSN2_HELPER_DEP(cvtss2si, cvtss2si, Gd, Wd)
+DEF_GEN_INSN2_HELPER_QEP(cvtss2si, cvtss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvttps2pi, cvttps2pi, Pq, Wq)
+DEF_GEN_INSN2_HELPER_DEP(cvttss2si, cvttss2si, Gd, Wd)
+DEF_GEN_INSN2_HELPER_QEP(cvttss2si, cvttss2sq, Gq, Wd)
+
+GEN_INSN2(maskmovq, Pq, Nq)
+{
+    const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
+    gen_extu(s->aflag, s->A0);
+    gen_add_A0_ds_seg(s);
+
+    tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);
+    tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);
+    gen_helper_maskmov_mmx(cpu_env, arg1_ptr, arg2_ptr, s->A0);
+
+    tcg_temp_free_ptr(arg1_ptr);
+    tcg_temp_free_ptr(arg2_ptr);
+}
+
+GEN_INSN2(movntps, Mdq, Vdq)
+{
+    assert(arg1 == s->A0);
+    gen_sto_env_A0(s, arg2);
+}
+
+GEN_INSN2(movntq, Mq, Pq)
+{
+    assert(arg1 == s->A0);
+    gen_stq_env_A0(s, arg2);
+}
+
 DEF_GEN_INSN0_HELPER(emms, emms)
 
+GEN_INSN0(sfence)
+{
+    if (s->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s);
+    } else {
+        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+    }
+}
+
+GEN_INSN1(ldmxcsr, Md)
+{
+    if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
+        gen_illegal_opcode(s);
+    } else if (s->flags & HF_TS_MASK) {
+        gen_exception(s, EXCP07_PREX);
+    } else {
+        tcg_gen_qemu_ld_i32(s->tmp2_i32, arg1, s->mem_index, MO_LEUL);
+        gen_helper_ldmxcsr(cpu_env, s->tmp2_i32);
+    }
+}
+
+GEN_INSN1(stmxcsr, Md)
+{
+    if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
+        gen_illegal_opcode(s);
+    } else if (s->flags & HF_TS_MASK) {
+        gen_exception(s, EXCP07_PREX);
+    } else {
+        const size_t ofs = offsetof(CPUX86State, mxcsr);
+        tcg_gen_ld_i32(s->tmp2_i32, cpu_env, ofs);
+        tcg_gen_qemu_st_i32(s->tmp2_i32, arg1, s->mem_index, MO_LEUL);
+    }
+}
+
+GEN_INSN1(prefetcht0, Mb)
+{
+}
+GEN_INSN1(prefetcht1, Mb)
+{
+}
+GEN_INSN1(prefetcht2, Mb)
+{
+}
+GEN_INSN1(prefetchnta, Mb)
+{
+}
+
 /*
  * Instruction translators
  */
-- 
2.20.1


