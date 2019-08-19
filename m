Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB8EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2493922CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8BwcgYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2493922CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq6d-0000y3-7g
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMl-0002b3-Q5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMk-0006kT-GH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMk-0006jx-Ac
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:02 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so1937297pfc.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xWTPQIHYecFzB/xCsq79DFxtQ/kqN477ghAb6EWu45A=;
 b=e8BwcgYXLMZDrO7gOFtA1K2tYWFxKf+QLeP7YzSCpyiYbNqRzRroQQs7AQOUdHOKW/
 jhQvujm7zMZEJc8Ddb2UJ09WZFbC6tvPQ9D6TLG9MNL2SxvR96Q7RUFqDCkjWRopJXo0
 hxPLqZJWOK9/cRzx4D6bs0o7FROvOi1KL4vb5e/4fC6mHzSB0Oy/uYCu+mS0vTl3sdj8
 QDu+MiQjKtFE7m0qADwskIcT0736i+wIu/nuwLGUzOHP5hGVitf9Rm0rzkWR7aAByzLh
 GULDdhV1zlsj9oQtVlElcoIw3hrqguwzoFtkZboIDquvpQtVLEiu4Zl6A+9BOGShUGQV
 LXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xWTPQIHYecFzB/xCsq79DFxtQ/kqN477ghAb6EWu45A=;
 b=fHxj7ycY/CeRBn6tKD2+mPb5PY9zfRxqLy01Ckk1K4B1sYPt9cPQx4YYEirKzueADu
 D940q7Cziygx1MXM/Fofe6YiR3jJ7TvRR7fVNygrUjm6K7yqQ4zxxewGZ7/RF6cZUaWA
 RUVjgsFni7w3MpA6nVJIP4UhVJfkm1EDyJv1wxGlnZHv+iilXFxzKFPBSSI5V5+U5zM7
 CR+0Or95bxFG3+P7Dv2lqNVjJzbaZ4+s/BXwvHbdFNMWHmNXdMEdubR+yHJA/VsZOlrL
 tn92+C/7t/zhk5IoQDN3WFT3Nwmrbd8CN/Xwqa0t43QJW/0hbQ9hIPxTv5xK7DcPEeWe
 SlRg==
X-Gm-Message-State: APjAAAVvLFQ5tsj72Eqj1UzcBcKbqTLL/p82e5vNohRu1WbqjhlJF8jK
 Qda81KF3Z//16rNCfwBc1CfMSTDBZjA=
X-Google-Smtp-Source: APXvYqw3I69VW+AMfTiuC4QPCRDNDH1obpSpmwupmiGogL/fCEW4fomidpN7CkrLfIwBsNYlF6Ks1g==
X-Received: by 2002:a17:90a:ab01:: with SMTP id
 m1mr21966827pjq.69.1566250741075; 
 Mon, 19 Aug 2019 14:39:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:39 -0700
Message-Id: <20190819213755.26175-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 52/68] target/arm: Convert T16 branch and
 exchange
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
 target/arm/translate.c | 64 +++++++++++++++---------------------------
 target/arm/t16.decode  | 10 +++++++
 2 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3a3b113822..60bfc943a3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8335,7 +8335,7 @@ static bool trans_BX(DisasContext *s, arg_BX *a)
     if (!ENABLE_ARCH_4T) {
         return false;
     }
-    gen_bx(s, load_reg(s, a->rm));
+    gen_bx_excret(s, load_reg(s, a->rm));
     return true;
 }
 
@@ -8362,6 +8362,26 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+static bool trans_BXNS(DisasContext *s, arg_BXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        unallocated_encoding(s);
+    } else {
+        gen_bxns(s, a->rm);
+    }
+    return true;
+}
+
+static bool trans_BLXNS(DisasContext *s, arg_BLXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        unallocated_encoding(s);
+    } else {
+        gen_blxns(s, a->rm);
+    }
+    return true;
+}
+
 static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
 {
     TCGv_i32 tmp;
@@ -10637,49 +10657,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 }
                 break;
             case 3:
-            {
                 /* 0b0100_0111_xxxx_xxxx
                  * - branch [and link] exchange thumb register
+                 * In decodetree
                  */
-                bool link = insn & (1 << 7);
-
-                if (insn & 3) {
-                    goto undef;
-                }
-                if (link) {
-                    ARCH(5);
-                }
-                if ((insn & 4)) {
-                    /* BXNS/BLXNS: only exists for v8M with the
-                     * security extensions, and always UNDEF if NonSecure.
-                     * We don't implement these in the user-only mode
-                     * either (in theory you can use them from Secure User
-                     * mode but they are too tied in to system emulation.)
-                     */
-                    if (!s->v8m_secure || IS_USER_ONLY) {
-                        goto undef;
-                    }
-                    if (link) {
-                        gen_blxns(s, rm);
-                    } else {
-                        gen_bxns(s, rm);
-                    }
-                    break;
-                }
-                /* BLX/BX */
-                tmp = load_reg(s, rm);
-                if (link) {
-                    val = (uint32_t)s->base.pc_next | 1;
-                    tmp2 = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp2, val);
-                    store_reg(s, 14, tmp2);
-                    gen_bx(s, tmp);
-                } else {
-                    /* Only BX works as exception-return, not BLX */
-                    gen_bx_excret(s, tmp);
-                }
-                break;
-            }
+                goto illegal_op;
             }
             break;
         }
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 0654275e68..edddbfb9b8 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &ri              !extern rd imm
+&r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
@@ -144,3 +145,12 @@ MOV_rxi         00100 ... ........              @arith_1i %s
 CMP_xri         00101 ... ........              @arith_1i s=1
 ADD_rri         00110 ... ........              @arith_1i %s
 SUB_rri         00111 ... ........              @arith_1i %s
+
+# Branch and exchange
+
+@branchr        .... .... . rm:4 ...            &r
+
+BX              0100 0111 0 .... 000            @branchr
+BLX_r           0100 0111 1 .... 000            @branchr
+BXNS            0100 0111 0 .... 100            @branchr
+BLXNS           0100 0111 1 .... 100            @branchr
-- 
2.17.1


