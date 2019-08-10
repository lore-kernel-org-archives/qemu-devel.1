Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B22C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B1C217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNLcXvN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B1C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwJ2T-0001Dz-Id
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlH-0006yG-TZ
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlF-0004i9-NE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlF-0004f9-H2
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id j11so40047706otp.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DxPrrGEHPmPl3Q+LidZQAcbTVrchg9uhnKuWrY0vGLs=;
 b=FNLcXvN7MeBjyRWmK74zvoEkpUB0hJ5DBmLZQ5DIv3TtJDIqqqEiVKx1kc/6VHP2To
 LWaJ6asXZggT8qvfJi3Vu8Zgqlw6AMsGRb1aFNyRgFMiy5tsiHVxhLLuIZ1HcDOVvacQ
 0tHZ0jkXLIT4Djq1+q+dOcNjoPb40DOz5xTf/xpsj1JqMQXXwp59RBtWlLW3AReveyhR
 yjaEwyAZKDoAdi0pOMOb1Szq3Vn316M0J8FhYJ55CfLKysJ2aLoyNuOr07K5HscKtyIM
 C2eABBCk5dvSMBypb7DeEwXHJq+F+HTKja89huuRo7XSNOfPvHu8fpxSwCtCajOhMbTq
 v2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxPrrGEHPmPl3Q+LidZQAcbTVrchg9uhnKuWrY0vGLs=;
 b=mjZjLOXc6yzS7Iobt+qa1r4DeIrpCkPuSsYImpDKo8UeSdi1iO7Ns12mHehx0iCQ5q
 ksVhjYlzSkWGdwhTZwBbtUfNn8CIuY4lkFv3ctVfUONyZvdL3U71agvUzVqCgpai3Xop
 15+IedP+dQcnEffhIx1NYqcfvW0ZYzJKTG6gk3VejcYc/RMK6Jh5qMuUrw8x8Be12oYO
 B0/pnRPPlgvUZUBX0xSTZC9fWKe8K0F60dPyunh7Zn9/VT9XYNCrOmrJS9LnyjLyk8+h
 3ZCkvH7N42yATLie8nCjxveIQ599Btf+DjO6L9CB1VZbOlvDD3C08Ld5wNW/hqoA4v8U
 qlow==
X-Gm-Message-State: APjAAAVOUJJB+UTYRNPh8BmolpczcaZ70YYs3QrAwd7zUmYPfDLg+0wP
 IalB05TdrqpDwniXxNmBShykXqiP
X-Google-Smtp-Source: APXvYqzN0/F9nao9MUwG1Q642yRYsU9gWVUOfWjrufApjLgPQjs8apSsTXl7Hu4yxhuFTNOuXpNg4A==
X-Received: by 2002:a05:6808:313:: with SMTP id
 i19mr8700292oie.30.1565410424571; 
 Fri, 09 Aug 2019 21:13:44 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:44 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:53 -0400
Message-Id: <20190810041255.6820-38-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 37/39] target/i386: introduce SSE code
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
 target/i386/translate.c | 440 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 440 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 12d2ac2eb5..681fa1aee2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4943,6 +4943,9 @@ INSNOP_LDST_UNIFY(Wdq, Udq, UdqMdq)
 #define GEN_INSN_WR_GVEC_MM(mnem, gvec, opW1, opR1, vece)       \
     GEN_INSN_WR_GVEC(mnem, gvec, opW1, opR1, vece,              \
                      sizeof(MMXReg), sizeof(MMXReg))
+#define GEN_INSN_WR_GVEC_XMM(mnem, gvec, opW1, opR1, vece)      \
+    GEN_INSN_WR_GVEC(mnem, gvec, opW1, opR1, vece,              \
+                     sizeof(XMMReg), sizeof(XMMReg))
 
 #define GEN_INSN_WRR_GVEC(mnem, gvec, opW1, opR1, opR2, vece, oprsz, maxsz) \
     static void gen_insn_wrr(mnem, opW1, opR1, opR2)(                   \
@@ -4954,6 +4957,9 @@ INSNOP_LDST_UNIFY(Wdq, Udq, UdqMdq)
 #define GEN_INSN_WRR_GVEC_MM(mnem, gvec, opW1, opR1, opR2, vece)    \
     GEN_INSN_WRR_GVEC(mnem, gvec, opW1, opR1, opR2, vece,           \
                       sizeof(MMXReg), sizeof(MMXReg))
+#define GEN_INSN_WRR_GVEC_XMM(mnem, gvec, opW1, opR1, opR2, vece)   \
+    GEN_INSN_WRR_GVEC(mnem, gvec, opW1, opR1, opR2, vece,           \
+                      sizeof(XMMReg), sizeof(XMMReg))
 
 static void gen_insn_wr(movq, Eq, Pq)(CPUX86State *env, DisasContext *s,
                                       insnop_t(Eq) ret, insnop_t(Pq) arg1)
@@ -4986,6 +4992,101 @@ static void gen_insn_wr(movd, Pq, Ed)(CPUX86State *env, DisasContext *s,
 
 GEN_INSN_WR_GVEC_MM(movq, mov, Pq, Qq, MO_64)
 GEN_INSN_WR_GVEC_MM(movq, mov, Qq, Pq, MO_64)
+GEN_INSN_WR_GVEC_XMM(movaps, mov, Vdq, Wdq, MO_64)
+GEN_INSN_WR_GVEC_XMM(movaps, mov, Wdq, Vdq, MO_64)
+GEN_INSN_WR_GVEC_XMM(movups, mov, Vdq, Wdq, MO_64)
+GEN_INSN_WR_GVEC_XMM(movups, mov, Wdq, Vdq, MO_64)
+
+static void gen_insn_wr(movss, Wd, Vd)(CPUX86State *env, DisasContext *s,
+                                       insnop_t(Wd) ret, insnop_t(Vd) arg1)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_L(0));
+    gen_op_movl(s, ret + ofs, arg1 + ofs);
+}
+
+static void gen_insn_wrr(movss, Vdq, Vdq, UdMd)(CPUX86State *env,
+                                                DisasContext *s,
+                                                insnop_t(Vdq) ret,
+                                                insnop_t(Vdq) arg1,
+                                                insnop_t(UdMd) arg2)
+{
+    assert(ret == arg1);
+
+    if (arg2.is_mem) {
+        const size_t ofs0 = offsetof(ZMMReg, ZMM_Q(0));
+        const size_t ofs1 = offsetof(ZMMReg, ZMM_Q(1));
+
+        tcg_gen_movi_i64(s->tmp1_i64, 0);
+        tcg_gen_st_i64(s->tmp1_i64, cpu_env, ret + ofs0);
+        tcg_gen_st_i64(s->tmp1_i64, cpu_env, ret + ofs1);
+    }
+    gen_insn_wr(movss, Wd, Vd)(env, s, ret, arg2.op_reg);
+}
+
+static void gen_insn_wr(movlps, Mq, Vq)(CPUX86State *env, DisasContext *s,
+                                        insnop_t(Mq) ret, insnop_t(Vq) arg1)
+{
+    assert(ret == s->A0);
+    gen_stq_env_A0(s, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+}
+
+static void gen_insn_wr(movhlps, Vq, UdqMq)(CPUX86State *env,
+                                            DisasContext *s,
+                                            insnop_t(Vq) ret,
+                                            insnop_t(UdqMq) arg1)
+{
+    const size_t dofs = offsetof(ZMMReg, ZMM_Q(0));
+    const size_t aofs = offsetof(ZMMReg, ZMM_Q(arg1.is_mem ? 0 : 1));
+    gen_op_movq(s, ret + dofs, arg1.op_reg + aofs);
+}
+
+static void gen_insn_wr(movhps, Mq, Vdq)(CPUX86State *env, DisasContext *s,
+                                         insnop_t(Mq) ret, insnop_t(Vdq) arg1)
+{
+    assert(ret == s->A0);
+    gen_stq_env_A0(s, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+}
+
+static void gen_insn_wrr(movlhps, Vdq, Vq, UqMq)(CPUX86State *env,
+                                                 DisasContext *s,
+                                                 insnop_t(Vdq) ret,
+                                                 insnop_t(Vq) arg1,
+                                                 insnop_t(UqMq) arg2)
+{
+    assert(ret == arg1);
+
+    const size_t dofs = offsetof(ZMMReg, ZMM_Q(1));
+    const size_t aofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, ret + dofs, arg2.op_reg + aofs);
+}
+
+static void gen_insn_wr(pmovmskb, Gd, Nq)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Gd) ret, insnop_t(Nq) arg1)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_pmovmskb_mmx(ret, cpu_env, s->ptr0);
+}
+
+static void gen_insn_wr(pmovmskb, Gq, Nq)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Gq) ret, insnop_t(Nq) arg1)
+{
+    gen_insn_wr(pmovmskb, Gd, Nq)(env, s, s->tmp2_i32, arg1);
+    tcg_gen_extu_i32_i64(ret, s->tmp2_i32);
+}
+
+static void gen_insn_wr(movmskps, Gd, Udq)(CPUX86State *env, DisasContext *s,
+                                           insnop_t(Gd) ret, insnop_t(Udq) arg1)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_movmskps(ret, cpu_env, s->ptr0);
+}
+
+static void gen_insn_wr(movmskps, Gq, Udq)(CPUX86State *env, DisasContext *s,
+                                           insnop_t(Gq) ret, insnop_t(Udq) arg1)
+{
+    gen_insn_wr(movmskps, Gd, Udq)(env, s, s->tmp2_i32, arg1);
+    tcg_gen_extu_i32_i64(ret, s->tmp2_i32);
+}
 
 GEN_INSN_WRR_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
@@ -4994,6 +5095,8 @@ GEN_INSN_WRR_GVEC_MM(paddsb, ssadd, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(paddsw, ssadd, Pq, Pq, Qq, MO_16)
 GEN_INSN_WRR_GVEC_MM(paddusb, usadd, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(paddusw, usadd, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_HELPER(addps, addps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(addss, addss, Vd, Vd, Wd)
 
 GEN_INSN_WRR_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(psubw, sub, Pq, Pq, Qq, MO_16)
@@ -5002,11 +5105,39 @@ GEN_INSN_WRR_GVEC_MM(psubsb, sssub, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(psubsw, sssub, Pq, Pq, Qq, MO_16)
 GEN_INSN_WRR_GVEC_MM(psubusb, ussub, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(psubusw, ussub, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_HELPER(subps, subps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(subss, subss, Vd, Vd, Wd)
 
 GEN_INSN_WRR_HELPER(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
 GEN_INSN_WRR_HELPER(pmullw, pmullw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(mulps, mulps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(mulss, mulss, Vd, Vd, Wd)
+
 GEN_INSN_WRR_HELPER(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
 
+GEN_INSN_WRR_HELPER(divps, divps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(divss, divss, Vd, Vd, Wd)
+
+GEN_INSN_WR_HELPER(rcpps, rcpps, Vdq, Wdq)
+GEN_INSN_WR_HELPER(rcpss, rcpss, Vd, Wd)
+GEN_INSN_WR_HELPER(sqrtps, sqrtps, Vdq, Wdq)
+GEN_INSN_WR_HELPER(sqrtss, sqrtss, Vd, Wd)
+GEN_INSN_WR_HELPER(rsqrtps, rsqrtps, Vdq, Wdq)
+GEN_INSN_WR_HELPER(rsqrtss, rsqrtss, Vd, Wd)
+
+GEN_INSN_WRR_GVEC_MM(pminub, umin, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(pminsw, smin, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_HELPER(minps, minps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(minss, minss, Vd, Vd, Wd)
+GEN_INSN_WRR_GVEC_MM(pmaxub, umax, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(pmaxsw, smax, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_HELPER(maxps, maxps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(maxss, maxss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(pavgb, pavgb_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(pavgw, pavgw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psadbw, psadbw_mmx, Pq, Pq, Qq)
+
 GEN_INSN_WRR_GVEC_MM(pcmpeqb, cmpeq, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(pcmpeqw, cmpeq, Pq, Pq, Qq, MO_16)
 GEN_INSN_WRR_GVEC_MM(pcmpeqd, cmpeq, Pq, Pq, Qq, MO_32)
@@ -5014,10 +5145,108 @@ GEN_INSN_WRR_GVEC_MM(pcmpgtb, cmpgt, Pq, Pq, Qq, MO_8)
 GEN_INSN_WRR_GVEC_MM(pcmpgtw, cmpgt, Pq, Pq, Qq, MO_16)
 GEN_INSN_WRR_GVEC_MM(pcmpgtd, cmpgt, Pq, Pq, Qq, MO_32)
 
+GEN_INSN_WRR_HELPER(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpeqss, cmpeqss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpltps, cmpltps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpltss, cmpltss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpleps, cmpleps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpless, cmpless, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpunordps, cmpunordps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpunordss, cmpunordss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpneqps, cmpneqps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpneqss, cmpneqss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpnltps, cmpnltps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpnltss, cmpnltss, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpnleps, cmpnleps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpnless, cmpnless, Vd, Vd, Wd)
+GEN_INSN_WRR_HELPER(cmpordps, cmpordps, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(cmpordss, cmpordss, Vd, Vd, Wd)
+
+static void gen_insn_wrrr(cmpps, Vdq, Vdq, Wdq, Ib)(CPUX86State *env,
+                                                    DisasContext *s,
+                                                    insnop_t(Vdq) ret,
+                                                    insnop_t(Vdq) arg1,
+                                                    insnop_t(Wdq) arg2,
+                                                    insnop_t(Ib) arg3)
+{
+    switch (arg3 & 7) {
+    case 0:
+        gen_insn_wrr(cmpeqps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 1:
+        gen_insn_wrr(cmpltps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 2:
+        gen_insn_wrr(cmpleps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 3:
+        gen_insn_wrr(cmpunordps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 4:
+        gen_insn_wrr(cmpneqps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 5:
+        gen_insn_wrr(cmpnltps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 6:
+        gen_insn_wrr(cmpnleps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    case 7:
+        gen_insn_wrr(cmpordps, Vdq, Vdq, Wdq)(env, s, ret, arg1, arg2);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+static void gen_insn_wrrr(cmpss, Vd, Vd, Wd, Ib)(CPUX86State *env,
+                                                 DisasContext *s,
+                                                 insnop_t(Vd) ret,
+                                                 insnop_t(Vd) arg1,
+                                                 insnop_t(Wd) arg2,
+                                                 insnop_t(Ib) arg3)
+{
+    switch (arg3 & 7) {
+    case 0:
+        gen_insn_wrr(cmpeqss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 1:
+        gen_insn_wrr(cmpltss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 2:
+        gen_insn_wrr(cmpless, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 3:
+        gen_insn_wrr(cmpunordss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 4:
+        gen_insn_wrr(cmpneqss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 5:
+        gen_insn_wrr(cmpnltss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 6:
+        gen_insn_wrr(cmpnless, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    case 7:
+        gen_insn_wrr(cmpordss, Vd, Vd, Wd)(env, s, ret, arg1, arg2);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+GEN_INSN_WR_HELPER(comiss, comiss, Vd, Wd)
+GEN_INSN_WR_HELPER(ucomiss, ucomiss, Vd, Wd)
+
 GEN_INSN_WRR_GVEC_MM(pand, and, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_XMM(andps, and, Vdq, Vdq, Wdq, MO_64)
 GEN_INSN_WRR_GVEC_MM(pandn, andn, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_XMM(andnps, andn, Vdq, Vdq, Wdq, MO_64)
 GEN_INSN_WRR_GVEC_MM(por, or, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_XMM(orps, or, Vdq, Vdq, Wdq, MO_64)
 GEN_INSN_WRR_GVEC_MM(pxor, xor, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_XMM(xorps, xor, Vdq, Vdq, Wdq, MO_64)
 
 GEN_INSN_WRR_HELPER(psllw, psllw_mmx, Pq, Pq, Qq)
 GEN_INSN_WRR_HELPER(pslld, pslld_mmx, Pq, Pq, Qq)
@@ -5061,8 +5290,219 @@ GEN_INSN_WRR_HELPER(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
 GEN_INSN_WRR_HELPER(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
 GEN_INSN_WRR_HELPER(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
 
+GEN_INSN_WRR_HELPER(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
+GEN_INSN_WRR_HELPER(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
+
 GEN_INSN_HELPER(emms, emms)
 
+static void gen_insn_wrr(pshufw, Pq, Qq, Ib)(CPUX86State *env,
+                                             DisasContext *s,
+                                             insnop_t(Pq) ret,
+                                             insnop_t(Qq) arg1,
+                                             insnop_t(Ib) arg2)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);
+    tcg_gen_addi_ptr(s->ptr1, cpu_env, arg1);
+    tcg_gen_movi_i32(s->tmp2_i32, arg2);
+    gen_helper_pshufw_mmx(s->ptr0, s->ptr1, s->tmp2_i32);
+}
+
+static void gen_insn_wrrr(shufps, Vdq, Vdq, Wdq, Ib)(CPUX86State *env,
+                                                     DisasContext *s,
+                                                     insnop_t(Vdq) ret,
+                                                     insnop_t(Vdq) arg1,
+                                                     insnop_t(Wdq) arg2,
+                                                     insnop_t(Ib) arg3)
+{
+    assert(ret == arg1);
+
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);
+    tcg_gen_addi_ptr(s->ptr1, cpu_env, arg2);
+    tcg_gen_movi_i32(s->tmp2_i32, arg3);
+    gen_helper_shufps(s->ptr0, s->ptr1, s->tmp2_i32);
+}
+
+static void gen_insn_wrrr(pinsrw, Pq, Pq, RdMw, Ib)(CPUX86State *env,
+                                                    DisasContext *s,
+                                                    insnop_t(Pq) ret,
+                                                    insnop_t(Pq) arg1,
+                                                    insnop_t(RdMw) arg2,
+                                                    insnop_t(Ib) arg3)
+{
+    assert(ret == arg1);
+
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
+    tcg_gen_st16_i32(arg2.op_reg, cpu_env, ret + ofs);
+}
+
+static void gen_insn_wrr(pextrw, Gd, Nq, Ib)(CPUX86State *env,
+                                             DisasContext *s,
+                                             insnop_t(Gd) ret,
+                                             insnop_t(Nq) arg1,
+                                             insnop_t(Ib) arg2)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg2 & 3));
+    tcg_gen_ld16u_i32(ret, cpu_env, arg1 + ofs);
+}
+
+static void gen_insn_wrr(pextrw, Gq, Nq, Ib)(CPUX86State *env,
+                                             DisasContext *s,
+                                             insnop_t(Gq) ret,
+                                             insnop_t(Nq) arg1,
+                                             insnop_t(Ib) arg2)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_W(arg2 & 3));
+    tcg_gen_ld16u_i64(ret, cpu_env, arg1 + ofs);
+}
+
+GEN_INSN_WR_HELPER(cvtpi2ps, cvtpi2ps, Vdq, Qq)
+
+static void gen_insn_wr(cvtsi2ss, Vd, Ed)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Vd) ret, insnop_t(Ed) arg1)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);
+    gen_helper_cvtsi2ss(cpu_env, s->ptr0, arg1);
+}
+
+static void gen_insn_wr(cvtsi2ss, Vd, Eq)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Vd) ret, insnop_t(Eq) arg1)
+{
+#ifdef TARGET_X86_64
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);
+    gen_helper_cvtsq2ss(cpu_env, s->ptr0, arg1);
+#else /* TARGET_X86_64 */
+    g_assert_not_reached();
+#endif /* TARGET_X86_64 */
+}
+
+GEN_INSN_WR_HELPER(cvtps2pi, cvtps2pi, Pq, Wq)
+
+static void gen_insn_wr(cvtss2si, Gd, Wd)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Gd) ret, insnop_t(Wd) arg1)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_cvtss2si(ret, cpu_env, s->ptr0);
+}
+
+static void gen_insn_wr(cvtss2si, Gq, Wd)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Gq) ret, insnop_t(Wd) arg1)
+{
+#ifdef TARGET_X86_64
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_cvtss2sq(ret, cpu_env, s->ptr0);
+#else /* TARGET_X86_64 */
+    g_assert_not_reached();
+#endif /* TARGET_X86_64 */
+}
+
+GEN_INSN_WR_HELPER(cvttps2pi, cvttps2pi, Pq, Wq)
+
+static void gen_insn_wr(cvttss2si, Gd, Wd)(CPUX86State *env, DisasContext *s,
+                                           insnop_t(Gd) ret, insnop_t(Wd) arg1)
+{
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_cvttss2si(ret, cpu_env, s->ptr0);
+}
+
+static void gen_insn_wr(cvttss2si, Gq, Wd)(CPUX86State *env, DisasContext *s,
+                                           insnop_t(Gq) ret, insnop_t(Wd) arg1)
+{
+#ifdef TARGET_X86_64
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, arg1);
+    gen_helper_cvttss2sq(ret, cpu_env, s->ptr0);
+#else /* TARGET_X86_64 */
+    g_assert_not_reached();
+#endif /* TARGET_X86_64 */
+}
+
+static void gen_insn_wr(maskmovq, Pq, Nq)(CPUX86State *env, DisasContext *s,
+                                          insnop_t(Pq) ret, insnop_t(Nq) arg1)
+{
+    tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
+    gen_extu(s->aflag, s->A0);
+    gen_add_A0_ds_seg(s);
+
+    tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);
+    tcg_gen_addi_ptr(s->ptr1, cpu_env, arg1);
+    gen_helper_maskmov_mmx(cpu_env, s->ptr0, s->ptr1, s->A0);
+}
+
+static void gen_insn_wr(movntq, Mq, Pq)(CPUX86State *env, DisasContext *s,
+                                        insnop_t(Mq) ret, insnop_t(Pq) arg1)
+{
+    assert(ret == s->A0);
+    gen_stq_env_A0(s, arg1);
+}
+
+static void gen_insn_wr(movntps, Mdq, Vdq)(CPUX86State *env,
+                                           DisasContext *s,
+                                           insnop_t(Mdq) ret,
+                                           insnop_t(Vdq) arg1)
+{
+    assert(ret == s->A0);
+    gen_sto_env_A0(s, arg1);
+}
+
+static void gen_insn(sfence)(CPUX86State *env, DisasContext *s)
+{
+    if (s->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s);
+    } else {
+        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+    }
+}
+
+static void gen_insn_r(ldmxcsr, Md)(CPUX86State *env, DisasContext *s,
+                                    insnop_t(Md) arg1)
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
+static void gen_insn_w(stmxcsr, Md)(CPUX86State *env, DisasContext *s,
+                                    insnop_t(Md) ret)
+{
+    if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
+        gen_illegal_opcode(s);
+    } else if (s->flags & HF_TS_MASK) {
+        gen_exception(s, EXCP07_PREX);
+    } else {
+        const size_t ofs = offsetof(CPUX86State, mxcsr);
+        tcg_gen_ld_i32(s->tmp2_i32, cpu_env, ofs);
+        tcg_gen_qemu_st_i32(s->tmp2_i32, ret, s->mem_index, MO_LEUL);
+    }
+}
+
+static void gen_insn_r(prefetcht0, Mb)(CPUX86State *env, DisasContext *s,
+                                       insnop_t(Mb) arg1)
+{
+    /* no-op */
+}
+
+static void gen_insn_r(prefetcht1, Mb)(CPUX86State *env, DisasContext *s,
+                                       insnop_t(Mb) arg1)
+{
+    /* no-op */
+}
+
+static void gen_insn_r(prefetcht2, Mb)(CPUX86State *env, DisasContext *s,
+                                       insnop_t(Mb) arg1)
+{
+    /* no-op */
+}
+
+static void gen_insn_r(prefetchnta, Mb)(CPUX86State *env, DisasContext *s,
+                                        insnop_t(Mb) arg1)
+{
+    /* no-op */
+}
+
 /*
  * Instruction translators
  */
-- 
2.20.1


