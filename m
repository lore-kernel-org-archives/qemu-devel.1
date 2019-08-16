Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10D1C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD272086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJuNxZkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD272086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycJ5-0002NC-80
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc74-0003ZQ-Tq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc73-0005mF-Mk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc73-0005lT-Gz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so1529124wrr.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6sDytIs50Z7JPLgJ0D8n+pKl2x0yeciEYsQAfCreOnQ=;
 b=JJuNxZkWMeOnhvPKAR8W/4qS8Uk4TM+ib8ZouH+2H4uZPRWz6P7O7LmQvyRPpTM3X8
 9X4aj3mNxvjNqBzMvPgP7t1V+0QWVkHlIHy5HNzsI9ehBTD4ayRQDtOn8Yzkk13zAgvK
 g/enkVF/jICbsfr53UaevREngdWDUzOMZ8NwyyVSKzZNFGf88a+Z0G56hYcUIKR65kln
 x2BskM/EdJF0p05ajwdQFr5lF5O0pN9cD8HylG05EFf4sHlpUYU8ghAuNIbWcUjqMx0Z
 uOWNbh8IbiMa+VZ3WKp3DNO3UMxme7OOzQwy3o4UCIwYjDeacmNb0wkDc3+1VMVaFR/x
 2f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6sDytIs50Z7JPLgJ0D8n+pKl2x0yeciEYsQAfCreOnQ=;
 b=kEUOV1y5W/jUK98znevBjKs3i9SKkcl1pjzfQnZe4h+7FrlzafdAIPKrGTPBjdYbXB
 xJDofGSuJx21Vyx1xkfvPCSb9HMrVXUVsVW5MDed3ILx3Tm17Ov0/1AbYgRtBPJAYVWG
 z+58TNMFC+m2XWkPvDt9YMEMTxiEIIgt0O3uVCw3Q/gp38mvnQbcXIgzOIwH73oFFOVc
 oeYEKzznuVlgS4HcxTZ+UugYG6Xbl7UhpMx/8l0fqYhdxqxdF8j0NNyAjdOrylmG8Ve8
 KwNA3C4g8lM25yZxV9BOZjWCnFdKCnRsmRBzppARTOMC4vj0kS5rQv5381RWD7dEUnLh
 sThA==
X-Gm-Message-State: APjAAAUiHK9CCSgRxI4nJLkHGgKDtIb8iGN9kubfrK0mn1QfK6TePkr3
 tB/aySaE5y9QL2u0ACcDMZ18r4/Vq/Fwig==
X-Google-Smtp-Source: APXvYqzuFVjXJiBZfbW1l+O5vhiU2ip77ER8Z4dvgXL79QQa4OHM42LqbJAbDB/Ri5JSEc9HTuBZiQ==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr10775771wru.193.1565961468453; 
 Fri, 16 Aug 2019 06:17:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:14 +0100
Message-Id: <20190816131719.28244-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 24/29] target/arm: Use tcg_gen_deposit_i32 for
 PKHBT, PKHTB
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use deposit as the composit operation to merge the
bits from the two inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 14d6b6d4d28..9c3323509e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8754,19 +8754,16 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         shift = (insn >> 7) & 0x1f;
                         if (insn & (1 << 6)) {
                             /* pkhtb */
-                            if (shift == 0)
+                            if (shift == 0) {
                                 shift = 31;
+                            }
                             tcg_gen_sari_i32(tmp2, tmp2, shift);
-                            tcg_gen_andi_i32(tmp, tmp, 0xffff0000);
-                            tcg_gen_ext16u_i32(tmp2, tmp2);
+                            tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
                         } else {
                             /* pkhbt */
-                            if (shift)
-                                tcg_gen_shli_i32(tmp2, tmp2, shift);
-                            tcg_gen_ext16u_i32(tmp, tmp);
-                            tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
+                            tcg_gen_shli_i32(tmp2, tmp2, shift);
+                            tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
                         }
-                        tcg_gen_or_i32(tmp, tmp, tmp2);
                         tcg_temp_free_i32(tmp2);
                         store_reg(s, rd, tmp);
                     } else if ((insn & 0x00200020) == 0x00200000) {
@@ -9802,19 +9799,16 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             shift = ((insn >> 10) & 0x1c) | ((insn >> 6) & 0x3);
             if (insn & (1 << 5)) {
                 /* pkhtb */
-                if (shift == 0)
+                if (shift == 0) {
                     shift = 31;
+                }
                 tcg_gen_sari_i32(tmp2, tmp2, shift);
-                tcg_gen_andi_i32(tmp, tmp, 0xffff0000);
-                tcg_gen_ext16u_i32(tmp2, tmp2);
+                tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
             } else {
                 /* pkhbt */
-                if (shift)
-                    tcg_gen_shli_i32(tmp2, tmp2, shift);
-                tcg_gen_ext16u_i32(tmp, tmp);
-                tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
+                tcg_gen_shli_i32(tmp2, tmp2, shift);
+                tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
             }
-            tcg_gen_or_i32(tmp, tmp, tmp2);
             tcg_temp_free_i32(tmp2);
             store_reg(s, rd, tmp);
         } else {
-- 
2.20.1


