Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC06FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8699122CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqk1yOxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699122CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bEn-0003C8-Rk
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azq-0004Cz-4A
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azl-00027i-Lg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azl-00026u-A3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id x3so4896288plr.12
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=P5lvwtIACyV9ZUvbqn+xMJvNmsrDasaQ1Nh981WiZ3I=;
 b=jqk1yOxXu8nqgdIANgGh2oQA/T01kxFmI7pGTEwqEghq67eVHauoOHO72qm6snBso7
 61Hqbnj6n2lwdZhLBmYKYI01z3EYe72V4Qqjg/yl5sQI5KcH3HA+jroPLZx48bIDIVst
 0fLPXD+AnCfzYuaM/mlKLrFKJ2oGRSJWNINtrFh4R9RH6aYrJmEjuLqA1jIc2LT/2K3a
 VcgceRq7HNnNV2J0DAVpzjbZlFltke6PcA2mRrDWBe5V3i4T50H6QxdbeEdRbJy0RmiE
 y0ly3MWCTk8/J4Sl8lZrhiTwPtJ4cmuwqtK6KuPc5O4FyV7DILbOGfLDBDvgZfIaAFAF
 Jj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=P5lvwtIACyV9ZUvbqn+xMJvNmsrDasaQ1Nh981WiZ3I=;
 b=nO43YcFI4EAzelCk0/0vfXZwvZFTM0N/oq49iX+tPsmTTbFuYG1Nz0odaVcJYW8T2u
 vryujkjDQWBnv3+Y0DPZhHbzqMcXPSIVJ9/bIwAd9qd3v9iwkX3cFeqnuMYqnoxP92LU
 V2u/6fOw0hjQFcDqKKQSkTzXnXFSRPVT/I6Jgu7l2ewKBV+rqpeszsrdoHJYuCOAwa0r
 VSaJet36vYgT0K/N3I8mwSVb1lSUf+4MJreWA7idSKVAi97FEuYA0RFSatC6yvHBbydo
 ifHp+2bfbC2a3ICvxRaP3BDkOve8tNHqq88mr++xmOlc05d1HfFEpThRx6LxKD2f2gQj
 0ldQ==
X-Gm-Message-State: APjAAAVhRL1cxRNmBRCJ43t/tsvG2QnziZK/tdLONIVGh24v57TV0kQO
 yGqitEoWRd2ubtB7ushgd3Ytm5oi02U=
X-Google-Smtp-Source: APXvYqzuxL1hITiitqLD7O8Tne79jy7GZmaIKEQIhocka/u7+wnqkhcPx195IbtNSaGLP5JonwrSrQ==
X-Received: by 2002:a17:902:ff09:: with SMTP id f9mr414988plj.55.1567625467681; 
 Wed, 04 Sep 2019 12:31:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:55 -0700
Message-Id: <20190904193059.26202-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 05/69] target/arm: Convert Data Processing
 (immediate)
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

Convert the modified immediate form of the data processing insns.
For A32, we can finally remove any code that was intertwined with
the register and register-shifted-register forms.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 449 +++++++++++------------------------------
 target/arm/a32.decode  |  29 +++
 target/arm/t32.decode  |  42 ++++
 3 files changed, 186 insertions(+), 334 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ff78b1bb74..1222946ba4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -439,12 +439,6 @@ static void gen_add16(TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(t1);
 }
 
-/* Set CF to the top bit of var.  */
-static void gen_set_CF_bit31(TCGv_i32 var)
-{
-    tcg_gen_shri_i32(cpu_CF, var, 31);
-}
-
 /* Set N and Z flags from var.  */
 static inline void gen_logic_CC(TCGv_i32 var)
 {
@@ -857,25 +851,6 @@ void arm_gen_test_cc(int cc, TCGLabel *label)
     arm_free_cc(&cmp);
 }
 
-static const uint8_t table_logic_cc[16] = {
-    1, /* and */
-    1, /* xor */
-    0, /* sub */
-    0, /* rsb */
-    0, /* add */
-    0, /* adc */
-    0, /* sbc */
-    0, /* rsc */
-    1, /* andl */
-    1, /* xorl */
-    0, /* cmp */
-    0, /* cmn */
-    1, /* orr */
-    1, /* mov */
-    1, /* bic */
-    1, /* mvn */
-};
-
 static inline void gen_set_condexec(DisasContext *s)
 {
     if (s->condexec_mask) {
@@ -7683,6 +7658,48 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+
+/*
+ * Constant expanders for the decoders.
+ */
+
+static int times_2(DisasContext *s, int x)
+{
+    return x * 2;
+}
+
+/* Return only the rotation part of T32ExpandImm.  */
+static int t32_expandimm_rot(DisasContext *s, int x)
+{
+    return x & 0xc00 ? extract32(x, 7, 5) : 0;
+}
+
+/* Return the unrotated immediate from T32ExpandImm.  */
+static int t32_expandimm_imm(DisasContext *s, int x)
+{
+    int imm = extract32(x, 0, 8);
+
+    switch (extract32(x, 8, 4)) {
+    case 0: /* XY */
+        /* Nothing to do.  */
+        break;
+    case 1: /* 00XY00XY */
+        imm *= 0x00010001;
+        break;
+    case 2: /* XY00XY00 */
+        imm *= 0x01000100;
+        break;
+    case 3: /* XYXYXYXY */
+        imm *= 0x01010101;
+        break;
+    default:
+        /* Rotated constant.  */
+        imm |= 0x80;
+        break;
+    }
+    return imm;
+}
+
 /*
  * Include the generated decoders.
  */
@@ -7838,23 +7855,82 @@ static bool op_s_rxr_shr(DisasContext *s, arg_s_rrr_shr *a,
     return store_reg_kind(s, a->rd, tmp2, kind);
 }
 
+/*
+ * Data-processing (immediate)
+ *
+ * Operate, with set flags, one register source,
+ * one rotated immediate, and a destination.
+ *
+ * Note that logic_cc && a->rot setting CF based on the msb of the
+ * immediate is the reason why we must pass in the unrotated form
+ * of the immediate.
+ */
+static bool op_s_rri_rot(DisasContext *s, arg_s_rri_rot *a,
+                         void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
+{
+    TCGv_i32 tmp1, tmp2;
+    uint32_t imm;
+
+    imm = ror32(a->imm, a->rot);
+    if (logic_cc && a->rot) {
+        tcg_gen_movi_i32(cpu_CF, imm >> 31);
+    }
+    tmp2 = tcg_const_i32(imm);
+    tmp1 = load_reg(s, a->rn);
+
+    gen(tmp1, tmp1, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    if (logic_cc) {
+        gen_logic_CC(tmp1);
+    }
+    return store_reg_kind(s, a->rd, tmp1, kind);
+}
+
+static bool op_s_rxi_rot(DisasContext *s, arg_s_rri_rot *a,
+                         void (*gen)(TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
+{
+    TCGv_i32 tmp;
+    uint32_t imm;
+
+    imm = ror32(a->imm, a->rot);
+    if (logic_cc && a->rot) {
+        tcg_gen_movi_i32(cpu_CF, imm >> 31);
+    }
+    tmp = tcg_const_i32(imm);
+
+    gen(tmp, tmp);
+    if (logic_cc) {
+        gen_logic_CC(tmp);
+    }
+    return store_reg_kind(s, a->rd, tmp, kind);
+}
+
 #define DO_ANY3(NAME, OP, L, K)                                         \
     static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)  \
     { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }      \
     static bool trans_##NAME##_rrrr(DisasContext *s, arg_s_rrr_shr *a)  \
-    { StoreRegKind k = (K); return op_s_rrr_shr(s, a, OP, L, k); }
+    { StoreRegKind k = (K); return op_s_rrr_shr(s, a, OP, L, k); }      \
+    static bool trans_##NAME##_rri(DisasContext *s, arg_s_rri_rot *a)   \
+    { StoreRegKind k = (K); return op_s_rri_rot(s, a, OP, L, k); }
 
 #define DO_ANY2(NAME, OP, L, K)                                         \
     static bool trans_##NAME##_rxri(DisasContext *s, arg_s_rrr_shi *a)  \
     { StoreRegKind k = (K); return op_s_rxr_shi(s, a, OP, L, k); }      \
     static bool trans_##NAME##_rxrr(DisasContext *s, arg_s_rrr_shr *a)  \
-    { StoreRegKind k = (K); return op_s_rxr_shr(s, a, OP, L, k); }
+    { StoreRegKind k = (K); return op_s_rxr_shr(s, a, OP, L, k); }      \
+    static bool trans_##NAME##_rxi(DisasContext *s, arg_s_rri_rot *a)   \
+    { StoreRegKind k = (K); return op_s_rxi_rot(s, a, OP, L, k); }
 
 #define DO_CMP2(NAME, OP, L)                                            \
     static bool trans_##NAME##_xrri(DisasContext *s, arg_s_rrr_shi *a)  \
     { return op_s_rrr_shi(s, a, OP, L, STREG_NONE); }                   \
     static bool trans_##NAME##_xrrr(DisasContext *s, arg_s_rrr_shr *a)  \
-    { return op_s_rrr_shr(s, a, OP, L, STREG_NONE); }
+    { return op_s_rrr_shr(s, a, OP, L, STREG_NONE); }                   \
+    static bool trans_##NAME##_xri(DisasContext *s, arg_s_rri_rot *a)   \
+    { return op_s_rri_rot(s, a, OP, L, STREG_NONE); }
 
 DO_ANY3(AND, tcg_gen_and_i32, a->s, STREG_NORMAL)
 DO_ANY3(EOR, tcg_gen_xor_i32, a->s, STREG_NORMAL)
@@ -7934,6 +8010,11 @@ static bool trans_ORN_rrri(DisasContext *s, arg_s_rrr_shi *a)
     return op_s_rrr_shi(s, a, tcg_gen_orc_i32, a->s, STREG_NORMAL);
 }
 
+static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
+{
+    return op_s_rri_rot(s, a, tcg_gen_orc_i32, a->s, STREG_NORMAL);
+}
+
 #undef DO_ANY3
 #undef DO_ANY2
 #undef DO_CMP2
@@ -8471,182 +8552,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     } else if (((insn & 0x0e000000) == 0 &&
                 (insn & 0x00000090) != 0x90) ||
                ((insn & 0x0e000000) == (1 << 25))) {
-        int set_cc, logic_cc, shiftop;
-
-        op1 = (insn >> 21) & 0xf;
-        set_cc = (insn >> 20) & 1;
-        logic_cc = table_logic_cc[op1] & set_cc;
-
-        /* data processing instruction */
-        if (insn & (1 << 25)) {
-            /* immediate operand */
-            val = insn & 0xff;
-            shift = ((insn >> 8) & 0xf) * 2;
-            val = ror32(val, shift);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, val);
-            if (logic_cc && shift) {
-                gen_set_CF_bit31(tmp2);
-            }
-        } else {
-            /* register */
-            rm = (insn) & 0xf;
-            tmp2 = load_reg(s, rm);
-            shiftop = (insn >> 5) & 3;
-            if (!(insn & (1 << 4))) {
-                shift = (insn >> 7) & 0x1f;
-                gen_arm_shift_im(tmp2, shiftop, shift, logic_cc);
-            } else {
-                rs = (insn >> 8) & 0xf;
-                tmp = load_reg(s, rs);
-                gen_arm_shift_reg(tmp2, shiftop, tmp, logic_cc);
-            }
-        }
-        if (op1 != 0x0f && op1 != 0x0d) {
-            rn = (insn >> 16) & 0xf;
-            tmp = load_reg(s, rn);
-        } else {
-            tmp = NULL;
-        }
-        rd = (insn >> 12) & 0xf;
-        switch(op1) {
-        case 0x00:
-            tcg_gen_and_i32(tmp, tmp, tmp2);
-            if (logic_cc) {
-                gen_logic_CC(tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x01:
-            tcg_gen_xor_i32(tmp, tmp, tmp2);
-            if (logic_cc) {
-                gen_logic_CC(tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x02:
-            if (set_cc && rd == 15) {
-                /* SUBS r15, ... is used for exception return.  */
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_sub_CC(tmp, tmp, tmp2);
-                gen_exception_return(s, tmp);
-            } else {
-                if (set_cc) {
-                    gen_sub_CC(tmp, tmp, tmp2);
-                } else {
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                }
-                store_reg_bx(s, rd, tmp);
-            }
-            break;
-        case 0x03:
-            if (set_cc) {
-                gen_sub_CC(tmp, tmp2, tmp);
-            } else {
-                tcg_gen_sub_i32(tmp, tmp2, tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x04:
-            if (set_cc) {
-                gen_add_CC(tmp, tmp, tmp2);
-            } else {
-                tcg_gen_add_i32(tmp, tmp, tmp2);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x05:
-            if (set_cc) {
-                gen_adc_CC(tmp, tmp, tmp2);
-            } else {
-                gen_add_carry(tmp, tmp, tmp2);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x06:
-            if (set_cc) {
-                gen_sbc_CC(tmp, tmp, tmp2);
-            } else {
-                gen_sub_carry(tmp, tmp, tmp2);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x07:
-            if (set_cc) {
-                gen_sbc_CC(tmp, tmp2, tmp);
-            } else {
-                gen_sub_carry(tmp, tmp2, tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x08:
-            if (set_cc) {
-                tcg_gen_and_i32(tmp, tmp, tmp2);
-                gen_logic_CC(tmp);
-            }
-            tcg_temp_free_i32(tmp);
-            break;
-        case 0x09:
-            if (set_cc) {
-                tcg_gen_xor_i32(tmp, tmp, tmp2);
-                gen_logic_CC(tmp);
-            }
-            tcg_temp_free_i32(tmp);
-            break;
-        case 0x0a:
-            if (set_cc) {
-                gen_sub_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp);
-            break;
-        case 0x0b:
-            if (set_cc) {
-                gen_add_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp);
-            break;
-        case 0x0c:
-            tcg_gen_or_i32(tmp, tmp, tmp2);
-            if (logic_cc) {
-                gen_logic_CC(tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        case 0x0d:
-            if (logic_cc && rd == 15) {
-                /* MOVS r15, ... is used for exception return.  */
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_exception_return(s, tmp2);
-            } else {
-                if (logic_cc) {
-                    gen_logic_CC(tmp2);
-                }
-                store_reg_bx(s, rd, tmp2);
-            }
-            break;
-        case 0x0e:
-            tcg_gen_andc_i32(tmp, tmp, tmp2);
-            if (logic_cc) {
-                gen_logic_CC(tmp);
-            }
-            store_reg_bx(s, rd, tmp);
-            break;
-        default:
-        case 0x0f:
-            tcg_gen_not_i32(tmp2, tmp2);
-            if (logic_cc) {
-                gen_logic_CC(tmp2);
-            }
-            store_reg_bx(s, rd, tmp2);
-            break;
-        }
-        if (op1 != 0x0f && op1 != 0x0d) {
-            tcg_temp_free_i32(tmp2);
-        }
+        /* Data-processing (reg, reg-shift-reg, imm).  */
+        /* All done in decodetree.  Reach here for illegal ops.  */
+        goto illegal_op;
     } else {
         /* other instructions */
         op1 = (insn >> 24) & 0xf;
@@ -9552,82 +9460,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
     return true;
 }
 
-/* Generate code for a Thumb-2 data processing operation.  If CONDS is nonzero
-   then set condition code flags based on the result of the operation.
-   If SHIFTER_OUT is nonzero then set the carry flag for logical operations
-   to the high bit of T1.
-   Returns zero if the opcode is valid.  */
-
-static int
-gen_thumb2_data_op(DisasContext *s, int op, int conds, uint32_t shifter_out,
-                   TCGv_i32 t0, TCGv_i32 t1)
-{
-    int logic_cc;
-
-    logic_cc = 0;
-    switch (op) {
-    case 0: /* and */
-        tcg_gen_and_i32(t0, t0, t1);
-        logic_cc = conds;
-        break;
-    case 1: /* bic */
-        tcg_gen_andc_i32(t0, t0, t1);
-        logic_cc = conds;
-        break;
-    case 2: /* orr */
-        tcg_gen_or_i32(t0, t0, t1);
-        logic_cc = conds;
-        break;
-    case 3: /* orn */
-        tcg_gen_orc_i32(t0, t0, t1);
-        logic_cc = conds;
-        break;
-    case 4: /* eor */
-        tcg_gen_xor_i32(t0, t0, t1);
-        logic_cc = conds;
-        break;
-    case 8: /* add */
-        if (conds)
-            gen_add_CC(t0, t0, t1);
-        else
-            tcg_gen_add_i32(t0, t0, t1);
-        break;
-    case 10: /* adc */
-        if (conds)
-            gen_adc_CC(t0, t0, t1);
-        else
-            gen_adc(t0, t1);
-        break;
-    case 11: /* sbc */
-        if (conds) {
-            gen_sbc_CC(t0, t0, t1);
-        } else {
-            gen_sub_carry(t0, t0, t1);
-        }
-        break;
-    case 13: /* sub */
-        if (conds)
-            gen_sub_CC(t0, t0, t1);
-        else
-            tcg_gen_sub_i32(t0, t0, t1);
-        break;
-    case 14: /* rsb */
-        if (conds)
-            gen_sub_CC(t0, t1, t0);
-        else
-            tcg_gen_sub_i32(t0, t1, t0);
-        break;
-    default: /* 5, 6, 7, 9, 12, 15. */
-        return 1;
-    }
-    if (logic_cc) {
-        gen_logic_CC(t0);
-        if (shifter_out)
-            gen_set_CF_bit31(t1);
-    }
-    return 0;
-}
-
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
@@ -10909,60 +10741,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     }
                 }
             } else {
-                /*
-                 * 0b1111_0x0x_xxxx_0xxx_xxxx_xxxx
-                 *  - Data-processing (modified immediate)
-                 */
-                int shifter_out = 0;
-                /* modified 12-bit immediate.  */
-                shift = ((insn & 0x04000000) >> 23) | ((insn & 0x7000) >> 12);
-                imm = (insn & 0xff);
-                switch (shift) {
-                case 0: /* XY */
-                    /* Nothing to do.  */
-                    break;
-                case 1: /* 00XY00XY */
-                    imm |= imm << 16;
-                    break;
-                case 2: /* XY00XY00 */
-                    imm |= imm << 16;
-                    imm <<= 8;
-                    break;
-                case 3: /* XYXYXYXY */
-                    imm |= imm << 16;
-                    imm |= imm << 8;
-                    break;
-                default: /* Rotated constant.  */
-                    shift = (shift << 1) | (imm >> 7);
-                    imm |= 0x80;
-                    imm = imm << (32 - shift);
-                    shifter_out = 1;
-                    break;
-                }
-                tmp2 = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp2, imm);
-                rn = (insn >> 16) & 0xf;
-                if (rn == 15) {
-                    tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, 0);
-                } else {
-                    tmp = load_reg(s, rn);
-                }
-                op = (insn >> 21) & 0xf;
-                if (gen_thumb2_data_op(s, op, (insn & (1 << 20)) != 0,
-                                       shifter_out, tmp, tmp2))
-                    goto illegal_op;
-                tcg_temp_free_i32(tmp2);
-                rd = (insn >> 8) & 0xf;
-                if (rd == 13 && rn == 13
-                    && (op == 8 || op == 13)) {
-                    /* ADD(S) SP, SP, imm or SUB(S) SP, SP, imm */
-                    store_sp_checked(s, tmp);
-                } else if (rd != 15) {
-                    store_reg(s, rd, tmp);
-                } else {
-                    tcg_temp_free_i32(tmp);
-                }
+                /* Data-processing (modified immediate) */
+                /* All done in decodetree.  Reach here for illegal ops.  */
+                goto illegal_op;
             }
         }
         break;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 8e0fb06d05..286adcbf89 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -24,6 +24,7 @@
 
 &s_rrr_shi       s rd rn rm shim shty
 &s_rrr_shr       s rn rd rm rs shty
+&s_rri_rot       s rn rd imm rot
 
 # Data-processing (register)
 
@@ -76,3 +77,31 @@ ORR_rrrr         .... 000 1100 . .... .... .... 0 .. 1 ....   @s_rrr_shr
 MOV_rxrr         .... 000 1101 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
 BIC_rrrr         .... 000 1110 . .... .... .... 0 .. 1 ....   @s_rrr_shr
 MVN_rxrr         .... 000 1111 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
+
+# Data-processing (immediate)
+
+%a32extrot       8:4 !function=times_2
+
+@s_rri_rot       ---- ... .... s:1 rn:4 rd:4 .... imm:8 \
+                 &s_rri_rot rot=%a32extrot
+@s_rxi_rot       ---- ... .... s:1 .... rd:4 .... imm:8 \
+                 &s_rri_rot rot=%a32extrot rn=0
+@S_xri_rot       ---- ... .... .   rn:4 .... .... imm:8 \
+                 &s_rri_rot rot=%a32extrot rd=0 s=1
+
+AND_rri          .... 001 0000 . .... .... ............       @s_rri_rot
+EOR_rri          .... 001 0001 . .... .... ............       @s_rri_rot
+SUB_rri          .... 001 0010 . .... .... ............       @s_rri_rot
+RSB_rri          .... 001 0011 . .... .... ............       @s_rri_rot
+ADD_rri          .... 001 0100 . .... .... ............       @s_rri_rot
+ADC_rri          .... 001 0101 . .... .... ............       @s_rri_rot
+SBC_rri          .... 001 0110 . .... .... ............       @s_rri_rot
+RSC_rri          .... 001 0111 . .... .... ............       @s_rri_rot
+TST_xri          .... 001 1000 1 .... 0000 ............       @S_xri_rot
+TEQ_xri          .... 001 1001 1 .... 0000 ............       @S_xri_rot
+CMP_xri          .... 001 1010 1 .... 0000 ............       @S_xri_rot
+CMN_xri          .... 001 1011 1 .... 0000 ............       @S_xri_rot
+ORR_rri          .... 001 1100 . .... .... ............       @s_rri_rot
+MOV_rxi          .... 001 1101 . 0000 .... ............       @s_rxi_rot
+BIC_rri          .... 001 1110 . .... .... ............       @s_rri_rot
+MVN_rxi          .... 001 1111 . 0000 .... ............       @s_rxi_rot
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index f0a73fa003..50cbe48cc8 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -21,6 +21,7 @@
 
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
+&s_rri_rot       !extern s rn rd imm rot
 
 # Data-processing (register)
 
@@ -67,3 +68,44 @@ RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
 
 MOV_rxrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
                  &s_rrr_shr rn=0
+
+# Data-processing (immediate)
+
+%t32extrot       26:1 12:3 0:8  !function=t32_expandimm_rot
+%t32extimm       26:1 12:3 0:8  !function=t32_expandimm_imm
+
+@s_rri_rot       ....... .... s:1 rn:4 . ... rd:4 ........ \
+                 &s_rri_rot imm=%t32extimm rot=%t32extrot
+@s_rxi_rot       ....... .... s:1 .... . ... rd:4 ........ \
+                 &s_rri_rot imm=%t32extimm rot=%t32extrot rn=0
+@S_xri_rot       ....... .... .   rn:4 . ... .... ........ \
+                 &s_rri_rot imm=%t32extimm rot=%t32extrot s=1 rd=0
+
+{
+  TST_xri        1111 0.0 0000 1 .... 0 ... 1111 ........     @S_xri_rot
+  AND_rri        1111 0.0 0000 . .... 0 ... .... ........     @s_rri_rot
+}
+BIC_rri          1111 0.0 0001 . .... 0 ... .... ........     @s_rri_rot
+{
+  MOV_rxi        1111 0.0 0010 . 1111 0 ... .... ........     @s_rxi_rot
+  ORR_rri        1111 0.0 0010 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  MVN_rxi        1111 0.0 0011 . 1111 0 ... .... ........     @s_rxi_rot
+  ORN_rri        1111 0.0 0011 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  TEQ_xri        1111 0.0 0100 1 .... 0 ... 1111 ........     @S_xri_rot
+  EOR_rri        1111 0.0 0100 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  CMN_xri        1111 0.0 1000 1 .... 0 ... 1111 ........     @S_xri_rot
+  ADD_rri        1111 0.0 1000 . .... 0 ... .... ........     @s_rri_rot
+}
+ADC_rri          1111 0.0 1010 . .... 0 ... .... ........     @s_rri_rot
+SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
+{
+  CMP_xri        1111 0.0 1101 1 .... 0 ... 1111 ........     @S_xri_rot
+  SUB_rri        1111 0.0 1101 . .... 0 ... .... ........     @s_rri_rot
+}
+RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
-- 
2.17.1


