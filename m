Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A8C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DFC22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hECd8Rxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DFC22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzqBv-0000EW-Ko
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN4-0003AG-Ir
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN3-00072F-FV
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpN3-00071d-AA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id go14so1587483plb.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7K6tczexVR/nH6QwvmxJgfglbEd8tmNPs5dg0F0AA4A=;
 b=hECd8RxjJLaEU94oUtD7Lw0+XlymgEaTX2Sr6OJmvKodg1gXIMOPiDVlImf8414ku/
 AKQbNJ8kpKNoHSa5LQQADHaFOkVNl+mF0D7MrVBZHvZam46Is6T0BB89dB94oC74lNgr
 rDfToz2SYwdjhtC6b3d4RMOjZhFuzbZ+0RzeXY0wzutCFUr/eLhzq5XtJ5VWPX/J4TQq
 8oO0tMBUFOupGlUxxGDqVVbIr6DADHjtg9dMq0os1psU9iwBfdZ5WYOGPkFA4mhDvB3I
 sTF1FZ+DO0KFH8IZWgKTXhCf6IXs4C6Omi6XFPpxw/jXkb1xlVkgfVItPIowKDGiouBJ
 M/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7K6tczexVR/nH6QwvmxJgfglbEd8tmNPs5dg0F0AA4A=;
 b=PnbeoJwkZ5sNYojYniNd1BW/fcASUqNFucohb1+VSuTiVDMdUEw3CJBmXGIGXHhtOX
 v4n+wiW6JKRVjhwPZGS8WDqKSbdUdqNn19BZ3LYFt/u/fEcYkvQSI6Eg3wEJhYtmfzqu
 hHbv8BORVORffLzTnuNCjkipLJIx3++VnMFZUxCsFTo0mHmgJjWCswHkIN+6TviR1jR3
 Y8ObBNXivn5/6lFi21fuul7Qmokeh0gB6rWAQ8EeqJ7U/oSTd86vsm2Kk/FC3ZK4dDAK
 HbVx2Hv/2Z8HSp8G9fWhPKxifGWB2/PBcspZXu7nZoptkse2er2q8IzdLkcrL7HuDY2f
 FKig==
X-Gm-Message-State: APjAAAViUyxEi5m1Bsj4mtqqq88Ug5io+7rmQIonERAzA/y2nAhYgh12
 cPK9Sfrj9KHwITYnuNnn3MGWxGcw2G8=
X-Google-Smtp-Source: APXvYqwxOVMKcUFWdRT5d3fvMANzXSUJ1YAzxzI2fNR4ElldLaQuX4OwxglxdqKe9IE1GnWBcfUn5w==
X-Received: by 2002:a17:902:834c:: with SMTP id
 z12mr10866725pln.8.1566250760089; 
 Mon, 19 Aug 2019 14:39:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:54 -0700
Message-Id: <20190819213755.26175-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 67/68] target/arm: Clean up disas_thumb_insn
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f8997a8424..bac38e6261 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10650,32 +10650,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
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


