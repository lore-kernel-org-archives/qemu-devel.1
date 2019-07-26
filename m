Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE67321842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWUgNkmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE67321842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4SB-0000fU-KQ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mq-0002id-Hs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mo-0007wV-Ul
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:56 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:46158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mo-0007nI-Nm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:54 -0400
Received: by mail-pg1-x52d.google.com with SMTP id k189so6067897pgk.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oJFhsjTpA90uLnkSb8PliACzOJvjF9fpzncu9tcD1hw=;
 b=aWUgNkmdWXEo6kR8q9PDUyX+wB7jKa/AFdJ6Jys42PvIqwzqopjF/6h/6ieaYqWvPv
 bmS1gdB5b93+PUfkw0nJgufPFpswf78rQdYN9LIvGkoAdmj+miV5T/IL/RofwvNzG1mq
 TBUX9h3WqEy6u9bcZZuKKmTj+17EmcuRn9f+3DqOo4ehAxSN03XEF2XU/AtEE8Mai4k+
 7n8TOPiHRtNuEWVnqcumd1oKgu2ISQ0OBpQba//8e3Hu8SuRnum7CLgbqZm2cpvzKuJY
 BUCu/4Fgdb5zcTH8BfxbXOv8926Gaw6SlnUIJa98zBOu7OTGOOCkvc65+GkvYPrlBAqF
 OOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oJFhsjTpA90uLnkSb8PliACzOJvjF9fpzncu9tcD1hw=;
 b=AvoEht9Vqntz2+A6ZYoZ4+G/Y9dlzeRLKZHSOvTaHTwSvXqXFpatNvRRaHbcr8CyO+
 Q0AYEGt7ulesUC1WzrYvZlxxAbTm/lfJV5bKl3BCXi1kebNMw1Ys5WvnWjdSf2wR7Ln3
 09ogLQReBNVuVcpKh/cQcKrhX8aY9D2umZ2i2PJALU8D6sByXZUmTGz/+8QFaErw/WxS
 pU1qZ+EsOfgf7iMmsDBl5wNrA/vN3gdqA8KeXDwENd89NB4nAM9tnfjPY2h6Ao3XUzmK
 jaRPEnTuTs9DBqwZ+/sTuPt16GJlsBjPZyhrNI53FeNnhcesCfeDCd/hGcaU8DVbtC1x
 Axrw==
X-Gm-Message-State: APjAAAVWgelOjOC7gZerAmE0glVfek1QRAofbGbt8O2rJMPD3HKwj/72
 xVxh4H9xPvYFhB8+I0YUcjEFaCNFf28=
X-Google-Smtp-Source: APXvYqwJzYMvqv4bmdcamzzmdTgWeG6TVMBHmDX5h5qRMb6yDbO5i8S4ee4+siw9TboP4O5IobLzcQ==
X-Received: by 2002:a17:90a:2023:: with SMTP id
 n32mr95173627pjc.3.1564163451357; 
 Fri, 26 Jul 2019 10:50:51 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:40 -0700
Message-Id: <20190726175032.6769-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH 15/67] target/arm: Convert Saturating addition
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h    |  1 -
 target/arm/op_helper.c | 15 ---------
 target/arm/translate.c | 74 +++++++++++++++++++++++++++---------------
 target/arm/a32.decode  | 10 ++++++
 target/arm/t32.decode  |  9 +++++
 5 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e..1fb2cb5a77 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -6,7 +6,6 @@ DEF_HELPER_3(add_saturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_saturate, i32, env, i32, i32)
 DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
-DEF_HELPER_2(double_saturate, i32, env, s32)
 DEF_HELPER_FLAGS_2(sdiv, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(udiv, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 1ab91f915e..142239b03a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -135,21 +135,6 @@ uint32_t HELPER(sub_saturate)(CPUARMState *env, uint32_t a, uint32_t b)
     return res;
 }
 
-uint32_t HELPER(double_saturate)(CPUARMState *env, int32_t val)
-{
-    uint32_t res;
-    if (val >= 0x40000000) {
-        res = ~SIGNBIT;
-        env->QF = 1;
-    } else if (val <= (int32_t)0xc0000000) {
-        res = SIGNBIT;
-        env->QF = 1;
-    } else {
-        res = val << 1;
-    }
-    return res;
-}
-
 uint32_t HELPER(add_usaturate)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 354a52d36c..85f829c1bb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8174,6 +8174,47 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
     return true;
 }
 
+/*
+ * Saturating addition and subtraction
+ */
+
+static bool op_qaddsub(DisasContext *s, arg_rrr *a, bool add, bool doub)
+{
+    TCGv_i32 t0, t1;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_5TE) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rm);
+    t1 = load_reg(s, a->rn);
+    if (doub) {
+        gen_helper_add_saturate(t1, cpu_env, t1, t1);
+    }
+    if (add) {
+        gen_helper_add_saturate(t0, cpu_env, t0, t1);
+    } else {
+        gen_helper_sub_saturate(t0, cpu_env, t0, t1);
+    }
+    tcg_temp_free_i32(t1);
+    store_reg(s, a->rd, t0);
+    return true;
+}
+
+#define DO_QADDSUB(NAME, ADD, DOUB) \
+static bool trans_##NAME(DisasContext *s, arg_rrr *a)    \
+{                                                        \
+    return op_qaddsub(s, a, ADD, DOUB);                  \
+}
+
+DO_QADDSUB(QADD, true, false)
+DO_QADDSUB(QSUB, false, false)
+DO_QADDSUB(QDADD, true, true)
+DO_QADDSUB(QDSUB, false, true)
+
+#undef DO_QADDSUB
 
 /*
  * Legacy decoder.
@@ -8582,21 +8623,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             store_reg(s, rd, tmp);
             break;
         }
-        case 0x5: /* saturating add/subtract */
-            ARCH(5TE);
-            rd = (insn >> 12) & 0xf;
-            rn = (insn >> 16) & 0xf;
-            tmp = load_reg(s, rm);
-            tmp2 = load_reg(s, rn);
-            if (op1 & 2)
-                gen_helper_double_saturate(tmp2, cpu_env, tmp2);
-            if (op1 & 1)
-                gen_helper_sub_saturate(tmp, cpu_env, tmp, tmp2);
-            else
-                gen_helper_add_saturate(tmp, cpu_env, tmp, tmp2);
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
-            break;
+        case 0x5:
+            /* Saturating addition and subtraction.  */
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         case 0x6: /* ERET */
             if (op1 != 3) {
                 goto illegal_op;
@@ -10070,18 +10100,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             op = ((insn >> 17) & 0x38) | ((insn >> 4) & 7);
             if (op < 4) {
                 /* Saturating add/subtract.  */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    goto illegal_op;
-                }
-                tmp = load_reg(s, rn);
-                tmp2 = load_reg(s, rm);
-                if (op & 1)
-                    gen_helper_double_saturate(tmp, cpu_env, tmp);
-                if (op & 2)
-                    gen_helper_sub_saturate(tmp, cpu_env, tmp2, tmp);
-                else
-                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
+                /* All done in decodetree.  Reach here for illegal ops.  */
+                goto illegal_op;
             } else {
                 switch (op) {
                 case 0x0a: /* rbit */
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 71846b79fd..af6712a9e8 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -27,6 +27,7 @@
 &s_rri_rot       s rn rd imm rot
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
+&rrr             rd rn rm
 
 # Data-processing (register)
 
@@ -122,3 +123,12 @@ UMULL            .... 0000 100 . .... .... .... 1001 ....     @s_rdamn
 UMLAL            .... 0000 101 . .... .... .... 1001 ....     @s_rdamn
 SMULL            .... 0000 110 . .... .... .... 1001 ....     @s_rdamn
 SMLAL            .... 0000 111 . .... .... .... 1001 ....     @s_rdamn
+
+# Saturating addition and subtraction
+
+@rndm            ---- .... .... rn:4 rd:4 .... .... rm:4      &rrr
+
+QADD             .... 0001 0000 .... .... 0000 0101 ....      @rndm
+QSUB             .... 0001 0010 .... .... 0000 0101 ....      @rndm
+QDADD            .... 0001 0100 .... .... 0000 0101 ....      @rndm
+QDSUB            .... 0001 0110 .... .... 0000 0101 ....      @rndm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 8e301ed2a1..7a27b5cc5c 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
+&rrr             !extern rd rn rm
 
 # Data-processing (register-shifted register)
 
@@ -117,6 +118,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
 @s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=0 s=0
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
+@rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
 
 {
   MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
@@ -128,3 +130,10 @@ UMULL            1111 1011 1010 .... .... .... 0000 ....      @s0_rnadm
 SMLAL            1111 1011 1100 .... .... .... 0000 ....      @s0_rnadm
 UMLAL            1111 1011 1110 .... .... .... 0000 ....      @s0_rnadm
 UMAAL            1111 1011 1110 .... .... .... 0110 ....      @rnadm
+
+# Data-processing (two source registers)
+
+QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
+QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
+QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
+QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
-- 
2.17.1


