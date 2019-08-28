Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D52C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7782173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwFti39e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7782173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Jk-0004P6-8w
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H3-00044u-7f
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H0-0000pC-TA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33H0-0000mv-Dt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id y200so391139pfb.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Lx+8GdSOm4AFV3gPcXa/Gz1WHaL2tglqVzn+6pptTZA=;
 b=EwFti39eQXHd8pj+7tYzrtWdwD06ZkjllFuQS6SE/1jq89J3rlwXZBViLNyNVTSfx+
 rnMNhskIAtiyZKBufQMiCXj6GD2OXMqNybObMG4TZNpxyPc9Byd/KB+WBLHY9uBil2xv
 Pnvpp39xJym8N5egXpnaKYRfvHx3EchvNodm0YseCXClxud0tX2fKiz7wcOOYLQF4s0u
 4f8wg06d/XSddypNw0DSpLGhALIF4FR6JwBMrQCFVBadlmnzV459sNklCekm+oeZKaLC
 iVbNtDNXpXKf8SHnYMdwm17bnCISmmYDm2RxVFfPXnsZfhQRPY52ZrtX8HAc+uZ97e6f
 bXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Lx+8GdSOm4AFV3gPcXa/Gz1WHaL2tglqVzn+6pptTZA=;
 b=Rozzib62CIyEDPWx5WHRGD8dvfRuTxvctBVmpTkErUouMDtzvpG8+ss0DpmWq0kdun
 GecgYQ3a0LV2KZVNU9CLBS5uMhgm60NvpEgSDwfZYjy2AucdvfxyKVoCvvjMc/O0mGgK
 JL47GcSPyDPn50i/XoIQFcLl0zAAomy1+NH0xrKoe5GF2uiMtjyZNRX/GUItLg9S7Dni
 e8pz8gsTfY37Zc5lroMH4j0dqU+bB4GeqWd2Hj5WN8ThV8tbhqY8Vv9synvEtoUAJrjJ
 Unvdhpfc1HkvbGcHp88IzQu76eiiJ/J/Lp2+bu6Is6ShSZmhq2ZRrnkmhfSP3oCTyEWN
 D/jQ==
X-Gm-Message-State: APjAAAVvy1dTLtQNeRXJkKl6vDjBfaSKDrMWBgrpl36LMYFumJe4+WDr
 Et0mM6JY0Ic+JwYatYVIFWqxHTOdNhw=
X-Google-Smtp-Source: APXvYqxO445495BGlIVyjWle21YmKjTicegIqNUxPk33IqMkOmvKRFYeNS9BD5ofM+WMhPkSIX78PA==
X-Received: by 2002:a62:1858:: with SMTP id 85mr6656045pfy.120.1567019183524; 
 Wed, 28 Aug 2019 12:06:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:53 -0700
Message-Id: <20190828190456.30315-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
Subject: [Qemu-devel] [PATCH v3 66/69] target/arm: Convert T16,
 Unconditional branch
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
 target/arm/translate.c | 9 ++-------
 target/arm/t16.decode  | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fe9f7e4f42..574a791461 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10713,7 +10713,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10757,12 +10756,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             gen_bx(s, tmp);
             break;
         }
-        /* unconditional branch */
-        val = read_pc(s);
-        offset = ((int32_t)insn << 21) >> 21;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+        /* unconditional branch, in decodetree */
+        goto illegal_op;
 
     case 15:
         /* thumb_insn_is_16bit() ensures we can't get here for
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 0b4da411e0..a4c89dba61 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -266,3 +266,9 @@ LDM_t16         1011 110 ......... \
   SVC           1101 1111 imm:8                 &i
   B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
 }
+
+# Unconditional Branch
+
+%imm11_0x2      0:s11 !function=times_2
+
+B               11100 ...........               &i imm=%imm11_0x2
-- 
2.17.1


