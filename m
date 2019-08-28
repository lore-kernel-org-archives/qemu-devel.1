Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0722173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erxTp27y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0722173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Gm-0001hh-Lf
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gl-0003tx-4t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gi-0000bE-Q3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gg-0000XV-Oe
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id v12so375599pfn.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6MCGFTmei0/LomQ5kSqH0JJCmj9qk8EmtY5FJ9APNto=;
 b=erxTp27yilKFTy0BE4fI3n4xYC6VEA9GgNc62jBB4wz8rvfhJVisEGTZkdKL4yWr04
 IRf0W6tJaeTvppRPHulBluNwX9LsstOyDoZtKmhFOpa4RQvJ6NFULZIJKPXnHhw+wHyw
 iNhLwG0HbndKrWSpeYork+qk4vMDYhvcIHvz59A7b+DPHuHSsn79DIxyCC9CYOfDHT97
 mDo7JTIW3P22xKkBo/LSVgGcgTM4+vzntLqaPVT48LAGKRxtgzAblbWSrQj0gzrHazWN
 +jM14njb5N3s1DNHUv/tKc9UNQSEVzVTLyYFK5SFGjxeRLKkN9Niyf2UBuXZ24awk72Y
 LDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6MCGFTmei0/LomQ5kSqH0JJCmj9qk8EmtY5FJ9APNto=;
 b=nnRwS+PSHMc3iIEEBEAqwvau/Dg4nE46kWUD0aly5Fw0aibz603oUpab3kr1fVzEVV
 yRVWzgB/x3CKMIuB6ROHIfHkYvInBR2C3qgQ2Q60D66ZOwhlPxLUgYL0t/0crBTTEbEJ
 gVaS7gRXRe0ytzxDzIwHmKCqqrM22HykVjc8v0FzH3SFYeCbgzysEq6I/wzExGf2KsHY
 ID3rYtS0EL16jW7X9XvkOQqnVQZCsgpIS850uwbG04LxmQZ7evDnJ7mg1LBBGHaDTUB0
 iiYSuD2nOvtmJfw7qwpuDE3Vy1ACOq1UyqCDzlSvBUBFk4aWd3Cliof6nEartQq7zh4J
 f78g==
X-Gm-Message-State: APjAAAWV1wdaIuAs+DGI5cAc/B2/BWlVi0NZI43Q3NubqCF3PY81O7Wl
 l1uMP4FGg+0s0A5I2Ik7RMY/qc0k/6o=
X-Google-Smtp-Source: APXvYqxRivS6oW1ySuCEG7Pk+DKc/MmeDR1LxETeA4z1Etl7uZ9bSBcA3cnFoAO5XIn3QEZlEZGBDg==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr4873135pgi.264.1567019163712; 
 Wed, 28 Aug 2019 12:06:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:37 -0700
Message-Id: <20190828190456.30315-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 50/69] target/arm: Convert T16 load/store
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
index d8dfddaea3..b6ee123bf5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10059,6 +10059,14 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
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
@@ -10846,6 +10854,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
     case 10: /* add PC/SP (immediate), in decodetree */
+    case 12: /* load/store multiple, in decodetree */
         goto illegal_op;
 
     case 11:
@@ -11069,45 +11078,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


