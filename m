Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03E82189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n14kUCs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03E82189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i340V-0000QO-Cw
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GY-0003qA-43
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GV-0000Re-F4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GV-0000QT-3N
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:55 -0400
Received: by mail-pl1-x641.google.com with SMTP id h3so393673pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zQWrs3An1QMtHJ2W4jZK3gQeIav2dkJ4+fToZUQZoOI=;
 b=n14kUCs+FUs+v/ojGQSd9viKzyRP0l4QSRqB7VdWfADDg72eGCU208XWqaxAEbHJ0H
 vt6B+McnL+dTc3mNfnz3U4+tE7vaw3eZehQ1TaFpRxpiGSrXKjjKu3hKej45m8rRK7TW
 B4/2fA8DQocP1raSSEGf50CQvopECXY98veLUCMZX74rCR165+N4nJlTUUD0kalJ3Gdj
 O5rQ+8twwfMKmN3oWbQXvml1fesmGYAuA3NnYepsJnzRirKOLBGgD//FYPUDxjnf7UOW
 rqw24FNEKngam1Yxg/K3MmFsKjsULZH63uqHb1eoqSPfD8TcOjGxraqinu+5iZFv2QCl
 x/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zQWrs3An1QMtHJ2W4jZK3gQeIav2dkJ4+fToZUQZoOI=;
 b=qWE5HaSBWQ4cc5eZ7SDhnYluJ8Hw/md2W2k0QN3jjtHPkQTtT2r4gM2l8LrlzYdJme
 JAcGQvi6wNm1Jvzq7XCPyz84usy+wzEjWA8ozCxqb2CE4amnWLfzdJzCnNCoR7bIvqDp
 Dns5gCBZSQC6fmHix4J1Cpe31Zf35SAvkt85QIBH0meR+DbD++V//dr+u6RqmzUDaX3N
 Rrm6A+AKiTr9Ypi3sNyGRIUKdCxRfe9cAWhiqhnEEy7MlsRod3AKwXJjAq2uAvbQL2Au
 nyy96k7Ia+pBU4EtG6UqwsAKP4bH6Hsj+OEqpJMDQty/pC/JpdYCyql/L2Fo3Aqc7hzY
 MQfQ==
X-Gm-Message-State: APjAAAXO5L93Z0aM2S3PMJ4jyI0QaYHpB0LwTtDylWOnKlit6/DGOEKM
 ocL7SQvQDIqCRHr2GHFdUYjehhojx+w=
X-Google-Smtp-Source: APXvYqwXe0tlIrcFsVQ0CUF2UIRASjs+8DOnlGzAkYJTfytVqtYGppulOzPdSHaTq0dm3qRSl3DhOA==
X-Received: by 2002:a17:902:8649:: with SMTP id
 y9mr5448781plt.252.1567019153746; 
 Wed, 28 Aug 2019 12:05:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:29 -0700
Message-Id: <20190828190456.30315-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 42/69] target/arm: Convert TT
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
index 52da7f4fa8..05aa998640 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8469,6 +8469,33 @@ static bool trans_SG(DisasContext *s, arg_SG *a)
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
@@ -10502,7 +10529,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rs;
+    uint32_t rn;
     int op;
 
     /*
@@ -10546,70 +10573,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index 2b30a767fe..91ba4ca7ae 100644
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


