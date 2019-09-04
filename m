Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2BC41514
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE0622CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3cKgFgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE0622CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bXt-0008K8-Sf
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0I-0004rs-Mq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0B-0002VS-KY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0B-0002UU-3L
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn20so11059plb.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iM/MK27WISdpRjls4DcvOBTp/PD0RaySkeZF+DPBDTg=;
 b=H3cKgFgciMaB4mJPnXFCXORV//+vnbB8yFMvPJZMnYJFDZCCrO5Q2NgE0Ta6mFBWEV
 so2etwYLf0JcQL0eUp+RV+s5Xx44ydghvUTf0stsQL9rJ4tsQCrozujQHdmnaJY68iDy
 HJAS/gFOQ3LblzASkrYIBjIi8N7u13rOEJhrP+IieQaVhF2RkcKDeuzS1a75EOs6iiND
 YGpVi2fdT2Npiox2oviexrWstTIBJ3uadBrsQgqCXcvrd257Iv9fp7/gVSEKbjUGU6FY
 Id7OkhjSoCbRGzM0bxX5v/fFajId6QtCHEiYuLoTIxV/w5dyVfuEU6N+OnBMJmuaMlE4
 G2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iM/MK27WISdpRjls4DcvOBTp/PD0RaySkeZF+DPBDTg=;
 b=XuYGBT/mxsSkohUDrgjiQR2nRn9U0iZygjCbzwwB2FHwPLbYz55eM+5/lEIYbNlyjG
 uu5q3Y5SPRsqrYdPGGrvih0d21UH5uf00yPl7uCycDTE8E/Pe6ePwrmyp8DqWrvMM8ia
 cutqWDIt1QoaBAGCg0Ae02hTldCkLY1xrbB51Z50MDO3cOYm4Yo898NjT7MrbW+Hj+gv
 2ABW1H1CAyKf9CUSwHLXdDiR4WhOgdI0htJQCW1Hf9kIX+YVw/7kvVKieLwpK1FM4l1z
 uqQr5TRMSx4EWoMuUqWwHO2kXvaJWS84O3k03IUycJwBgWOfHOkhJkG7E/QLKJYUvWQt
 Y88A==
X-Gm-Message-State: APjAAAWVnAsiVfAfSFjcafGX27eWEk+44AwxJPkVYRN6+Hi4idzc97Lz
 9l0kgDdxvkBBZE533/N+gjstLT1zbPM=
X-Google-Smtp-Source: APXvYqwCTPhB7xi8Q2yEx80jSiTVQ86LJ0plcX7/RW151fdaykK6rhrirQVgKhSV2WWRuVAaSKi0vA==
X-Received: by 2002:a17:902:820f:: with SMTP id
 x15mr40611321pln.229.1567625492854; 
 Wed, 04 Sep 2019 12:31:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:15 -0700
Message-Id: <20190904193059.26202-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 25/69] target/arm: Convert packing, unpacking,
 saturation, and reversal
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 541 ++++++++++++++++++-----------------------
 target/arm/a32.decode  |  32 +++
 target/arm/t32.decode  |  37 ++-
 3 files changed, 300 insertions(+), 310 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 181d3d77f0..a6de23c6d3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -355,7 +355,7 @@ static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
 }
 
 /* Byteswap each halfword.  */
-static void gen_rev16(TCGv_i32 var)
+static void gen_rev16(TCGv_i32 dest, TCGv_i32 var)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
     TCGv_i32 mask = tcg_const_i32(0x00ff00ff);
@@ -363,17 +363,17 @@ static void gen_rev16(TCGv_i32 var)
     tcg_gen_and_i32(tmp, tmp, mask);
     tcg_gen_and_i32(var, var, mask);
     tcg_gen_shli_i32(var, var, 8);
-    tcg_gen_or_i32(var, var, tmp);
+    tcg_gen_or_i32(dest, var, tmp);
     tcg_temp_free_i32(mask);
     tcg_temp_free_i32(tmp);
 }
 
 /* Byteswap low halfword and sign extend.  */
-static void gen_revsh(TCGv_i32 var)
+static void gen_revsh(TCGv_i32 dest, TCGv_i32 var)
 {
     tcg_gen_ext16u_i32(var, var);
     tcg_gen_bswap16_i32(var, var);
-    tcg_gen_ext16s_i32(var, var);
+    tcg_gen_ext16s_i32(dest, var);
 }
 
 /* 32x32->64 multiply.  Marks inputs as dead.  */
@@ -426,7 +426,7 @@ static void gen_swap_half(TCGv_i32 var)
     t0 = (t0 + t1) ^ tmp;
  */
 
-static void gen_add16(TCGv_i32 t0, TCGv_i32 t1)
+static void gen_add16(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
     tcg_gen_xor_i32(tmp, t0, t1);
@@ -434,9 +434,8 @@ static void gen_add16(TCGv_i32 t0, TCGv_i32 t1)
     tcg_gen_andi_i32(t0, t0, ~0x8000);
     tcg_gen_andi_i32(t1, t1, ~0x8000);
     tcg_gen_add_i32(t0, t0, t1);
-    tcg_gen_xor_i32(t0, t0, tmp);
+    tcg_gen_xor_i32(dest, t0, tmp);
     tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(t1);
 }
 
 /* Set N and Z flags from var.  */
@@ -6356,7 +6355,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                             break;
                         case NEON_2RM_VREV16:
-                            gen_rev16(tmp);
+                            gen_rev16(tmp, tmp);
                             break;
                         case NEON_2RM_VCLS:
                             switch (size) {
@@ -9333,13 +9332,225 @@ DO_PAR_ADDSUB(UHSUB8, gen_helper_uhsub8)
 #undef DO_PAR_ADDSUB
 #undef DO_PAR_ADDSUB_GE
 
+/*
+ * Packing, unpacking, saturation, and reversal
+ */
+
+static bool trans_PKH(DisasContext *s, arg_PKH *a)
+{
+    TCGv_i32 tn, tm;
+    int shift = a->imm;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    tn = load_reg(s, a->rn);
+    tm = load_reg(s, a->rm);
+    if (a->tb) {
+        /* PKHTB */
+        if (shift == 0) {
+            shift = 31;
+        }
+        tcg_gen_sari_i32(tm, tm, shift);
+        tcg_gen_deposit_i32(tn, tn, tm, 0, 16);
+    } else {
+        /* PKHBT */
+        tcg_gen_shli_i32(tm, tm, shift);
+        tcg_gen_deposit_i32(tn, tm, tn, 0, 16);
+    }
+    tcg_temp_free_i32(tm);
+    store_reg(s, a->rd, tn);
+    return true;
+}
+
+static bool op_sat(DisasContext *s, arg_sat *a,
+                   void (*gen)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 tmp, satimm;
+    int shift = a->imm;
+
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rn);
+    if (a->sh) {
+        tcg_gen_sari_i32(tmp, tmp, shift ? shift : 31);
+    } else {
+        tcg_gen_shli_i32(tmp, tmp, shift);
+    }
+
+    satimm = tcg_const_i32(a->satimm);
+    gen(tmp, cpu_env, tmp, satimm);
+    tcg_temp_free_i32(satimm);
+
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_SSAT(DisasContext *s, arg_sat *a)
+{
+    return op_sat(s, a, gen_helper_ssat);
+}
+
+static bool trans_USAT(DisasContext *s, arg_sat *a)
+{
+    return op_sat(s, a, gen_helper_usat);
+}
+
+static bool trans_SSAT16(DisasContext *s, arg_sat *a)
+{
+    if (s->thumb && !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
+        return false;
+    }
+    return op_sat(s, a, gen_helper_ssat16);
+}
+
+static bool trans_USAT16(DisasContext *s, arg_sat *a)
+{
+    if (s->thumb && !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
+        return false;
+    }
+    return op_sat(s, a, gen_helper_usat16);
+}
+
+static bool op_xta(DisasContext *s, arg_rrr_rot *a,
+                   void (*gen_extract)(TCGv_i32, TCGv_i32),
+                   void (*gen_add)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rm);
+    /*
+     * TODO: In many cases we could do a shift instead of a rotate.
+     * Combined with a simple extend, that becomes an extract.
+     */
+    tcg_gen_rotri_i32(tmp, tmp, a->rot * 8);
+    gen_extract(tmp, tmp);
+
+    if (a->rn != 15) {
+        TCGv_i32 tmp2 = load_reg(s, a->rn);
+        gen_add(tmp, tmp, tmp2);
+        tcg_temp_free_i32(tmp2);
+    }
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_SXTAB(DisasContext *s, arg_rrr_rot *a)
+{
+    return op_xta(s, a, tcg_gen_ext8s_i32, tcg_gen_add_i32);
+}
+
+static bool trans_SXTAH(DisasContext *s, arg_rrr_rot *a)
+{
+    return op_xta(s, a, tcg_gen_ext16s_i32, tcg_gen_add_i32);
+}
+
+static bool trans_SXTAB16(DisasContext *s, arg_rrr_rot *a)
+{
+    if (s->thumb && !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
+        return false;
+    }
+    return op_xta(s, a, gen_helper_sxtb16, gen_add16);
+}
+
+static bool trans_UXTAB(DisasContext *s, arg_rrr_rot *a)
+{
+    return op_xta(s, a, tcg_gen_ext8u_i32, tcg_gen_add_i32);
+}
+
+static bool trans_UXTAH(DisasContext *s, arg_rrr_rot *a)
+{
+    return op_xta(s, a, tcg_gen_ext16u_i32, tcg_gen_add_i32);
+}
+
+static bool trans_UXTAB16(DisasContext *s, arg_rrr_rot *a)
+{
+    if (s->thumb && !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
+        return false;
+    }
+    return op_xta(s, a, gen_helper_uxtb16, gen_add16);
+}
+
+static bool trans_SEL(DisasContext *s, arg_rrr *a)
+{
+    TCGv_i32 t1, t2, t3;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    t3 = tcg_temp_new_i32();
+    tcg_gen_ld_i32(t3, cpu_env, offsetof(CPUARMState, GE));
+    gen_helper_sel_flags(t1, t3, t1, t2);
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool op_rr(DisasContext *s, arg_rr *a,
+                  void (*gen)(TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    tmp = load_reg(s, a->rm);
+    gen(tmp, tmp);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_REV(DisasContext *s, arg_rr *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    return op_rr(s, a, tcg_gen_bswap32_i32);
+}
+
+static bool trans_REV16(DisasContext *s, arg_rr *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    return op_rr(s, a, gen_rev16);
+}
+
+static bool trans_REVSH(DisasContext *s, arg_rr *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    return op_rr(s, a, gen_revsh);
+}
+
+static bool trans_RBIT(DisasContext *s, arg_rr *a)
+{
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+    return op_rr(s, a, gen_helper_rbit);
+}
+
 /*
  * Legacy decoder.
  */
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
+    unsigned int cond, val, op1, i, rm, rs, rn, rd;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 tmp3;
@@ -9648,112 +9859,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     /* Done by decodetree */
                     goto illegal_op;
                 case 1:
-                    if ((insn & 0x00700020) == 0) {
-                        /* Halfword pack.  */
-                        tmp = load_reg(s, rn);
-                        tmp2 = load_reg(s, rm);
-                        shift = (insn >> 7) & 0x1f;
-                        if (insn & (1 << 6)) {
-                            /* pkhtb */
-                            if (shift == 0) {
-                                shift = 31;
-                            }
-                            tcg_gen_sari_i32(tmp2, tmp2, shift);
-                            tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
-                        } else {
-                            /* pkhbt */
-                            tcg_gen_shli_i32(tmp2, tmp2, shift);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        store_reg(s, rd, tmp);
-                    } else if ((insn & 0x00200020) == 0x00200000) {
-                        /* [us]sat */
-                        tmp = load_reg(s, rm);
-                        shift = (insn >> 7) & 0x1f;
-                        if (insn & (1 << 6)) {
-                            if (shift == 0)
-                                shift = 31;
-                            tcg_gen_sari_i32(tmp, tmp, shift);
-                        } else {
-                            tcg_gen_shli_i32(tmp, tmp, shift);
-                        }
-                        sh = (insn >> 16) & 0x1f;
-                        tmp2 = tcg_const_i32(sh);
-                        if (insn & (1 << 22))
-                          gen_helper_usat(tmp, cpu_env, tmp, tmp2);
-                        else
-                          gen_helper_ssat(tmp, cpu_env, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        store_reg(s, rd, tmp);
-                    } else if ((insn & 0x00300fe0) == 0x00200f20) {
-                        /* [us]sat16 */
-                        tmp = load_reg(s, rm);
-                        sh = (insn >> 16) & 0x1f;
-                        tmp2 = tcg_const_i32(sh);
-                        if (insn & (1 << 22))
-                          gen_helper_usat16(tmp, cpu_env, tmp, tmp2);
-                        else
-                          gen_helper_ssat16(tmp, cpu_env, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        store_reg(s, rd, tmp);
-                    } else if ((insn & 0x00700fe0) == 0x00000fa0) {
-                        /* Select bytes.  */
-                        tmp = load_reg(s, rn);
-                        tmp2 = load_reg(s, rm);
-                        tmp3 = tcg_temp_new_i32();
-                        tcg_gen_ld_i32(tmp3, cpu_env, offsetof(CPUARMState, GE));
-                        gen_helper_sel_flags(tmp, tmp3, tmp, tmp2);
-                        tcg_temp_free_i32(tmp3);
-                        tcg_temp_free_i32(tmp2);
-                        store_reg(s, rd, tmp);
-                    } else if ((insn & 0x000003e0) == 0x00000060) {
-                        tmp = load_reg(s, rm);
-                        shift = (insn >> 10) & 3;
-                        /* ??? In many cases it's not necessary to do a
-                           rotate, a shift is sufficient.  */
-                        tcg_gen_rotri_i32(tmp, tmp, shift * 8);
-                        op1 = (insn >> 20) & 7;
-                        switch (op1) {
-                        case 0: gen_sxtb16(tmp);  break;
-                        case 2: gen_sxtb(tmp);    break;
-                        case 3: gen_sxth(tmp);    break;
-                        case 4: gen_uxtb16(tmp);  break;
-                        case 6: gen_uxtb(tmp);    break;
-                        case 7: gen_uxth(tmp);    break;
-                        default: goto illegal_op;
-                        }
-                        if (rn != 15) {
-                            tmp2 = load_reg(s, rn);
-                            if ((op1 & 3) == 0) {
-                                gen_add16(tmp, tmp2);
-                            } else {
-                                tcg_gen_add_i32(tmp, tmp, tmp2);
-                                tcg_temp_free_i32(tmp2);
-                            }
-                        }
-                        store_reg(s, rd, tmp);
-                    } else if ((insn & 0x003f0f60) == 0x003f0f20) {
-                        /* rev */
-                        tmp = load_reg(s, rm);
-                        if (insn & (1 << 22)) {
-                            if (insn & (1 << 7)) {
-                                gen_revsh(tmp);
-                            } else {
-                                ARCH(6T2);
-                                gen_helper_rbit(tmp, tmp);
-                            }
-                        } else {
-                            if (insn & (1 << 7))
-                                gen_rev16(tmp);
-                            else
-                                tcg_gen_bswap32_i32(tmp, tmp);
-                        }
-                        store_reg(s, rd, tmp);
-                    } else {
-                        goto illegal_op;
-                    }
-                    break;
+                    /* Halfword pack, [US]SAT, [US]SAT16, SEL, REV et al */
+                    /* Done by decodetree */
+                    goto illegal_op;
                 case 2: /* Multiplies (Type 3).  */
                     switch ((insn >> 20) & 0x7) {
                     case 5:
@@ -10098,7 +10206,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t imm, shift, offset;
+    uint32_t imm, offset;
     uint32_t rd, rn, rm, rs;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10353,151 +10461,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         }
         break;
     case 5:
-
-        op = (insn >> 21) & 0xf;
-        if (op == 6) {
-            if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                goto illegal_op;
-            }
-            /* Halfword pack.  */
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            shift = ((insn >> 10) & 0x1c) | ((insn >> 6) & 0x3);
-            if (insn & (1 << 5)) {
-                /* pkhtb */
-                if (shift == 0) {
-                    shift = 31;
-                }
-                tcg_gen_sari_i32(tmp2, tmp2, shift);
-                tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
-            } else {
-                /* pkhbt */
-                tcg_gen_shli_i32(tmp2, tmp2, shift);
-                tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
-            }
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
-        } else {
-            /* Data processing register constant shift.  */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        }
-        break;
+        /* All in decodetree */
+        goto illegal_op;
     case 13: /* Misc data processing.  */
         op = ((insn >> 22) & 6) | ((insn >> 7) & 1);
         if (op < 4 && (insn & 0xf000) != 0xf000)
             goto illegal_op;
         switch (op) {
         case 0: /* Register controlled shift, in decodetree */
-            goto illegal_op;
-        case 1: /* Sign/zero extend.  */
-            op = (insn >> 20) & 7;
-            switch (op) {
-            case 0: /* SXTAH, SXTH */
-            case 1: /* UXTAH, UXTH */
-            case 4: /* SXTAB, SXTB */
-            case 5: /* UXTAB, UXTB */
-                break;
-            case 2: /* SXTAB16, SXTB16 */
-            case 3: /* UXTAB16, UXTB16 */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    goto illegal_op;
-                }
-                break;
-            default:
-                goto illegal_op;
-            }
-            if (rn != 15) {
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    goto illegal_op;
-                }
-            }
-            tmp = load_reg(s, rm);
-            shift = (insn >> 4) & 3;
-            /* ??? In many cases it's not necessary to do a
-               rotate, a shift is sufficient.  */
-            tcg_gen_rotri_i32(tmp, tmp, shift * 8);
-            op = (insn >> 20) & 7;
-            switch (op) {
-            case 0: gen_sxth(tmp);   break;
-            case 1: gen_uxth(tmp);   break;
-            case 2: gen_sxtb16(tmp); break;
-            case 3: gen_uxtb16(tmp); break;
-            case 4: gen_sxtb(tmp);   break;
-            case 5: gen_uxtb(tmp);   break;
-            default:
-                g_assert_not_reached();
-            }
-            if (rn != 15) {
-                tmp2 = load_reg(s, rn);
-                if ((op >> 1) == 1) {
-                    gen_add16(tmp, tmp2);
-                } else {
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                }
-            }
-            store_reg(s, rd, tmp);
-            break;
+        case 1: /* Sign/zero extend, in decodetree */
         case 2: /* SIMD add/subtract, in decodetree */
+        case 3: /* Other data processing, in decodetree */
             goto illegal_op;
-        case 3: /* Other data processing.  */
-            op = ((insn >> 17) & 0x38) | ((insn >> 4) & 7);
-            if (op < 4) {
-                /* Saturating add/subtract.  */
-                /* All done in decodetree.  Reach here for illegal ops.  */
-                goto illegal_op;
-            } else {
-                switch (op) {
-                case 0x0a: /* rbit */
-                case 0x08: /* rev */
-                case 0x09: /* rev16 */
-                case 0x0b: /* revsh */
-                    break;
-                case 0x10: /* sel */
-                    if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                        goto illegal_op;
-                    }
-                    break;
-                case 0x18: /* clz, in decodetree */
-                case 0x20: /* crc32/crc32c, in decodetree */
-                case 0x21:
-                case 0x22:
-                case 0x28:
-                case 0x29:
-                case 0x2a:
-                    goto illegal_op;
-                default:
-                    goto illegal_op;
-                }
-                tmp = load_reg(s, rn);
-                switch (op) {
-                case 0x0a: /* rbit */
-                    gen_helper_rbit(tmp, tmp);
-                    break;
-                case 0x08: /* rev */
-                    tcg_gen_bswap32_i32(tmp, tmp);
-                    break;
-                case 0x09: /* rev16 */
-                    gen_rev16(tmp);
-                    break;
-                case 0x0b: /* revsh */
-                    gen_revsh(tmp);
-                    break;
-                case 0x10: /* sel */
-                    tmp2 = load_reg(s, rm);
-                    tmp3 = tcg_temp_new_i32();
-                    tcg_gen_ld_i32(tmp3, cpu_env, offsetof(CPUARMState, GE));
-                    gen_helper_sel_flags(tmp, tmp3, tmp, tmp2);
-                    tcg_temp_free_i32(tmp3);
-                    tcg_temp_free_i32(tmp2);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-            }
-            store_reg(s, rd, tmp);
-            break;
         case 4: case 5: /* 32-bit multiply.  Sum of absolute differences.  */
             switch ((insn >> 20) & 7) {
             case 0: /* 32 x 32 -> 32 */
@@ -10851,60 +10826,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                  *  - Data-processing (plain binary immediate)
                  */
                 if (insn & (1 << 24)) {
-                    if (insn & (1 << 20))
-                        goto illegal_op;
-                    /* Bitfield/Saturate.  */
-                    op = (insn >> 21) & 7;
-                    imm = insn & 0x1f;
-                    shift = ((insn >> 6) & 3) | ((insn >> 10) & 0x1c);
-                    if (rn == 15) {
-                        tmp = tcg_temp_new_i32();
-                        tcg_gen_movi_i32(tmp, 0);
-                    } else {
-                        tmp = load_reg(s, rn);
-                    }
-                    switch (op) {
-                    case 2: /* Signed bitfield extract, in decodetree */
-                    case 6: /* Unsigned bitfield extract, in decodetree */
-                    case 3: /* Bitfield insert/clear, in decodetree */
-                    case 7:
-                        goto illegal_op;
-                    default: /* Saturate.  */
-                        if (op & 1) {
-                            tcg_gen_sari_i32(tmp, tmp, shift);
-                        } else {
-                            tcg_gen_shli_i32(tmp, tmp, shift);
-                        }
-                        tmp2 = tcg_const_i32(imm);
-                        if (op & 4) {
-                            /* Unsigned.  */
-                            if ((op & 1) && shift == 0) {
-                                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                                    tcg_temp_free_i32(tmp);
-                                    tcg_temp_free_i32(tmp2);
-                                    goto illegal_op;
-                                }
-                                gen_helper_usat16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_usat(tmp, cpu_env, tmp, tmp2);
-                            }
-                        } else {
-                            /* Signed.  */
-                            if ((op & 1) && shift == 0) {
-                                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                                    tcg_temp_free_i32(tmp);
-                                    tcg_temp_free_i32(tmp2);
-                                    goto illegal_op;
-                                }
-                                gen_helper_ssat16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_ssat(tmp, cpu_env, tmp, tmp2);
-                            }
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        break;
-                    }
-                    store_reg(s, rd, tmp);
+                    /* Bitfield/Saturate, in decodetree */
+                    goto illegal_op;
                 } else {
                     imm = ((insn & 0x04000000) >> 15)
                           | ((insn & 0x7000) >> 4) | (insn & 0xff);
@@ -11596,8 +11519,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             tmp = load_reg(s, rn);
             switch (op1) {
             case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-            case 1: gen_rev16(tmp); break;
-            case 3: gen_revsh(tmp); break;
+            case 1: gen_rev16(tmp, tmp); break;
+            case 3: gen_revsh(tmp, tmp); break;
             default:
                 g_assert_not_reached();
             }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 4dfd8133f7..4990eb3839 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -28,6 +28,7 @@
 &s_rri_rot       s rn rd imm rot
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
+&rrr_rot         rd rn rm rot
 &rrr             rd rn rm
 &rr              rd rm
 &ri              rd imm
@@ -43,6 +44,8 @@
 &ldrex           rn rt rt2 imm
 &bfx             rd rn lsb widthm1
 &bfi             rd rn lsb msb
+&sat             rd rn satimm imm sh
+&pkh             rd rn rm imm tb
 
 # Data-processing (register)
 
@@ -454,3 +457,32 @@ UHSAX            .... 0110 0111 .... .... 1111 0101 ....      @rndm
 UHSUB16          .... 0110 0111 .... .... 1111 0111 ....      @rndm
 UHADD8           .... 0110 0111 .... .... 1111 1001 ....      @rndm
 UHSUB8           .... 0110 0111 .... .... 1111 1111 ....      @rndm
+
+# Packing, unpacking, saturation, and reversal
+
+PKH              ---- 0110 1000 rn:4 rd:4 imm:5 tb:1 01 rm:4  &pkh
+
+@sat             ---- .... ... satimm:5  rd:4 imm:5 sh:1 .. rn:4  &sat
+@sat16           ---- .... .... satimm:4 rd:4 .... .... rn:4 \
+                 &sat imm=0 sh=0
+
+SSAT             .... 0110 101. .... .... .... ..01 ....      @sat
+USAT             .... 0110 111. .... .... .... ..01 ....      @sat
+
+SSAT16           .... 0110 1010 .... .... 1111 0011 ....      @sat16
+USAT16           .... 0110 1110 .... .... 1111 0011 ....      @sat16
+
+@rrr_rot         ---- .... .... rn:4 rd:4 rot:2 ...... rm:4   &rrr_rot
+
+SXTAB16          .... 0110 1000 .... .... ..00 0111 ....      @rrr_rot
+SXTAB            .... 0110 1010 .... .... ..00 0111 ....      @rrr_rot
+SXTAH            .... 0110 1011 .... .... ..00 0111 ....      @rrr_rot
+UXTAB16          .... 0110 1100 .... .... ..00 0111 ....      @rrr_rot
+UXTAB            .... 0110 1110 .... .... ..00 0111 ....      @rrr_rot
+UXTAH            .... 0110 1111 .... .... ..00 0111 ....      @rrr_rot
+
+SEL              .... 0110 1000 .... .... 1111 1011 ....      @rndm
+REV              .... 0110 1011 1111 .... 1111 0011 ....      @rdm
+REV16            .... 0110 1011 1111 .... 1111 1011 ....      @rdm
+REVSH            .... 0110 1111 1111 .... 1111 1011 ....      @rdm
+RBIT             .... 0110 1111 1111 .... 1111 0011 ....      @rdm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c899c56766..71f6d728f2 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -25,6 +25,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
+&rrr_rot         !extern rd rn rm rot
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
 &ri              !extern rd imm
@@ -40,6 +41,8 @@
 &ldrex           !extern rn rt rt2 imm
 &bfx             !extern rd rn lsb widthm1
 &bfi             !extern rd rn lsb msb
+&sat             !extern rd rn satimm imm sh
+&pkh             !extern rd rn rm imm tb
 
 # Data-processing (register)
 
@@ -69,7 +72,8 @@ BIC_rrri         1110101 0001 . .... 0 ... .... .... ....     @s_rrr_shi
   TEQ_xrri       1110101 0100 1 .... 0 ... 1111 .... ....     @S_xrr_shi
   EOR_rrri       1110101 0100 . .... 0 ... .... .... ....     @s_rrr_shi
 }
-# PKHBT, PKHTB at opc1 = 0110
+PKH              1110101 0110 0 rn:4 0 ... rd:4 .. tb:1 0 rm:4 \
+                 &pkh imm=%imm5_12_6
 {
   CMN_xrri       1110101 1000 1 .... 0 ... 1111 .... ....     @S_xrr_shi
   ADD_rrri       1110101 1000 . .... 0 ... .... .... ....     @s_rrr_shi
@@ -148,6 +152,20 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 
 # Saturate, bitfield
 
+@sat             .... .... .. sh:1 . rn:4 . ... rd:4 .. . satimm:5 \
+                 &sat imm=%imm5_12_6
+@sat16           .... .... .. .    . rn:4 . ... rd:4 .. . satimm:5 \
+                 &sat sh=0 imm=0
+
+{
+  SSAT16         1111 0011 001 0 .... 0 000 .... 00 0 .....   @sat16
+  SSAT           1111 0011 00. 0 .... 0 ... .... .. 0 .....   @sat
+}
+{
+  USAT16         1111 0011 101 0 .... 0 000 .... 00 0 .....   @sat16
+  USAT           1111 0011 10. 0 .... 0 ... .... .. 0 .....   @sat
+}
+
 @bfx             .... .... ... . rn:4 . ... rd:4 .. . widthm1:5 \
                  &bfx lsb=%imm5_12_6
 @bfi             .... .... ... . rn:4 . ... rd:4 .. . msb:5 \
@@ -224,7 +242,13 @@ CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
 CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
 CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
 
+SEL              1111 1010 1010 .... 1111 .... 1000 ....      @rndm
+
 # Note rn != rm is CONSTRAINED UNPREDICTABLE; we choose to ignore rn.
+REV              1111 1010 1001 ---- 1111 .... 1000 ....      @rdm
+REV16            1111 1010 1001 ---- 1111 .... 1001 ....      @rdm
+RBIT             1111 1010 1001 ---- 1111 .... 1010 ....      @rdm
+REVSH            1111 1010 1001 ---- 1111 .... 1011 ....      @rdm
 CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
 
 # Branches and miscellaneous control
@@ -501,3 +525,14 @@ SHSAX            1111 1010 1110 .... 1111 .... 0010 ....      @rndm
 USAX             1111 1010 1110 .... 1111 .... 0100 ....      @rndm
 UQSAX            1111 1010 1110 .... 1111 .... 0101 ....      @rndm
 UHSAX            1111 1010 1110 .... 1111 .... 0110 ....      @rndm
+
+# Register extends
+
+@rrr_rot         .... .... .... rn:4 .... rd:4 .. rot:2 rm:4  &rrr_rot
+
+SXTAH            1111 1010 0000 .... 1111 .... 10.. ....      @rrr_rot
+UXTAH            1111 1010 0001 .... 1111 .... 10.. ....      @rrr_rot
+SXTAB16          1111 1010 0010 .... 1111 .... 10.. ....      @rrr_rot
+UXTAB16          1111 1010 0011 .... 1111 .... 10.. ....      @rrr_rot
+SXTAB            1111 1010 0100 .... 1111 .... 10.. ....      @rrr_rot
+UXTAB            1111 1010 0101 .... 1111 .... 10.. ....      @rrr_rot
-- 
2.17.1


