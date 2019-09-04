Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494EC208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaRIVmJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494EC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5b5y-0001cE-V0
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azm-00047x-Fu
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azk-00025y-4T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azj-00024g-Qo
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id d15so4397594pfo.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Jry4oWswzAPXeBy/WDcBrZ1+10Lxn1DFEJfUkAP4P00=;
 b=kaRIVmJQlGcC7fofMY4bXSi62XONCG/gw7TdtihxGNdETO6Bjn4Nssr6TLKDNsgVKV
 lGI7WBfmr1wPN6sJtIQJPg/jHOnWIFcBFnnjvOym5WaElNZGkNAYhnrvXL7otqIkrO6a
 r9m5QjEFhfjplM6qbIfRE3ZmYtYuzEMJdv53AYQtwah5ocGJiUsY81Jbvn33bj00INZI
 L50ZFJ4DJdH9xnOZ9heoFojJssIHIbrKeze3thvFUGvfh8/Ws21YQY2tRXot/kloiy8s
 iQ9Hs6e0bZmifJTfXG4zOMcJc5POW5QTBFpe/KxZEtYVkwshCzuicO4XTomz46i8rX9p
 5JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Jry4oWswzAPXeBy/WDcBrZ1+10Lxn1DFEJfUkAP4P00=;
 b=o5eAr+eYlJ8qTGk9QwxRDA1wW5x+u0KlSJSv4qfOln2foZIv+kj8w0uiNv6gX1ynxU
 sGJj8ejoWKh5tbDeilBP7vGPakzocurY6LCodDQEYYVWuY4DSSHiYA5ksTiT5rktMEqs
 d9Wd/0zcqHGRMUwTH3zfpQwc8hQuaQpaTB1mXHpyNDC+u/fgK0tC1YyI9sF0rl+rGTMR
 5KiNsvvXqlRbl+T/5MvaDMZXD5mK0KEiThO2NUyX6DJJNeIshac407cGQ9gWskxGAVOD
 inT8p8Icnk0/DR4rPU9YF03eEASlrcZWHrNwdAUzK/DPOnjBQGisowjGqlnuNKQRYf1G
 4oGg==
X-Gm-Message-State: APjAAAVKRe1uRiZFwKYCCNvjLUv52DaF6M4gh6aGE0fZxGikndWR+hfB
 D2WRoqIwGLStYckpqPrzJuPt8U+iLXE=
X-Google-Smtp-Source: APXvYqwvttWCHoclzCV4SG2gipL6osx0TGua8brelxF3p+ExBlmunu77mcMwqS1KT4cx9B5JnqDQtA==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr37646975pgo.64.1567625466391; 
 Wed, 04 Sep 2019 12:31:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:29:54 -0700
Message-Id: <20190904193059.26202-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 04/69] target/arm: Convert Data Processing
 (reg-shifted-reg)
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

Convert the register shifted by register form of the data
processing insns.  For A32, we cannot yet remove any code
because the legacy decoder intertwines the immediate form.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 74 ++++++++++++++++++++++++++++++------------
 target/arm/a32.decode  | 27 +++++++++++++++
 target/arm/t32.decode  |  6 ++++
 3 files changed, 87 insertions(+), 20 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cb97f5b22d..ff78b1bb74 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7795,17 +7795,66 @@ static bool op_s_rxr_shi(DisasContext *s, arg_s_rrr_shi *a,
     return store_reg_kind(s, a->rd, tmp, kind);
 }
 
+/*
+ * Data-processing (register-shifted register)
+ *
+ * Operate, with set flags, one register source,
+ * one register shifted register source, and a destination.
+ */
+static bool op_s_rrr_shr(DisasContext *s, arg_s_rrr_shr *a,
+                         void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
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
+    return store_reg_kind(s, a->rd, tmp1, kind);
+}
+
+static bool op_s_rxr_shr(DisasContext *s, arg_s_rrr_shr *a,
+                         void (*gen)(TCGv_i32, TCGv_i32),
+                         int logic_cc, StoreRegKind kind)
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
+    return store_reg_kind(s, a->rd, tmp2, kind);
+}
+
 #define DO_ANY3(NAME, OP, L, K)                                         \
     static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)  \
-    { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }
+    { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }      \
+    static bool trans_##NAME##_rrrr(DisasContext *s, arg_s_rrr_shr *a)  \
+    { StoreRegKind k = (K); return op_s_rrr_shr(s, a, OP, L, k); }
 
 #define DO_ANY2(NAME, OP, L, K)                                         \
     static bool trans_##NAME##_rxri(DisasContext *s, arg_s_rrr_shi *a)  \
-    { StoreRegKind k = (K); return op_s_rxr_shi(s, a, OP, L, k); }
+    { StoreRegKind k = (K); return op_s_rxr_shi(s, a, OP, L, k); }      \
+    static bool trans_##NAME##_rxrr(DisasContext *s, arg_s_rrr_shr *a)  \
+    { StoreRegKind k = (K); return op_s_rxr_shr(s, a, OP, L, k); }
 
 #define DO_CMP2(NAME, OP, L)                                            \
     static bool trans_##NAME##_xrri(DisasContext *s, arg_s_rrr_shi *a)  \
-    { return op_s_rrr_shi(s, a, OP, L, STREG_NONE); }
+    { return op_s_rrr_shi(s, a, OP, L, STREG_NONE); }                   \
+    static bool trans_##NAME##_xrrr(DisasContext *s, arg_s_rrr_shr *a)  \
+    { return op_s_rrr_shr(s, a, OP, L, STREG_NONE); }
 
 DO_ANY3(AND, tcg_gen_and_i32, a->s, STREG_NORMAL)
 DO_ANY3(EOR, tcg_gen_xor_i32, a->s, STREG_NORMAL)
@@ -9590,7 +9639,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 addr;
     TCGv_i64 tmp64;
     int op;
-    int logic_cc;
 
     /*
      * ARMv6-M supports a limited subset of Thumb2 instructions.
@@ -10028,22 +10076,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index b23e83f17c..8e0fb06d05 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -23,6 +23,7 @@
 #
 
 &s_rrr_shi       s rd rn rm shim shty
+&s_rrr_shr       s rn rd rm rs shty
 
 # Data-processing (register)
 
@@ -49,3 +50,29 @@ ORR_rrri         .... 000 1100 . .... .... ..... .. 0 ....    @s_rrr_shi
 MOV_rxri         .... 000 1101 . 0000 .... ..... .. 0 ....    @s_rxr_shi
 BIC_rrri         .... 000 1110 . .... .... ..... .. 0 ....    @s_rrr_shi
 MVN_rxri         .... 000 1111 . 0000 .... ..... .. 0 ....    @s_rxr_shi
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
+TST_xrrr         .... 000 1000 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+TEQ_xrrr         .... 000 1001 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+CMP_xrrr         .... 000 1010 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+CMN_xrrr         .... 000 1011 1 .... 0000 .... 0 .. 1 ....   @S_xrr_shr
+ORR_rrrr         .... 000 1100 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+MOV_rxrr         .... 000 1101 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
+BIC_rrrr         .... 000 1110 . .... .... .... 0 .. 1 ....   @s_rrr_shr
+MVN_rxrr         .... 000 1111 . 0000 .... .... 0 .. 1 ....   @s_rxr_shr
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7068596b99..f0a73fa003 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -20,6 +20,7 @@
 #
 
 &s_rrr_shi       !extern s rd rn rm shim shty
+&s_rrr_shr       !extern s rn rd rm rs shty
 
 # Data-processing (register)
 
@@ -61,3 +62,8 @@ SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
   SUB_rrri       1110101 1101 . .... 0 ... .... .... ....     @s_rrr_shi
 }
 RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
+
+# Data-processing (register-shifted register)
+
+MOV_rxrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
+                 &s_rrr_shr rn=0
-- 
2.17.1


