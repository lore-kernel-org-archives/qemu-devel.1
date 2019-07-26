Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD522C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799A121842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azOLCzTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799A121842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Wt-0003nn-3j
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NM-0004uS-94
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NI-0000Y2-Sj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NI-0000Q4-I3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id f17so20864100pfn.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8jS7+sK+VOWigPY1q5W77YMTHCuDnHzgvWGfuf+9BAA=;
 b=azOLCzTt87mhEvZFoPs2GqxB8az68wv1L3gzdeqQyminX1GfMMN/y2NhMugWSWXLTh
 paPKGB/xNH6LmwFw5tPCnouRsT/gUWKbiJ2aA4wbDDAZ+e5f00WE6DOBjcPw86sAXB23
 z+l2WRBmT6CLb5DRxMdRoUfoIqWPfrXqS9UXeqfstMCH9b4pbEtRiyHuMRlKXbqEQXdk
 kGggh7bdixhrz8OLp+a1yYKX+a7zdHoPvE0ATHWcxOMTOv9kM0mkCpPM4ksBcMEaXIXQ
 uHgkKqTwI2rjqk9McXYXLwyNEKAiE8Py5tUsiG7eKaQpb+YReNN6cChZUt9yU02MZ5eG
 lmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8jS7+sK+VOWigPY1q5W77YMTHCuDnHzgvWGfuf+9BAA=;
 b=TgsnhOBIXzI1PndDgpaitPfwQYnlM9LDwcE6b2MHEKn0+NZzVpXhv93hNexFXYllBt
 kLzWFIkpnBmhBFBtk6XJIPM0TNwFZI/stve42b1IiI5Se6iTrnq48us2ZOcTjDB06kW6
 uBy7OhP7B0m6JUG1EwXzAxk3kpM8fA17XJ32GwHBiZylak4Bshtip8Sjg1EpM92WBUTW
 R8PN/HPlH+YipS4x4P7AlB6OeLxztG64wIo8XMbW7kCR63EG+PvymjfIzes1BPYAp+rI
 spPEwreCCeosa8mBs43vHHtY0hiKWoUp1IEQ3HfAOmkICBAZ7ZUAzCHivDF3PYANQc5d
 dDNQ==
X-Gm-Message-State: APjAAAUn7hqMHjgng/SeGMSifUhb03aHTyDqryGSSkF0ALJGYa672wJo
 nJd1dqvqZI9BLe/7Z7kJKVa3W/wtXLU=
X-Google-Smtp-Source: APXvYqyNooYO1ks8Dbu4+/cbPxHLOh7oVAAPtnFuNiQhik3OflMKJIg8hxjgYGOFcZOFKnnEhIUF8w==
X-Received: by 2002:a62:2d3:: with SMTP id 202mr23840798pfc.131.1564163481243; 
 Fri, 26 Jul 2019 10:51:21 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:05 -0700
Message-Id: <20190726175032.6769-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PATCH 40/67] target/arm: Convert TT
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
 target/arm/translate.c | 88 ++++++++++++++----------------------------
 target/arm/t32.decode  |  5 ++-
 2 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index df515e9341..a750a2c092 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8525,6 +8525,31 @@ static bool trans_SG(DisasContext *s, arg_SG *a)
     return true;
 }
 
+static bool trans_TT(DisasContext *s, arg_TT *a)
+{
+    TCGv_i32 addr, tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+    if (a->rd == 13 || a->rd == 15 || a->rn == 15) {
+        /* We UNDEF for these UNPREDICTABLE cases */
+        return false;
+    }
+    if (a->A && !s->v8m_secure) {
+        gen_illegal_op(s);
+        return true;
+    }
+
+    addr = load_reg(s, a->rn);
+    tmp = tcg_const_i32((a->A << 1) | a->T);
+    gen_helper_v7m_tt(tmp, cpu_env, addr, tmp);
+    tcg_temp_free_i32(addr);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
 /*
  * Load/store register index
  */
@@ -10417,7 +10442,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rs;
+    uint32_t rn;
     int op;
 
     /*
@@ -10461,70 +10486,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     /* fall back to legacy decoder */
 
     rn = (insn >> 16) & 0xf;
-    rs = (insn >> 12) & 0xf;
-    rd = (insn >> 8) & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
         abort();
     case 4:
-        if (insn & (1 << 22)) {
-            /* 0b1110_100x_x1xx_xxxx_xxxx_xxxx_xxxx_xxxx
-             * - load/store doubleword, load/store exclusive, ldacq/strel,
-             *   table branch, TT.
-             */
-            if (insn & 0x01200000) {
-                /* load/store dual, in decodetree */
-                goto illegal_op;
-            } else if ((insn & (1 << 23)) == 0) {
-                /* 0b1110_1000_010x_xxxx_xxxx_xxxx_xxxx_xxxx
-                 * - load/store exclusive word
-                 * - TT (v8M only)
-                 */
-                if (rs == 15) {
-                    if (!(insn & (1 << 20)) &&
-                        arm_dc_feature(s, ARM_FEATURE_M) &&
-                        arm_dc_feature(s, ARM_FEATURE_V8)) {
-                        /* 0b1110_1000_0100_xxxx_1111_xxxx_xxxx_xxxx
-                         *  - TT (v8M only)
-                         */
-                        bool alt = insn & (1 << 7);
-                        TCGv_i32 addr, op, ttresp;
-
-                        if ((insn & 0x3f) || rd == 13 || rd == 15 || rn == 15) {
-                            /* we UNDEF for these UNPREDICTABLE cases */
-                            goto illegal_op;
-                        }
-
-                        if (alt && !s->v8m_secure) {
-                            goto illegal_op;
-                        }
-
-                        addr = load_reg(s, rn);
-                        op = tcg_const_i32(extract32(insn, 6, 2));
-                        ttresp = tcg_temp_new_i32();
-                        gen_helper_v7m_tt(ttresp, cpu_env, addr, op);
-                        tcg_temp_free_i32(addr);
-                        tcg_temp_free_i32(op);
-                        store_reg(s, rd, ttresp);
-                        break;
-                    }
-                    goto illegal_op;
-                }
-                /* Load/store exclusive, in decodetree */
-                goto illegal_op;
-            } else if ((insn & (7 << 5)) == 0) {
-                /* Table Branch, in decodetree */
-                goto illegal_op;
-            } else {
-                /* Load/store exclusive, load-acq/store-rel, in decodetree */
-                goto illegal_op;
-            }
-        } else {
-            /* Load/store multiple, RFE, SRS, in decodetree */
-            goto illegal_op;
-        }
-        break;
+        /* All in decodetree */
+        goto illegal_op;
     case 5:
         /* All in decodetree */
         goto illegal_op;
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c0b962479b..90db05dab6 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -506,7 +506,10 @@ STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
 @ldrex_d         .... .... .... rn:4 rt:4 rt2:4 .... .... \
                  &ldrex imm=0
 
-STREX            1110 1000 0100 .... .... .... .... ....      @strex_i
+{
+  TT             1110 1000 0100 rn:4 1111 rd:4 A:1 T:1 000000
+  STREX          1110 1000 0100 .... .... .... .... ....      @strex_i
+}
 STREXB           1110 1000 1100 .... .... 1111 0100 ....      @strex_0
 STREXH           1110 1000 1100 .... .... 1111 0101 ....      @strex_0
 STREXD_t32       1110 1000 1100 .... .... .... 0111 ....      @strex_d
-- 
2.17.1


