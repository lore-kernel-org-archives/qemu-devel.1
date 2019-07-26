Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4582C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833DA21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atpvhmyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833DA21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Uk-0003U5-Jy
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nb-00064j-Vr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NY-00011O-I6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NX-0000wX-Di
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id i2so25048116plt.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8uDpXmk2fu+tSj6HfWWHlssj2XKXCMWZi0tyb4tGXOc=;
 b=atpvhmyDtUy1RYtrvBv8oBntVn6bXSSR/tqasJqEeDKCXAJtNA4QXtSDtVERLdpQic
 HlIgcmBOi3sFqG2kOMXxGD5lX0bd8ZOGOnYO38RRda5KT3rv/wxfKu0a139NyIYhb9NZ
 WNUPWW/H7XT2HRnJ3zv9oqSj1+eJVT9Z4byUzp6fomtXJWWG10wPgEq0OCugjjjUffgE
 uT460ehbKiJPf33AqhO4dpUVDx6v5MEkQmRCk9yWq33tbPJL45WvYCAalHYbgC0LCOZq
 qJ7XtBiG3epLuMHsX9v/1S5GDzLiUxSKViQqLaMwrdUgBP4YUOe01a5XTYzt+/e6goCJ
 ZQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8uDpXmk2fu+tSj6HfWWHlssj2XKXCMWZi0tyb4tGXOc=;
 b=kO1bJ+qTIUrL5Icg7/GRABBneNyzJBxG91PptXKS3f8SYdW5PDs1PQNnn3C1GbXpXu
 B0hDc8tfi4ph7QYCnj/A1Pm0w/wiaepsoeSK7h+9TT+4fZjrrEeAZ31iz8A5c7ximHh3
 /2HUS/0V9bcFyV9aMQEHZEeaosqzMq/eN3HAx0sU9jxKsE7RgWaD5kwsLeq+2vVepyii
 w/wxNn+48tQw0W5mRc5oa7pXIrzJdDecEnlV+rYkXGwxVHjCGOKAGmiLqRE6aW6oPXGR
 NoMFqlp4ogYExaB+yUeRm/V/L8Y2/U5qlqEQhQ6Idg+Rja9FHEtbjxNGUI6WLfMLiUh7
 5vwA==
X-Gm-Message-State: APjAAAXap3dazlRX5wxloCq6/O+ieFBznz2I2wYI19U+BohnHNwkSf6I
 Qne0mHglUpn3SlhMjmYI6pdVedmsuCw=
X-Google-Smtp-Source: APXvYqxS5X6bOUz7Pj1WvHsVSILAQhsLX9Xe+SlELQBuv29a4cwHVw3pYoNgFWAMfqLNWq/kGoY2LA==
X-Received: by 2002:a17:902:d70a:: with SMTP id
 w10mr92328491ply.251.1564163495029; 
 Fri, 26 Jul 2019 10:51:35 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:15 -0700
Message-Id: <20190726175032.6769-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 50/67] target/arm: Convert T16 one low register
 and immediate
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
 target/arm/translate.c | 44 ++----------------------------------------
 target/arm/t16.decode  | 11 +++++++++++
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 692891dbe0..9bdcb91537 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10594,48 +10594,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index 965fb1bf6e..edb67a3896 100644
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
+MOV_rri         00100 ... ........              @arith_1i %s
+CMP_rri         00101 ... ........              @arith_1i s=1
+ADD_rri         00110 ... ........              @arith_1i %s
+SUB_rri         00111 ... ........              @arith_1i %s
-- 
2.17.1


