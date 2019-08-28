Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54089C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D221214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ir7AL9XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D221214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Ro-0005xW-P3
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fp-00035j-1K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fm-0008Er-Nc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:44922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fm-0008C8-Ag
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id t14so383255plr.11
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=apUZtrcjAYHXG/DQT2c+ZwTy4vc4Zs/04QzrnC09KMU=;
 b=Ir7AL9XV3kNXVaH++R0efXidOYFM+YEbzXUVUFviVSzBoJufOdHnVPdMMfVIviYxOQ
 aKC8hIEOlqR8O9GlVg4NYZSzS8AUizCU/KJEJk+4c1hN1+F641N2rB9ths/gBmHO5rse
 f5nXGeo0v4h9M+a8tZO6GQuat/azQm/oTvoh7pYJzKq/LzUm2xqfiwh5AaOUTvywKMHm
 PqTlexMH0UImdyHGD1mWEvPkEzUGqEtvOqeCVOe6/FtaqXUKXiu4tVQ9Op2kIyeirbxW
 aZQkff6gmQcDcK20QJZnV/vOBQcCBWEFXX33FjpMAdY/QACVQTMc7YxtV8oIaLmJV3si
 uXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=apUZtrcjAYHXG/DQT2c+ZwTy4vc4Zs/04QzrnC09KMU=;
 b=TmhkhSSZIiBmsIhs9WlZY0CLCCZkvv4sIil00bfVoUbVUZHezRGOpMR7ESUHl8yCIU
 DXgMxjhbhqU6E468Z+ovnD94nMStqSt5Z3ID4wJZAL5mulxqyXTyx1g4VMISaYhqlQYb
 p+s+xojPRxmgwSWRY0K+qPA/IIBziQaU8xjda4XQugAkzoqrlJplDF57P8v+JknH0GYm
 FOvDhWwnTiMN8Buv6aPnhnb2hLqDQTJKGRcgEIHwjx+dtWrXdq9Wbkp4HYnk1ItyPVM1
 AROzSVCQ924hkndO1QeWZwleBfVigaiNubRaBPrLBs4SRGqXIAInXfivVEsuJ/H3U4jh
 gHAA==
X-Gm-Message-State: APjAAAXRJMSYKoZ0BgZVpxWJvFvgeNIr5l5nVnXMvOHMowPI5ojL26Pp
 9zSMzni49X4+DxX99I+QDTEeJjlmLsI=
X-Google-Smtp-Source: APXvYqydoizcLmyNMHIF7SVnyzRBiENSaui9sxMheyXW7DoTGgSNQhMoQNGmN4JWUVwLaoxDKDVjUg==
X-Received: by 2002:a17:902:e60c:: with SMTP id
 cm12mr5940821plb.304.1567019108864; 
 Wed, 28 Aug 2019 12:05:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:55 -0700
Message-Id: <20190828190456.30315-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH v3 08/69] target/arm: Convert Saturating
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 75 +++++++++++++++++++++++++++---------------
 target/arm/a32.decode  | 10 ++++++
 target/arm/t32.decode  |  9 +++++
 3 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 17659627b1..70bbad48fc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8102,6 +8102,48 @@ static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
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
@@ -8511,21 +8553,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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


