Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A532173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIwwXksl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A532173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55007 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp2H-0005eC-R2
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozV-0007GR-HP
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozU-0001Kr-AB
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:29 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozU-0001KX-4z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so44710127pff.9
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vnbne/W2wov3KpmwjXJZkwuhxAhaLlZZtxHbTHDmpe4=;
 b=RIwwXkslgVIYPkHoDmBsybWghAJcH0UDGklI/tuE4EYGEe5a5mATL1CjdAja0LuDGd
 RuWX3hOAs7y5acmb8fY2Er2k2rGGq28CRuLqiTXpGgV//3/O+hhoH1CeQRcm300yyKR6
 4bnxb2DSv+MbAaUs3yoeD4UTuuPpaJS9XvSy4cT7uQXLvago1N7nSZd5gyjR7TeaLg1i
 f8qyU1EAOXWx6JUHbDmkwYTQ5f1X/jO7zeMstI8s29JOEljzeex9V6uLfcRmzmuBTS+m
 +H3be5ziHW0Oip2CsTZnVU7ATkJEXl2T65LTxCe9fxs5Hf3UWWdbHaHPtaKojJa5qgpJ
 +pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vnbne/W2wov3KpmwjXJZkwuhxAhaLlZZtxHbTHDmpe4=;
 b=X8lKjd1dUc9mpTV6p/gXprvB6vYfNf8qB4NFx+nIaYP8yg01jX6QgYCKotkZg67O5M
 kRZi/KKWJzbTy5V9J63h1ttAHBzd/ddPnQCTTXh65+t/OyUgYXqPxHs4HoP3D/lG1H1i
 X8zdIMC8rehyn6by9iiuZmAzdf4z3vmrcLNEwt1FjWuVrQgt1Pgn7sZJdXBMPzLyI3aJ
 KpmWJ+anZBc0FUmVJfQH38EPcuo5o3Ffpyl/6xJnGIZ/FyOtSi1KB4NTc3Y5qSePYtxy
 8sBep6llf+B1vyuPjqmFy+yLTCG5TaSk2vxJkXr4iX4TVWk3pwTfw3B5ADgT3VLlCazR
 VD8g==
X-Gm-Message-State: APjAAAWhbdWYMOtrxerKBBOA/056UakeWnhTWHg+7ASVs1fum2vivZBK
 dS0xcsTAlBpTDYiqe9NXMJgS3qG8ZwU=
X-Google-Smtp-Source: APXvYqweMZWhgG5RUAQ3DWddb6tRHcBzimB3t2gBAGpO/hDWx4+vHrT0+xw3DoBjlwTRuAZHneNHCQ==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr16838473pfh.56.1565295986728; 
 Thu, 08 Aug 2019 13:26:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:15 -0700
Message-Id: <20190808202616.13782-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 6/7] target/arm: Simplify SMMLA, SMMLAR, SMMLS,
 SMMLSR
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

All of the inputs to these instructions are 32-bits.  Rather than
extend each input to 64-bits and then extract the high 32-bits of
the output, use tcg_gen_muls2_i32 and other 32-bit generator functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 72 +++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ddc54e77e4..77154be743 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -391,34 +391,6 @@ static void gen_revsh(TCGv_i32 var)
     tcg_gen_ext16s_i32(var, var);
 }
 
-/* Return (b << 32) + a. Mark inputs as dead */
-static TCGv_i64 gen_addq_msw(TCGv_i64 a, TCGv_i32 b)
-{
-    TCGv_i64 tmp64 = tcg_temp_new_i64();
-
-    tcg_gen_extu_i32_i64(tmp64, b);
-    tcg_temp_free_i32(b);
-    tcg_gen_shli_i64(tmp64, tmp64, 32);
-    tcg_gen_add_i64(a, tmp64, a);
-
-    tcg_temp_free_i64(tmp64);
-    return a;
-}
-
-/* Return (b << 32) - a. Mark inputs as dead. */
-static TCGv_i64 gen_subq_msw(TCGv_i64 a, TCGv_i32 b)
-{
-    TCGv_i64 tmp64 = tcg_temp_new_i64();
-
-    tcg_gen_extu_i32_i64(tmp64, b);
-    tcg_temp_free_i32(b);
-    tcg_gen_shli_i64(tmp64, tmp64, 32);
-    tcg_gen_sub_i64(a, tmp64, a);
-
-    tcg_temp_free_i64(tmp64);
-    return a;
-}
-
 /* 32x32->64 multiply.  Marks inputs as dead.  */
 static TCGv_i64 gen_mulu_i64_i32(TCGv_i32 a, TCGv_i32 b)
 {
@@ -8872,23 +8844,27 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                            (SMMUL, SMMLA, SMMLS) */
                         tmp = load_reg(s, rm);
                         tmp2 = load_reg(s, rs);
-                        tmp64 = gen_muls_i64_i32(tmp, tmp2);
+                        tcg_gen_muls2_i32(tmp2, tmp, tmp, tmp2);
 
                         if (rd != 15) {
-                            tmp = load_reg(s, rd);
+                            tmp3 = load_reg(s, rd);
                             if (insn & (1 << 6)) {
-                                tmp64 = gen_subq_msw(tmp64, tmp);
+                                tcg_gen_sub_i32(tmp, tmp, tmp3);
                             } else {
-                                tmp64 = gen_addq_msw(tmp64, tmp);
+                                tcg_gen_add_i32(tmp, tmp, tmp3);
                             }
+                            tcg_temp_free_i32(tmp3);
                         }
                         if (insn & (1 << 5)) {
-                            tcg_gen_addi_i64(tmp64, tmp64, 0x80000000u);
+                            /*
+                             * Adding 0x80000000 to the 64-bit quantity
+                             * means that we have carry in to the high
+                             * word when the low word has the high bit set.
+                             */
+                            tcg_gen_shri_i32(tmp2, tmp2, 31);
+                            tcg_gen_add_i32(tmp, tmp, tmp2);
                         }
-                        tcg_gen_shri_i64(tmp64, tmp64, 32);
-                        tmp = tcg_temp_new_i32();
-                        tcg_gen_extrl_i64_i32(tmp, tmp64);
-                        tcg_temp_free_i64(tmp64);
+                        tcg_temp_free_i32(tmp2);
                         store_reg(s, rn, tmp);
                         break;
                     case 0:
@@ -10114,22 +10090,26 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                   }
                 break;
             case 5: case 6: /* 32 * 32 -> 32msb (SMMUL, SMMLA, SMMLS) */
-                tmp64 = gen_muls_i64_i32(tmp, tmp2);
+                tcg_gen_muls2_i32(tmp2, tmp, tmp, tmp2);
                 if (rs != 15) {
-                    tmp = load_reg(s, rs);
+                    tmp3 = load_reg(s, rs);
                     if (insn & (1 << 20)) {
-                        tmp64 = gen_addq_msw(tmp64, tmp);
+                        tcg_gen_add_i32(tmp, tmp, tmp3);
                     } else {
-                        tmp64 = gen_subq_msw(tmp64, tmp);
+                        tcg_gen_sub_i32(tmp, tmp, tmp3);
                     }
+                    tcg_temp_free_i32(tmp3);
                 }
                 if (insn & (1 << 4)) {
-                    tcg_gen_addi_i64(tmp64, tmp64, 0x80000000u);
+                    /*
+                     * Adding 0x80000000 to the 64-bit quantity
+                     * means that we have carry in to the high
+                     * word when the low word has the high bit set.
+                     */
+                    tcg_gen_shri_i32(tmp2, tmp2, 31);
+                    tcg_gen_add_i32(tmp, tmp, tmp2);
                 }
-                tcg_gen_shri_i64(tmp64, tmp64, 32);
-                tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tmp64);
-                tcg_temp_free_i64(tmp64);
+                tcg_temp_free_i32(tmp2);
                 break;
             case 7: /* Unsigned sum of absolute differences.  */
                 gen_helper_usad8(tmp, tmp, tmp2);
-- 
2.17.1


