Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FFBC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CD6218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoMVKWu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CD6218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4W3-0000W1-Bo
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nd-0006Bv-Ku
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Na-00012q-Fa
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:43567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NY-0000yQ-Ck
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id 4so18030903pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IrOBDo+AXilRW3wlJP2NZAtzPEtyDf6q+uMfRAEA/NI=;
 b=HoMVKWu0oOTa7UKx7ED5TontqAfti1JQ7VEe/rbHXTE6oXK41FnB8koKNRRa71pN5u
 syIBAu0/b9SOUGSx0Rt0Aua2n+KjsSgFnKGnT2pW8vHEQDBl2WSeNV1/vFeNAxwa/v4Q
 Tu8M3VjQY9QW9pS3aQUVEy+u/cDRtctHyw0WkzFqdQKVEEA5yS5A+eTtBw4IFUFgvZAe
 mJAh7sDsN9fZqnxRg3H1UQbVJ4POiLKiVdqubDzV+40lC5E6eS4/JUKDpqKAf++KtyN1
 hFrKhaVAfdwaPhF7KXln3gcXZEvMmT8h7ghX3OaKtOhRQw4s1ui45XsKGiLU29CFuqCQ
 re0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IrOBDo+AXilRW3wlJP2NZAtzPEtyDf6q+uMfRAEA/NI=;
 b=ILMuPDD6ZeRiWh50yztHS6f1hqlr43FDXw6XgUzbVPhSckdmESrbbBafry63yp91e6
 j/mHliN5V/Z50gmLyeCw8vnAo7Rg8U+Bq5DqBZR0wq9VUtyXCVtul3S4MdBXHK//6ZUW
 F8znxFCzRD6LoyR6Hp5kXTX7/6GLMIqRTS9z8JT0TpK0jnx2gNsXZMOqkhtm90XpqBIF
 NjDGq9qEuYwjH3abCYFhxBDCXw/A0y7PIRHcNK/OvejYLfFWmXlVvh2XyQgjZlZ/LQMo
 iZ4vlgmDKi41WcPNgrfUmaplLVKt9SVHWNsxUIYnmalFMqBFZfKh3xtddjB5EMSxGMOV
 Jt2Q==
X-Gm-Message-State: APjAAAVfsj1gbKMI1fdhT9aADFleC091SJfIFCwsVkjsFyDovPMM4Uhd
 Fz3vA9eiVk7fDdy5CS0rRrWrrKjtps8=
X-Google-Smtp-Source: APXvYqy9OGNGKQ5h+et5+J+SrXhlN8lcWxk5kbiWRbKP6YLAch7y2QBgopRNTIUaAdnPXtiVHE4eLQ==
X-Received: by 2002:a17:902:e210:: with SMTP id
 ce16mr98753140plb.335.1564163496015; 
 Fri, 26 Jul 2019 10:51:36 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:16 -0700
Message-Id: <20190726175032.6769-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
Subject: [Qemu-devel] [PATCH 51/67] target/arm: Convert T16 branch and
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 64 +++++++++++++++---------------------------
 target/arm/t16.decode  | 10 +++++++
 2 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9bdcb91537..e2183eb543 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8406,7 +8406,7 @@ static bool trans_BX(DisasContext *s, arg_BX *a)
     if (!ENABLE_ARCH_4T) {
         return false;
     }
-    gen_bx(s, load_reg(s, a->rm));
+    gen_bx_excret(s, load_reg(s, a->rm));
     return true;
 }
 
@@ -8433,6 +8433,26 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+static bool trans_BXNS(DisasContext *s, arg_BXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        gen_illegal_op(s);
+    } else {
+        gen_bxns(s, a->rm);
+    }
+    return true;
+}
+
+static bool trans_BLXNS(DisasContext *s, arg_BLXNS *a)
+{
+    if (!s->v8m_secure || IS_USER_ONLY) {
+        gen_illegal_op(s);
+    } else {
+        gen_blxns(s, a->rm);
+    }
+    return true;
+}
+
 static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
 {
     TCGv_i32 tmp;
@@ -10645,49 +10665,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
-                    val = (uint32_t)s->pc | 1;
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
index edb67a3896..4701f72357 100644
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
@@ -144,3 +145,12 @@ MOV_rri         00100 ... ........              @arith_1i %s
 CMP_rri         00101 ... ........              @arith_1i s=1
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


