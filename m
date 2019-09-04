Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A54C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6AE21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBr3jDB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6AE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bsa-0004wl-6p
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0t-0005Ud-Cs
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0r-00037q-39
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0n-00030g-7w
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id q5so6054477pfg.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GTpzfRqA1Z7CTTR4kjGQDvZeJQsqYpR7KKBaZOTKQX8=;
 b=xBr3jDB+VGXTWDyJtijhac1nLdzJw0dR9/idz0hu1xY62fYMdAqnpwxvJT5mP76+xC
 5GtUs8+hfRtJ6q4YZxWFsSW1rbvBHLFvizZPdrRCAEDEUw/FbEylHgNZJEMURJ8SlnkQ
 65HA6LJFKtgMlJpDPJORWkGXjrlIRYHgroIAHN7m65QvRD4Adzd27TD/kJ0rva2HN2/i
 fwosAVB8e9Ph9G0b1+ZTQDKg/MzXAc9HwVPIQLbxsSfqn5jkaY1lrsv26EF8P5n+Iefg
 facNsKao72OMYvDwYrtbAddx+bUzAiFv27Ds6xZD8w6UrwaerIhS7oKI5BxnrT+c2hAB
 YRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GTpzfRqA1Z7CTTR4kjGQDvZeJQsqYpR7KKBaZOTKQX8=;
 b=HIUOHPlkBPDHEh7Q2XZ1KiD50gszZvKknIAcpqCn69L5Nvu+/L4bodjjBux5Go5Rzn
 kGA7vaFYAQUi8JoLbEKDJ2Cqk3EW08Lk3wK7czQ5C8Th0FSZ5PqZSlC+O0CgYk+3FMtj
 78siSLBCxmHGpZCJGMs70BR3As9FdJohOgK4I0wJ7zxpQv5iMHvLGH3+SBoIFT+/BUgX
 XILoXBImeU016gzA7qVzVZxHvuP9UHPwSIFx4ECXttrE2xf1bXPV+7qQMTkFC3Gzzba6
 rF3AejtE00JlDMZzNup+/Y5W+ImpgpNr6Y4Rp3jiuAGp3jAWvS6P5uqPCClAYzBgEoiN
 RXsg==
X-Gm-Message-State: APjAAAVQwzhCOI14BJRrDuu3g27M1fHkdKmj+mqEMcFyLZQNjJ+PtghB
 6EvEoEaYhm2ksJo8jd/7mAloZsKT7cg=
X-Google-Smtp-Source: APXvYqwDF0NMnvJblyDch+LRhDkCAcR5UPs4+J+1sM4hdDW+mCB45EGKca0+qraeOWvnZFAs4+I0eA==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr19300441pgb.19.1567625527220; 
 Wed, 04 Sep 2019 12:32:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:42 -0700
Message-Id: <20190904193059.26202-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 52/69] target/arm: Convert T16 one low
 register and immediate
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
 target/arm/translate.c | 44 ++----------------------------------------
 target/arm/t16.decode  | 11 +++++++++++
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 45d617a2d3..405176527c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10705,48 +10705,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
         }
         break;
-    case 2: case 3:
-        /*
-         * 0b001x_xxxx_xxxx_xxxx
-         *  - Add, subtract, compare, move (one low register and immediate)
-         */
-        op = (insn >> 11) & 3;
-        rd = (insn >> 8) & 0x7;
-        if (op == 0) { /* mov */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, insn & 0xff);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        } else {
-            tmp = load_reg(s, rd);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, insn & 0xff);
-            switch (op) {
-            case 1: /* cmp */
-                gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp);
-                tcg_temp_free_i32(tmp2);
-                break;
-            case 2: /* add */
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            case 3: /* sub */
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            }
-        }
-        break;
+    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
+        goto illegal_op;
     case 4:
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 2b5f368d31..0654275e68 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -133,3 +133,14 @@ SUB_rrri        0001101 ... ... ...             @addsub_3
 
 ADD_rri         0001 110 ... ... ...            @addsub_2i
 SUB_rri         0001 111 ... ... ...            @addsub_2i
+
+# Add, subtract, compare, move (one low register and immediate)
+
+%reg_8          8:3
+@arith_1i       ..... rd:3 imm:8 \
+                &s_rri_rot rot=0 rn=%reg_8
+
+MOV_rxi         00100 ... ........              @arith_1i %s
+CMP_xri         00101 ... ........              @arith_1i s=1
+ADD_rri         00110 ... ........              @arith_1i %s
+SUB_rri         00111 ... ........              @arith_1i %s
-- 
2.17.1


