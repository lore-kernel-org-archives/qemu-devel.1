Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E5A21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kguO3AG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E5A21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bLZ-0002SJ-Dq
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0D-0004kR-1m
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b09-0002Tm-BB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:36 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b08-0002Si-U1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:33 -0400
Received: by mail-pl1-x643.google.com with SMTP id k1so2685007pls.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8O9yVa1OdaQBLBtEP/sB66vbD+5ooxIYXjeV2VOkFhs=;
 b=kguO3AG/5YwVV4r2PmvWdd7TjGxdZnp4R6GaBrpZzl1lhlta0iZowB54f3Wnge16mm
 XOjTxiRabsj4CdMv/I1MOHANJSR9avdMmtPL5j+9mIF0RlGY8u3tHUnbuU2i2ooOavMW
 oxTZmISxBhYPX+LiA602RgR1enPvinvyULyI/KypUJFKmtYS9+CcyeIrmUFzsi78onwX
 FW0m3HJ5qzh5M6BUETOcLJ0YvWs1iVxh7uF9aHlrmXZcqf/W/fts2jinuGM06bDVv2aB
 uxRId3oPVS0IlI8k/k6quc6tm8eKx0Inp1Yqx1mZrTwWpl0njo9HtmyQsnKQ26M3Oc+6
 ypJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8O9yVa1OdaQBLBtEP/sB66vbD+5ooxIYXjeV2VOkFhs=;
 b=fUrrU4fwx8PKG9zJ+YoZw6xtWcIxtua0T2gZX/SGCPY4PEZq11BclxTfSFm3GftLfe
 I91wyg8DCTkJN78G0oih2wCV58VgKTfPHIvECpV71Entqgwjqwf5ojJI2IA5KndmPfPs
 wtaB08A7LuZafiDyzBhaOUJyfHBjPrSIDPZ9uJ+4QqqT12C8NKRFZOgy2YgOcEXNaZvj
 xKOIu50FQXQkCqeY+7BB0pmxX5oTvEPj2NigJWTgUoiqGAF0VcJyqNab1q62sG+wF7a5
 NeI8jckcP0wp94YFNYz5/1bhHJFXj88uaH0oY9iblVgFVDcyPm/SfeNZUFCNFmGk9/Ea
 RFdQ==
X-Gm-Message-State: APjAAAWvEXt66Wbm4EdZsBvvG/pAzmB2Voop+GvpAM7OzE4HAHGKs2qD
 m6pyWTlq6UaITucjhycOIGSUOFTAfqI=
X-Google-Smtp-Source: APXvYqxFyieuXM7VHV+JsobstH/5EZKtddm5gijyFENn25rhX+ZjOVFwxwKVkULdDgefDxMbLmau0w==
X-Received: by 2002:a17:902:9a41:: with SMTP id
 x1mr43370078plv.88.1567625491470; 
 Wed, 04 Sep 2019 12:31:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:14 -0700
Message-Id: <20190904193059.26202-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 24/69] target/arm: Convert Parallel addition
 and subtraction
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
 target/arm/translate.c | 229 ++++++++++++++++++++---------------------
 target/arm/a32.decode  |  44 ++++++++
 target/arm/t32.decode  |  44 ++++++++
 3 files changed, 200 insertions(+), 117 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1c50ea232a..181d3d77f0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -648,99 +648,6 @@ static inline void gen_arm_shift_reg(TCGv_i32 var, int shiftop,
     tcg_temp_free_i32(shift);
 }
 
-#define PAS_OP(pfx) \
-    switch (op2) {  \
-    case 0: gen_pas_helper(glue(pfx,add16)); break; \
-    case 1: gen_pas_helper(glue(pfx,addsubx)); break; \
-    case 2: gen_pas_helper(glue(pfx,subaddx)); break; \
-    case 3: gen_pas_helper(glue(pfx,sub16)); break; \
-    case 4: gen_pas_helper(glue(pfx,add8)); break; \
-    case 7: gen_pas_helper(glue(pfx,sub8)); break; \
-    }
-static void gen_arm_parallel_addsub(int op1, int op2, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_ptr tmp;
-
-    switch (op1) {
-#define gen_pas_helper(name) glue(gen_helper_,name)(a, a, b, tmp)
-    case 1:
-        tmp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tmp, cpu_env, offsetof(CPUARMState, GE));
-        PAS_OP(s)
-        tcg_temp_free_ptr(tmp);
-        break;
-    case 5:
-        tmp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tmp, cpu_env, offsetof(CPUARMState, GE));
-        PAS_OP(u)
-        tcg_temp_free_ptr(tmp);
-        break;
-#undef gen_pas_helper
-#define gen_pas_helper(name) glue(gen_helper_,name)(a, a, b)
-    case 2:
-        PAS_OP(q);
-        break;
-    case 3:
-        PAS_OP(sh);
-        break;
-    case 6:
-        PAS_OP(uq);
-        break;
-    case 7:
-        PAS_OP(uh);
-        break;
-#undef gen_pas_helper
-    }
-}
-#undef PAS_OP
-
-/* For unknown reasons Arm and Thumb-2 use arbitrarily different encodings.  */
-#define PAS_OP(pfx) \
-    switch (op1) {  \
-    case 0: gen_pas_helper(glue(pfx,add8)); break; \
-    case 1: gen_pas_helper(glue(pfx,add16)); break; \
-    case 2: gen_pas_helper(glue(pfx,addsubx)); break; \
-    case 4: gen_pas_helper(glue(pfx,sub8)); break; \
-    case 5: gen_pas_helper(glue(pfx,sub16)); break; \
-    case 6: gen_pas_helper(glue(pfx,subaddx)); break; \
-    }
-static void gen_thumb2_parallel_addsub(int op1, int op2, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_ptr tmp;
-
-    switch (op2) {
-#define gen_pas_helper(name) glue(gen_helper_,name)(a, a, b, tmp)
-    case 0:
-        tmp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tmp, cpu_env, offsetof(CPUARMState, GE));
-        PAS_OP(s)
-        tcg_temp_free_ptr(tmp);
-        break;
-    case 4:
-        tmp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tmp, cpu_env, offsetof(CPUARMState, GE));
-        PAS_OP(u)
-        tcg_temp_free_ptr(tmp);
-        break;
-#undef gen_pas_helper
-#define gen_pas_helper(name) glue(gen_helper_,name)(a, a, b)
-    case 1:
-        PAS_OP(q);
-        break;
-    case 2:
-        PAS_OP(sh);
-        break;
-    case 5:
-        PAS_OP(uq);
-        break;
-    case 6:
-        PAS_OP(uh);
-        break;
-#undef gen_pas_helper
-    }
-}
-#undef PAS_OP
-
 /*
  * Generate a conditional based on ARM condition code cc.
  * This is common between ARM and Aarch64 targets.
@@ -9318,6 +9225,114 @@ static bool trans_UDF(DisasContext *s, arg_UDF *a)
     return true;
 }
 
+/*
+ * Parallel addition and subtraction
+ */
+
+static bool op_par_addsub(DisasContext *s, arg_rrr *a,
+                          void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 t0, t1;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rn);
+    t1 = load_reg(s, a->rm);
+
+    gen(t0, t0, t1);
+
+    tcg_temp_free_i32(t1);
+    store_reg(s, a->rd, t0);
+    return true;
+}
+
+static bool op_par_addsub_ge(DisasContext *s, arg_rrr *a,
+                             void (*gen)(TCGv_i32, TCGv_i32,
+                                         TCGv_i32, TCGv_ptr))
+{
+    TCGv_i32 t0, t1;
+    TCGv_ptr ge;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rn);
+    t1 = load_reg(s, a->rm);
+
+    ge = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ge, cpu_env, offsetof(CPUARMState, GE));
+    gen(t0, t0, t1, ge);
+
+    tcg_temp_free_ptr(ge);
+    tcg_temp_free_i32(t1);
+    store_reg(s, a->rd, t0);
+    return true;
+}
+
+#define DO_PAR_ADDSUB(NAME, helper) \
+static bool trans_##NAME(DisasContext *s, arg_rrr *a)   \
+{                                                       \
+    return op_par_addsub(s, a, helper);                 \
+}
+
+#define DO_PAR_ADDSUB_GE(NAME, helper) \
+static bool trans_##NAME(DisasContext *s, arg_rrr *a)   \
+{                                                       \
+    return op_par_addsub_ge(s, a, helper);              \
+}
+
+DO_PAR_ADDSUB_GE(SADD16, gen_helper_sadd16)
+DO_PAR_ADDSUB_GE(SASX, gen_helper_saddsubx)
+DO_PAR_ADDSUB_GE(SSAX, gen_helper_ssubaddx)
+DO_PAR_ADDSUB_GE(SSUB16, gen_helper_ssub16)
+DO_PAR_ADDSUB_GE(SADD8, gen_helper_sadd8)
+DO_PAR_ADDSUB_GE(SSUB8, gen_helper_ssub8)
+
+DO_PAR_ADDSUB_GE(UADD16, gen_helper_uadd16)
+DO_PAR_ADDSUB_GE(UASX, gen_helper_uaddsubx)
+DO_PAR_ADDSUB_GE(USAX, gen_helper_usubaddx)
+DO_PAR_ADDSUB_GE(USUB16, gen_helper_usub16)
+DO_PAR_ADDSUB_GE(UADD8, gen_helper_uadd8)
+DO_PAR_ADDSUB_GE(USUB8, gen_helper_usub8)
+
+DO_PAR_ADDSUB(QADD16, gen_helper_qadd16)
+DO_PAR_ADDSUB(QASX, gen_helper_qaddsubx)
+DO_PAR_ADDSUB(QSAX, gen_helper_qsubaddx)
+DO_PAR_ADDSUB(QSUB16, gen_helper_qsub16)
+DO_PAR_ADDSUB(QADD8, gen_helper_qadd8)
+DO_PAR_ADDSUB(QSUB8, gen_helper_qsub8)
+
+DO_PAR_ADDSUB(UQADD16, gen_helper_uqadd16)
+DO_PAR_ADDSUB(UQASX, gen_helper_uqaddsubx)
+DO_PAR_ADDSUB(UQSAX, gen_helper_uqsubaddx)
+DO_PAR_ADDSUB(UQSUB16, gen_helper_uqsub16)
+DO_PAR_ADDSUB(UQADD8, gen_helper_uqadd8)
+DO_PAR_ADDSUB(UQSUB8, gen_helper_uqsub8)
+
+DO_PAR_ADDSUB(SHADD16, gen_helper_shadd16)
+DO_PAR_ADDSUB(SHASX, gen_helper_shaddsubx)
+DO_PAR_ADDSUB(SHSAX, gen_helper_shsubaddx)
+DO_PAR_ADDSUB(SHSUB16, gen_helper_shsub16)
+DO_PAR_ADDSUB(SHADD8, gen_helper_shadd8)
+DO_PAR_ADDSUB(SHSUB8, gen_helper_shsub8)
+
+DO_PAR_ADDSUB(UHADD16, gen_helper_uhadd16)
+DO_PAR_ADDSUB(UHASX, gen_helper_uhaddsubx)
+DO_PAR_ADDSUB(UHSAX, gen_helper_uhsubaddx)
+DO_PAR_ADDSUB(UHSUB16, gen_helper_uhsub16)
+DO_PAR_ADDSUB(UHADD8, gen_helper_uhadd8)
+DO_PAR_ADDSUB(UHSUB8, gen_helper_uhsub8)
+
+#undef DO_PAR_ADDSUB
+#undef DO_PAR_ADDSUB_GE
+
 /*
  * Legacy decoder.
  */
@@ -9630,16 +9645,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 rs = (insn >> 8) & 0xf;
                 switch ((insn >> 23) & 3) {
                 case 0: /* Parallel add/subtract.  */
-                    op1 = (insn >> 20) & 7;
-                    tmp = load_reg(s, rn);
-                    tmp2 = load_reg(s, rm);
-                    sh = (insn >> 5) & 7;
-                    if ((op1 & 3) == 0 || sh == 5 || sh == 6)
-                        goto illegal_op;
-                    gen_arm_parallel_addsub(op1, sh, tmp, tmp2);
-                    tcg_temp_free_i32(tmp2);
-                    store_reg(s, rd, tmp);
-                    break;
+                    /* Done by decodetree */
+                    goto illegal_op;
                 case 1:
                     if ((insn & 0x00700020) == 0) {
                         /* Halfword pack.  */
@@ -10432,20 +10439,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             store_reg(s, rd, tmp);
             break;
-        case 2: /* SIMD add/subtract.  */
-            if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                goto illegal_op;
-            }
-            op = (insn >> 20) & 7;
-            shift = (insn >> 4) & 7;
-            if ((op & 3) == 3 || (shift & 3) == 3)
-                goto illegal_op;
-            tmp = load_reg(s, rn);
-            tmp2 = load_reg(s, rm);
-            gen_thumb2_parallel_addsub(op, shift, tmp, tmp2);
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
-            break;
+        case 2: /* SIMD add/subtract, in decodetree */
+            goto illegal_op;
         case 3: /* Other data processing.  */
             op = ((insn >> 17) & 0x38) | ((insn >> 4) & 7);
             if (op < 4) {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 285c08ca22..4dfd8133f7 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -410,3 +410,47 @@ BFCI             ---- 0111 110 msb:5 rd:4 lsb:5 001 rn:4      &bfi
 # While we could get UDEF by not including this, add the pattern for
 # documentation and to conflict with any other typos in this file.
 UDF              1110 0111 1111 ---- ---- ---- 1111 ----
+
+# Parallel addition and subtraction
+
+SADD16           .... 0110 0001 .... .... 1111 0001 ....      @rndm
+SASX             .... 0110 0001 .... .... 1111 0011 ....      @rndm
+SSAX             .... 0110 0001 .... .... 1111 0101 ....      @rndm
+SSUB16           .... 0110 0001 .... .... 1111 0111 ....      @rndm
+SADD8            .... 0110 0001 .... .... 1111 1001 ....      @rndm
+SSUB8            .... 0110 0001 .... .... 1111 1111 ....      @rndm
+
+QADD16           .... 0110 0010 .... .... 1111 0001 ....      @rndm
+QASX             .... 0110 0010 .... .... 1111 0011 ....      @rndm
+QSAX             .... 0110 0010 .... .... 1111 0101 ....      @rndm
+QSUB16           .... 0110 0010 .... .... 1111 0111 ....      @rndm
+QADD8            .... 0110 0010 .... .... 1111 1001 ....      @rndm
+QSUB8            .... 0110 0010 .... .... 1111 1111 ....      @rndm
+
+SHADD16          .... 0110 0011 .... .... 1111 0001 ....      @rndm
+SHASX            .... 0110 0011 .... .... 1111 0011 ....      @rndm
+SHSAX            .... 0110 0011 .... .... 1111 0101 ....      @rndm
+SHSUB16          .... 0110 0011 .... .... 1111 0111 ....      @rndm
+SHADD8           .... 0110 0011 .... .... 1111 1001 ....      @rndm
+SHSUB8           .... 0110 0011 .... .... 1111 1111 ....      @rndm
+
+UADD16           .... 0110 0101 .... .... 1111 0001 ....      @rndm
+UASX             .... 0110 0101 .... .... 1111 0011 ....      @rndm
+USAX             .... 0110 0101 .... .... 1111 0101 ....      @rndm
+USUB16           .... 0110 0101 .... .... 1111 0111 ....      @rndm
+UADD8            .... 0110 0101 .... .... 1111 1001 ....      @rndm
+USUB8            .... 0110 0101 .... .... 1111 1111 ....      @rndm
+
+UQADD16          .... 0110 0110 .... .... 1111 0001 ....      @rndm
+UQASX            .... 0110 0110 .... .... 1111 0011 ....      @rndm
+UQSAX            .... 0110 0110 .... .... 1111 0101 ....      @rndm
+UQSUB16          .... 0110 0110 .... .... 1111 0111 ....      @rndm
+UQADD8           .... 0110 0110 .... .... 1111 1001 ....      @rndm
+UQSUB8           .... 0110 0110 .... .... 1111 1111 ....      @rndm
+
+UHADD16          .... 0110 0111 .... .... 1111 0001 ....      @rndm
+UHASX            .... 0110 0111 .... .... 1111 0011 ....      @rndm
+UHSAX            .... 0110 0111 .... .... 1111 0101 ....      @rndm
+UHSUB16          .... 0110 0111 .... .... 1111 0111 ....      @rndm
+UHADD8           .... 0110 0111 .... .... 1111 1001 ....      @rndm
+UHSUB8           .... 0110 0111 .... .... 1111 1111 ....      @rndm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 682fc5c2c4..c899c56766 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -457,3 +457,47 @@ LDAEXD_t32       1110 1000 1101 .... .... .... 1111 1111      @ldrex_d
 LDA              1110 1000 1101 .... .... 1111 1010 1111      @ldrex_0
 LDAB             1110 1000 1101 .... .... 1111 1000 1111      @ldrex_0
 LDAH             1110 1000 1101 .... .... 1111 1001 1111      @ldrex_0
+
+# Parallel addition and subtraction
+
+SADD8            1111 1010 1000 .... 1111 .... 0000 ....      @rndm
+QADD8            1111 1010 1000 .... 1111 .... 0001 ....      @rndm
+SHADD8           1111 1010 1000 .... 1111 .... 0010 ....      @rndm
+UADD8            1111 1010 1000 .... 1111 .... 0100 ....      @rndm
+UQADD8           1111 1010 1000 .... 1111 .... 0101 ....      @rndm
+UHADD8           1111 1010 1000 .... 1111 .... 0110 ....      @rndm
+
+SADD16           1111 1010 1001 .... 1111 .... 0000 ....      @rndm
+QADD16           1111 1010 1001 .... 1111 .... 0001 ....      @rndm
+SHADD16          1111 1010 1001 .... 1111 .... 0010 ....      @rndm
+UADD16           1111 1010 1001 .... 1111 .... 0100 ....      @rndm
+UQADD16          1111 1010 1001 .... 1111 .... 0101 ....      @rndm
+UHADD16          1111 1010 1001 .... 1111 .... 0110 ....      @rndm
+
+SASX             1111 1010 1010 .... 1111 .... 0000 ....      @rndm
+QASX             1111 1010 1010 .... 1111 .... 0001 ....      @rndm
+SHASX            1111 1010 1010 .... 1111 .... 0010 ....      @rndm
+UASX             1111 1010 1010 .... 1111 .... 0100 ....      @rndm
+UQASX            1111 1010 1010 .... 1111 .... 0101 ....      @rndm
+UHASX            1111 1010 1010 .... 1111 .... 0110 ....      @rndm
+
+SSUB8            1111 1010 1100 .... 1111 .... 0000 ....      @rndm
+QSUB8            1111 1010 1100 .... 1111 .... 0001 ....      @rndm
+SHSUB8           1111 1010 1100 .... 1111 .... 0010 ....      @rndm
+USUB8            1111 1010 1100 .... 1111 .... 0100 ....      @rndm
+UQSUB8           1111 1010 1100 .... 1111 .... 0101 ....      @rndm
+UHSUB8           1111 1010 1100 .... 1111 .... 0110 ....      @rndm
+
+SSUB16           1111 1010 1101 .... 1111 .... 0000 ....      @rndm
+QSUB16           1111 1010 1101 .... 1111 .... 0001 ....      @rndm
+SHSUB16          1111 1010 1101 .... 1111 .... 0010 ....      @rndm
+USUB16           1111 1010 1101 .... 1111 .... 0100 ....      @rndm
+UQSUB16          1111 1010 1101 .... 1111 .... 0101 ....      @rndm
+UHSUB16          1111 1010 1101 .... 1111 .... 0110 ....      @rndm
+
+SSAX             1111 1010 1110 .... 1111 .... 0000 ....      @rndm
+QSAX             1111 1010 1110 .... 1111 .... 0001 ....      @rndm
+SHSAX            1111 1010 1110 .... 1111 .... 0010 ....      @rndm
+USAX             1111 1010 1110 .... 1111 .... 0100 ....      @rndm
+UQSAX            1111 1010 1110 .... 1111 .... 0101 ....      @rndm
+UHSAX            1111 1010 1110 .... 1111 .... 0110 ....      @rndm
-- 
2.17.1


