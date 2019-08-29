Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B04C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31508205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6ZyTcAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31508205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i39L0-000853-Cs
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i39J9-0006oS-SK
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i39J8-0006Tu-Dm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:33:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i39J8-0006TV-7W
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:33:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id n190so689552pgn.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 18:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=744Nlg5qsnK3Xn9iAOjHRV5LS028FvH66MjBiNi4Lvg=;
 b=j6ZyTcAaZKSBehcYvEOFfr3Q4xcRN8Cx9lnoetgVmd4YqOXv1nv+y2q2qV1hDy8tl5
 dyk10HCINJRzErY5iZUPybsDjlywwJI9P5p9EmjnjnHw5NASI+LsNE9qTh7PiYt+xq7h
 9iX6vTwBd+l4ogL3HqOgYNjAa06tH1Jy9v9SUtmRpfqrpOYK5OEIpo2XW3AZ5t9P5Zl9
 NV80Do3OrZuy8P455Gh1+3qGY2b2O/OVATeIJR616/4cvw/Uqa2LHVJUBZevPCXdMyeS
 PX+TIVGuGzQNEZWHV/6u3JsEVzldTfehD/6hS2+anCUFw8E21imG1bw0XHxK7kFsUu+I
 Odww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=744Nlg5qsnK3Xn9iAOjHRV5LS028FvH66MjBiNi4Lvg=;
 b=JrbOqPhaVGrjnUnsiFm46OMagxjghCN60WtLUORrdy6s1CoKIeGZKsMkWhQrbFH7kk
 NzaCgP3NLH1kLEk3CoTkvOm4SKiKPJC9T8/7wrlGm8Fu3AxHkDp2Qr0plYydvocsE+Zb
 njYx6Mtg7rsziagG/MDLgNHhfBpDiTkO4k/nx/re8Ggpl4BUsjeMPS5gpzT5ux+1HKOd
 qYSlqfY2G8MDQulCWFFsOEUt9b0JVzJ5w8CIHtyHTVhToZyvJY1wC7UKm/WnA7WaIexR
 P1jZni9p1NZ53SG6NLFrKCX/vJQr+DGc+iNRV4qV0DO+buwriwQ8HUtxNEhkBeTKCcxy
 TOfg==
X-Gm-Message-State: APjAAAWQSQIPYLXuGufEZF3p9fofteOZOH7dKrw9C56GvxzYZsvAulDs
 tONR5QvsKgp0WWtwtsY/FPxzPy6UtDo=
X-Google-Smtp-Source: APXvYqwmFJYEY1kbWwqNEQJGc5rjBbpVNoKs3j000NmsGl6DXWyVLzGWgHu6bDCqxxgUzB7KcQ1VVg==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr6091093pgk.355.1567042380367; 
 Wed, 28 Aug 2019 18:33:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h17sm701303pfo.24.2019.08.28.18.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 18:32:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:32:58 -0700
Message-Id: <20190829013258.16102-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH] target/arm: Fix SMMLS argument order
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
Cc: laurent.desnogues@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous simplification got the order of operands to the
subtraction wrong.  Since the 64-bit product is the subtrahend,
we must use a 64-bit subtract to properly compute the borrow
from the low-part of the product.

Fixes: 5f8cd06ebcf5 ("target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR")
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cbe19b7a62..a0f7577f47 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8824,7 +8824,16 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         if (rd != 15) {
                             tmp3 = load_reg(s, rd);
                             if (insn & (1 << 6)) {
-                                tcg_gen_sub_i32(tmp, tmp, tmp3);
+                                /*
+                                 * For SMMLS, we need a 64-bit subtract.
+                                 * Borrow caused by a non-zero multiplicand
+                                 * lowpart, and the correct result lowpart
+                                 * for rounding.
+                                 */
+                                TCGv_i32 zero = tcg_const_i32(0);
+                                tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3,
+                                                 tmp2, tmp);
+                                tcg_temp_free_i32(zero);
                             } else {
                                 tcg_gen_add_i32(tmp, tmp, tmp3);
                             }
@@ -10068,7 +10077,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     if (insn & (1 << 20)) {
                         tcg_gen_add_i32(tmp, tmp, tmp3);
                     } else {
-                        tcg_gen_sub_i32(tmp, tmp, tmp3);
+                        /*
+                         * For SMMLS, we need a 64-bit subtract.
+                         * Borrow caused by a non-zero multiplicand lowpart,
+                         * and the correct result lowpart for rounding.
+                         */
+                        TCGv_i32 zero = tcg_const_i32(0);
+                        tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3, tmp2, tmp);
+                        tcg_temp_free_i32(zero);
                     }
                     tcg_temp_free_i32(tmp3);
                 }
-- 
2.17.1


