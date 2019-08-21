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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796C9216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXabAak9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796C9216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VM5-0006RB-3C
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US3-0001z9-Jb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US1-0000E0-BZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:15 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34]:40558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0US1-0000DG-5B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:13 -0400
Received: by mail-yb1-xb34.google.com with SMTP id g7so1339222ybd.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fdZNMW0ODVzKW35HMfdxnHfg1fmzHTFXd7vaL1DTdtQ=;
 b=FXabAak9SCw0KC45r1/ZRhKSatnKKOHSe7aEbCrgJaEa2an6j/2LB88eI4bglX8SUc
 hQ5ZpyzG8OzvGvhDjUVz0dYjOtUdfRrfVILCG7yWOspi3C1h8Q6kS/bn4QNnxKf3tf7I
 OLiij6jFslOmjkamUEz7FBRHgDvhX1OUi+O0lX/s5I+8gGD2oNjfnpy9k8LqH+uuuqQE
 FwmKxH1E6VfqaSMSe0QvFmjdMCOjofax7J7Wo5oGTlSD8heSS9+iRfeb3U2DqPNCrv4u
 om8/7IlgF65MDfXOtWHlbUCtdSJWb+9JeCA6G1WxcXEQRsEPkxmWLnGZxTs/kzkg9gXO
 xT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fdZNMW0ODVzKW35HMfdxnHfg1fmzHTFXd7vaL1DTdtQ=;
 b=UgJG8dxaWpufNz3oOUqYV2k/GbG8LSw2D37bYumCQ/hJ8Rt2UA6VFPkECa40LWO14q
 xlVIONOwB5gSJdHWyV1g9XYUnOu3+GiVMhuCShxGz65p42fRH+OXRzEI0VxiQWLyekCT
 9h7ux00EPI1AxWpyWJEfmtNL7qF55P12omOL2jj8dh6Sr10LhEeBLq1SbWx1l37KMuDl
 Z9udDOBzdk4kzcVLdGgTcrZ+u7tInxvAZ+t79oNbPZs7OxE4+8wY1vMKDz8hTSCl1egM
 S6GHe7F+M8mO6wVhTYXR/uRCrlBgHC9m+ir0HRQkc/njPpKDhDJ3jWZ30T6qoy9vqMfo
 sNtg==
X-Gm-Message-State: APjAAAU3vsPxMz8SrbW9FZ6UTV8u1vroYN5ajS4b6EHcvys9QsE0VbeZ
 D/l+6imr8+FIdtAPjwJbGMkXTVvE
X-Google-Smtp-Source: APXvYqzF6qEX9X3iGXm2BO34dRrPs/KoMRkZGYjPtZiuOJrJiWNConU4HUH1sYq7iPLDX2TlrBAgtA==
X-Received: by 2002:a25:216:: with SMTP id 22mr23796905ybc.188.1566408672323; 
 Wed, 21 Aug 2019 10:31:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:11 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:51 -0400
Message-Id: <20190821172951.15333-76-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b34
Subject: [Qemu-devel] [RFC PATCH v4 75/75] target/i386: convert
 pmovmskb/movmskps/movmskpd helpers to gvec style
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
 target/i386/ops_sse.h        |  74 ++++++++++----------
 target/i386/ops_sse_header.h |   9 ++-
 target/i386/translate.c      | 132 ++++++-----------------------------
 3 files changed, 65 insertions(+), 150 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 2e50d91a25..82562c9473 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1169,52 +1169,56 @@ void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
     CC_SRC = comis_eflags[ret + 1];
 }
 
-uint32_t helper_movmskps(CPUX86State *env, Reg *s)
+uint32_t helper_movmskpsd(Reg *a, uint32_t desc)
 {
-    int b0, b1, b2, b3;
+    const intptr_t oprsz = simd_oprsz(desc);
 
-    b0 = s->ZMM_L(0) >> 31;
-    b1 = s->ZMM_L(1) >> 31;
-    b2 = s->ZMM_L(2) >> 31;
-    b3 = s->ZMM_L(3) >> 31;
-    return b0 | (b1 << 1) | (b2 << 2) | (b3 << 3);
+    uint32_t ret = 0;
+    for (intptr_t i = 0; i * sizeof(uint32_t) < oprsz; ++i) {
+        const uint32_t t = a->ZMM_L(i) & (1UL << 31);
+        ret |= t >> (31 - i);
+    }
+    return ret;
 }
 
-uint32_t helper_movmskpd(CPUX86State *env, Reg *s)
+uint64_t helper_movmskpsq(Reg *a, uint32_t desc)
 {
-    int b0, b1;
+    return helper_movmskpsd(a, desc);
+}
+
+uint32_t helper_movmskpdd(Reg *a, uint32_t desc)
+{
+    const intptr_t oprsz = simd_oprsz(desc);
 
-    b0 = s->ZMM_L(1) >> 31;
-    b1 = s->ZMM_L(3) >> 31;
-    return b0 | (b1 << 1);
+    uint32_t ret = 0;
+    for (intptr_t i = 0; i * sizeof(uint64_t) < oprsz; ++i) {
+        const uint64_t t = a->ZMM_Q(i) & (1ULL << 63);
+        ret |= t >> (63 - i);
+    }
+    return ret;
 }
 
+uint64_t helper_movmskpdq(Reg *a, uint32_t desc)
+{
+    return helper_movmskpdd(a, desc);
+}
 #endif
 
-uint32_t glue(helper_pmovmskb, SUFFIX)(CPUX86State *env, Reg *s)
+uint32_t glue(helper_pmovmskbd, SUFFIX)(Reg *a, uint32_t desc)
 {
-    uint32_t val;
-
-    val = 0;
-    val |= (s->B(0) >> 7);
-    val |= (s->B(1) >> 6) & 0x02;
-    val |= (s->B(2) >> 5) & 0x04;
-    val |= (s->B(3) >> 4) & 0x08;
-    val |= (s->B(4) >> 3) & 0x10;
-    val |= (s->B(5) >> 2) & 0x20;
-    val |= (s->B(6) >> 1) & 0x40;
-    val |= (s->B(7)) & 0x80;
-#if SHIFT == 1
-    val |= (s->B(8) << 1) & 0x0100;
-    val |= (s->B(9) << 2) & 0x0200;
-    val |= (s->B(10) << 3) & 0x0400;
-    val |= (s->B(11) << 4) & 0x0800;
-    val |= (s->B(12) << 5) & 0x1000;
-    val |= (s->B(13) << 6) & 0x2000;
-    val |= (s->B(14) << 7) & 0x4000;
-    val |= (s->B(15) << 8) & 0x8000;
-#endif
-    return val;
+    const intptr_t oprsz = simd_oprsz(desc);
+
+    uint32_t ret = 0;
+    for (intptr_t i = 0; i * sizeof(uint8_t) < oprsz; ++i) {
+        const uint8_t t = a->B(i) & (1 << 7);
+        ret |= i < 8 ? t >> (7 - i) : t << (i - 7);
+    }
+    return ret;
+}
+
+uint64_t glue(helper_pmovmskbq, SUFFIX)(Reg *a, uint32_t desc)
+{
+    return glue(helper_pmovmskbd, SUFFIX)(a, desc);
 }
 
 void glue(helper_packsswb, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 207d41e248..59ac1f28e3 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -178,11 +178,14 @@ DEF_HELPER_3(ucomiss, void, env, Reg, Reg)
 DEF_HELPER_3(comiss, void, env, Reg, Reg)
 DEF_HELPER_3(ucomisd, void, env, Reg, Reg)
 DEF_HELPER_3(comisd, void, env, Reg, Reg)
-DEF_HELPER_2(movmskps, i32, env, Reg)
-DEF_HELPER_2(movmskpd, i32, env, Reg)
+DEF_HELPER_2(movmskpsd, i32, Reg, i32)
+DEF_HELPER_2(movmskpsq, i64, Reg, i32)
+DEF_HELPER_2(movmskpdd, i32, Reg, i32)
+DEF_HELPER_2(movmskpdq, i64, Reg, i32)
 #endif
 
-DEF_HELPER_2(glue(pmovmskb, SUFFIX), i32, env, Reg)
+DEF_HELPER_2(glue(pmovmskbd, SUFFIX), i32, Reg, i32)
+DEF_HELPER_2(glue(pmovmskbq, SUFFIX), i64, Reg, i32)
 DEF_HELPER_3(glue(packsswb, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(packuswb, SUFFIX), void, env, Reg, Reg)
 DEF_HELPER_3(glue(packssdw, SUFFIX), void, env, Reg, Reg)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index bb4120a848..8f891b6e47 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3339,20 +3339,6 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
                 goto illegal_op;
             }
             break;
-        case 0x050: /* movmskps */
-            rm = (modrm & 7) | REX_B(s);
-            tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                             offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskps(s->tmp2_i32, cpu_env, s->ptr0);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
-            break;
-        case 0x150: /* movmskpd */
-            rm = (modrm & 7) | REX_B(s);
-            tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                             offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskpd(s->tmp2_i32, cpu_env, s->ptr0);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
-            break;
         case 0x02a: /* cvtpi2ps */
         case 0x12a: /* cvtpi2pd */
             gen_helper_enter_mmx(cpu_env);
@@ -3524,24 +3510,6 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
             gen_op_movq(s, offsetof(CPUX86State, fpregs[reg & 7].mmx),
                         offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             break;
-        case 0xd7: /* pmovmskb */
-        case 0x1d7:
-            if (mod != 3)
-                goto illegal_op;
-            if (b1) {
-                rm = (modrm & 7) | REX_B(s);
-                tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                                 offsetof(CPUX86State, xmm_regs[rm]));
-                gen_helper_pmovmskb_xmm(s->tmp2_i32, cpu_env, s->ptr0);
-            } else {
-                rm = (modrm & 7);
-                tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                                 offsetof(CPUX86State, fpregs[rm].mmx));
-                gen_helper_pmovmskb_mmx(s->tmp2_i32, cpu_env, s->ptr0);
-            }
-            reg = ((modrm >> 3) & 7) | REX_R(s);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
-            break;
 
         case 0x138:
         case 0x038:
@@ -5773,88 +5741,28 @@ GEN_INSN2(vmovhpd, Mq, Vdq)
     gen_insn2(movhpd, Mq, Vdq)(env, s, arg1, arg2);
 }
 
-DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
-GEN_INSN2(pmovmskb, Gq, Nq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(pmovmskb, Gd, Nq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_xmm, Gd, Udq)
-GEN_INSN2(pmovmskb, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(pmovmskb, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vpmovmskb, pmovmskb_xmm, Gd, Udq)
-GEN_INSN2(vpmovmskb, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vpmovmskb, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vpmovmskb, pmovmskb_xmm, Gd, Uqq)
-GEN_INSN2(vpmovmskb, Gq, Uqq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vpmovmskb, Gd, Uqq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
+DEF_GEN_INSN2_GVEC(pmovmskb, Gd, Nq, sd1_ool, MM_OPRSZ, MM_MAXSZ, pmovmskbd_mmx)
+DEF_GEN_INSN2_GVEC(pmovmskb, Gq, Nq, sq1_ool, MM_OPRSZ, MM_MAXSZ, pmovmskbq_mmx)
+DEF_GEN_INSN2_GVEC(pmovmskb, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbd_xmm)
+DEF_GEN_INSN2_GVEC(pmovmskb, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbq_xmm)
+DEF_GEN_INSN2_GVEC(vpmovmskb, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbd_xmm)
+DEF_GEN_INSN2_GVEC(vpmovmskb, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbq_xmm)
+DEF_GEN_INSN2_GVEC(vpmovmskb, Gd, Uqq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbd_xmm)
+DEF_GEN_INSN2_GVEC(vpmovmskb, Gq, Uqq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, pmovmskbq_xmm)
 
-DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
-GEN_INSN2(movmskps, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(movmskps, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vmovmskps, movmskps, Gd, Udq)
-GEN_INSN2(vmovmskps, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vmovmskps, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vmovmskps, movmskps, Gd, Uqq)
-GEN_INSN2(vmovmskps, Gq, Uqq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vmovmskps, Gd, Uqq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
+DEF_GEN_INSN2_GVEC(movmskps, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsd)
+DEF_GEN_INSN2_GVEC(movmskps, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsq)
+DEF_GEN_INSN2_GVEC(vmovmskps, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsd)
+DEF_GEN_INSN2_GVEC(vmovmskps, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsq)
+DEF_GEN_INSN2_GVEC(vmovmskps, Gd, Uqq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsd)
+DEF_GEN_INSN2_GVEC(vmovmskps, Gq, Uqq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpsq)
 
-DEF_GEN_INSN2_HELPER_DEP(movmskpd, movmskpd, Gd, Udq)
-GEN_INSN2(movmskpd, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(movmskpd, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vmovmskpd, movmskpd, Gd, Udq)
-GEN_INSN2(vmovmskpd, Gq, Udq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vmovmskpd, Gd, Udq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
-DEF_GEN_INSN2_HELPER_DEP(vmovmskpd, movmskpd, Gd, Uqq)
-GEN_INSN2(vmovmskpd, Gq, Uqq)
-{
-    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
-    gen_insn2(vmovmskpd, Gd, Uqq)(env, s, arg1_r32, arg2);
-    tcg_gen_extu_i32_i64(arg1, arg1_r32);
-    tcg_temp_free_i32(arg1_r32);
-}
+DEF_GEN_INSN2_GVEC(movmskpd, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdd)
+DEF_GEN_INSN2_GVEC(movmskpd, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdq)
+DEF_GEN_INSN2_GVEC(vmovmskpd, Gd, Udq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdd)
+DEF_GEN_INSN2_GVEC(vmovmskpd, Gq, Udq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdq)
+DEF_GEN_INSN2_GVEC(vmovmskpd, Gd, Uqq, sd1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdd)
+DEF_GEN_INSN2_GVEC(vmovmskpd, Gq, Uqq, sq1_ool, XMM_OPRSZ, XMM_MAXSZ, movmskpdq)
 
 GEN_INSN2(lddqu, Vdq, Mdq)
 {
-- 
2.20.1


