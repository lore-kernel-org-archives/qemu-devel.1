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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1288CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53BA22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ2YPWRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53BA22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V2V-0001BI-GH
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URX-0001Ut-4M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URU-0007pg-RV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:42 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URU-0007pM-Mk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:40 -0400
Received: by mail-yb1-xb43.google.com with SMTP id t5so1346376ybt.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XTNhzsWZmlyghNA6cx/sDxfqZ+eeuh66Tyk6g/qnVYc=;
 b=fJ2YPWRRgZ/WRbpCWfVHxCVIY5xCih/3JwiZEEG+ObXBuJdtyZJfBdFzHVkouyRjcB
 Qcmwr0lIM0upyeQW1NbiIuUmGL3GCRKEbYcA8S4v5vIKQUSwaGUwcnpIUYB3A8Azb4kM
 wSwTDRMU1/UDDKoKj6lM8WSnS202n8sYJlsiJIywk/DCz2Tk5p1uYjP2Rvyl5n/ZZlo/
 8cV/PKxevQ8rVBhw9DNWgOaT62XDFfpFNaBoDZaxRZ4y6zUX6vr/5RrGAIr6ZIBcQgaT
 FoslNFxHDn4IKUrIHhu8O3+PlUu0W/C+W5LmbbMG4V3v1fdvHuV0u9rLwU/dcn6AcwWy
 hrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XTNhzsWZmlyghNA6cx/sDxfqZ+eeuh66Tyk6g/qnVYc=;
 b=QyoMIyOfN+2gWO8bq4w0yDplwBHB+k0Ei0uAdkBaG/NHIbXurfFvHWSKeE65n3t16d
 HVmXITLjdN3ZqqMNOKyAxRCiAFacapS6oWxRtk9DEyOCNhKOROmNhbYasLZFAjZktmyq
 jFDjxdcjMBIsRF/mymYgYsGis4V5nAV5kb3iVq1tcD+xW9LND1wc8E+GzUuEksbID2Eo
 UXkEJKAk/8NP8ot0TJVtykHXUHtHsOSu/RCeEpOyhkPlkpsTkvtzz/TJ5QgZDFYS956T
 pJ3/HISjjOT7Ah5jnx7/4J1pQew+cvy1A6vTFtHO3JipIBppF+WW1Azcn4cVHwGJVwi7
 YB7A==
X-Gm-Message-State: APjAAAXINX3AvcNChUB4MukrdMfv5ho9YwWPvnBt1Nv90ve2HBpMlcNp
 eI9IlqlpJ+hOCooymTTxie4WPejr
X-Google-Smtp-Source: APXvYqwNdlEGGdLhUEVengpl+3aks77+QgOneT7wNGU/CV1uGNpgK2Icppa3JD7j4TWKreXw8eZ/LA==
X-Received: by 2002:a25:7005:: with SMTP id l5mr25781407ybc.452.1566408639799; 
 Wed, 21 Aug 2019 10:30:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:39 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:16 -0400
Message-Id: <20190821172951.15333-41-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 40/75] target/i386: introduce SSE code
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
 target/i386/translate.c | 309 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d77c08b7db..d1537bc1b7 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5586,6 +5586,90 @@ GEN_INSN2(movq, Eq, Pq)
 
 DEF_GEN_INSN2_GVEC(movq, Pq, Qq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movq, Qq, Pq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movaps, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movaps, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movups, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movups, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+
+GEN_INSN4(movss, Vdq, Vdq, Wd, modrm_mod)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    if (arg4 == 3) {
+        /* merging movss */
+        tcg_gen_ld_i32(r32, cpu_env, arg3 + offsetof(ZMMReg, ZMM_L(0)));
+        tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+        if (arg1 != arg2) {
+            tcg_gen_ld_i32(r32, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(1)));
+            tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+            tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
+            tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+        }
+    } else {
+        /* zero-extending movss */
+        tcg_gen_ld_i32(r32, cpu_env, arg3 + offsetof(ZMMReg, ZMM_L(0)));
+        tcg_gen_extu_i32_i64(r64, r32);
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+        tcg_gen_movi_i64(r64, 0);
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    }
+    tcg_temp_free_i32(r32);
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movss, Wd, Vd)
+{
+    gen_insn4(movss, Vdq, Vdq, Wd, modrm_mod)(env, s, arg1, arg1, arg2, 3);
+}
+
+GEN_INSN3(movhlps, Vdq, Vdq, UdqMhq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    tcg_gen_ld_i64(r64, cpu_env, arg3 + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    if (arg1 != arg2) {
+        tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    }
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movlps, Mq, Vq)
+{
+    insnop_ldst(xmm, Mq)(env, s, 1, arg2, arg1);
+}
+
+GEN_INSN3(movlhps, Vdq, Vq, Wq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    tcg_gen_ld_i64(r64, cpu_env, arg3 + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    if (arg1 != arg2) {
+        tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    }
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movhps, Mq, Vdq)
+{
+    insnop_ldst(xmm, Mhq)(env, s, 1, arg2, arg1);
+}
+
+DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
+GEN_INSN2(pmovmskb, Gq, Nq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(pmovmskb, Gd, Nq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+
+DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
+GEN_INSN2(movmskps, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(movmskps, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
@@ -5594,6 +5678,8 @@ DEF_GEN_INSN3_GVEC(paddsb, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsw, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusb, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusw, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
 
 DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubw, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_16)
@@ -5602,11 +5688,38 @@ DEF_GEN_INSN3_GVEC(psubsb, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsw, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusb, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusw, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_16)
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
+DEF_GEN_INSN3_GVEC(pminub, Pq, Pq, Qq, umin, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pminsw, Pq, Pq, Qq, smin, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
+DEF_GEN_INSN3_GVEC(pmaxub, Pq, Pq, Qq, umax, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pmaxsw, Pq, Pq, Qq, smax, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
+
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
@@ -5614,10 +5727,98 @@ DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_
 DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
 
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
 DEF_GEN_INSN3_GVEC(pand, Pq, Pq, Qq, and, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(andps, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Pq, Pq, Qq, andn, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(andnps, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Pq, Pq, Qq, or, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(orps, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Pq, Pq, Qq, xor, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(xorps, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
@@ -5660,8 +5861,116 @@ DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
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
+    insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
+}
+
+GEN_INSN2(movntq, Mq, Pq)
+{
+    insnop_ldst(mm, Mq)(env, s, 1, arg2, arg1);
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


