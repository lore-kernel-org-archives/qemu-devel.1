Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93825C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F87D21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Li4LbwiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F87D21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bIu-0007L5-Qw
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0B-0004ii-LP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b08-0002SW-Ck
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:35 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b08-0002Qg-1v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:32 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so7275627pfo.8
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9EVYYItSGNQSywfg+zBeibu25FcUXVkBN++lQhzBXj0=;
 b=Li4LbwiE0oYalvKlZHVMqJt3VJRTDO73Rt92TjbJNJeZrdywh7g4ESP8C5wl+R4E/E
 7LBKCKPkrq6iZtCVtkkuZ991TRbD/8LaWbegV/Qu+OXUkbjdWzw4JwFu3OpGxKPnvTy9
 5Q/nJS1Ly721iJaIYawR5YTJ8OvKjmqHenatmWbjP9qVS+05NsNpClxAXbh7mrG8MZbD
 /qO6JPO0prxsCmRIrhhhVG97+OhVsZ5Z1QNr0Fe03wgfZDOej4H9vDIMQbEzGhSv1B/U
 5Y4Owj1Y9W2dwKeWDhMiNcIAYxnDm9x5J0SMN0z6qsH2a+UyfIxuaGNzSa8wwsSaH5qs
 4nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9EVYYItSGNQSywfg+zBeibu25FcUXVkBN++lQhzBXj0=;
 b=PTfgTL64mBw5ObdJJ/XmvjSRgSedZHD3xWo/Fhnp/RMJIL31IZpWPzPqJ2PRJKf3su
 Ir5vhfPArfQQswEY9uSN/6K3E8h+huXl/EXkhPDk/CT0AE+KDad6BB31tF3Wcfw7yu5q
 3cq7DqsX+GGvsgrQ1J9FIya8qQsoJcJ3MMb2FfRdpi0t4WOoGrk6fgq7eq7Sk6OC2cig
 s0CchZnkV6tIS5TkB5KnzRrhjQQDuyhUWmxgrt7uCEotYGyQ3m4VXUeNHXFdtPAxHSb+
 2Mg1qDWlKn/8muVq836SYJsBuHMKjaLoVoPlrLmgx9++slE8OGeYVrs8Uqc+rmXulktC
 uoQw==
X-Gm-Message-State: APjAAAWtPSV1k7Vz7jT9ZfxIZ2iabRExERF+j8pzoEmLKp2FYZgbplcL
 DoRx53lVZoRVPqQI3/y8Z4yM5T1SUsc=
X-Google-Smtp-Source: APXvYqyoPAOaEeL+f52zyOKNHtvJg9xWqCQ6mTJMdHUCuUlmKr9ywKqNh73JOM94AP23syj0Zwm4pQ==
X-Received: by 2002:a63:3006:: with SMTP id w6mr36813812pgw.440.1567625490222; 
 Wed, 04 Sep 2019 12:31:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:13 -0700
Message-Id: <20190904193059.26202-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 23/69] target/arm: Convert USAD8, USADA8,
 SBFX, UBFX, BFC, BFI, UDF
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

In op_bfx, note that tcg_gen_{,s}extract_i32 already checks
for width == 32, so we don't need to special case that here.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use unallocated_encoding for out-of-range bitops.
---
 target/arm/translate.c | 201 +++++++++++++++++++++--------------------
 target/arm/a32.decode  |  20 ++++
 target/arm/t32.decode  |  19 ++++
 3 files changed, 144 insertions(+), 96 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9338873a4a..1c50ea232a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9220,6 +9220,104 @@ static bool trans_LDAH(DisasContext *s, arg_LDA *a)
     return op_lda(s, a, MO_UW);
 }
 
+/*
+ * Media instructions
+ */
+
+static bool trans_USADA8(DisasContext *s, arg_USADA8 *a)
+{
+    TCGv_i32 t1, t2;
+
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    gen_helper_usad8(t1, t1, t2);
+    tcg_temp_free_i32(t2);
+    if (a->ra != 15) {
+        t2 = load_reg(s, a->ra);
+        tcg_gen_add_i32(t1, t1, t2);
+        tcg_temp_free_i32(t2);
+    }
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool op_bfx(DisasContext *s, arg_UBFX *a, bool u)
+{
+    TCGv_i32 tmp;
+    int width = a->widthm1 + 1;
+    int shift = a->lsb;
+
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+    if (shift + width > 32) {
+        /* UNPREDICTABLE; we choose to UNDEF */
+        unallocated_encoding(s);
+        return true;
+    }
+
+    tmp = load_reg(s, a->rn);
+    if (u) {
+        tcg_gen_extract_i32(tmp, tmp, shift, width);
+    } else {
+        tcg_gen_sextract_i32(tmp, tmp, shift, width);
+    }
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_SBFX(DisasContext *s, arg_SBFX *a)
+{
+    return op_bfx(s, a, false);
+}
+
+static bool trans_UBFX(DisasContext *s, arg_UBFX *a)
+{
+    return op_bfx(s, a, true);
+}
+
+static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
+{
+    TCGv_i32 tmp;
+    int msb = a->msb, lsb = a->lsb;
+    int width;
+
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+    if (msb < lsb) {
+        /* UNPREDICTABLE; we choose to UNDEF */
+        unallocated_encoding(s);
+        return true;
+    }
+
+    width = msb + 1 - lsb;
+    if (a->rn == 15) {
+        /* BFC */
+        tmp = tcg_const_i32(0);
+    } else {
+        /* BFI */
+        tmp = load_reg(s, a->rn);
+    }
+    if (width != 32) {
+        TCGv_i32 tmp2 = load_reg(s, a->rd);
+        tcg_gen_deposit_i32(tmp, tmp2, tmp, lsb, width);
+        tcg_temp_free_i32(tmp2);
+    }
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_UDF(DisasContext *s, arg_UDF *a)
+{
+    unallocated_encoding(s);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -9769,65 +9867,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                     break;
                 case 3:
-                    op1 = ((insn >> 17) & 0x38) | ((insn >> 5) & 7);
-                    switch (op1) {
-                    case 0: /* Unsigned sum of absolute differences.  */
-                        ARCH(6);
-                        tmp = load_reg(s, rm);
-                        tmp2 = load_reg(s, rs);
-                        gen_helper_usad8(tmp, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        if (rd != 15) {
-                            tmp2 = load_reg(s, rd);
-                            tcg_gen_add_i32(tmp, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                        }
-                        store_reg(s, rn, tmp);
-                        break;
-                    case 0x20: case 0x24: case 0x28: case 0x2c:
-                        /* Bitfield insert/clear.  */
-                        ARCH(6T2);
-                        shift = (insn >> 7) & 0x1f;
-                        i = (insn >> 16) & 0x1f;
-                        if (i < shift) {
-                            /* UNPREDICTABLE; we choose to UNDEF */
-                            goto illegal_op;
-                        }
-                        i = i + 1 - shift;
-                        if (rm == 15) {
-                            tmp = tcg_temp_new_i32();
-                            tcg_gen_movi_i32(tmp, 0);
-                        } else {
-                            tmp = load_reg(s, rm);
-                        }
-                        if (i != 32) {
-                            tmp2 = load_reg(s, rd);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, shift, i);
-                            tcg_temp_free_i32(tmp2);
-                        }
-                        store_reg(s, rd, tmp);
-                        break;
-                    case 0x12: case 0x16: case 0x1a: case 0x1e: /* sbfx */
-                    case 0x32: case 0x36: case 0x3a: case 0x3e: /* ubfx */
-                        ARCH(6T2);
-                        tmp = load_reg(s, rm);
-                        shift = (insn >> 7) & 0x1f;
-                        i = ((insn >> 16) & 0x1f) + 1;
-                        if (shift + i > 32)
-                            goto illegal_op;
-                        if (i < 32) {
-                            if (op1 & 0x20) {
-                                tcg_gen_extract_i32(tmp, tmp, shift, i);
-                            } else {
-                                tcg_gen_sextract_i32(tmp, tmp, shift, i);
-                            }
-                        }
-                        store_reg(s, rd, tmp);
-                        break;
-                    default:
-                        goto illegal_op;
-                    }
-                    break;
+                    /* USAD, BFI, BFC, SBFX, UBFX */
+                    /* Done by decodetree */
+                    goto illegal_op;
                 }
                 break;
             }
@@ -10466,10 +10508,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             case 0: /* 32 x 32 -> 32 */
             case 1: /* 16 x 16 -> 32 */
             case 3: /* 32 * 16 -> 32msb */
+            case 7: /* Unsigned sum of absolute differences.  */
                 /* in decodetree */
                 goto illegal_op;
-            case 7: /* Unsigned sum of absolute differences.  */
-                break;
             case 2: /* Dual multiply add.  */
             case 4: /* Dual multiply subtract.  */
             case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
@@ -10534,15 +10575,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
                 tcg_temp_free_i32(tmp2);
                 break;
-            case 7: /* Unsigned sum of absolute differences.  */
-                gen_helper_usad8(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                if (rs != 15) {
-                    tmp2 = load_reg(s, rs);
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                }
-                break;
             }
             store_reg(s, rd, tmp);
             break;
@@ -10837,32 +10869,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         tmp = load_reg(s, rn);
                     }
                     switch (op) {
-                    case 2: /* Signed bitfield extract.  */
-                        imm++;
-                        if (shift + imm > 32)
-                            goto illegal_op;
-                        if (imm < 32) {
-                            tcg_gen_sextract_i32(tmp, tmp, shift, imm);
-                        }
-                        break;
-                    case 6: /* Unsigned bitfield extract.  */
-                        imm++;
-                        if (shift + imm > 32)
-                            goto illegal_op;
-                        if (imm < 32) {
-                            tcg_gen_extract_i32(tmp, tmp, shift, imm);
-                        }
-                        break;
-                    case 3: /* Bitfield insert/clear.  */
-                        if (imm < shift)
-                            goto illegal_op;
-                        imm = imm + 1 - shift;
-                        if (imm != 32) {
-                            tmp2 = load_reg(s, rd);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, shift, imm);
-                            tcg_temp_free_i32(tmp2);
-                        }
-                        break;
+                    case 2: /* Signed bitfield extract, in decodetree */
+                    case 6: /* Unsigned bitfield extract, in decodetree */
+                    case 3: /* Bitfield insert/clear, in decodetree */
                     case 7:
                         goto illegal_op;
                     default: /* Saturate.  */
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index c76cbad569..285c08ca22 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -41,6 +41,8 @@
 &ldst_ri         p w u rn rt imm
 &strex           rn rd rt rt2 imm
 &ldrex           rn rt rt2 imm
+&bfx             rd rn lsb widthm1
+&bfi             rd rn lsb msb
 
 # Data-processing (register)
 
@@ -390,3 +392,21 @@ LDAEXH           .... 0001 1111 .... .... 1110 1001 1111      @ldrex
 LDA              .... 0001 1001 .... .... 1100 1001 1111      @ldrex
 LDAB             .... 0001 1101 .... .... 1100 1001 1111      @ldrex
 LDAH             .... 0001 1111 .... .... 1100 1001 1111      @ldrex
+
+# Media instructions
+
+# usad8 is usada8 w/ ra=15
+USADA8           ---- 0111 1000 rd:4 ra:4 rm:4 0001 rn:4
+
+# ubfx and sbfx
+@bfx             ---- .... ... widthm1:5 rd:4 lsb:5 ... rn:4  &bfx
+
+SBFX             .... 0111 101 ..... .... ..... 101 ....      @bfx
+UBFX             .... 0111 111 ..... .... ..... 101 ....      @bfx
+
+# bfc is bfi w/ rn=15
+BFCI             ---- 0111 110 msb:5 rd:4 lsb:5 001 rn:4      &bfi
+
+# While we could get UDEF by not including this, add the pattern for
+# documentation and to conflict with any other typos in this file.
+UDF              1110 0111 1111 ---- ---- ---- 1111 ----
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 70cf8039d7..682fc5c2c4 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -38,6 +38,8 @@
 &ldst_ri         !extern p w u rn rt imm
 &strex           !extern rn rd rt rt2 imm
 &ldrex           !extern rn rt rt2 imm
+&bfx             !extern rd rn lsb widthm1
+&bfi             !extern rd rn lsb msb
 
 # Data-processing (register)
 
@@ -144,6 +146,19 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
   SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
 }
 
+# Saturate, bitfield
+
+@bfx             .... .... ... . rn:4 . ... rd:4 .. . widthm1:5 \
+                 &bfx lsb=%imm5_12_6
+@bfi             .... .... ... . rn:4 . ... rd:4 .. . msb:5 \
+                 &bfi lsb=%imm5_12_6
+
+SBFX             1111 0011 010 0 .... 0 ... .... ..0.....     @bfx
+UBFX             1111 0011 110 0 .... 0 ... .... ..0.....     @bfx
+
+# bfc is bfi w/ rn=15
+BFCI             1111 0011 011 0 .... 0 ... .... ..0.....     @bfi
+
 # Multiply and multiply accumulate
 
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
@@ -192,6 +207,9 @@ SMLALBT          1111 1011 1100 .... .... .... 1001 ....      @rnadm
 SMLALTB          1111 1011 1100 .... .... .... 1010 ....      @rnadm
 SMLALTT          1111 1011 1100 .... .... .... 1011 ....      @rnadm
 
+# usad8 is usada8 w/ ra=15
+USADA8           1111 1011 0111 .... .... .... 0000 ....      @rnadm
+
 # Data-processing (two source registers)
 
 QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
@@ -254,6 +272,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
   SMC            1111 0111 1111 imm:4 1000 0000 0000 0000     &i
   HVC            1111 0111 1110 ....  1000 .... .... ....     \
                  &i imm=%imm16_16_0
+  UDF            1111 0111 1111 ---- 1010 ---- ---- ----
 }
 
 # Load/store (register, immediate, literal)
-- 
2.17.1


