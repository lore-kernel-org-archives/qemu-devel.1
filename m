Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902AFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A71217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD/ClnCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A71217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34N7-00087h-1p
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H6-00048y-Kv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H2-0000qV-JO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33H1-0000oj-Hm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so211844pgb.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AjmucdomfKxGM6hnf1R57zZqrIKHMIhApG2eFqmaHBc=;
 b=hD/ClnCCAfC+KrJCN3zA1EKEPJN/d9DDbG8Bp84tKpcHJTnJsIwyao2XyYMTIg2y/3
 evkaafRRRCoL/ipAI5gLnCAtGxPunDFIBR8dxFDtIYT0a+oLEZWYKJTLWnPNhMlDutH7
 /JAo2o7sdp9qddEo6PuDZX2+SPpubW7pIHPY/4TRhfO9LiVCkMyukUxiOpXAXxa1P0xi
 FgpkGIAV8m+XYbnDxSY2dUVVygxGsBedLTerZkSZEMwTtYpPVEc1GEJ/CpLkl17ZLj3Y
 pz9PA+IJ3RPv/3yyhaAEzk0LFE8L1GJGPWEcNQ6kdG5vQGeI9oZaY0cuJ6kaRUud2PVQ
 FWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AjmucdomfKxGM6hnf1R57zZqrIKHMIhApG2eFqmaHBc=;
 b=p+GB5kHYeA8wj1b48DR9ALiHGXdqXusnwyP1LZ2Szr3A6E4pTQ0bwdb9Yz6FrWXnCD
 qlffQ/+RLP7vlJu1syg6h7MzW6831uynIhLr6icnC37rdTdzth+phI9VnJOkHkcvNlB/
 OtrkNgAWMCSSBrZkzBODk8VmQAGhU1lOLw+7ncMC5Am9BvDTtCvR2FWPfCgp6sqSPz3r
 0vY70F5OL1YKLH2RtFUtzqp15VLnAD8oiAk40EDzC6OJg9CJ5Uci3gxzidWSI2MkeBlQ
 D9qV649DH9SbHtCSyuC1ZZ47DPjSyDIsnsW2oRqehbDIlaBHvjYpIvoTvN0Fi7WsbbOF
 k5ew==
X-Gm-Message-State: APjAAAVulD13Xs9mtm04nFLUmm7/0asjLi0RVRJBSBVLcsNzbtWMplro
 +do7dSrvPf35kKTjgKdwvkbdWKBd7fU=
X-Google-Smtp-Source: APXvYqxZstl043K3i1YM53QVjxhJ2OOre9QAQtxBfwVJ8KjRmQqtEBzdNXTTgCRuKfLxbINefEebKg==
X-Received: by 2002:a17:90a:b395:: with SMTP id
 e21mr5788048pjr.76.1567019185680; 
 Wed, 28 Aug 2019 12:06:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:55 -0700
Message-Id: <20190828190456.30315-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 68/69] target/arm: Clean up disas_thumb_insn
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

Now that everything is converted, remove the rest of
the legacy decode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 424a8354c1..5a9a6d3a1e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10747,32 +10747,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    if (disas_t16(s, insn)) {
-        return;
+    if (!disas_t16(s, insn)) {
+        unallocated_encoding(s);
     }
-    /* fall back to legacy decoder */
-
-    switch (insn >> 12) {
-    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
-    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
-    case 4: /* ldr lit, data proc (2reg), data proc ext, bx; in decodetree */
-    case 5: /* load/store register offset, in decodetree */
-    case 6: /* load/store word immediate offset, in decodetree */
-    case 7: /* load/store byte immediate offset, in decodetree */
-    case 8: /* load/store halfword immediate offset, in decodetree */
-    case 9: /* load/store from stack, in decodetree */
-    case 10: /* add PC/SP (immediate), in decodetree */
-    case 11: /* misc, in decodetree */
-    case 12: /* load/store multiple, in decodetree */
-    case 13: /* conditional branch or swi, in decodetree */
-    case 14:
-    case 15:
-        /* branches, in decodetree */
-        goto illegal_op;
-    }
-    return;
-illegal_op:
-    unallocated_encoding(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


