Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D96C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2984E22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRiUNrzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2984E22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpoy-0007Xw-1D
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMd-0002RD-Df
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMb-0006bU-7O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMX-0006XJ-Ap
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id m12so1591036plt.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ac3UBjPihyDkOeX0vZxfIb3puwN3GecMDaJ1xyBUXaw=;
 b=VRiUNrzCYdV2Fjxa9QpObGV22NV5RPDM6YKfqC4R20btrDTQT8tH2oFbUdq0MujkiR
 Ar7IApPhQp9siEY3cQ4oMIqajBbJSIJnTguFuyETeCWbJudkZv3d1a4NvTrqH+T1+7ti
 tmM/p9YsIVcaJD73f4veRXN80sWJI418zM7CPyToiKXXm5sNLwHwonFjukw3eDzsF8nA
 eoVp3KQ9ygS6g7ikDHI/qDWCT99hsBRCJPIhWREG5fB71UF2JA608xjS7BbznGPrpjr7
 +rOaq0j2JISMe0HktD7nS3ceRRmiA4Ac7Q556zguAO8PJABdXOJINGYKm53YOjTe1wY8
 O4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ac3UBjPihyDkOeX0vZxfIb3puwN3GecMDaJ1xyBUXaw=;
 b=isLiqaxi+20xOL8QyyMkuPjNQW/02RFcZMtpY8zmjEGdGTbOGJ8DEN8oeXfeTGfCSP
 3jTQwd3f+ssqf4U1okDwKluzec/v8Aqd8V+Chc4xIqD36YNa1ZRA4WGJdxnc6R8duZjy
 WzkwrL5x7khdwDkc/jF96v8E6rpbuc1I0y/qdaZlWKTdcPCNS7m8DV0FHMjJaCK3ZR96
 CTHQdO2+4/5UBjYQXm9y1uKhhrA1lF9qPchTK9dmZBj+WggqEUSNM2zNJxXBfRI+t3zK
 t5xtfvSxcdDfsHOUG6oRxf24rSfaKB8KwP7EIXj1R48z1NFgRDqncfqzlQb5TmtCYUwq
 sXQA==
X-Gm-Message-State: APjAAAURifEgTwbb1HnIXvM/AfkC/88v15cPs0Q2ITQ9QAq3BaYFDDuy
 XYg3qic0BJE0ahMuJ0rTiyunkDG00zU=
X-Google-Smtp-Source: APXvYqx4LamgaJDw1LT9cmAMavLrBNJ6adbVGQ37v05DG++uJiE2J3bkryRjBmrLH9Pat3vO0hUX8Q==
X-Received: by 2002:a17:902:2bc5:: with SMTP id
 l63mr22378145plb.239.1566250727323; 
 Mon, 19 Aug 2019 14:38:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:28 -0700
Message-Id: <20190819213755.26175-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 41/68] target/arm: Convert TT
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
 target/arm/translate.c | 87 +++++++++++++-----------------------------
 target/arm/t32.decode  |  5 ++-
 2 files changed, 31 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9a8864e8ff..d1078ca1ec 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8454,6 +8454,30 @@ static bool trans_SG(DisasContext *s, arg_SG *a)
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
+        return false;
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
@@ -10409,7 +10433,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rs;
+    uint32_t rn;
     int op;
 
     /*
@@ -10453,70 +10477,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index ce46650446..bb875f77b0 100644
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


