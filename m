Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B2C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EB822CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9ssxPL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EB822CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq7w-0002tI-8N
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMm-0002cw-Tb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMl-0006lh-OP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMl-0006kk-HS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id 196so1941437pfz.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A/kxiGsWb33X0BCIForTFk+4xWAxXqSlHmM910wf6kg=;
 b=x9ssxPL87BlkTXhaz2s9f10VQLKxuH3fZVfv+qFjGSWUwCho1+Vd6gZw85my0aUcM4
 QeV4aX2/ZvXJL7x8lKoStAOfyA0diBQ2NOo2dPULSAGByv5Z3SaGpuJNRCkV/njnLjk/
 3m6mRcocMnvo89bOs/D/l7Gwrbo8FbiFP5grumenlGslPdfqC2/1PaJxKr/ySdFughgb
 O/xkaXwGyICV0FEfRySl/y0HE1ABu8WzXQ91WPrZZIFojMZf4u8iaKIxxrJG4o3y3dnQ
 t+BYMHriU7cvVZmKWxXhumoVx1p4wRE5mPRDk1z1JSUQG7wNfKbi+FMDOWpr1w7B51Fh
 E0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A/kxiGsWb33X0BCIForTFk+4xWAxXqSlHmM910wf6kg=;
 b=orQ8FDm7GseuuwJhumnGJk91hQSjNJkrTGSWHHxVEQUjhuzxZvcP+5jusm8gL68fB0
 +aehpIR+b3bLtsWsIU44t0gTsR/ObDU4htH7u4q3wyHy1ddV37D/O/wlTqwcivbrqTUa
 MvnGvKlHIov+MqWNDuvUvsbsUwVZ8eOpfaxCI9MKdYeE9lCmeH5DOZV0p6cuyjancjAU
 wOsAWUbeAh78sj8iLHjngCHMOxxyDiOd0T21UJT+kpmluFTn0Y340QmrFpTWvUuB7wxa
 UI00RtrMNg0yw+pitPr7TPeftXvsCQ8jb3RSAThvPxrKxX6GTr++Ba4GLgKCqqm1M9e3
 yXpA==
X-Gm-Message-State: APjAAAX2vgbreWUlYQ/dFzDyZp+kohCKWncOEdxx/BTnFkJQVrSxIDKL
 DYnEi8QuSzneOGcEuU9krYNtLEBMvpI=
X-Google-Smtp-Source: APXvYqzLKzG+wtgmjgY36c4b3F4bmO8Cgm/hyKtzbNJzvelQ2NcN8/ROkP04uTWh9VZ7/EpKGiyluA==
X-Received: by 2002:a17:90a:fa82:: with SMTP id
 cu2mr23548752pjb.85.1566250742275; 
 Mon, 19 Aug 2019 14:39:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:40 -0700
Message-Id: <20190819213755.26175-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 53/68] target/arm: Convert T16 add, compare,
 move (two high registers)
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
 target/arm/translate.c | 49 ++----------------------------------------
 target/arm/t16.decode  | 10 +++++++++
 2 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 60bfc943a3..e639059a5a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10620,55 +10620,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
             break;
         }
-        if (insn & (1 << 10)) {
-            /* 0b0100_01xx_xxxx_xxxx
-             * - data processing extended, branch and exchange
-             */
-            rd = (insn & 7) | ((insn >> 4) & 8);
-            rm = (insn >> 3) & 0xf;
-            op = (insn >> 8) & 3;
-            switch (op) {
-            case 0: /* add */
-                tmp = load_reg(s, rd);
-                tmp2 = load_reg(s, rm);
-                tcg_gen_add_i32(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                if (rd == 13) {
-                    /* ADD SP, SP, reg */
-                    store_sp_checked(s, tmp);
-                } else {
-                    store_reg(s, rd, tmp);
-                }
-                break;
-            case 1: /* cmp */
-                tmp = load_reg(s, rd);
-                tmp2 = load_reg(s, rm);
-                gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                tcg_temp_free_i32(tmp);
-                break;
-            case 2: /* mov/cpy */
-                tmp = load_reg(s, rm);
-                if (rd == 13) {
-                    /* MOV SP, reg */
-                    store_sp_checked(s, tmp);
-                } else {
-                    store_reg(s, rd, tmp);
-                }
-                break;
-            case 3:
-                /* 0b0100_0111_xxxx_xxxx
-                 * - branch [and link] exchange thumb register
-                 * In decodetree
-                 */
-                goto illegal_op;
-            }
-            break;
-        }
 
         /*
-         * 0b0100_00xx_xxxx_xxxx
-         *  - Data-processing (two low registers), in decodetree
+         * - Data-processing (two low registers), in decodetree
+         * - data processing extended, branch and exchange, in decodetree
          */
         goto illegal_op;
 
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index edddbfb9b8..5a570484e3 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -146,6 +146,16 @@ CMP_xri         00101 ... ........              @arith_1i s=1
 ADD_rri         00110 ... ........              @arith_1i %s
 SUB_rri         00111 ... ........              @arith_1i %s
 
+# Add, compare, move (two high registers)
+
+%reg_0_7        7:1 0:3
+@addsub_2h      .... .... . rm:4 ... \
+                &s_rrr_shi rd=%reg_0_7 rn=%reg_0_7 shim=0 shty=0
+
+ADD_rrri        0100 0100 . .... ...            @addsub_2h s=0
+CMP_xrri        0100 0101 . .... ...            @addsub_2h s=1
+MOV_rxri        0100 0110 . .... ...            @addsub_2h s=0
+
 # Branch and exchange
 
 @branchr        .... .... . rm:4 ...            &r
-- 
2.17.1


