Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8CC41514
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBA72173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnwvmjTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBA72173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp1M-0003Km-En
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozR-00071Z-0g
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozQ-0001Ho-0F
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozP-0001G4-Qy
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so44696427pfe.11
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KppSBSLgqldeUIFCtJ9vyMILLmhpVP0HjXn8WOkkAA4=;
 b=WnwvmjTrnJNDu8FpkcTfajv3YXkp1HDXgKJRDnJsh4LeprPE+rotaDg4ArlBy1pUqi
 MZLBz7rc+F9xOy/MNt81VkGgqzO4Jdw8I394H1auRIe6ugilnMZs6WQBakXrAZebVnOp
 smUm8YPLbU5Vi9kD5cFR3zfwYvniUefvxMMqshlui48xAy59hVauPkjscWOFwMRyl1ZY
 YT1bQp7hM+l0T6qpOP7uH9oGv81z0mAKikO87668goWxo3r6FHp8MtDg6aUy1Rk9KOr/
 ++9updJ2Yp6+tALpTW8JV1s47nUe0LrhWt9jmdUvdrSLGVm4ce9DYHCu+PSvZoKu5QSy
 mCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KppSBSLgqldeUIFCtJ9vyMILLmhpVP0HjXn8WOkkAA4=;
 b=snEYsuxS1X9GW5PtwQB2N67POEddrc9JEAnHbJGtJVx2SSOjeL0MEaSMRrXm/3tbZB
 isqZuoBOTbi2WeBBPvb4mb87qXuVAqftvsAJE7QoexBsZFiqVw9JRtyE4NX0iRhQUbFp
 Rb5HeWwhFH0183LZMnLlAmbW999tP0b5cJsDPv3I9hsUW8XPU/tdmZRbsSiarmPJhIqb
 3YjtlLA7PyW3EgfO7hVzMENEjWehywmZevlVL/XVBjNGPWgN+sBosOpCU6mkByDNEHq+
 hnf1hIUcyR2jO/G7hiB9VrRiMEuvHZjWQoS/hWqgD99F4rK3mszfUUSPsGilrYdX8X/c
 R/TA==
X-Gm-Message-State: APjAAAXUbhxnVsX4s4PnQWKkRk8yUzNuGjQbXxOiDHHy38OQheT6CKvB
 ghW5SPKQbZQvjHZi+S+ynqHFOdFzQLA=
X-Google-Smtp-Source: APXvYqyRqEzzbb30wen7bTbdUzD/fS5VaTAp+LTO/o6EPXhMrHB7vKvkSGhFZOBNiYUp+Bld5dhnjQ==
X-Received: by 2002:a17:90a:2305:: with SMTP id
 f5mr6123614pje.128.1565295982598; 
 Thu, 08 Aug 2019 13:26:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:12 -0700
Message-Id: <20190808202616.13782-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 3/7] target/arm: Remove redundant shift tests
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

The immediate shift generator functions already test for,
and eliminate, the case of a shift by zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 94170af134..3ddc404b3b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8826,8 +8826,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         shift = (insn >> 10) & 3;
                         /* ??? In many cases it's not necessary to do a
                            rotate, a shift is sufficient.  */
-                        if (shift != 0)
-                            tcg_gen_rotri_i32(tmp, tmp, shift * 8);
+                        tcg_gen_rotri_i32(tmp, tmp, shift * 8);
                         op1 = (insn >> 20) & 7;
                         switch (op1) {
                         case 0: gen_sxtb16(tmp);  break;
@@ -9904,8 +9903,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             shift = (insn >> 4) & 3;
             /* ??? In many cases it's not necessary to do a
                rotate, a shift is sufficient.  */
-            if (shift != 0)
-                tcg_gen_rotri_i32(tmp, tmp, shift * 8);
+            tcg_gen_rotri_i32(tmp, tmp, shift * 8);
             op = (insn >> 20) & 7;
             switch (op) {
             case 0: gen_sxth(tmp);   break;
@@ -10632,11 +10630,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     case 7:
                         goto illegal_op;
                     default: /* Saturate.  */
-                        if (shift) {
-                            if (op & 1)
-                                tcg_gen_sari_i32(tmp, tmp, shift);
-                            else
-                                tcg_gen_shli_i32(tmp, tmp, shift);
+                        if (op & 1) {
+                            tcg_gen_sari_i32(tmp, tmp, shift);
+                        } else {
+                            tcg_gen_shli_i32(tmp, tmp, shift);
                         }
                         tmp2 = tcg_const_i32(imm);
                         if (op & 4) {
@@ -10827,9 +10824,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     goto illegal_op;
                 }
                 tmp = load_reg(s, rm);
-                if (shift) {
-                    tcg_gen_shli_i32(tmp, tmp, shift);
-                }
+                tcg_gen_shli_i32(tmp, tmp, shift);
                 tcg_gen_add_i32(addr, addr, tmp);
                 tcg_temp_free_i32(tmp);
                 break;
-- 
2.17.1


