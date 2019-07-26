Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037BAC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B611021842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kISlNp5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B611021842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Tc-0006su-Ms
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N6-0003nL-I0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N2-0008Tr-4x
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:11 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4N1-0008RK-Mv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so24857463pfo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G+QSnEYqXF/oTE+I+ALJbsZ2r4R3OZGRCeVr3t2ySsk=;
 b=kISlNp5nE8I749I4oLIKQckvP5KwoKV4u5lFjFNZsgCw/ptdlVvoWE4ef5IS1npxFF
 vaoULYbwEDhQK4EKdTJs74/nlh0kxPGP90Px1BsYpuBdv0fJJ3UD7+LBB6cW4uYhaoKh
 rfDP1nk/MsMfD7xzt5fmEIPXbNDU15fFKu+7gL7552x6mLnOqfZbcjeSxWC3T6YE8CM8
 FofFOzeWbZHUbPMuadl3euCmym1DJFh1QzZuMxZOnsNHESGhQhjkmI+rppZhu9U/c5jL
 z313rgCDJWweNELovc2Wbf8CwGattOFWivvhf+/8IFGk8szaa4cRuQQIU90oaE2BSJ6D
 S5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G+QSnEYqXF/oTE+I+ALJbsZ2r4R3OZGRCeVr3t2ySsk=;
 b=r0oUAWuwY8w5ymyJ7lLYP9Si6X5lI7sflpHO1f9PAj2wWRd/41ZcOWH3J9a9D4PhUv
 0XV7QIll3Ii6h3DpGdW4XKZAC9Pt0cNxi2BNs62pC6baO/fkQOi9Np6UCtBJAGT00Bd2
 QxrLhtL8DU67Bge1CwFui6AG6znbvdgUBxQ0vAIaaXGtw8jYk/YtNbQMzj6BhXISjj+e
 e+pVXwvrfy1ELymkzWr5poGNrsp9XToLVoPAMV34Nh6TDDa6xyQp2ypjz6eZzCWfM9t1
 k1OjNLPc7SF2r1ZMT+yntPMOE+rXBZTZw/3OQ/cDqVWanitsRmPQqBgtR8NXo8gdTeaS
 JiEQ==
X-Gm-Message-State: APjAAAXoRZVszj4lcDMfOd/WfYYNsbUCz1rspY0MvPVU03R9xRTGg9fS
 O+JHMP4RGBubQgP2qkBIK4is9yPa1c0=
X-Google-Smtp-Source: APXvYqxrgKeALelDo5nQDJnwqBPxjQfqrqHjysc56s10cna0tnn1gu/Mw4nvkZdjCxo6qtQ1kZN5rA==
X-Received: by 2002:a65:5082:: with SMTP id r2mr66449305pgp.170.1564163466096; 
 Fri, 26 Jul 2019 10:51:06 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:52 -0700
Message-Id: <20190726175032.6769-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 27/67] target/arm: Convert Signed multiply,
 signed and unsigned divide
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 471 ++++++++++++++++++-----------------------
 target/arm/a32.decode  |  22 ++
 target/arm/t32.decode  |  18 ++
 3 files changed, 248 insertions(+), 263 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 11e74135fd..5bdec27265 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9512,17 +9512,218 @@ static bool trans_RBIT(DisasContext *s, arg_rr *a)
     return op_rr(s, a, gen_helper_rbit);
 }
 
+/*
+ * Signed multiply, signed and unsigned divide
+ */
+
+static bool op_smlad(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
+{
+    TCGv_i32 t1, t2;
+
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    if (m_swap) {
+        gen_swap_half(t2);
+    }
+    gen_smul_dual(t1, t2);
+
+    if (sub) {
+        /* This subtraction cannot overflow. */
+        tcg_gen_sub_i32(t1, t1, t2);
+    } else {
+        /*
+         * This addition cannot overflow 32 bits; however it may
+         * overflow considered as a signed operation, in which case
+         * we must set the Q flag.
+         */
+        gen_helper_add_setq(t1, cpu_env, t1, t2);
+    }
+    tcg_temp_free_i32(t2);
+
+    if (a->ra != 15) {
+        t2 = load_reg(s, a->ra);
+        gen_helper_add_setq(t1, cpu_env, t1, t2);
+        tcg_temp_free_i32(t2);
+    }
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_SMLAD(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlad(s, a, false, false);
+}
+
+static bool trans_SMLADX(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlad(s, a, true, false);
+}
+
+static bool trans_SMLSD(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlad(s, a, false, true);
+}
+
+static bool trans_SMLSDX(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlad(s, a, true, true);
+}
+
+static bool op_smlald(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
+{
+    TCGv_i32 t1, t2;
+    TCGv_i64 l1, l2;
+
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    if (m_swap) {
+        gen_swap_half(t2);
+    }
+    gen_smul_dual(t1, t2);
+
+    l1 = tcg_temp_new_i64();
+    l2 = tcg_temp_new_i64();
+    tcg_gen_ext_i32_i64(l1, t1);
+    tcg_gen_ext_i32_i64(l2, t2);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
+
+    if (sub) {
+        tcg_gen_sub_i64(l1, l1, l2);
+    } else {
+        tcg_gen_add_i64(l1, l1, l2);
+    }
+    tcg_temp_free_i64(l2);
+
+    gen_addq(s, l1, a->ra, a->rd);
+    gen_storeq_reg(s, a->ra, a->rd, l1);
+    tcg_temp_free_i64(l1);
+    return true;
+}
+
+static bool trans_SMLALD(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlald(s, a, false, false);
+}
+
+static bool trans_SMLALDX(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlald(s, a, true, false);
+}
+
+static bool trans_SMLSLD(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlald(s, a, false, true);
+}
+
+static bool trans_SMLSLDX(DisasContext *s, arg_rrrr *a)
+{
+    return op_smlald(s, a, true, true);
+}
+
+static bool op_smmla(DisasContext *s, arg_rrrr *a, bool round, bool sub)
+{
+    TCGv_i32 t1, t2;
+    TCGv_i64 tmp64;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    tmp64 = gen_muls_i64_i32(t1, t2);
+
+    if (a->ra != 15) {
+        t1 = load_reg(s, a->ra);
+        if (sub) {
+            tmp64 = gen_subq_msw(tmp64, t1);
+        } else {
+            tmp64 = gen_addq_msw(tmp64, t1);
+        }
+    }
+    if (round) {
+        tcg_gen_addi_i64(tmp64, tmp64, 0x80000000u);
+    }
+    t1 = tcg_temp_new_i32();
+    tcg_gen_extrh_i64_i32(t1, tmp64);
+    tcg_temp_free_i64(tmp64);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_SMMLA(DisasContext *s, arg_rrrr *a)
+{
+    return op_smmla(s, a, false, false);
+}
+
+static bool trans_SMMLAR(DisasContext *s, arg_rrrr *a)
+{
+    return op_smmla(s, a, true, false);
+}
+
+static bool trans_SMMLS(DisasContext *s, arg_rrrr *a)
+{
+    return op_smmla(s, a, false, true);
+}
+
+static bool trans_SMMLSR(DisasContext *s, arg_rrrr *a)
+{
+    return op_smmla(s, a, true, true);
+}
+
+static bool op_div(DisasContext *s, arg_rrr *a, bool u)
+{
+    TCGv_i32 t1, t2;
+
+    if (s->thumb
+        ? !dc_isar_feature(thumb_div, s)
+        : !dc_isar_feature(arm_div, s)) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    if (u) {
+        gen_helper_udiv(t1, t1, t2);
+    } else {
+        gen_helper_sdiv(t1, t1, t2);
+    }
+    tcg_temp_free_i32(t2);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_SDIV(DisasContext *s, arg_rrr *a)
+{
+    return op_div(s, a, false);
+}
+
+static bool trans_UDIV(DisasContext *s, arg_rrr *a)
+{
+    return op_div(s, a, true);
+}
+
 /*
  * Legacy decoder.
  */
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, val, op1, i, rm, rs, rn, rd;
+    unsigned int cond, val, op1, i, rn, rd;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
-    TCGv_i64 tmp64;
 
     /* M variants do not implement ARM mode; this must raise the INVSTATE
      * UsageFault exception.
@@ -9802,144 +10003,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         switch(op1) {
         case 0x0:
         case 0x1:
-            /* multiplies, extra load/stores */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-            break;
         case 0x4:
         case 0x5:
-            goto do_ldst;
         case 0x6:
         case 0x7:
-            if (insn & (1 << 4)) {
-                ARCH(6);
-                /* Armv6 Media instructions.  */
-                rm = insn & 0xf;
-                rn = (insn >> 16) & 0xf;
-                rd = (insn >> 12) & 0xf;
-                rs = (insn >> 8) & 0xf;
-                switch ((insn >> 23) & 3) {
-                case 0: /* Parallel add/subtract.  */
-                    /* Done by decodetree */
-                    goto illegal_op;
-                case 1:
-                    /* Halfword pack, [US]SAT, [US]SAT16, SEL, REV et al */
-                    /* Done by decodetree */
-                    goto illegal_op;
-                case 2: /* Multiplies (Type 3).  */
-                    switch ((insn >> 20) & 0x7) {
-                    case 5:
-                        if (((insn >> 6) ^ (insn >> 7)) & 1) {
-                            /* op2 not 00x or 11x : UNDEF */
-                            goto illegal_op;
-                        }
-                        /* Signed multiply most significant [accumulate].
-                           (SMMUL, SMMLA, SMMLS) */
-                        tmp = load_reg(s, rm);
-                        tmp2 = load_reg(s, rs);
-                        tmp64 = gen_muls_i64_i32(tmp, tmp2);
-
-                        if (rd != 15) {
-                            tmp = load_reg(s, rd);
-                            if (insn & (1 << 6)) {
-                                tmp64 = gen_subq_msw(tmp64, tmp);
-                            } else {
-                                tmp64 = gen_addq_msw(tmp64, tmp);
-                            }
-                        }
-                        if (insn & (1 << 5)) {
-                            tcg_gen_addi_i64(tmp64, tmp64, 0x80000000u);
-                        }
-                        tcg_gen_shri_i64(tmp64, tmp64, 32);
-                        tmp = tcg_temp_new_i32();
-                        tcg_gen_extrl_i64_i32(tmp, tmp64);
-                        tcg_temp_free_i64(tmp64);
-                        store_reg(s, rn, tmp);
-                        break;
-                    case 0:
-                    case 4:
-                        /* SMLAD, SMUAD, SMLSD, SMUSD, SMLALD, SMLSLD */
-                        if (insn & (1 << 7)) {
-                            goto illegal_op;
-                        }
-                        tmp = load_reg(s, rm);
-                        tmp2 = load_reg(s, rs);
-                        if (insn & (1 << 5))
-                            gen_swap_half(tmp2);
-                        gen_smul_dual(tmp, tmp2);
-                        if (insn & (1 << 22)) {
-                            /* smlald, smlsld */
-                            TCGv_i64 tmp64_2;
-
-                            tmp64 = tcg_temp_new_i64();
-                            tmp64_2 = tcg_temp_new_i64();
-                            tcg_gen_ext_i32_i64(tmp64, tmp);
-                            tcg_gen_ext_i32_i64(tmp64_2, tmp2);
-                            tcg_temp_free_i32(tmp);
-                            tcg_temp_free_i32(tmp2);
-                            if (insn & (1 << 6)) {
-                                tcg_gen_sub_i64(tmp64, tmp64, tmp64_2);
-                            } else {
-                                tcg_gen_add_i64(tmp64, tmp64, tmp64_2);
-                            }
-                            tcg_temp_free_i64(tmp64_2);
-                            gen_addq(s, tmp64, rd, rn);
-                            gen_storeq_reg(s, rd, rn, tmp64);
-                            tcg_temp_free_i64(tmp64);
-                        } else {
-                            /* smuad, smusd, smlad, smlsd */
-                            if (insn & (1 << 6)) {
-                                /* This subtraction cannot overflow. */
-                                tcg_gen_sub_i32(tmp, tmp, tmp2);
-                            } else {
-                                /* This addition cannot overflow 32 bits;
-                                 * however it may overflow considered as a
-                                 * signed operation, in which case we must set
-                                 * the Q flag.
-                                 */
-                                gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                            }
-                            tcg_temp_free_i32(tmp2);
-                            if (rd != 15)
-                              {
-                                tmp2 = load_reg(s, rd);
-                                gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                                tcg_temp_free_i32(tmp2);
-                              }
-                            store_reg(s, rn, tmp);
-                        }
-                        break;
-                    case 1:
-                    case 3:
-                        /* SDIV, UDIV */
-                        if (!dc_isar_feature(arm_div, s)) {
-                            goto illegal_op;
-                        }
-                        if (((insn >> 5) & 7) || (rd != 15)) {
-                            goto illegal_op;
-                        }
-                        tmp = load_reg(s, rm);
-                        tmp2 = load_reg(s, rs);
-                        if (insn & (1 << 21)) {
-                            gen_helper_udiv(tmp, tmp, tmp2);
-                        } else {
-                            gen_helper_sdiv(tmp, tmp, tmp2);
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        store_reg(s, rn, tmp);
-                        break;
-                    default:
-                        goto illegal_op;
-                    }
-                    break;
-                case 3:
-                    /* USAD, BFI, BFC, SBFX, UBFX */
-                    /* Done by decodetree */
-                    goto illegal_op;
-                }
-                break;
-            }
-        do_ldst:
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
         case 0x08:
@@ -10163,7 +10230,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
-    TCGv_i64 tmp64;
     int op;
 
     /*
@@ -10429,132 +10495,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         case 2: /* SIMD add/subtract, in decodetree */
         case 3: /* Other data processing, in decodetree */
             goto illegal_op;
-        case 4: case 5: /* 32-bit multiply.  Sum of absolute differences.  */
-            switch ((insn >> 20) & 7) {
-            case 0: /* 32 x 32 -> 32 */
-            case 1: /* 16 x 16 -> 32 */
-            case 3: /* 32 * 16 -> 32msb */
-            case 7: /* Unsigned sum of absolute differences.  */
-                /* in decodetree */
-                goto illegal_op;
-            case 2: /* Dual multiply add.  */
-            case 4: /* Dual multiply subtract.  */
-            case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    goto illegal_op;
-                }
-                break;
-            }
-            op = (insn >> 4) & 0xf;
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            switch ((insn >> 20) & 7) {
-            case 2: /* Dual multiply add.  */
-            case 4: /* Dual multiply subtract.  */
-                if (op)
-                    gen_swap_half(tmp2);
-                gen_smul_dual(tmp, tmp2);
-                if (insn & (1 << 22)) {
-                    /* This subtraction cannot overflow. */
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                } else {
-                    /* This addition cannot overflow 32 bits;
-                     * however it may overflow considered as a signed
-                     * operation, in which case we must set the Q flag.
-                     */
-                    gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                }
-                tcg_temp_free_i32(tmp2);
-                if (rs != 15)
-                  {
-                    tmp2 = load_reg(s, rs);
-                    gen_helper_add_setq(tmp, cpu_env, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                  }
-                break;
-            case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
-                tmp64 = gen_muls_i64_i32(tmp, tmp2);
-                if (rs != 15) {
-                    tmp = load_reg(s, rs);
-                    if (insn & (1 << 20)) {
-                        tmp64 = gen_addq_msw(tmp64, tmp);
-                    } else {
-                        tmp64 = gen_subq_msw(tmp64, tmp);
-                    }
-                }
-                if (insn & (1 << 4)) {
-                    tcg_gen_addi_i64(tmp64, tmp64, 0x80000000u);
-                }
-                tcg_gen_shri_i64(tmp64, tmp64, 32);
-                tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tmp64);
-                tcg_temp_free_i64(tmp64);
-                break;
-            }
-            store_reg(s, rd, tmp);
-            break;
-        case 6: case 7: /* 64-bit multiply, Divide.  */
-            op = ((insn >> 4) & 0xf) | ((insn >> 16) & 0x70);
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            if ((op & 0x50) == 0x10) {
-                /* sdiv, udiv */
-                if (!dc_isar_feature(thumb_div, s)) {
-                    goto illegal_op;
-                }
-                if (op & 0x20)
-                    gen_helper_udiv(tmp, tmp, tmp2);
-                else
-                    gen_helper_sdiv(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-            } else if ((op & 0xe) == 0xc) {
-                /* Dual multiply accumulate long.  */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(tmp2);
-                    goto illegal_op;
-                }
-                if (op & 1)
-                    gen_swap_half(tmp2);
-                gen_smul_dual(tmp, tmp2);
-                if (op & 0x10) {
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                } else {
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                }
-                tcg_temp_free_i32(tmp2);
-                /* BUGFIX */
-                tmp64 = tcg_temp_new_i64();
-                tcg_gen_ext_i32_i64(tmp64, tmp);
-                tcg_temp_free_i32(tmp);
-                gen_addq(s, tmp64, rs, rd);
-                gen_storeq_reg(s, rs, rd, tmp64);
-                tcg_temp_free_i64(tmp64);
-            } else {
-                if (op & 0x20) {
-                    /* Unsigned 64-bit multiply  */
-                    tmp64 = gen_mulu_i64_i32(tmp, tmp2);
-                } else {
-                    if (op & 8) {
-                        /* smlalxy, in decodetree */
-                        goto illegal_op;
-                    } else {
-                        /* Signed 64-bit multiply  */
-                        tmp64 = gen_muls_i64_i32(tmp, tmp2);
-                    }
-                }
-                if (op & 4) {
-                    /* umaal, in decodetree */
-                    goto illegal_op;
-                } else if (op & 0x40) {
-                    /* 64-bit accumulate.  */
-                    gen_addq(s, tmp64, rs, rd);
-                }
-                gen_storeq_reg(s, rs, rd, tmp64);
-                tcg_temp_free_i64(tmp64);
-            }
-            break;
+        case 4: case 5:
+            /* 32-bit multiply.  Sum of absolute differences, in decodetree */
+            goto illegal_op;
+        case 6: case 7: /* 64-bit multiply, Divide, in decodetree */
+            goto illegal_op;
         }
         break;
     case 6: case 7: case 14: case 15:
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 725e627796..c5af685585 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -486,3 +486,25 @@ REV              .... 0110 1011 1111 .... 1111 0011 ....      @rdm
 REV16            .... 0110 1011 1111 .... 1111 1011 ....      @rdm
 REVSH            .... 0110 1111 1111 .... 1111 1011 ....      @rdm
 RBIT             .... 0110 1111 1111 .... 1111 0011 ....      @rdm
+
+# Signed multiply, signed and unsigned divide
+
+@rdmn            ---- .... .... rd:4 .... rm:4 .... rn:4      &rrr
+
+SMLAD            .... 0111 0000 .... .... .... 0001 ....      @rdamn
+SMLADX           .... 0111 0000 .... .... .... 0011 ....      @rdamn
+SMLSD            .... 0111 0000 .... .... .... 0101 ....      @rdamn
+SMLSDX           .... 0111 0000 .... .... .... 0111 ....      @rdamn
+
+SDIV             .... 0111 0001 .... 1111 .... 0001 ....      @rdmn
+UDIV             .... 0111 0011 .... 1111 .... 0001 ....      @rdmn
+
+SMLALD           .... 0111 0100 .... .... .... 0001 ....      @rdamn
+SMLALDX          .... 0111 0100 .... .... .... 0011 ....      @rdamn
+SMLSLD           .... 0111 0100 .... .... .... 0101 ....      @rdamn
+SMLSLDX          .... 0111 0100 .... .... .... 0111 ....      @rdamn
+
+SMMLA            .... 0111 0101 .... .... .... 0001 ....      @rdamn
+SMMLAR           .... 0111 0101 .... .... .... 0011 ....      @rdamn
+SMMLS            .... 0111 0101 .... .... .... 1101 ....      @rdamn
+SMMLSR           .... 0111 0101 .... .... .... 1111 ....      @rdamn
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index ea147e5348..68203e3704 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -228,6 +228,24 @@ SMLALTT          1111 1011 1100 .... .... .... 1011 ....      @rnadm
 # usad8 is usada8 w/ ra=15
 USADA8           1111 1011 0111 .... .... .... 0000 ....      @rnadm
 
+SMLAD            1111 1011 0010 .... .... .... 0000 ....      @rnadm
+SMLADX           1111 1011 0010 .... .... .... 0001 ....      @rnadm
+SMLSD            1111 1011 0100 .... .... .... 0000 ....      @rnadm
+SMLSDX           1111 1011 0100 .... .... .... 0001 ....      @rnadm
+
+SMLALD           1111 1011 1100 .... .... .... 1100 ....      @rnadm
+SMLALDX          1111 1011 1100 .... .... .... 1101 ....      @rnadm
+SMLSLD           1111 1011 1101 .... .... .... 1100 ....      @rnadm
+SMLSLDX          1111 1011 1101 .... .... .... 1101 ....      @rnadm
+
+SMMLA            1111 1011 0101 .... .... .... 0000 ....      @rnadm
+SMMLAR           1111 1011 0101 .... .... .... 0001 ....      @rnadm
+SMMLS            1111 1011 0110 .... .... .... 0000 ....      @rnadm
+SMMLSR           1111 1011 0110 .... .... .... 0001 ....      @rnadm
+
+SDIV             1111 1011 1001 .... 1111 .... 1111 ....      @rndm
+UDIV             1111 1011 1011 .... 1111 .... 1111 ....      @rndm
+
 # Data-processing (two source registers)
 
 QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
-- 
2.17.1


