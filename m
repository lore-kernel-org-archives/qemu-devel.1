Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0968C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E077214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMI9Sb/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E077214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j053x-0000I7-89
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iI-0001SX-HG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iH-0003VP-AF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iH-0003UA-2t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:33 -0500
Received: by mail-wr1-x430.google.com with SMTP id t2so2977740wrr.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H6l4J2wISZvntTfWJFqb7Wof8ehV1xbBXnIgF8L+9t0=;
 b=DMI9Sb/zFp1R/BlQqqjfu2Bqm4WB+tfKqVNbqe2o0hml7vp4ZU0CdJ06nrnJBlOxy6
 ZK4J3ARJHidJT9JQty++Ofc66nTrPtZqd+YQepTyubskrUgaNNmzKskKLEb4Z7LzKr/R
 5dbpzn6eXWkI46gRlhTivJ3bBBF4FKYAFQzZ1lwOMXSU8opD32zZ4S7g1ZJQAWhqVa3k
 KE3Eg9JWas3UoX9oilT8bF1em3u4VwbG95Dr2MkR6MgKSsDFcmVlQn4xWCrxK6E2LcRh
 O2jbzS5V9NH5JdyTggBAZl0U2OxTxYUG4EY7VzYfeSTuehLT257DJjZF1ajLOME5PRNL
 dJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H6l4J2wISZvntTfWJFqb7Wof8ehV1xbBXnIgF8L+9t0=;
 b=lkcXHFqG3QtdoBUjCrAGhVWTkBQMwzgxhATGHNTl2QeQ+CO13ms8eba4rCIwqh8oK3
 dpxkLHg8l8jEQsreQwDTGXGXx7wBwLsp+lw2Y9jqC7fCud+z/lnVDGPlQiU3StBWEc7P
 244OIDQKnckEmNH7GIU1dbZsNhJ4zUztFAS02XZmaY8gxp+idnGFbxD4ylfgkjrjKacy
 I5Non/5rgf2OdizXUujT7AJexfxifoOGBBwpg45685izNSlL4/j/v0d37NtgAEPH+sAK
 ClvSVFa2qPrKUJgiEj3V5eFh0oQxD5aUiYvvEeYhKoOGxMvhT3GLbdbQ50XYKsnUp+kO
 XGtw==
X-Gm-Message-State: APjAAAWEDZuQsDq3iCBpLd98CDq1Ad923SwZXaG3+06kIo/Thh1aKvNg
 V8AzGWnG1YOxIb9f5U6nZQ8XM3ONitc=
X-Google-Smtp-Source: APXvYqzHo3N1ey2hUU+xPf3tvB6WCOkRNgXIATvwCSXu+8hsGHuTS/bxBgBIYvexPu/A7u7cPEQ1qA==
X-Received: by 2002:adf:f288:: with SMTP id k8mr5274288wro.301.1581086071829; 
 Fri, 07 Feb 2020 06:34:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/48] bcm2835_dma: Fix the ylen loop in TD mode
Date: Fri,  7 Feb 2020 14:33:38 +0000
Message-Id: <20200207143343.30322-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

From: Rene Stange <rsta2@o2online.de>

In TD (two dimensions) DMA mode ylen has to be increased by one after
reading it from the TXFR_LEN register, because a value of zero has to
result in one run through of the ylen loop. This has been tested on a
real Raspberry Pi 3 Model B+. In the previous implementation the ylen
loop was not passed at all for a value of zero.

Signed-off-by: Rene Stange <rsta2@o2online.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/bcm2835_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 1e458d7fba5..667d951a6f7 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -70,14 +70,14 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
         ch->stride = ldl_le_phys(&s->dma_as, ch->conblk_ad + 16);
         ch->nextconbk = ldl_le_phys(&s->dma_as, ch->conblk_ad + 20);
 
+        ylen = 1;
         if (ch->ti & BCM2708_DMA_TDMODE) {
             /* 2D transfer mode */
-            ylen = (ch->txfr_len >> 16) & 0x3fff;
+            ylen += (ch->txfr_len >> 16) & 0x3fff;
             xlen = ch->txfr_len & 0xffff;
             dst_stride = ch->stride >> 16;
             src_stride = ch->stride & 0xffff;
         } else {
-            ylen = 1;
             xlen = ch->txfr_len;
             dst_stride = 0;
             src_stride = 0;
-- 
2.20.1


