Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3915322CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNdd8Diu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3915322CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bmJ-0006kJ-Ll
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0Y-0005Ee-RJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0W-0002qQ-Kk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0W-0002pG-Bi
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id q21so8879137pfn.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1o+uWqBuu4o1NL9VW7TCfscdl6K+gK/4Ohpfut2UuGg=;
 b=fNdd8DiuTLcYPMGPz+kZGEZm4gOdHJ/qr/K3hJmq8zB+3wPlF8ErMIikd1RNliqWM/
 6IzjIlqCFvu2Y+zQkQdAjABeSb79T47F206LwD7yO9s6qn5mYuzUMjJ2PpxGjfuyQN/L
 mXgDlbbRg4PUSL5DNfnSSHK7PMVvkQjPwe3q5vZALDJKkmwlCzs61njv5oZQAwkL7jU0
 LIYdvIBNRXjOeb6Wn1lcn9yc2cqY5EPAYTHtvG79V2IXksLR5nBUFdY86lpBlQem6JZ7
 cEOOeEvItIPqJ3UB2EsOttSCI32ObEDyqU0U4kwzd7S2Y8F+0nxaMRL5+h9/7cnPW/vk
 aS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1o+uWqBuu4o1NL9VW7TCfscdl6K+gK/4Ohpfut2UuGg=;
 b=JRdtDLG5/wUipQjJL0u+VO+phpbiW75sAGo2P4i53nyBn56hHBlwMsJlMDoAnhO5pB
 ZSKwsJGpItcCgxz4L3WaCJTbbTTYdvzBgYy+gBqCkTJ41MQwJmPpjIu+BBL3EUnaI/TU
 f0Lr1jVt3zoosXATUYthqPLmgD4dQwr4/T7vNoXFdLqHh5bxyWkt4suDhFserIJ00L8A
 4aQEDy3gS45kaOE3A/Y29qUu4I1CLLd9GewtywWMCW2x3gAJGYcudz35gnlZagJ99N5l
 KjUKsDm+O1YtBMmKGAKSBCNWIzGLt+9OEwbDA9AmDoBkXwvd4vPBFDfyihJ1ySOs3vt1
 2wMg==
X-Gm-Message-State: APjAAAWNoNYuz0rLPj+xjNeTKHlaxQegZYuQ6EcYjlbcOMedBFUYWH38
 izAisoCYgCn8yWv3Jt731YMURQYbjug=
X-Google-Smtp-Source: APXvYqzkR1nB+o0n7VkzJ53grmloFg4oT7AdQWlmAoo3XojS37DC2XiOiPSyicwBzLCZlvd58cdL3g==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr37649749pgo.64.1567625514948; 
 Wed, 04 Sep 2019 12:31:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:32 -0700
Message-Id: <20190904193059.26202-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 42/69] target/arm: Convert TT
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
v3: Use unallocated_encoding.
---
 target/arm/translate.c | 90 ++++++++++++++----------------------------
 target/arm/t32.decode  |  5 ++-
 2 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index af7eddca48..46c27ea6a8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8495,6 +8495,33 @@ static bool trans_SG(DisasContext *s, arg_SG *a)
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
+        unallocated_encoding(s);
+        return true;
+    }
+    if (a->A && !s->v8m_secure) {
+        /* This case is UNDEFINED.  */
+        unallocated_encoding(s);
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
@@ -10525,7 +10552,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rs;
+    uint32_t rn;
     int op;
 
     /*
@@ -10569,70 +10596,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index c956ddb254..c63082fc9c 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -508,7 +508,10 @@ STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
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


