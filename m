Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9858C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71960208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAWMyx+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71960208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c6X-00038U-2m
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0p-0005QE-8K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0n-00034A-3p
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0l-0002yr-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id y9so13912269pfl.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w0yZvSWJxMpGMZQus1AoRlEpuCLgbCFvsCSBHnvLgJY=;
 b=oAWMyx+OInAyeHVBRTYQ0211CU9f7YQQu7eHhi0OtBesm6zLBmEq4gf0IAnKFOltPU
 FKqnJxVRtrbo0daKSFCCZxQHxGDhHrvx0UwxrpjDBHWNdI50D9d4+Okda5HrDKAlRBAa
 XCNHiXgJS0RaUzzpBG6aMA4PvDSaUmgY61v0ysv2xMJAP443bsF8l6TmdKYeIGbiIVKh
 BJ487Djgb1nLzYlDBW/Y6mfmewyiEIlU5m7YHGwrB6yAcgOlTqLcVCx/AbOQj4k3kqs7
 vP38dqCyHKO54mAMSc225E7JzZ5IGQlDoCVCYyvU+Svt4po73TMEDYbt0CFoJxXJR1c1
 71Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w0yZvSWJxMpGMZQus1AoRlEpuCLgbCFvsCSBHnvLgJY=;
 b=LaUY3Z5uL8gq1a+J2B5o0EudKMjVZDoMGlZ0621aYz7pDnin2C0pyn4hwe1x/nNofZ
 2jDy0mlI0+vRb1sckcR8ZVV9FswChvEB8Bqgc7LxneJHTJfTR6aWY7DrGBOietn+kBeX
 FHtMjDV343EerWYVa2qEi6YvJW2iCyZbKQBXxvBtibVX27t/giwVkpAKC3MTkzrM4EeQ
 lZfBMgMowWb94Uyp4UUWxqKSHSE66Gss4xCt71O1BkFtAtkhyg7FO9Ih5jHv5+NIglI1
 p3jgAuJZ33PIikFhLQ+mI5pfBg0QQHn57KqmSdxRHTm6e9BFZnaXTkS8NH4b9OU8AdlP
 iz7Q==
X-Gm-Message-State: APjAAAUbyBWHTgadpo8Asck02BLzw7xPh8/clGlrcwMe3RLYKwKUXJa9
 XdMH92sFc2lqQp9LmRa01DSNEBpg1Yg=
X-Google-Smtp-Source: APXvYqzDmzn2ArF2IUTIOfAmxP6op311GEPsnDAViWTSHhSS5FOzm+s1OKHauysgb9jGLdn0Ju6heQ==
X-Received: by 2002:a63:b346:: with SMTP id x6mr36949199pgt.218.1567625524723; 
 Wed, 04 Sep 2019 12:32:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:40 -0700
Message-Id: <20190904193059.26202-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 50/69] target/arm: Convert T16 load/store
 multiple
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
 target/arm/translate.c | 48 ++++++++----------------------------------
 target/arm/t16.decode  |  8 +++++++
 2 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d8a4c7bf99..f9d4b619fa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10092,6 +10092,14 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
     return do_ldm(s, a, 2);
 }
 
+static bool trans_LDM_t16(DisasContext *s, arg_ldst_block *a)
+{
+    /* Writeback is conditional on the base register not being loaded.  */
+    a->w = !(a->list & (1 << a->rn));
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return do_ldm(s, a, 1);
+}
+
 /*
  * Branch, branch with link
  */
@@ -10869,6 +10877,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
     case 10: /* add PC/SP (immediate), in decodetree */
+    case 12: /* load/store multiple, in decodetree */
         goto illegal_op;
 
     case 11:
@@ -11092,45 +11101,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 12:
-    {
-        /* load/store multiple */
-        TCGv_i32 loaded_var = NULL;
-        rn = (insn >> 8) & 0x7;
-        addr = load_reg(s, rn);
-        for (i = 0; i < 8; i++) {
-            if (insn & (1 << i)) {
-                if (insn & (1 << 11)) {
-                    /* load */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    if (i == rn) {
-                        loaded_var = tmp;
-                    } else {
-                        store_reg(s, i, tmp);
-                    }
-                } else {
-                    /* store */
-                    tmp = load_reg(s, i);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                /* advance to the next address */
-                tcg_gen_addi_i32(addr, addr, 4);
-            }
-        }
-        if ((insn & (1 << rn)) == 0) {
-            /* base reg not in list: base register writeback */
-            store_reg(s, rn, addr);
-        } else {
-            /* base reg in list: if load, complete it now */
-            if (insn & (1 << 11)) {
-                store_reg(s, rn, loaded_var);
-            }
-            tcg_temp_free_i32(addr);
-        }
-        break;
-    }
     case 13:
         /* conditional branch or swi */
         cond = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 71b3e8f02e..a7a437f930 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -26,6 +26,7 @@
 &ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
+&ldst_block      !extern rn i b u w list
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -109,3 +110,10 @@ LDR_ri          10011 ... ........              @ldst_spec_i rn=13
 ADR             10100 rd:3 ........             imm=%imm8_0x4
 ADD_rri         10101 rd:3 ........ \
                 &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
+
+# Load/store multiple
+
+@ldstm          ..... rn:3 list:8               &ldst_block i=1 b=0 u=0 w=1
+
+STM             11000 ... ........              @ldstm
+LDM_t16         11001 ... ........              @ldstm
-- 
2.17.1


