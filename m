Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C84C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2FB20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ776R6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2FB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33ut-0001dH-Qy
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gp-0003wN-1d
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gn-0000fL-AX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:43842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gk-0000Wg-V3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id 4so388328pld.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n5NWM0ujFZG4Z0hFWBvOI0a8a8o7N/upmmw5k4rwO2k=;
 b=RJ776R6Iw6K8wmXWFLXvOhPGtbBBtJ2ZQC8jeRdC68997MJUAUzHhS2BJXCp46AQg7
 ggnCkYopb/xi9HQfQNKmCFyaFsXBAOhhRMuvh7JNQWLHz73j0cgSrJvZgd/mP+tR9Kvx
 ajEZ08yCMTEJ1rNeAxqlrs1ChkSKihBFxK8Ru/76UbQV2z3re4br6QEPmOM8bIhkU1Tc
 yVQY6Ubk2NVaA/QhTg2TXPoz1ggH2VONfiBtn7VqBYtSsmWo1MEcgeH26q4yLjrtKHxy
 fveTMcSZU6tA1Utt6cbCS0ak/mo8xAJSw09pccsj5JRnhpI02RJaMdY7Z0THpZVEdyUy
 S0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n5NWM0ujFZG4Z0hFWBvOI0a8a8o7N/upmmw5k4rwO2k=;
 b=K8CPb33zA4FYzWd5T8lXmZHt439lG+u986htRFHtwInbykRVE6yi50VgeADgeg677J
 ZPESv0xofJypScF9OegO1CjhgGmzWEXUrWvEM91BPd08zS7Lc5tnc3Mzs/yop81jIN2n
 kg3yvUTThPLT7jItuc7l5LEuPX0G7XJjS+CuJhwlUE/qxBV1MGc83wIEwssp50V+K+Yc
 G016FfdAGxqBl7mDMV0zi8P39H+qv+4pHNBYTY8kodpppc12C88sfPNigfxZkgRzCkYy
 85a4hWgfDAwIwxTsCfUcfFfcpL8J3DMPV+NpYeun49RONRZXtylJysNjYuGl85PHty9L
 JAGA==
X-Gm-Message-State: APjAAAV2tVhAiUkcc8kJkGqTigBu7rEMGcwLzdI0akstFi097/k0Ij/H
 lru5kk9I0/HlcHQAQt+KOKIEU+0sSJM=
X-Google-Smtp-Source: APXvYqzFR+kwEkGl3FanSUeXvg6ddHFd6SZ/lORPkTR0QDvqzhk9fo6sBCRFtGkzUvZQBQ2JIFHSiQ==
X-Received: by 2002:a17:902:9889:: with SMTP id
 s9mr5978286plp.100.1567019162488; 
 Wed, 28 Aug 2019 12:06:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:36 -0700
Message-Id: <20190828190456.30315-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH v3 49/69] target/arm: Convert T16 add pc/sp
 (immediate)
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
 target/arm/translate.c | 12 +-----------
 target/arm/t16.decode  |  7 +++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8e182f338c..d8dfddaea3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10845,19 +10845,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 7: /* load/store byte immediate offset, in decodetree */
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
+    case 10: /* add PC/SP (immediate), in decodetree */
         goto illegal_op;
 
-    case 10:
-        /*
-         * 0b1010_xxxx_xxxx_xxxx
-         *  - Add PC/SP (immediate)
-         */
-        rd = (insn >> 8) & 7;
-        val = (insn & 0xff) * 4;
-        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
-        store_reg(s, rd, tmp);
-        break;
-
     case 11:
         /* misc */
         op = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 1cf79789ac..71b3e8f02e 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 
@@ -102,3 +103,9 @@ LDRH_ri         10001 ..... ... ...             @ldst_ri_2
 
 STR_ri          10010 ... ........              @ldst_spec_i rn=13
 LDR_ri          10011 ... ........              @ldst_spec_i rn=13
+
+# Add PC/SP (immediate)
+
+ADR             10100 rd:3 ........             imm=%imm8_0x4
+ADD_rri         10101 rd:3 ........ \
+                &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
-- 
2.17.1


