Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51365C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DE9218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2LVzuza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DE9218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Qe-0002Dd-ND
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mo-0002cK-Vd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ml-0007lj-H2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Ml-0007k3-5Q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:51 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so24852872pfa.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H+C2V+j8/JNNNhWaoLPsj+V4nwfuzqa8kDIsrAt6EtU=;
 b=K2LVzuzaCiJT74unyEQFC8duZqRYfuKK2aORw7+RItencmqNK7/7yFtxyXfn4oOhnl
 5xmts6lCJRWAsJbTfRBOWHdkvCOKNu4sG7bGHVKxqQBu1521wDRfOwPzbuAlXxGmFQ9k
 QqD/q9hw17Kgi9yZh2rpoPImAP5jrgevhN6yTay56xkj7uOxw8YKSaOLChO1cxdQkOBh
 dy7DO4dwDl4wwro3XRi4x1KGWA9w9RwPKVFojeDYSaVGW10CVtBComkJQqRzdXTUvxrj
 YdZjdOLNAMwWsjkItcHVTDUPAB2/i1Ot2borV5X1I87AqgG0tMJlbxOx2rzeRrBuOauK
 Iq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=H+C2V+j8/JNNNhWaoLPsj+V4nwfuzqa8kDIsrAt6EtU=;
 b=UXq4b/7OBULqGiqMsE8NRBzpxxek5gGzSOTXtRLNnyYmZ7A16EtYj6PF2qJmSlzM8S
 2aEIeGEk6RS+8vXMKuEStgd/Tvs9xwW2camjBckayBdoswWMsUcxOIDhuKJm5m+SqGjo
 o8EekQ31IhbShKiWZp0ts0NyAxPffkrFffb0O8y+2aQLhGCWjjSH2T4tScJhMZe4ACiU
 T1umbhOIwGAEHCcce+Exmmgg4ZOTpS2WqmdZuanMvGpi0hrVD2+gmMF0DuSd7HSzQsUB
 Cdxgupy6LBo3EcIDf5DUQngOQO5iNFriLiQhtsA9EBCXzk8Gn1BTeZVLogFZP3RTfBsr
 VDlw==
X-Gm-Message-State: APjAAAUi0a2eFabFLRZxWcCEGxrF8sqExWrE9tjkkEQKugwHGaKBNSJg
 9akCIzfUZq/eJsHaVuVIO6H0aDYpblA=
X-Google-Smtp-Source: APXvYqxU+OTEbyeL4fI7xJoUR6vKx01xZc1zgBdafADwWYqhzxriBLk4zkJMy4zl6H0b5Hb6mk8wYA==
X-Received: by 2002:a17:90a:37e9:: with SMTP id
 v96mr97152975pjb.10.1564163449467; 
 Fri, 26 Jul 2019 10:50:49 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:38 -0700
Message-Id: <20190726175032.6769-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 13/67] target/arm: Convert Data Processing (reg,
 reg-shifted-reg, imm)
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

Do these all in one lump because these are all logically intertwined.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 747 ++++++++++++++++++++---------------------
 target/arm/a32.decode  |  84 +++++
 target/arm/t32.decode  |  91 +++++
 3 files changed, 536 insertions(+), 386 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0f21ee9ce7..ee7d53dfa5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -480,12 +480,6 @@ static void gen_add16(TCGv_i32 t0, TCGv_i32 t1)
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
@@ -905,25 +899,6 @@ void arm_gen_test_cc(int cc, TCGLabel *label)
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
@@ -7719,6 +7694,49 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     }
 }
 
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
+        imm |= imm << 16;
+        break;
+    case 2: /* XY00XY00 */
+        imm |= imm << 16;
+        imm <<= 8;
+        break;
+    case 3: /* XYXYXYXY */
+        imm |= imm << 8;
+        imm |= imm << 16;
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
  * Note that the T32 decoder reuses some of the trans_* functions
@@ -7742,6 +7760,314 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
 # pragma GCC diagnostic pop
 #endif
 
+/* Helpers to swap operands for reverse-subtract.  */
+static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_sub_i32(dst, b, a);
+}
+
+static void gen_rsb_CC(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sub_CC(dst, b, a);
+}
+
+static void gen_rsc(TCGv_i32 dest, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sub_carry(dest, b, a);
+}
+
+static void gen_rsc_CC(TCGv_i32 dest, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_sbc_CC(dest, b, a);
+}
+
+/*
+ * Helper for the data processing routines.
+ * After the computation store the results back.
+ * This may be suppressed altogether (STREG_NONE), require a runtime
+ * check against the stack limits (STREG_SP_CHECK), or generate an
+ * exception return.  Oh, or store into a register.
+ */
+typedef enum {
+   STREG_NORMAL,
+   STREG_NONE,
+   STREG_SP_CHECK,
+   STREG_EXC_RET,
+} StoreRegKind;
+
+static bool store_reg_flags(DisasContext *s, int rd,
+                            TCGv_i32 val, StoreRegKind kind)
+{
+    switch (kind) {
+    case STREG_NORMAL:
+        break;
+    case STREG_NONE:
+        tcg_temp_free_i32(val);
+        return true;
+    case STREG_SP_CHECK:
+        if (rd == 13) {
+            store_sp_checked(s, val);
+            return true;
+        }
+        break;
+    case STREG_EXC_RET:
+        gen_exception_return(s, val);
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+    /* ALUWritePC: Interworking only from a32 mode. */
+    if (s->thumb) {
+        store_reg(s, rd, val);
+    } else {
+        store_reg_bx(s, rd, val);
+    }
+    return true;
+}
+
+/*
+ * Data Processing (register)
+ *
+ * Operate, with set flags, one register source,
+ * one immediate shifted register source, and a destination.
+ * Here, we return the result without storing into a destination.
+ */
+static TCGv_i32 op_s_rrr_shi(DisasContext *s, arg_s_rrr_shi *a,
+                             void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                             int logic_cc)
+{
+    TCGv_i32 tmp1, tmp2;
+
+    tmp2 = load_reg(s, a->rm);
+    gen_arm_shift_im(tmp2, a->shty, a->shim, logic_cc);
+    tmp1 = load_reg(s, a->rn);
+
+    gen(tmp1, tmp1, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    if (logic_cc) {
+        gen_logic_CC(tmp1);
+    }
+    return tmp1;
+}
+
+static TCGv_i32 op_s_rxr_shi(DisasContext *s, arg_s_rrr_shi *a,
+                             void (*gen)(TCGv_i32, TCGv_i32),
+                             int logic_cc)
+{
+    TCGv_i32 tmp;
+
+    tmp = load_reg(s, a->rm);
+    gen_arm_shift_im(tmp, a->shty, a->shim, logic_cc);
+
+    gen(tmp, tmp);
+    if (logic_cc) {
+        gen_logic_CC(tmp);
+    }
+    return tmp;
+}
+
+/*
+ * Data-processing (register-shifted register)
+ *
+ * Operate, with set flags, one register source,
+ * one register shifted register source, and a destination.
+ * Here, we return the result without storing into a destination.
+ */
+static TCGv_i32 op_s_rrr_shr(DisasContext *s, arg_s_rrr_shr *a,
+                             void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                             int logic_cc)
+{
+    TCGv_i32 tmp1, tmp2;
+
+    tmp1 = load_reg(s, a->rs);
+    tmp2 = load_reg(s, a->rm);
+    gen_arm_shift_reg(tmp2, a->shty, tmp1, logic_cc);
+    tmp1 = load_reg(s, a->rn);
+
+    gen(tmp1, tmp1, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    if (logic_cc) {
+        gen_logic_CC(tmp1);
+    }
+    return tmp1;
+}
+
+static TCGv_i32 op_s_rxr_shr(DisasContext *s, arg_s_rrr_shr *a,
+                             void (*gen)(TCGv_i32, TCGv_i32),
+                             int logic_cc)
+{
+    TCGv_i32 tmp1, tmp2;
+
+    tmp1 = load_reg(s, a->rs);
+    tmp2 = load_reg(s, a->rm);
+    gen_arm_shift_reg(tmp2, a->shty, tmp1, logic_cc);
+
+    gen(tmp2, tmp2);
+    if (logic_cc) {
+        gen_logic_CC(tmp2);
+    }
+    return tmp2;
+}
+
+/*
+ * Data-processing (immediate)
+ *
+ * Operate, with set flags, one register source,
+ * one rotated immediate, and a destination.
+ * Here, we return the result without storing into a destination.
+ */
+static TCGv_i32 op_s_rri_rot(DisasContext *s, arg_s_rri_rot *a,
+                             void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                             int logic_cc)
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
+    return tmp1;
+}
+
+static TCGv_i32 op_s_rxi_rot(DisasContext *s, arg_s_rri_rot *a,
+                             void (*gen)(TCGv_i32, TCGv_i32),
+                             int logic_cc)
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
+    return tmp;
+}
+
+#define DO_ANY3(NAME, OPERATION, LOGIC_CC, FLAGS)                       \
+static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)      \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rrr_shi(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}                                                                       \
+static bool trans_##NAME##_rrrr(DisasContext *s, arg_s_rrr_shr *a)      \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rrr_shr(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}                                                                       \
+static bool trans_##NAME##_rri(DisasContext *s, arg_s_rri_rot *a)       \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rri_rot(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}
+
+#define DO_ANY2(NAME, OPERATION, LOGIC_CC, FLAGS)                       \
+static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)      \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rxr_shi(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}                                                                       \
+static bool trans_##NAME##_rrrr(DisasContext *s, arg_s_rrr_shr *a)      \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rxr_shr(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}                                                                       \
+static bool trans_##NAME##_rri(DisasContext *s, arg_s_rri_rot *a)       \
+{                                                                       \
+    StoreRegKind flags = FLAGS;                                         \
+    TCGv_i32 val = op_s_rxi_rot(s, a, OPERATION, LOGIC_CC);             \
+    return store_reg_flags(s, a->rd, val, flags);                       \
+}
+
+#define DO_LOGIC(NAME, OPERATION, FLAGS) DO_ANY3(NAME, OPERATION, a->s, FLAGS)
+
+DO_LOGIC(AND, tcg_gen_and_i32, STREG_NORMAL)
+DO_LOGIC(EOR, tcg_gen_xor_i32, STREG_NORMAL)
+DO_LOGIC(ORR, tcg_gen_or_i32, STREG_NORMAL)
+DO_LOGIC(BIC, tcg_gen_andc_i32, STREG_NORMAL)
+
+DO_ANY2(MOV, tcg_gen_mov_i32, a->s,
+        ({
+             int result = STREG_SP_CHECK;
+             if (a->s && a->rd == 15) {
+                 if (IS_USER(s)) {
+                     return false;
+                 }
+                 result = STREG_EXC_RET;
+             }
+             result;
+        }))
+
+DO_ANY2(MVN, tcg_gen_not_i32, a->s, STREG_NORMAL)
+
+DO_ANY3(RSB, a->s ? gen_rsb_CC : gen_rsb, false, STREG_NORMAL)
+DO_ANY3(ADC, a->s ? gen_adc_CC : gen_add_carry, false, STREG_NORMAL)
+DO_ANY3(SBC, a->s ? gen_sbc_CC : gen_sub_carry, false, STREG_NORMAL)
+DO_ANY3(RSC, a->s ? gen_rsc_CC : gen_rsc, false, STREG_NORMAL)
+
+DO_ANY3(TST, tcg_gen_and_i32, true, STREG_NONE)
+DO_ANY3(TEQ, tcg_gen_xor_i32, true, STREG_NONE)
+DO_ANY3(CMN, gen_add_CC, false, STREG_NONE)
+DO_ANY3(CMP, gen_sub_CC, false, STREG_NONE)
+
+DO_ANY3(SUB, a->s ? gen_sub_CC : tcg_gen_sub_i32, false,
+        ({
+             int result = STREG_SP_CHECK;
+             if (a->s && a->rd == 15) {
+                 if (IS_USER(s)) {
+                     return false;
+                 }
+                 result = STREG_EXC_RET;
+             } else if (a->rn == 13) {
+                 result = STREG_SP_CHECK;
+             }
+             result;
+        }))
+
+DO_ANY3(ADD, a->s ? gen_add_CC : tcg_gen_add_i32, false,
+        a->rn == 13 ? STREG_SP_CHECK : STREG_NORMAL)
+
+/*
+ * ORN is only available with T32, and so there is no c_s_rrr_shr decode.
+ * Using the DO_LOGIC macro would create an unused function.
+ */
+static bool trans_ORN_rrri(DisasContext *s, arg_s_rrr_shi *a)
+{
+    TCGv_i32 val = op_s_rrr_shi(s, a, tcg_gen_orc_i32, a->s);
+    return store_reg_flags(s, a->rd, val, STREG_NORMAL);
+}
+
+static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
+{
+    TCGv_i32 val = op_s_rri_rot(s, a, tcg_gen_orc_i32, a->s);
+    return store_reg_flags(s, a->rd, val, STREG_NORMAL);
+}
+
+#undef DO_ANY
+#undef DO_LOGIC
+
 /*
  * Legacy decoder.
  */
@@ -8273,184 +8599,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
-            if (shift) {
-                val = (val >> shift) | (val << (32 - shift));
-            }
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
@@ -9348,89 +9499,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
     return true;
 }
 
-/* Return true if this is a Thumb-2 logical op.  */
-static int
-thumb2_logic_op(int op)
-{
-    return (op < 8);
-}
-
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
@@ -9442,9 +9510,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 addr;
     TCGv_i64 tmp64;
     int op;
-    int shiftop;
-    int conds;
-    int logic_cc;
 
     /*
      * ARMv6-M supports a limited subset of Thumb2 instructions.
@@ -9881,33 +9946,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
         } else {
             /* Data processing register constant shift.  */
-            if (rn == 15) {
-                tmp = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp, 0);
-            } else {
-                tmp = load_reg(s, rn);
-            }
-            tmp2 = load_reg(s, rm);
-
-            shiftop = (insn >> 4) & 3;
-            shift = ((insn >> 6) & 3) | ((insn >> 10) & 0x1c);
-            conds = (insn & (1 << 20)) != 0;
-            logic_cc = (conds && thumb2_logic_op(op));
-            gen_arm_shift_im(tmp2, shiftop, shift, logic_cc);
-            if (gen_thumb2_data_op(s, op, conds, 0, tmp, tmp2))
-                goto illegal_op;
-            tcg_temp_free_i32(tmp2);
-            if (rd == 13 &&
-                ((op == 2 && rn == 15) ||
-                 (op == 8 && rn == 13) ||
-                 (op == 13 && rn == 13))) {
-                /* MOV SP, ... or ADD SP, SP, ... or SUB SP, SP, ... */
-                store_sp_checked(s, tmp);
-            } else if (rd != 15) {
-                store_reg(s, rd, tmp);
-            } else {
-                tcg_temp_free_i32(tmp);
-            }
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         }
         break;
     case 13: /* Misc data processing.  */
@@ -9915,22 +9955,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         if (op < 4 && (insn & 0xf000) != 0xf000)
             goto illegal_op;
         switch (op) {
-        case 0: /* Register controlled shift.  */
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            if ((insn & 0x70) != 0)
-                goto illegal_op;
-            /*
-             * 0b1111_1010_0xxx_xxxx_1111_xxxx_0000_xxxx:
-             *  - MOV, MOVS (register-shifted register), flagsetting
-             */
-            op = (insn >> 21) & 3;
-            logic_cc = (insn & (1 << 20)) != 0;
-            gen_arm_shift_reg(tmp, op, tmp2, logic_cc);
-            if (logic_cc)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-            break;
+        case 0: /* Register controlled shift, in decodetree */
+            goto illegal_op;
         case 1: /* Sign/zero extend.  */
             op = (insn >> 20) & 7;
             switch (op) {
@@ -10753,60 +10779,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index 2d84a02861..1db621576f 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -21,3 +21,87 @@
 # All of the insn that have a COND field in insn[31:28] are here.
 # All insns that have 0xf in insn[31:28] are in a32u.decode.
 #
+
+&s_rrr_shi       s rd rn rm shim shty
+&s_rrr_shr       s rn rd rm rs shty
+&s_rri_rot       s rn rd imm rot
+
+# Data-processing (register)
+
+@s_rrr_shi       ---- ... .... s:1 rn:4 rd:4 shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi
+@s_rxr_shi       ---- ... .... s:1 .... rd:4 shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi rn=0
+@S_xrr_shi       ---- ... .... .   rn:4 .... shim:5 shty:2 . rm:4 \
+                 &s_rrr_shi s=1 rd=0
+
+AND_rrri         .... 000 0000 . .... .... ..... .. 0 ....    @s_rrr_shi
+EOR_rrri         .... 000 0001 . .... .... ..... .. 0 ....    @s_rrr_shi
+SUB_rrri         .... 000 0010 . .... .... ..... .. 0 ....    @s_rrr_shi
+RSB_rrri         .... 000 0011 . .... .... ..... .. 0 ....    @s_rrr_shi
+ADD_rrri         .... 000 0100 . .... .... ..... .. 0 ....    @s_rrr_shi
+ADC_rrri         .... 000 0101 . .... .... ..... .. 0 ....    @s_rrr_shi
+SBC_rrri         .... 000 0110 . .... .... ..... .. 0 ....    @s_rrr_shi
+RSC_rrri         .... 000 0111 . .... .... ..... .. 0 ....    @s_rrr_shi
+TST_rrri         .... 000 1000 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+TEQ_rrri         .... 000 1001 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+CMP_rrri         .... 000 1010 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+CMN_rrri         .... 000 1011 1 .... 0000 ..... .. 0 ....    @S_xrr_shi
+ORR_rrri         .... 000 1100 . .... .... ..... .. 0 ....    @s_rrr_shi
+MOV_rrri         .... 000 1101 . 0000 .... ..... .. 0 ....    @s_rxr_shi
+BIC_rrri         .... 000 1110 . .... .... ..... .. 0 ....    @s_rrr_shi
+MVN_rrri         .... 000 1111 . 0000 .... ..... .. 0 ....    @s_rxr_shi
+
+# Data-processing (register-shifted register)
+
+@s_rrr_shr       ---- ... .... s:1 rn:4 rd:4 rs:4 . shty:2 . rm:4 \
+                 &s_rrr_shr
+@s_rxr_shr       ---- ... .... s:1 .... rd:4 rs:4 . shty:2 . rm:4 \
+                 &s_rrr_shr rn=0
+@S_xrr_shr       ---- ... .... .   rn:4 .... rs:4 . shty:2 . rm:4 \
+                 &s_rrr_shr rd=0 s=1
+
+AND_rrrr         .... 000 0000 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+EOR_rrrr         .... 000 0001 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+SUB_rrrr         .... 000 0010 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+RSB_rrrr         .... 000 0011 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+ADD_rrrr         .... 000 0100 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+ADC_rrrr         .... 000 0101 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+SBC_rrrr         .... 000 0110 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+RSC_rrrr         .... 000 0111 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+TST_rrrr         .... 000 1000 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+TEQ_rrrr         .... 000 1001 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+CMP_rrrr         .... 000 1010 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+CMN_rrrr         .... 000 1011 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+ORR_rrrr         .... 000 1100 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+MOV_rrrr         .... 000 1101 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
+BIC_rrrr         .... 000 1110 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+MVN_rrrr         .... 000 1111 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
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
+TST_rri          .... 001 1000 1 .... 0000 ............       @S_xri_rot
+TEQ_rri          .... 001 1001 1 .... 0000 ............       @S_xri_rot
+CMP_rri          .... 001 1010 1 .... 0000 ............       @S_xri_rot
+CMN_rri          .... 001 1011 1 .... 0000 ............       @S_xri_rot
+ORR_rri          .... 001 1100 . .... .... ............       @s_rri_rot
+MOV_rri          .... 001 1101 . 0000 .... ............       @s_rxi_rot
+BIC_rri          .... 001 1110 . .... .... ............       @s_rri_rot
+MVN_rri          .... 001 1111 . 0000 .... ............       @s_rxi_rot
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index ac01fb6958..7bfd8ee854 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -18,3 +18,94 @@
 #
 # This file is processed by scripts/decodetree.py
 #
+
+&s_rrr_shi       !extern s rd rn rm shim shty
+&s_rrr_shr       !extern s rn rd rm rs shty
+&s_rri_rot       !extern s rn rd imm rot
+
+# Data-processing (register-shifted register)
+
+MOV_rrrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
+                 &s_rrr_shr rn=0
+
+# Data-processing (register)
+
+%imm5_12_6       12:3 6:2
+
+@s_rrr_shi       ....... .... s:1 rn:4 .... rd:4 .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6
+@s_rxr_shi       ....... .... s:1 .... .... rd:4 .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6 rn=0
+@S_xrr_shi       ....... .... .   rn:4 .... .... .. shty:2 rm:4 \
+                 &s_rrr_shi shim=%imm5_12_6 s=1 rd=0
+
+{
+  TST_rrri       1110101 0000 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  AND_rrri       1110101 0000 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+BIC_rrri         1110101 0001 . .... 0 ... .... .... ....     @s_rrr_shi
+{
+  MOV_rrri       1110101 0010 . 1111 0 ... .... .... ....     @s_rxr_shi
+  ORR_rrri       1110101 0010 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+{
+  MVN_rrri       1110101 0011 . 1111 0 ... .... .... ....     @s_rxr_shi
+  ORN_rrri       1110101 0011 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+{
+  TEQ_rrri       1110101 0100 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  EOR_rrri       1110101 0100 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+# PKHBT, PKHTB at opc1 = 0110
+{
+  CMN_rrri       1110101 1000 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  ADD_rrri       1110101 1000 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+ADC_rrri         1110101 1010 . .... 0 ... .... .... ....     @s_rrr_shi
+SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
+{
+  CMP_rrri       1110101 1101 1 .... 0 ... 1111 .... ....     @S_xrr_shi
+  SUB_rrri       1110101 1101 . .... 0 ... .... .... ....     @s_rrr_shi
+}
+RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
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
+  TST_rri        1111 0.0 0000 1 .... 0 ... 1111 ........     @S_xri_rot
+  AND_rri        1111 0.0 0000 . .... 0 ... .... ........     @s_rri_rot
+}
+BIC_rri          1111 0.0 0001 . .... 0 ... .... ........     @s_rri_rot
+{
+  MOV_rri        1111 0.0 0010 . 1111 0 ... .... ........     @s_rxi_rot
+  ORR_rri        1111 0.0 0010 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  MVN_rri        1111 0.0 0011 . 1111 0 ... .... ........     @s_rxi_rot
+  ORN_rri        1111 0.0 0011 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  TEQ_rri        1111 0.0 0100 1 .... 0 ... 1111 ........     @S_xri_rot
+  EOR_rri        1111 0.0 0100 . .... 0 ... .... ........     @s_rri_rot
+}
+{
+  CMN_rri        1111 0.0 1000 1 .... 0 ... 1111 ........     @S_xri_rot
+  ADD_rri        1111 0.0 1000 . .... 0 ... .... ........     @s_rri_rot
+}
+ADC_rri          1111 0.0 1010 . .... 0 ... .... ........     @s_rri_rot
+SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
+{
+  CMP_rri        1111 0.0 1101 1 .... 0 ... 1111 ........     @S_xri_rot
+  SUB_rri        1111 0.0 1101 . .... 0 ... .... ........     @s_rri_rot
+}
+RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
-- 
2.17.1


