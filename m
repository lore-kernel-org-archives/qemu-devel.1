Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E0621726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWmnukhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E0621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bpY-000263-My
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0Z-0005GD-Rn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0X-0002rv-WE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0X-0002qm-L6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so11767558pgb.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3YTIbEYYLxo/KQorAmZTbgiM25Lefa2PHYOLeWCcYi0=;
 b=sWmnukhBDGqqcv9TjfJdZ4SDcjn9MSCaKDM1tJlw3hc3tFSxec9rouYA6YODRBk0o7
 n94gEhbxKULseowqcYiiBCewkSsYUt8yq+el1xfOtPtk12nql1NRSzE7ZknirJ2Xcbd5
 ANt7aIWg/D1iLHRXqxnubmvKCKvXIHfTHrO4SgDq5tioVMz1lHYX7VZNzXRoxSmEZMQX
 jWSaxVv7e6fGN5ciAUK3BkJsRoz+mTHBpcesf1guc1o/EAkSKx2PWE3Ec9K87205CoUS
 LSLZMszDz8c1KSyKVlXoWjVSgrHfFA6yUZg8ZUO1na9EJTx1ae9wTM/rvhmx4WyYe7xU
 DZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3YTIbEYYLxo/KQorAmZTbgiM25Lefa2PHYOLeWCcYi0=;
 b=TdJmOILL9+7AjrPvSnocMTxYAiZMYKrr3erJzrJaytKX6Gz8DQUGTRxPPrTT3LLMq1
 RpZDQcx7ohQBlRIy9mNss07suGQB9BZXW0yCfD5E9kmvxbYn+DdDcGZnnjdj085Bpuop
 aBUUbVC5IDflvjdQWL99m5earcPxJVO3ZaXli/n5t2DXyiM22c1AyulRAURDFEFaBZqR
 t+kyhbJ5Qx6knzl0mOtvq9GZfcPOtI+Z3Mu1Xg+n1DXUlPUDa4pCc+erdQJIxcL+JJEv
 jPDr94x33bLKAg0OcfYwglO1k5kp0mOiF0yaOuLmaBQZ6nwPhQBgkyDlG/Jc/Qz12XSj
 NGxg==
X-Gm-Message-State: APjAAAWz5mwICENaTe+oJmlV7kqu7wcZ7JrxD/X1mkJy+NCB1Ibdl9KH
 21CvVGjqvgX03WDEGq2z5c+dd/cfEAo=
X-Google-Smtp-Source: APXvYqxeXi/ceqN0XHAoOunUdbpcpnq/5W8WjrkMgDm0AyORoB8C0RwshAs0bQ5OPQVwMv92XfPiGA==
X-Received: by 2002:a63:f048:: with SMTP id s8mr35777496pgj.26.1567625516138; 
 Wed, 04 Sep 2019 12:31:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:33 -0700
Message-Id: <20190904193059.26202-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 43/69] target/arm: Simplify disas_thumb2_insn
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

Fold away all of the cases that now just goto illegal_op,
because all of their internal bits are now in decodetree.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 79 ++----------------------------------------
 1 file changed, 3 insertions(+), 76 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46c27ea6a8..f68e09ff1f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10552,9 +10552,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rn;
-    int op;
-
     /*
      * ARMv6-M supports a limited subset of Thumb2 instructions.
      * Other Thumb1 architectures allow only 32-bit
@@ -10595,34 +10592,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     /* fall back to legacy decoder */
 
-    rn = (insn >> 16) & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
         abort();
-    case 4:
-        /* All in decodetree */
-        goto illegal_op;
-    case 5:
-        /* All in decodetree */
-        goto illegal_op;
-    case 13: /* Misc data processing.  */
-        op = ((insn >> 22) & 6) | ((insn >> 7) & 1);
-        if (op < 4 && (insn & 0xf000) != 0xf000)
-            goto illegal_op;
-        switch (op) {
-        case 0: /* Register controlled shift, in decodetree */
-        case 1: /* Sign/zero extend, in decodetree */
-        case 2: /* SIMD add/subtract, in decodetree */
-        case 3: /* Other data processing, in decodetree */
-            goto illegal_op;
-        case 4: case 5:
-            /* 32-bit multiply.  Sum of absolute differences, in decodetree */
-            goto illegal_op;
-        case 6: case 7: /* 64-bit multiply, Divide, in decodetree */
-            goto illegal_op;
-        }
-        break;
     case 6: case 7: case 14: case 15:
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
@@ -10651,6 +10624,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
 
                 if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
+                    uint32_t rn = (insn >> 16) & 0xf;
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
@@ -10709,50 +10683,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
         }
         break;
-    case 8: case 9: case 10: case 11:
-        if (insn & (1 << 15)) {
-            /* Branches, misc control.  */
-            if (insn & 0x5000) {
-                /* Unconditional branch, in decodetree */
-                goto illegal_op;
-            } else if (((insn >> 23) & 7) == 7) {
-                /* Misc control */
-                if (insn & (1 << 13))
-                    goto illegal_op;
-
-                if (insn & (1 << 26)) {
-                    /* hvc, smc, in decodetree */
-                    goto illegal_op;
-                } else {
-                    op = (insn >> 20) & 7;
-                    switch (op) {
-                    case 0: /* msr cpsr, in decodetree  */
-                    case 1: /* msr spsr, in decodetree  */
-                        goto illegal_op;
-                    case 2: /* cps, nop-hint, in decodetree */
-                        goto illegal_op;
-                    case 3: /* Special control operations, in decodetree */
-                    case 4: /* bxj, in decodetree */
-                        goto illegal_op;
-                    case 5: /* Exception return.  */
-                    case 6: /* MRS, in decodetree */
-                    case 7: /* MSR, in decodetree */
-                        goto illegal_op;
-                    }
-                }
-            } else {
-                /* Conditional branch, in decodetree */
-                goto illegal_op;
-            }
-        } else {
-            /*
-             * 0b1111_0xxx_xxxx_0xxx_xxxx_xxxx
-             *  - Data-processing (modified immediate, plain binary immediate)
-             * All in decodetree.
-             */
-            goto illegal_op;
-        }
-        break;
     case 12:
         if ((insn & 0x01100000) == 0x01000000) {
             if (disas_neon_ls_insn(s, insn)) {
@@ -10760,14 +10690,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             break;
         }
-        /* Load/store single data item, in decodetree */
         goto illegal_op;
     default:
-        goto illegal_op;
+    illegal_op:
+        unallocated_encoding(s);
     }
-    return;
-illegal_op:
-    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
-- 
2.17.1


