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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D11C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E804208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clvpy6qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E804208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5qr-0006J3-KH
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dp-0006al-1o
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dm-0000WL-1I
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:36 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dl-0000Vp-RN
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:33 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n7so398864ybd.8
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5e6l03Qz5LQ2A/rrsuSgH7TNz9zLWV4wYVJ76E7XL0A=;
 b=clvpy6qyVDPIkGPHsIPLL16HuTRgPFPSFSpWbDm+RJu4ggSF4ZZQ9F4PEwbrvujHCM
 SpM9Rsdfifgsiv//CElikUTigeUwj0maVPyqkjgd/JPajO3BzxFD2/eSk/09ZASz4eKQ
 II4qUVxz2Tqb3+YlHM3VPZAu/sovI7LRSABWTAFgb0JbXTRONGWHezBQ/sRDZWe4J3d+
 YKggBy3iqiPp3SA1+jC/jdwpvV+hrWtLlAs0fzAz+LMHDmgZB0qSalC4dwJUl9fdWB31
 SdpXEpp4ti4gg8Yp/WBB3GjKqiEG3K1UkR1IOS3dGRi9ikUB7ehw/KmFKYwdXr6qySjm
 +99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5e6l03Qz5LQ2A/rrsuSgH7TNz9zLWV4wYVJ76E7XL0A=;
 b=KQ/ywltPZjf+lSggUjll5qf/2nxICLwtv9jmRrGCyJEwmFjIqlgc9FYpex30cmS9Kx
 twpmIglR3veWyz43j20DOmZUAL/UavuhKJNil1oTkV4BZafvo4dsFsJ4Qbul28O82akS
 uUi/PEA1yS+Z27v9Ii4d8v8JkO8hiC5Tk60+5KmbFbTwO57gSXdEt8Ut0Imlecz9MwiZ
 WVhWL+tVDhh5MRpioBuHyYwjD+sTcceqEkuGHXYaBTozIM1/GU08Lg3fYGtJdMLDzIe5
 Ke3PjVddBPIq6rhIxwAIWzHfse9RmYpFlWcnqSzBaxsqlKr0PGnAIEB/I0DV018k+GQc
 DTvA==
X-Gm-Message-State: APjAAAXoXtP16kCWaW8KtKJKhTYpDUCzcdaY/IGmeLfX0srvmccWo+Qq
 QjvrFzHcF9SuyFrDrc2CgocEkuI7
X-Google-Smtp-Source: APXvYqwKSJ1OfM0fnnGuDELrTZT/XAqoeyucOfluD/YwZYklzPzdqR9G1wnHad1119uE/a75eHO4uw==
X-Received: by 2002:a25:97c1:: with SMTP id j1mr2043613ybo.349.1565835032861; 
 Wed, 14 Aug 2019 19:10:32 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:32 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:24 -0400
Message-Id: <20190815020928.9679-43-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 42/46] target/i386: introduce SSE2 code
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

Introduce code generators required by SSE2 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 444 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 442 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 177bedd0ef..7ec082e79d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5391,6 +5391,21 @@ GEN_INSN2(movd, Ed, Pq)
     tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
 }
 
+GEN_INSN2(movq, Vdq, Eq);       /* forward declaration */
+GEN_INSN2(movd, Vdq, Ed)
+{
+    const insnop_arg_t(Eq) arg2_r64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(arg2_r64, arg2);
+    gen_insn2(movq, Vdq, Eq)(env, s, arg1, arg2_r64);
+    tcg_temp_free_i64(arg2_r64);
+}
+
+GEN_INSN2(movd, Ed, Vdq)
+{
+    const insnop_arg_t(Vdq) ofs = offsetof(ZMMReg, ZMM_L(0));
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
+}
+
 GEN_INSN2(movq, Pq, Eq)
 {
     const insnop_arg_t(Pq) ofs = offsetof(MMXReg, MMX_Q(0));
@@ -5403,12 +5418,53 @@ GEN_INSN2(movq, Eq, Pq)
     tcg_gen_ld_i64(arg1, cpu_env, arg2 + ofs);
 }
 
+GEN_INSN2(movq, Vdq, Eq)
+{
+    const insnop_arg_t(Vdq) ofs0 = offsetof(ZMMReg, ZMM_Q(0));
+    tcg_gen_st_i64(arg2, cpu_env, arg1 + ofs0);
+
+    const insnop_arg_t(Vdq) ofs1 = offsetof(ZMMReg, ZMM_Q(1));
+    tcg_gen_movi_i64(arg2, 0);
+    tcg_gen_st_i64(arg2, cpu_env, arg1 + ofs1);
+}
+
+GEN_INSN2(movq, Eq, Vdq)
+{
+    const insnop_arg_t(Vdq) ofs = offsetof(ZMMReg, ZMM_Q(0));
+    tcg_gen_ld_i64(arg1, cpu_env, arg2 + ofs);
+}
+
 DEF_GEN_INSN2_GVEC_MM(movq, mov, Pq, Qq, MO_64)
 DEF_GEN_INSN2_GVEC_MM(movq, mov, Qq, Pq, MO_64)
+
+GEN_INSN2(movq, Vdq, Wq)
+{
+    const insnop_arg_t(Vdq) dofs = offsetof(ZMMReg, ZMM_Q(0));
+    const insnop_arg_t(Wq) aofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+
+    const TCGv_i64 r64z = tcg_const_i64(0);
+    tcg_gen_st_i64(r64z, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_temp_free_i64(r64z);
+}
+
+GEN_INSN2(movq, UdqMq, Vq)
+{
+    gen_insn2(movq, Vdq, Wq)(env, s, arg1, arg2);
+}
+
 DEF_GEN_INSN2_GVEC_XMM(movaps, mov, Vdq, Wdq, MO_64)
 DEF_GEN_INSN2_GVEC_XMM(movaps, mov, Wdq, Vdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movapd, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movapd, mov, Wdq, Vdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movdqa, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movdqa, mov, Wdq, Vdq, MO_64)
 DEF_GEN_INSN2_GVEC_XMM(movups, mov, Vdq, Wdq, MO_64)
 DEF_GEN_INSN2_GVEC_XMM(movups, mov, Wdq, Vdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movupd, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movupd, mov, Wdq, Vdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movdqu, mov, Vdq, Wdq, MO_64)
+DEF_GEN_INSN2_GVEC_XMM(movdqu, mov, Wdq, Vdq, MO_64)
 
 GEN_INSN2(movss, Wd, Vd);       /* forward declaration */
 GEN_INSN4(movss, Vdq, Vdq, Wd, modrm_mod)
@@ -5442,6 +5498,44 @@ GEN_INSN2(movss, Wd, Vd)
     gen_op_movl(s, arg1 + dofs, arg2 + aofs);
 }
 
+GEN_INSN2(movsd, Wq, Vq);       /* forward declaration */
+GEN_INSN4(movsd, Vdq, Vdq, Wq, modrm_mod)
+{
+    assert(arg1 == arg2);
+
+    if (arg4 == 3) {
+        /* merging movsd */
+        gen_insn2(movsd, Wq, Vq)(env, s, arg1, arg3);
+    } else {
+        /* zero-extending movsd */
+        gen_insn2(movq, Vdq, Wq)(env, s, arg1, arg3);
+    }
+}
+
+GEN_INSN2(movsd, Wq, Vq)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, arg1 + ofs, arg2 + ofs);
+}
+
+GEN_INSN2(movq2dq, Vdq, Nq)
+{
+    const insnop_arg_t(Vdq) dofs = offsetof(ZMMReg, ZMM_Q(0));
+    const insnop_arg_t(Nq) aofs = offsetof(MMXReg, MMX_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+
+    const TCGv_i64 r64z = tcg_const_i64(0);
+    tcg_gen_st_i64(r64z, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_temp_free_i64(r64z);
+}
+
+GEN_INSN2(movdq2q, Pq, Uq)
+{
+    const insnop_arg_t(Pq) dofs = offsetof(MMXReg, MMX_Q(0));
+    const insnop_arg_t(Uq) aofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+}
+
 GEN_INSN2(movhlps, Vq, UdqMhq)
 {
     const size_t dofs = offsetof(ZMMReg, ZMM_Q(0));
@@ -5455,6 +5549,17 @@ GEN_INSN2(movlps, Mq, Vq)
     gen_stq_env_A0(s, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
 }
 
+GEN_INSN2(movlpd, Vq, Mq)
+{
+    assert(arg2 == s->A0);
+    gen_ldq_env_A0(s, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+}
+
+GEN_INSN2(movlpd, Mq, Vq)
+{
+    gen_insn2(movlps, Mq, Vq)(env, s, arg1, arg2);
+}
+
 GEN_INSN3(movlhps, Vdq, Vq, Wq)
 {
     assert(arg1 == arg2);
@@ -5470,6 +5575,18 @@ GEN_INSN2(movhps, Mq, Vdq)
     gen_stq_env_A0(s, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
 }
 
+GEN_INSN3(movhpd, Vdq, Vd, Mq)
+{
+    assert(arg1 == arg2);
+    assert(arg3 == s->A0);
+    gen_ldq_env_A0(s, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+}
+
+GEN_INSN2(movhpd, Mq, Vdq)
+{
+    gen_insn2(movhps, Mq, Vdq)(env, s, arg1, arg2);
+}
+
 DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
 
 GEN_INSN2(pmovmskb, Gq, Nq)
@@ -5480,6 +5597,16 @@ GEN_INSN2(pmovmskb, Gq, Nq)
     tcg_temp_free_i32(arg1_r32);
 }
 
+DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_xmm, Gd, Udq)
+
+GEN_INSN2(pmovmskb, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(pmovmskb, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+
 DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
 
 GEN_INSN2(movmskps, Gq, Udq)
@@ -5490,78 +5617,155 @@ GEN_INSN2(movmskps, Gq, Udq)
     tcg_temp_free_i32(arg1_r32);
 }
 
+DEF_GEN_INSN2_HELPER_DEP(movmskpd, movmskpd, Gd, Udq)
+
+GEN_INSN2(movmskpd, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(movmskpd, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+
 DEF_GEN_INSN3_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(paddb, add, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(paddw, add, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(paddd, add, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_XMM(paddd, add, Vdq, Vdq, Wdq, MO_32)
+DEF_GEN_INSN3_GVEC_MM(paddq, add, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(paddq, add, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(paddsb, ssadd, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(paddsb, ssadd, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddsw, ssadd, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(paddsw, ssadd, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(paddusb, usadd, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(paddusb, usadd, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(paddusw, usadd, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(paddusw, usadd, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN3_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(psubb, sub, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubw, sub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(psubw, sub, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(psubd, sub, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_XMM(psubd, sub, Vdq, Vdq, Wdq, MO_32)
+DEF_GEN_INSN3_GVEC_MM(psubq, sub, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(psubq, sub, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(psubsb, sssub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(psubsb, sssub, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubsw, sssub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(psubsw, sssub, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(psubusb, ussub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(psubusb, ussub, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(psubusw, ussub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(psubusw, ussub, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(mulpd, mulpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(mulsd, mulsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(divss, divss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(divpd, divpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(divsd, divsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN2_HELPER_EPP(rcpps, rcpps, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(rcpss, rcpss, Vd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(sqrtps, sqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(sqrtpd, sqrtpd, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(sqrtss, sqrtss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(sqrtsd, sqrtsd, Vq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtps, rsqrtps, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtss, rsqrtss, Vd, Wd)
 
 DEF_GEN_INSN3_GVEC_MM(pminub, umin, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(pminub, umin, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pminsw, smin, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(pminsw, smin, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(minpd, minpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(minsd, minsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_GVEC_MM(pmaxub, umax, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(pmaxub, umax, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pmaxsw, smax, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(pmaxsw, smax, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(maxpd, maxpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(maxsd, maxsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_GVEC_MM(pcmpeqb, cmpeq, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(pcmpeqb, cmpeq, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pcmpeqw, cmpeq, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(pcmpeqw, cmpeq, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(pcmpeqd, cmpeq, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_XMM(pcmpeqd, cmpeq, Vdq, Vdq, Wdq, MO_32)
 DEF_GEN_INSN3_GVEC_MM(pcmpgtb, cmpgt, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_XMM(pcmpgtb, cmpgt, Vdq, Vdq, Wdq, MO_8)
 DEF_GEN_INSN3_GVEC_MM(pcmpgtw, cmpgt, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_XMM(pcmpgtw, cmpgt, Vdq, Vdq, Wdq, MO_16)
 DEF_GEN_INSN3_GVEC_MM(pcmpgtd, cmpgt, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_XMM(pcmpgtd, cmpgt, Vdq, Vdq, Wdq, MO_32)
 
 DEF_GEN_INSN3_HELPER_EPP(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpeqpd, cmpeqpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqss, cmpeqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpeqsd, cmpeqsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltps, cmpltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpltpd, cmpltpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltss, cmpltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpltsd, cmpltsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpleps, cmpleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmplepd, cmplepd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpless, cmpless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmplesd, cmplesd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordps, cmpunordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordpd, cmpunordpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordss, cmpunordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordsd, cmpunordsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqps, cmpneqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqpd, cmpneqpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqss, cmpneqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqsd, cmpneqsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltps, cmpnltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltpd, cmpnltpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltss, cmpnltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltsd, cmpnltsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnleps, cmpnleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnlepd, cmpnlepd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnless, cmpnless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnlesd, cmpnlesd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordps, cmpordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpordpd, cmpordpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordss, cmpordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpordsd, cmpordsd, Vq, Vq, Wq)
 
 GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
 {
@@ -5595,6 +5799,38 @@ GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(cmppd, Vdq, Vdq, Wdq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmplepd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnlepd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
 {
     switch (arg4 & 7) {
@@ -5627,26 +5863,78 @@ GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(cmpsd, Vq, Vq, Wq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmplesd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnlesd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 DEF_GEN_INSN2_HELPER_EPP(comiss, comiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(comisd, comisd, Vq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(ucomiss, ucomiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(ucomisd, ucomisd, Vq, Wq)
 
 DEF_GEN_INSN3_GVEC_MM(pand, and, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(pand, and, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_XMM(andps, and, Vdq, Vdq, Wdq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(andpd, and, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(pandn, andn, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(pandn, andn, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_XMM(andnps, andn, Vdq, Vdq, Wdq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(andnpd, andn, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(por, or, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(por, or, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_XMM(orps, or, Vdq, Vdq, Wdq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(orpd, or, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_MM(pxor, xor, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(pxor, xor, Vdq, Vdq, Wdq, MO_64)
 DEF_GEN_INSN3_GVEC_XMM(xorps, xor, Vdq, Vdq, Wdq, MO_64)
+DEF_GEN_INSN3_GVEC_XMM(xorpd, xor, Vdq, Vdq, Wdq, MO_64)
 
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pslldq, pslldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(psrldq, psrldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
 
 #define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
     GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
@@ -5660,31 +5948,70 @@ DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
         gen_insn2(movq, Pq, Eq)(env, s, arg3_mm, arg3_r64);             \
         gen_insn3(mnem, Pq, Pq, Qq)(env, s, arg1, arg2, arg3_mm);       \
     }
+#define DEF_GEN_PSHIFT_IMM_XMM(mnem, opT1, opT2)                        \
+    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
+    {                                                                   \
+        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
+        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
+        const insnop_arg_t(Wdq) arg3_xmm =                              \
+            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
+                                                                        \
+        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
+        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
+        gen_insn3(mnem, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3_xmm);   \
+    }
 
 DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psllw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(pslld, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psllq, Udq, Udq)
+DEF_GEN_PSHIFT_IMM_XMM(pslldq, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrlw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrld, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrlq, Udq, Udq)
+DEF_GEN_PSHIFT_IMM_XMM(psrldq, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
 
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(punpcklqdq, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhqdq, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(unpcklpd, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(unpckhpd, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(shufpd, shufpd, Vdq, Vdq, Wdq, Ib)
 
 GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
 {
@@ -5694,6 +6021,14 @@ GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
     tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
 }
 
+GEN_INSN4(pinsrw, Vdq, Vdq, RdMw, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg4 & 7));
+    tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
+}
+
 GEN_INSN3(pextrw, Gd, Nq, Ib)
 {
     const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
@@ -5706,15 +6041,47 @@ GEN_INSN3(pextrw, Gq, Nq, Ib)
     tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
 }
 
+GEN_INSN3(pextrw, Gd, Udq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
+    tcg_gen_ld16u_i32(arg1, cpu_env, arg2 + ofs);
+}
+
+GEN_INSN3(pextrw, Gq, Udq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
+    tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
+}
+
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
 DEF_GEN_INSN2_HELPER_EPQ(cvtsi2ss, cvtsq2ss, Vd, Eq)
+DEF_GEN_INSN2_HELPER_EPP(cvtpi2pd, cvtpi2pd, Vdq, Qq)
+DEF_GEN_INSN2_HELPER_EPD(cvtsi2sd, cvtsi2sd, Vq, Ed)
+DEF_GEN_INSN2_HELPER_EPQ(cvtsi2sd, cvtsq2sd, Vq, Eq)
 DEF_GEN_INSN2_HELPER_EPP(cvtps2pi, cvtps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvtss2si, cvtss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvtss2si, cvtss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2pi, cvtpd2pi, Pq, Wdq)
+DEF_GEN_INSN2_HELPER_DEP(cvtsd2si, cvtsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(cvtsd2si, cvtsd2sq, Gq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(cvttps2pi, cvttps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvttss2si, cvttss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvttss2si, cvttss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvttpd2pi, cvttpd2pi, Pq, Wdq)
+DEF_GEN_INSN2_HELPER_DEP(cvttsd2si, cvttsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(cvttsd2si, cvttsd2sq, Gq, Wq)
+
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2dq, cvtpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvttpd2dq, cvttpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtdq2pd, cvtdq2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtps2pd, cvtps2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2ps, cvtpd2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtss2sd, cvtss2sd, Vq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvtsd2ss, cvtsd2ss, Vd, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtdq2ps, cvtdq2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtps2dq, cvtps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvttps2dq, cvttps2dq, Vdq, Wdq)
 
 GEN_INSN2(maskmovq, Pq, Nq)
 {
@@ -5733,26 +6100,99 @@ GEN_INSN2(maskmovq, Pq, Nq)
     tcg_temp_free_ptr(arg2_ptr);
 }
 
+GEN_INSN2(maskmovdqu, Vdq, Udq)
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
+    gen_helper_maskmov_xmm(cpu_env, arg1_ptr, arg2_ptr, s->A0);
+
+    tcg_temp_free_ptr(arg1_ptr);
+    tcg_temp_free_ptr(arg2_ptr);
+}
+
 GEN_INSN2(movntps, Mdq, Vdq)
 {
     assert(arg1 == s->A0);
     gen_sto_env_A0(s, arg2);
 }
 
+GEN_INSN2(movntpd, Mdq, Vdq)
+{
+    assert(arg1 == s->A0);
+    gen_sto_env_A0(s, arg2);
+}
+
+GEN_INSN2(movnti, Md, Gd)
+{
+    tcg_gen_qemu_st_i32(arg2, arg1, s->mem_index, MO_LEUL);
+}
+
+GEN_INSN2(movnti, Mq, Gq)
+{
+    tcg_gen_qemu_st_i64(arg2, arg1, s->mem_index, MO_LEQ);
+}
+
 GEN_INSN2(movntq, Mq, Pq)
 {
     assert(arg1 == s->A0);
     gen_stq_env_A0(s, arg2);
 }
 
+GEN_INSN2(movntdq, Mdq, Vdq)
+{
+    assert(arg1 == s->A0);
+    gen_sto_env_A0(s, arg2);
+}
+
+GEN_INSN0(pause)
+{
+    /* handled in disas_insn at the moment */
+    g_assert_not_reached();
+}
+
 DEF_GEN_INSN0_HELPER(emms, emms)
 
-GEN_INSN0(sfence)
+GEN_INSN2(sfence_clflush, modrm_mod, modrm)
+{
+    if (arg1 == 3) {
+        /* sfence */
+        if (s->prefix & PREFIX_LOCK) {
+            gen_illegal_opcode(s);
+        } else {
+            tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+        }
+    } else {
+        /* clflush */
+        if (ck_cpuid(env, s, CK_CPUID_CLFLUSH)) {
+            gen_illegal_opcode(s);
+        } else {
+            gen_nop_modrm(env, s, arg2);
+        }
+    }
+}
+
+GEN_INSN0(lfence)
+{
+    if (s->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s);
+    } else {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
+    }
+ }
+
+GEN_INSN0(mfence)
 {
     if (s->prefix & PREFIX_LOCK) {
         gen_illegal_opcode(s);
     } else {
-        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     }
 }
 
-- 
2.20.1


