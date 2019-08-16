Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA1C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185FF2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPUq+TdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185FF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycSa-0004iM-3v
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc79-0003fr-L2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc78-0005sR-CR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc78-0005ro-5U
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id y8so1511865wrn.10
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xpfRGBW6oeUhJSHa15P6/UBxYtD8fPq019+58iIX+9c=;
 b=aPUq+TdLslcO8RXTZa+vkV8eq3VQ/Zy15/RPiP6brAiSp/buWu0tNc34pHEv7GBJbJ
 LsJgfN8KYKtz9siUPFYNjAoFMjdzvGG9Uk8UkSC9hNXPq93FWauXHucwq1yLy9if02gq
 w8wBTiP5e75xx7j7ntc7luo/G3deR+tc1AjkTLw6X84gKCugtgm5I/ClQQkf8afZ+4Da
 /sgdvP5fT6EcS7BIJzdEmjziY/NuElqUCXYNstsIWbEWj9dl/G+CRKw0ZNZnqD1n1LgZ
 5Kjvas6of0HE6mDmTfptUBax+Skl9M+AqqpmUVx0KkbzIam/2oUUBd9yyJUBdrLbY1eC
 UP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xpfRGBW6oeUhJSHa15P6/UBxYtD8fPq019+58iIX+9c=;
 b=JKvRPaZKI0oSplTESxWMk2wmVmD3gSbTXScawJ3NyziXGiXgVfO3AxIjRyyKdBlyt3
 i+Ecb3P6XTXmArJaX6FusqUJd1jWPs9ENlH8z18EAKEpfTUR7D2xI1G+4KA/03XA7wTe
 pjvPtasneHYk96qFo80cWZj02e3w8MtQdu4yKIcCwO0e3Gr1BQY+RI5vp4z4Nc6fkVL5
 YKWvk3OwirBN7eCXLWJx51T7vzqiKAN8ZNVUGC8FUKgzx4mhC7sseO6x0LEaDLhOBQOA
 0ZD7k1dhtP7X1ydYYVA7RIzcyYRdHunSwKGPP0JbnkY9gQjjzRXP2AYV++SspZak0B+A
 /uoA==
X-Gm-Message-State: APjAAAWt9qRKST7N8LTKJATuk/CfBAvfFGgDva5fsXX47DpC5uXEpT2m
 89xZyovE2zUvnijsQD4PyL+FVPsfCkzzUg==
X-Google-Smtp-Source: APXvYqz8PS10HhS1ioVuZlDIvXinErzGISaVVFRa1pxk0Mt5GKkdkpyyOeqzLFeex3l4AoOSUij3cg==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr10634933wru.116.1565961472867; 
 Fri, 16 Aug 2019 06:17:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:18 +0100
Message-Id: <20190816131719.28244-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 28/29] target/arm: Simplify SMMLA, SMMLAR, SMMLS,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

All of the inputs to these instructions are 32-bits.  Rather than
extend each input to 64-bits and then extract the high 32-bits of
the output, use tcg_gen_muls2_i32 and other 32-bit generator functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 72 +++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2e160646206..9e2853fe76c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -376,34 +376,6 @@ static void gen_revsh(TCGv_i32 var)
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
@@ -8857,23 +8829,27 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10099,22 +10075,26 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
2.20.1


