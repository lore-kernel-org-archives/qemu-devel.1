Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B235C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70A12087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRigrk3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70A12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpVd-0004kp-2E
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLu-0001MQ-3P
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLs-00062d-FM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:09 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLs-00061x-98
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:08 -0400
Received: by mail-pl1-x644.google.com with SMTP id go14so1586048plb.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4Nawwn1CWQIrW/uHwTKLseXI15oBdHOjRF/v0JlzLb8=;
 b=oRigrk3owLUYDN0e9JS3SZYVzI3H3b3EZczrFC0wYeRZlcxirqZQhM1nkoGvs4wsQI
 pD2eH2Ej6Ek7FhRj2I58TTszcKI75RUSnXJw+yIIVbo873ZVhhDG62Oqdsu2gqU/JfBy
 RKgNjAIFLx10TT4y8nhVaYLL45ej/0j4qE8G0AFNVC35Ldpg1E4pDG1dFTHd/DpUYQ38
 0SeiG1bweq+r/H1Vm7DV0ECY9nHDXeZMY4VupVvTOVC8NagFgo9RpgxwtGq4qR8r4ft2
 jFoNcz7Y0msWYq2gpwGE6CZ0rUq8ERJhCAcTfEIuoI29BmH3N+EiVo1glVSUdH/0isXO
 SA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4Nawwn1CWQIrW/uHwTKLseXI15oBdHOjRF/v0JlzLb8=;
 b=i9DXRIaetINmvBZWDSOQzwFLazKv2G1tqBesnMw1enXHIU0svuLJrehbjSFUpi4fAR
 pkydtEcJb4rLMMkZJDmfRJjVdXTTTYawr9vDxT7LlRyG/0bXxbMfFfF9YqDnKgAfLPvi
 +L7SkaH4H+y0KTXPdP3Oi40t3qDdiUA1XU359Vn8cmaSKVCUiyz44o4uJ3XZ8RGHOdE2
 4xYMoebJJbrOw4+b660k9lJCLRpwPuRls32gzqsI5bP2aeNVA8ctydSCp6/XKGc9IIlb
 2r4SoRw4ZGQQQtcLLfxwhY7BQAjzDgW2GACIpnNRRJOgn4r32hP16gmT/ZHgHMtgYlxn
 iY7g==
X-Gm-Message-State: APjAAAXeRq1ndy9BZlsI2VFayrlQktTkDK38u8WVw9rLkTMpCX43QkAx
 183HnA5ZtSEwchS+YcMZzq/Mitgxvik=
X-Google-Smtp-Source: APXvYqxEjmCDx25t25J4uRLEFka37UjRZuEhFOgkzehQfQcX63NMoJrNb6XtvygkDMkDcgQuIBu6UA==
X-Received: by 2002:a17:902:2d03:: with SMTP id
 o3mr18043863plb.96.1566250687019; 
 Mon, 19 Aug 2019 14:38:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:55 -0700
Message-Id: <20190819213755.26175-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 08/68] target/arm: Convert Saturating
 addition and subtraction
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
 target/arm/translate.c | 75 +++++++++++++++++++++++++++---------------
 target/arm/a32.decode  | 10 ++++++
 target/arm/t32.decode  |  9 +++++
 3 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 82bd207799..b731e08fe4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8099,6 +8099,48 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
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
+
 /*
  * Legacy decoder.
  */
@@ -8508,21 +8550,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
-                gen_helper_add_saturate(tmp2, cpu_env, tmp2, tmp2);
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
@@ -9989,18 +10020,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             op = ((insn >> 17) & 0x38) | ((insn >> 4) & 7);
             if (op < 4) {
                 /* Saturating add/subtract.  */
-                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                    goto illegal_op;
-                }
-                tmp = load_reg(s, rn);
-                tmp2 = load_reg(s, rm);
-                if (op & 1)
-                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp);
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
index 87bbb2eec2..7791be5590 100644
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
index 40cc69aee3..7c6226e0af 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
+&rrr             !extern rd rn rm
 
 # Data-processing (register)
 
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


