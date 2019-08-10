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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D3C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E282166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/H2o46c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E282166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIt9-0000rT-FY
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlA-0006bk-UV
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl9-0004Xp-Is
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl9-0004Xb-E2
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id j11so40047106otp.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zIMkv7Ci/SY2YQuD6s0tteNDjdvIT0Ql16O4dJapRLk=;
 b=W/H2o46c7Oxuwl/N3PU5OQhaYy+mkyH/BGXtsosYSD4xjuz5+stG8tHUw46ootk7wl
 TBSyTnYRJLhh8NO24npH8ygiT+09QCZZn+L1DvN0M0X4M3I5PnHBkREYUqis5CyR8Jmk
 i5qgRk7iFWr6wPWYmT8r8ZEeINp5nLreCNI9TGoFjsYczOtvBbPh+0GIyF0qBbHplF42
 FeGX1euBYXh57k+CtwmosSkSiyRSC+pPJRJL2Y1tF6Iq130bOLRw/HLeUjSV52Eb2hhR
 bdgGTPJrFLIGPCeTxhuzskOe2BMHN6kQXe6WW4My8Df54euV0jqPwfDoAJTUDWrrkqud
 zVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zIMkv7Ci/SY2YQuD6s0tteNDjdvIT0Ql16O4dJapRLk=;
 b=AKkmImGTh6wFJ28+SdlDLSbrjwVwBagDEGBEx9QC22oL/YJt4aQnKwvK4xIpzAKJlf
 zJRdYThhHKByBOOYSPzlrdn7ePSEEnPS605VSpKlZ3I3U0fN5ue7BUwMmRNJKYjMdKiK
 JNLnvLw0W+HWVOQj7P5czj2cKMz+WR9RGR91xnmsy7mfJQ2TIJFkN9rV6D3tpfDxODf6
 5wGckKq0fz8U0jPY3+fyh7v01+n37LOtWFGkcwnM2shfPwmA1zgYWqJnsq00BbdojXJv
 JepBA9aPOfM8WWy1fJXVMga7TFlTBjPVqUxnv+4AcLDxp8eiNhtZtxm7YrKzp59+SBGP
 Ilnw==
X-Gm-Message-State: APjAAAXEBRyjp2BQxQwdWO6oj61aIdYW0//la+uDzoBpKZkiO7Y/iHpM
 9evGX4bkisrzpwrNQZA7/NvGKsTJ
X-Google-Smtp-Source: APXvYqzCLUuVJ/HYjUFTJ4hAW4HOEiW2BJvfMuVknGW6ZliaECjmVofjYqpC5kGh1+dX22TfdtUJwQ==
X-Received: by 2002:aca:4a97:: with SMTP id x145mr8134043oia.120.1565410418558; 
 Fri, 09 Aug 2019 21:13:38 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:38 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:48 -0400
Message-Id: <20190810041255.6820-33-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RFC PATCH v2 32/39] target/i386: introduce MMX code
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

Define code generators required for MMX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 114 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3475727380..aa6fb8b013 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4890,6 +4890,9 @@ INSNOP_LDST_UNIFY(Qq, Nq, NqMq)
     {                                                                   \
         tcg_gen_gvec_ ## gvec(vece, ret, arg1, oprsz, maxsz);           \
     }
+#define GEN_INSN_WR_GVEC_MM(mnem, gvec, opW1, opR1, vece)       \
+    GEN_INSN_WR_GVEC(mnem, gvec, opW1, opR1, vece,              \
+                     sizeof(MMXReg), sizeof(MMXReg))
 
 #define GEN_INSN_WRR_GVEC(mnem, gvec, opW1, opR1, opR2, vece, oprsz, maxsz) \
     static void gen_insn_wrr(mnem, opW1, opR1, opR2)(                   \
@@ -4898,6 +4901,117 @@ INSNOP_LDST_UNIFY(Qq, Nq, NqMq)
     {                                                                   \
         tcg_gen_gvec_ ## gvec(vece, ret, arg1, arg2, oprsz, maxsz);     \
     }
+#define GEN_INSN_WRR_GVEC_MM(mnem, gvec, opW1, opR1, opR2, vece)    \
+    GEN_INSN_WRR_GVEC(mnem, gvec, opW1, opR1, opR2, vece,           \
+                      sizeof(MMXReg), sizeof(MMXReg))
+
+static void gen_insn_wr(movq, Eq, Pq)(CPUX86State *env, DisasContext *s,
+                                      insnop_t(Eq) ret, insnop_t(Pq) arg1)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_Q(0));
+    tcg_gen_ld_i64(ret, cpu_env, arg1 + ofs);
+}
+
+static void gen_insn_wr(movd, Ed, Pq)(CPUX86State *env, DisasContext *s,
+                                      insnop_t(Ed) ret, insnop_t(Pq) arg1)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_L(0));
+    tcg_gen_ld_i32(ret, cpu_env, arg1 + ofs);
+}
+
+static void gen_insn_wr(movq, Pq, Eq)(CPUX86State *env, DisasContext *s,
+                                      insnop_t(Pq) ret, insnop_t(Eq) arg1)
+{
+    const size_t ofs = offsetof(MMXReg, MMX_Q(0));
+    tcg_gen_st_i64(arg1, cpu_env, ret + ofs);
+}
+
+static void gen_insn_wr(movd, Pq, Ed)(CPUX86State *env, DisasContext *s,
+                                      insnop_t(Pq) ret, insnop_t(Ed) arg1)
+{
+    const insnop_t(Eq) r64 = s->tmp1_i64;
+    tcg_gen_extu_i32_i64(r64, arg1);
+    gen_insn_wr(movq, Pq, Eq)(env, s, ret, r64);
+}
+
+GEN_INSN_WR_GVEC_MM(movq, mov, Pq, Qq, MO_64)
+GEN_INSN_WR_GVEC_MM(movq, mov, Qq, Pq, MO_64)
+
+GEN_INSN_WRR_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(paddd, add, Pq, Pq, Qq, MO_32)
+GEN_INSN_WRR_GVEC_MM(paddsb, ssadd, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(paddsw, ssadd, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(paddusb, usadd, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(paddusw, usadd, Pq, Pq, Qq, MO_16)
+
+GEN_INSN_WRR_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(psubw, sub, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(psubd, sub, Pq, Pq, Qq, MO_32)
+GEN_INSN_WRR_GVEC_MM(psubsb, sssub, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(psubsw, sssub, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(psubusb, ussub, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(psubusw, ussub, Pq, Pq, Qq, MO_16)
+
+GEN_INSN_WRR_HELPER(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(pmullw, pmullw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
+
+GEN_INSN_WRR_GVEC_MM(pcmpeqb, cmpeq, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(pcmpeqw, cmpeq, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(pcmpeqd, cmpeq, Pq, Pq, Qq, MO_32)
+GEN_INSN_WRR_GVEC_MM(pcmpgtb, cmpgt, Pq, Pq, Qq, MO_8)
+GEN_INSN_WRR_GVEC_MM(pcmpgtw, cmpgt, Pq, Pq, Qq, MO_16)
+GEN_INSN_WRR_GVEC_MM(pcmpgtd, cmpgt, Pq, Pq, Qq, MO_32)
+
+GEN_INSN_WRR_GVEC_MM(pand, and, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_MM(pandn, andn, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_MM(por, or, Pq, Pq, Qq, MO_64)
+GEN_INSN_WRR_GVEC_MM(pxor, xor, Pq, Pq, Qq, MO_64)
+
+GEN_INSN_WRR_HELPER(psllw, psllw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(pslld, pslld_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psllq, psllq_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psrlw, psrlw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psrld, psrld_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psrlq, psrlq_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psraw, psraw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(psrad, psrad_mmx, Pq, Pq, Qq)
+
+#define GEN_PSHIFT_IMM_MM(mnem, opW1, opR1)                             \
+    static void gen_insn_wrr(mnem, opW1, opR1, Ib)(                     \
+        CPUX86State *env, DisasContext *s,                              \
+        insnop_t(opW1) ret, insnop_t(opR1) arg1, insnop_t(Ib) arg2)     \
+    {                                                                   \
+        const uint64_t arg2_ui64 = (uint8_t)arg2;                       \
+        const insnop_t(Eq) arg2_r64 = s->tmp1_i64;                      \
+        const insnop_t(Qq) arg2_mm = offsetof(CPUX86State, mmx_t0.MMX_Q(0)); \
+                                                                        \
+        tcg_gen_movi_i64(arg2_r64, arg2_ui64);                          \
+        gen_insn_wr(movq, Pq, Eq)(env, s, arg2_mm, arg2_r64);           \
+        gen_insn_wrr(mnem, Pq, Pq, Qq)(env, s, ret, arg1, arg2_mm);     \
+    }
+
+GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
+GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
+GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
+
+GEN_INSN_WRR_HELPER(packsswb, packsswb_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(packssdw, packssdw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(packuswb, packuswb_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
+GEN_INSN_WRR_HELPER(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
+GEN_INSN_WRR_HELPER(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
+GEN_INSN_WRR_HELPER(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
+GEN_INSN_WRR_HELPER(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
+
+GEN_INSN_HELPER(emms, emms)
 
 /*
  * Instruction translators
-- 
2.20.1


