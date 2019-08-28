Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB20C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F4C217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i86swx/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4C217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34KC-0004pO-Pm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gn-0003w8-Fe
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gl-0000d5-GE
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:12 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gj-0000Z2-I9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:10 -0400
Received: by mail-pl1-x641.google.com with SMTP id z3so395936pln.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W7Njx5fsc6fJoAUaqNSP00kDYpcwXysWT9wttSWRibc=;
 b=i86swx/FRswyTONOGwgCLPvgXcsrnuxF+v5duHhig19ZSjEUOoSVB9V1wmd9Gzp+Z0
 JVGHiLBiKYm4oKHQIRmacAQBangR9QOC5w3zE2CyRuZ0nl0763Gy2tXPvLE7HqwSfDTe
 UwljaqJXyFbiBd0Ci1Py9DsmjZ76uLF1xxt/YeOv4nzC9j23copESWdXEy7gBjyGiX3U
 iOeyLovCFgjmTJ36aqbNTvwBgrqu3h+Py8PYypvCiFKgXj8T3KR6bTBl1zxvVWGexVDB
 qXRKhFLDcEh9NR9ZA1YuMbAWUwMt3UezksUzckd5QSR5qKPRNndhcr0XPw2C8eSd3zdF
 l3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W7Njx5fsc6fJoAUaqNSP00kDYpcwXysWT9wttSWRibc=;
 b=LU7RX7dheXWZO5CyqLIBmTe2oX6fTlSPYTs+OT0x+754YwVjf+8H76R8In2tVZNY/Y
 oo+N6mQEAHBnce5/03LMgh0kYlh9OF3HgCTV8oV8eKqyW0djDTJH40Yy0k9n/Qa9fern
 7+7Zyi5M2XDY9bH6pm5XQIOafH8C/HqPQ9GKt41MG+gyjRxNYX6PCvDntHB+SZmX5zMW
 Z/9Y13/ssk23YZaQILhHOYY6zk34kf0+oCK3slz/CKfqYb2jgHe71Hc4Er6zO/ppIWbb
 bNNrvH8ozgy4lRHuzYlG5+NIKqXRGHm8MXaK1uDSPJBEGhhE8fC8C0rHJ4dSUGjSaRx3
 GbJw==
X-Gm-Message-State: APjAAAXrtDiEI8W87zQjXdF/jRqu3+N8NV6Plur74s0o320tv6r0UDfw
 Oev1vxS7Tj1p9cjbp3CnrtAX2gMoLzw=
X-Google-Smtp-Source: APXvYqyUCsYUocGIijXSnXNrrf3ewYJqCzIt7ytDcNcAQciyhlvIrzMOWw/oGaQI+W0mjYBCUmkXxg==
X-Received: by 2002:a17:902:b18b:: with SMTP id
 s11mr6003928plr.1.1567019166144; 
 Wed, 28 Aug 2019 12:06:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:39 -0700
Message-Id: <20190828190456.30315-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 52/69] target/arm: Convert T16 one low
 register and immediate
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
 target/arm/translate.c | 44 ++----------------------------------------
 target/arm/t16.decode  | 11 +++++++++++
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fa6892d6af..d4d7d99da8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10682,48 +10682,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
         }
         break;
-    case 2: case 3:
-        /*
-         * 0b001x_xxxx_xxxx_xxxx
-         *  - Add, subtract, compare, move (one low register and immediate)
-         */
-        op = (insn >> 11) & 3;
-        rd = (insn >> 8) & 0x7;
-        if (op == 0) { /* mov */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, insn & 0xff);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        } else {
-            tmp = load_reg(s, rd);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, insn & 0xff);
-            switch (op) {
-            case 1: /* cmp */
-                gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp);
-                tcg_temp_free_i32(tmp2);
-                break;
-            case 2: /* add */
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            case 3: /* sub */
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            }
-        }
-        break;
+    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
+        goto illegal_op;
     case 4:
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 2b5f368d31..0654275e68 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -133,3 +133,14 @@ SUB_rrri        0001101 ... ... ...             @addsub_3
 
 ADD_rri         0001 110 ... ... ...            @addsub_2i
 SUB_rri         0001 111 ... ... ...            @addsub_2i
+
+# Add, subtract, compare, move (one low register and immediate)
+
+%reg_8          8:3
+@arith_1i       ..... rd:3 imm:8 \
+                &s_rri_rot rot=0 rn=%reg_8
+
+MOV_rxi         00100 ... ........              @arith_1i %s
+CMP_xri         00101 ... ........              @arith_1i s=1
+ADD_rri         00110 ... ........              @arith_1i %s
+SUB_rri         00111 ... ........              @arith_1i %s
-- 
2.17.1


