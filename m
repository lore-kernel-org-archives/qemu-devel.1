Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B8720856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMOh4v51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B8720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33xr-0005GP-L0
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gs-0003xD-4s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Go-0000gD-3g
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:15 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gn-0000ar-0s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id h3so393906pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Xh3njORL91tYVCqkinovfhGK3k94iR1HSBdgpNlJCqs=;
 b=CMOh4v51aFrrn+VVcnMwP/eonazi2DDhn7yZSLIK5jtz7SGJkMvXVsHhdNS6cC4kYh
 QvZCTo3q8T7RXGbb5gQVKA85ZeZcGKP4mntvIDjOlypacZsOjxiw76YBxMhYzT1krILB
 CbWgQNESlUehZV1I/phISpkS64zns2jkrD0uYHbiOW4ZZFVLTdRHwxUx+hxdj4MBk5y2
 wIfOSRFYu3D7839CRdj3owH4kfZrojBz5oLLiRzPcLVubXLfFzmJw8nawhZR4UeOcsff
 NdJrey+YXhB8hxfEyGQWOW9b3hm4Y7EkmIhI3kKb7kjQPqm3YvX7MQ5glglJBbXD8WzE
 YFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Xh3njORL91tYVCqkinovfhGK3k94iR1HSBdgpNlJCqs=;
 b=ZuwJYwImf5uR7ZhPbr2uCQ5yAoTitXOYBN6GxKEhs5iUZZxT46FzjkVl2Uv9zUBdHk
 /qty+YnLb7E1FeFIF2mT80pjoSOHkdk9efnS7AL5X1Hed5Oq1EnKzzSiam9NRI5c0wtA
 imfXG9Y9G/3KN7K4C2T80nUB38EVDbrJjdN3UTUVVoBC8SbJ36QYhoDExW5mwgyooUTz
 gBEV85RlU8KNuK6NNFFm/IIAhUWccHGIMBafu5dOPJDA+E1wUQO3tVUu9EXvfYca8e3l
 w4viCNuy0Av3ZfXmrbEUCQ/gGyCJboO3a6rYi9Yp6qMM8EKA8cvEBAiywKlg6gxhrWkg
 IboA==
X-Gm-Message-State: APjAAAWFsO1g4KeYMcOXsqU3g1FaIinLB8GE1iaESI/wuwRwMtPKFonf
 ylXmYZBaIFfQy04RQQ13DkjWKtFyxTc=
X-Google-Smtp-Source: APXvYqwpAP4NpM1qmvNLJaZADmK2ZWlYW1WtXCVyRR5jkKNX+jXMqSwCPovEXMV0OCY+3mxTz2oK7g==
X-Received: by 2002:a17:902:d906:: with SMTP id
 c6mr5635816plz.13.1567019167406; 
 Wed, 28 Aug 2019 12:06:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:40 -0700
Message-Id: <20190828190456.30315-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 53/69] target/arm: Convert T16 branch and
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 70 +++++++++++++++++-------------------------
 target/arm/t16.decode  | 10 ++++++
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d4d7d99da8..cd39329e5c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8338,7 +8338,7 @@ static bool trans_BX(DisasContext *s, arg_BX *a)
     if (!ENABLE_ARCH_4T) {
         return false;
     }
-    gen_bx(s, load_reg(s, a->rm));
+    gen_bx_excret(s, load_reg(s, a->rm));
     return true;
 }
 
@@ -8365,6 +8365,32 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+/*
+ * BXNS/BLXNS: only exist for v8M with the security extensions,
+ * and always UNDEF if NonSecure.  We don't implement these in
+ * the user-only mode either (in theory you can use them from
+ * Secure User mode but they are too tied in to system emulation).
+ */
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
@@ -10733,49 +10759,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


