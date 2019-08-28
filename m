Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3A6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E976722CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axcs5CpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E976722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Nv-0000bL-Sp
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gp-0003wO-7l
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gn-0000ff-Dx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:14 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gm-0000bY-Gp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3so393925pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=x7zkDeuRWBqPgbu0Uw/jBwIGlLUUfHJ8yMWyeY3L4GI=;
 b=axcs5CpEI8yuoqlwGkqd94L5BMP4ASAOkiNXDU6hWnvu0S83Cg1jOCz6Muv7zNLMMj
 MfacYvCjljRRbZ4FM9E3NxO5haSKLTn5TleGwN1JEoaBt4t2Q0ZtWTuPNbtH03rv3A8X
 Fdf8VOsZ8ZxUmeX4SI3MTmHiXVy9FWXqO17a5nNO0diqdwoDBsdqC4b/W0+DO2PA8aGO
 3hh3daIdiTPXjj1Voen45MBovK7++mwyjyNfQ+lIz54FyWH4mP3aYcexiW1ypfpWOKGW
 5D/JHNgLCFwixKEbKRR2WTKgRTYDSIgpKs9+iCQ/QbgwO3hcakFSnOX9npr4UUGI6Pg7
 AngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x7zkDeuRWBqPgbu0Uw/jBwIGlLUUfHJ8yMWyeY3L4GI=;
 b=RKxXSW0oeecLJvcMTGsuMtf79+RyuCwilKAG0n1C9O8qAaOhWVEb3zWYp1YoJv0taL
 y7KiG3RuiV4C9rAto0szl2Yz87xLLxCegTJcBmnrEvUch8ZrWItR1KQkVyuyj5+uS9tC
 1P6oLJNDEO7kYXXtsfKmzBpsOCHw+NR0uMgj4ca4bfgn4qLu8f77aoaHRtGNbiEE+G8t
 Ciq7PwqHMql+WDVDEa9d2+eE6ea+fkxJGrDHU9CPigkW3dyRxshSzqddQlU9pymvylvc
 5aRdHmuowIoT8Cj0ng7rHIANbGXcXx+TZPBDERl83nyrJYZ8Sg1ilytB9SVtnHQ6YTeJ
 1XAw==
X-Gm-Message-State: APjAAAW4hVHWdaBJfCV2VM0jTNJvmC4IyGcwEIq1MmtEwIRdAP4SphzY
 jHNTGUivSZNigspong6KO8whZNbmjvI=
X-Google-Smtp-Source: APXvYqwtxB8gxq1SlavCA72/W/Fe73q0lDiX8NCMKtcsaMhX/qg6ZUZx4+yc5qEu+7RmTZ6bhvlk2w==
X-Received: by 2002:a17:902:e489:: with SMTP id
 cj9mr5926759plb.327.1567019168623; 
 Wed, 28 Aug 2019 12:06:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:41 -0700
Message-Id: <20190828190456.30315-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 54/69] target/arm: Convert T16 add, compare,
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 49 ++----------------------------------------
 target/arm/t16.decode  | 10 +++++++++
 2 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cd39329e5c..cf19f1f777 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10722,55 +10722,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


