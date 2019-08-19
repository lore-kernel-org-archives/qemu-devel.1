Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B84DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8252087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dE1/FoVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8252087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpOW-0004Jv-Na
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLs-0001JS-Bg
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLq-000614-6k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLp-00060W-Vl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id w2so1949955pfi.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8jDMWWrRw0xR5k5R+zRH/f+0xphRhVsC4zoFKmwW1D8=;
 b=dE1/FoVSc+y7ow8OaWI1+sk/VcBqRhlS1ok5atG0cgJfHn4lmm6i4ylwnlOCSev8GL
 9gkDtim6hZJNGoFn3hVo5tnXWAamwNssbkBudkM9tY8qZg3qpaenAOEMRIdlD94Wd8Ke
 Deyzdwb9HLhbK1jd6Lcxoen6x5b72UzvZjLF/kxp1TXGbE8TBtDRc48TecxNE0j37RHy
 YKr2p1qDBdSpeVm9WR/8LPrkizYlu8H3suL6h9o5CaviETIjzIij0SQ97iCsoWYx9GSY
 g8RxjSHOJlzJW30eBfOf0V01nTn8vCa1HQYsIIA0Kg/VV8GMUNuJ3U+4OkhomtDOO0Uc
 qYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8jDMWWrRw0xR5k5R+zRH/f+0xphRhVsC4zoFKmwW1D8=;
 b=ONTK+Bzsr7CSIP2tqS0WE4Gz6Mnqd4uUJn41OA2B0HnAmId5KgEtGbo80IPlvgHabo
 7tybtmd9tDbo6ZavmRsR4ZfPPR1vJWtZisZO0OufWlBra4OjVfyUiJr3q9gMFeljwKzS
 fqPGJFNN4ih1MuRWnLPqlxY5PSkIjBEjutqCEWjFJZJhF1UvJnuBgWXapgazcjNNkRHB
 4gdm3u2zlQfJWw6tLGVB4kOtniDflo9L2wowSPwi2+o7xxJ61qd6lzLE32H9PuqAVBAx
 Cm0X7oydToFljTxBUlqbzDrTtX3iSreGAby4huWcYvHWj+ERbqtHwf6XQuU3da9Exq52
 fw+A==
X-Gm-Message-State: APjAAAW5cYu6I7XCBvtNunDvHHJw6fs7hFF+c9v0vU8jfL0rkiAGba2i
 lIR1zGV/xkOvgS6MvmKcW7Ou5H3HcpI=
X-Google-Smtp-Source: APXvYqzr1XoJCe615XFZrW4aFWHOgeXVPaAD7nDB+x2jXL+gqQJrPOJs5Jd0s5JF0GZgQPHroAtHpw==
X-Received: by 2002:a17:90a:9905:: with SMTP id
 b5mr23711432pjp.70.1566250684644; 
 Mon, 19 Aug 2019 14:38:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:53 -0700
Message-Id: <20190819213755.26175-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 06/68] target/arm: Convert multiply and
 multiply accumulate
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 248 +++++++++++++++++++++++------------------
 target/arm/a32.decode  |  17 +++
 target/arm/t32.decode  |  19 ++++
 3 files changed, 177 insertions(+), 107 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b5af38bf84..94659086c0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7990,6 +7990,125 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
 #undef DO_ANY2
 #undef DO_CMP2
 
+/*
+ * Multiply and multiply accumulate
+ */
+
+static bool op_mla(DisasContext *s, arg_s_rrrr *a, bool add)
+{
+    TCGv_i32 t1, t2;
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    tcg_gen_mul_i32(t1, t1, t2);
+    tcg_temp_free_i32(t2);
+    if (add) {
+        t2 = load_reg(s, a->ra);
+        tcg_gen_add_i32(t1, t1, t2);
+        tcg_temp_free_i32(t2);
+    }
+    if (a->s) {
+        gen_logic_CC(t1);
+    }
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_MUL(DisasContext *s, arg_MUL *a)
+{
+    return op_mla(s, a, false);
+}
+
+static bool trans_MLA(DisasContext *s, arg_MLA *a)
+{
+    return op_mla(s, a, true);
+}
+
+static bool trans_MLS(DisasContext *s, arg_MLS *a)
+{
+    TCGv_i32 t1, t2;
+
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    tcg_gen_mul_i32(t1, t1, t2);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_sub_i32(t1, t2, t1);
+    tcg_temp_free_i32(t2);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool op_mlal(DisasContext *s, arg_s_rrrr *a, bool uns, bool add)
+{
+    TCGv_i32 t0, t1, t2, t3;
+
+    t0 = load_reg(s, a->rm);
+    t1 = load_reg(s, a->rn);
+    if (uns) {
+        tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    } else {
+        tcg_gen_muls2_i32(t0, t1, t0, t1);
+    }
+    if (add) {
+        t2 = load_reg(s, a->ra);
+        t3 = load_reg(s, a->rd);
+        tcg_gen_add2_i32(t0, t1, t0, t1, t2, t3);
+        tcg_temp_free_i32(t2);
+        tcg_temp_free_i32(t3);
+    }
+    if (a->s) {
+        gen_logicq_cc(t0, t1);
+    }
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_UMULL(DisasContext *s, arg_UMULL *a)
+{
+    return op_mlal(s, a, true, false);
+}
+
+static bool trans_SMULL(DisasContext *s, arg_SMULL *a)
+{
+    return op_mlal(s, a, false, false);
+}
+
+static bool trans_UMLAL(DisasContext *s, arg_UMLAL *a)
+{
+    return op_mlal(s, a, true, true);
+}
+
+static bool trans_SMLAL(DisasContext *s, arg_SMLAL *a)
+{
+    return op_mlal(s, a, false, true);
+}
+
+static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
+{
+    TCGv_i32 t0, t1;
+    TCGv_i64 t64;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rm);
+    t1 = load_reg(s, a->rn);
+    t64 = gen_mulu_i64_i32(t0, t1);
+    gen_addq_lo(s, t64, a->ra);
+    gen_addq_lo(s, t64, a->rd);
+    gen_storeq_reg(s, a->ra, a->rd, t64);
+    tcg_temp_free_i64(t64);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8536,71 +8655,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             sh = (insn >> 5) & 3;
             if (sh == 0) {
                 if (op1 == 0x0) {
-                    rd = (insn >> 16) & 0xf;
-                    rn = (insn >> 12) & 0xf;
-                    rs = (insn >> 8) & 0xf;
-                    rm = (insn) & 0xf;
-                    op1 = (insn >> 20) & 0xf;
-                    switch (op1) {
-                    case 0: case 1: case 2: case 3: case 6:
-                        /* 32 bit mul */
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        tcg_gen_mul_i32(tmp, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        if (insn & (1 << 22)) {
-                            /* Subtract (mls) */
-                            ARCH(6T2);
-                            tmp2 = load_reg(s, rn);
-                            tcg_gen_sub_i32(tmp, tmp2, tmp);
-                            tcg_temp_free_i32(tmp2);
-                        } else if (insn & (1 << 21)) {
-                            /* Add */
-                            tmp2 = load_reg(s, rn);
-                            tcg_gen_add_i32(tmp, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                        }
-                        if (insn & (1 << 20))
-                            gen_logic_CC(tmp);
-                        store_reg(s, rd, tmp);
-                        break;
-                    case 4:
-                        /* 64 bit mul double accumulate (UMAAL) */
-                        ARCH(6);
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        tmp64 = gen_mulu_i64_i32(tmp, tmp2);
-                        gen_addq_lo(s, tmp64, rn);
-                        gen_addq_lo(s, tmp64, rd);
-                        gen_storeq_reg(s, rn, rd, tmp64);
-                        tcg_temp_free_i64(tmp64);
-                        break;
-                    case 8: case 9: case 10: case 11:
-                    case 12: case 13: case 14: case 15:
-                        /* 64 bit mul: UMULL, UMLAL, SMULL, SMLAL. */
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        if (insn & (1 << 22)) {
-                            tcg_gen_muls2_i32(tmp, tmp2, tmp, tmp2);
-                        } else {
-                            tcg_gen_mulu2_i32(tmp, tmp2, tmp, tmp2);
-                        }
-                        if (insn & (1 << 21)) { /* mult accumulate */
-                            TCGv_i32 al = load_reg(s, rn);
-                            TCGv_i32 ah = load_reg(s, rd);
-                            tcg_gen_add2_i32(tmp, tmp2, tmp, tmp2, al, ah);
-                            tcg_temp_free_i32(al);
-                            tcg_temp_free_i32(ah);
-                        }
-                        if (insn & (1 << 20)) {
-                            gen_logicq_cc(tmp, tmp2);
-                        }
-                        store_reg(s, rn, tmp);
-                        store_reg(s, rd, tmp2);
-                        break;
-                    default:
-                        goto illegal_op;
-                    }
+                    /* Multiply and multiply accumulate.  */
+                    /* All done in decodetree.  Reach here for illegal ops.  */
+                    goto illegal_op;
                 } else {
                     rn = (insn >> 16) & 0xf;
                     rd = (insn >> 12) & 0xf;
@@ -10040,7 +10097,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             break;
         case 4: case 5: /* 32-bit multiply.  Sum of absolute differences.  */
             switch ((insn >> 20) & 7) {
-            case 0: /* 32 x 32 -> 32 */
+            case 0: /* 32 x 32 -> 32, in decodetree */
+                goto illegal_op;
             case 7: /* Unsigned sum of absolute differences.  */
                 break;
             case 1: /* 16 x 16 -> 32 */
@@ -10057,18 +10115,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             tmp = load_reg(s, rn);
             tmp2 = load_reg(s, rm);
             switch ((insn >> 20) & 7) {
-            case 0: /* 32 x 32 -> 32 */
-                tcg_gen_mul_i32(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                if (rs != 15) {
-                    tmp2 = load_reg(s, rs);
-                    if (op)
-                        tcg_gen_sub_i32(tmp, tmp2, tmp);
-                    else
-                        tcg_gen_add_i32(tmp, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                }
-                break;
             case 1: /* 16 x 16 -> 32 */
                 gen_mulxy(tmp, tmp2, op & 2, op & 1);
                 tcg_temp_free_i32(tmp2);
@@ -10191,36 +10237,24 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 gen_storeq_reg(s, rs, rd, tmp64);
                 tcg_temp_free_i64(tmp64);
             } else {
-                if (op & 0x20) {
-                    /* Unsigned 64-bit multiply  */
-                    tmp64 = gen_mulu_i64_i32(tmp, tmp2);
-                } else {
-                    if (op & 8) {
-                        /* smlalxy */
-                        if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_i32(tmp);
-                            goto illegal_op;
-                        }
-                        gen_mulxy(tmp, tmp2, op & 2, op & 1);
-                        tcg_temp_free_i32(tmp2);
-                        tmp64 = tcg_temp_new_i64();
-                        tcg_gen_ext_i32_i64(tmp64, tmp);
-                        tcg_temp_free_i32(tmp);
-                    } else {
-                        /* Signed 64-bit multiply  */
-                        tmp64 = gen_muls_i64_i32(tmp, tmp2);
-                    }
+                if ((op & 0x20) || !(op & 8)) {
+                    /* Signed/unsigned 64-bit multiply, in decodetree */
+                    tcg_temp_free_i32(tmp2);
+                    tcg_temp_free_i32(tmp);
+                    goto illegal_op;
                 }
-                if (op & 4) {
-                    /* umaal */
-                    if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                        tcg_temp_free_i64(tmp64);
-                        goto illegal_op;
-                    }
-                    gen_addq_lo(s, tmp64, rs);
-                    gen_addq_lo(s, tmp64, rd);
-                } else if (op & 0x40) {
+                /* smlalxy */
+                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
+                    tcg_temp_free_i32(tmp2);
+                    tcg_temp_free_i32(tmp);
+                    goto illegal_op;
+                }
+                gen_mulxy(tmp, tmp2, op & 2, op & 1);
+                tcg_temp_free_i32(tmp2);
+                tmp64 = tcg_temp_new_i64();
+                tcg_gen_ext_i32_i64(tmp64, tmp);
+                tcg_temp_free_i32(tmp);
+                if (op & 0x40) {
                     /* 64-bit accumulate.  */
                     gen_addq(s, tmp64, rs, rd);
                 }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 286adcbf89..87bbb2eec2 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -25,6 +25,8 @@
 &s_rrr_shi       s rd rn rm shim shty
 &s_rrr_shr       s rn rd rm rs shty
 &s_rri_rot       s rn rd imm rot
+&s_rrrr          s rd rn rm ra
+&rrrr            rd rn rm ra
 
 # Data-processing (register)
 
@@ -105,3 +107,18 @@ ORR_rri          .... 001 1100 . .... .... ............       @s_rri_rot
 MOV_rxi          .... 001 1101 . 0000 .... ............       @s_rxi_rot
 BIC_rri          .... 001 1110 . .... .... ............       @s_rri_rot
 MVN_rxi          .... 001 1111 . 0000 .... ............       @s_rxi_rot
+
+# Multiply and multiply accumulate
+
+@s_rdamn         ---- .... ... s:1 rd:4 ra:4 rm:4 .... rn:4   &s_rrrr
+@s_rd0mn         ---- .... ... s:1 rd:4 .... rm:4 .... rn:4   &s_rrrr ra=0
+@rdamn           ---- .... ... .   rd:4 ra:4 rm:4 .... rn:4   &rrrr
+
+MUL              .... 0000 000 . .... 0000 .... 1001 ....     @s_rd0mn
+MLA              .... 0000 001 . .... .... .... 1001 ....     @s_rdamn
+UMAAL            .... 0000 010 0 .... .... .... 1001 ....     @rdamn
+MLS              .... 0000 011 0 .... .... .... 1001 ....     @rdamn
+UMULL            .... 0000 100 . .... .... .... 1001 ....     @s_rdamn
+UMLAL            .... 0000 101 . .... .... .... 1001 ....     @s_rdamn
+SMULL            .... 0000 110 . .... .... .... 1001 ....     @s_rdamn
+SMLAL            .... 0000 111 . .... .... .... 1001 ....     @s_rdamn
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 50cbe48cc8..40cc69aee3 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -22,6 +22,8 @@
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
+&s_rrrr          !extern s rd rn rm ra
+&rrrr            !extern rd rn rm ra
 
 # Data-processing (register)
 
@@ -109,3 +111,20 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
   SUB_rri        1111 0.0 1101 . .... 0 ... .... ........     @s_rri_rot
 }
 RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
+
+# Multiply and multiply accumulate
+
+@s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
+@s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=0 s=0
+@rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
+
+{
+  MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
+  MLA            1111 1011 0000 .... .... .... 0000 ....      @s0_rnadm
+}
+MLS              1111 1011 0000 .... .... .... 0001 ....      @rnadm
+SMULL            1111 1011 1000 .... .... .... 0000 ....      @s0_rnadm
+UMULL            1111 1011 1010 .... .... .... 0000 ....      @s0_rnadm
+SMLAL            1111 1011 1100 .... .... .... 0000 ....      @s0_rnadm
+UMLAL            1111 1011 1110 .... .... .... 0000 ....      @s0_rnadm
+UMAAL            1111 1011 1110 .... .... .... 0110 ....      @rnadm
-- 
2.17.1


