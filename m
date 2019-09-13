Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2E920678
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MomvmlIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2E920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8o3D-0004Ya-Uf
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npl-0007cF-Os
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npk-0000sr-Fb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npk-0000rw-9N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id q17so27894852wrx.10
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A1cjHFhYc5I7kRW1lKINEm/mLxw+4h/q6C9juDhceJc=;
 b=MomvmlIMdGxHV9VO20+3mi7nAGl38KeDli9ry7hdklJRtn8YcT9gndhhKD/BmzAujc
 FGqEP8ezXGr2GIonX9RPoz/RLCvV+EMNha+oZwhZV0/UbC9d3kXTRdY1aHRDiT4VqU4b
 Hiy/4PI2TLMm3ks5ZJ2bEROyLqouFRe+tcR0QCnSJWxyeo+yx0MzA7N2+nPxWHWbJUHZ
 TnON/BxcgZp2cK6VVhTxmLGcSLsXaDKBkWkqDtCF4FTciQaXAwKx89GffCDSEg0yX3nJ
 6SvRVvWqKkM29PUb6mtvK6YLyv4CoE1p6t/eCI4MpaKcPLV23nSFFdlDTJUYgENhr0Q9
 ChZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1cjHFhYc5I7kRW1lKINEm/mLxw+4h/q6C9juDhceJc=;
 b=gU2dyetVFD1uJwnYmCVfffw1/iXz2I/FRJB9YzUqgxCE3u7EQCSYs3ZsURZEZhol2S
 Bz+/gRhYEizwPKHUBzlg8wO8dnXo7Ng1oe0eHtFWK5UlocjKPAHDvK5lH1IHkh2051Dh
 dW7jrf9XZoJNVECsvcIUJRjxzEHy/cEwgjzaoGy2CziNQWPtQpiiQMHIh6xCPLmjtI+l
 C2lr2hV3KT4/BSafinuKwNiH6+3VbslU0lXI7X4mjyy5bBqo8UuZA4M96hr4GjzIV7X/
 izj6Yao7lXJAQuvH7pnlAWv0fkyel1SyBmgpASaQAIIotAhABQMCwomo21kcPbbI58d+
 +ZWA==
X-Gm-Message-State: APjAAAWRKFlant1n+LyPHnnQrl2Z2aRshvecYzXUrVQ/rPLEsAhnxDe6
 LA6zlahwO5fXuQMte/cPNGVXkVccrmUskg==
X-Google-Smtp-Source: APXvYqyEENhLI5imPW6MH7rAinBbf9BT2BvPVFzpp2qOMJ4auBU6fw9cTdBlm0GM4V+54E8csQIjXg==
X-Received: by 2002:adf:f901:: with SMTP id b1mr13000134wrr.184.1568389803158; 
 Fri, 13 Sep 2019 08:50:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:47 +0100
Message-Id: <20190913154952.27724-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 07/12] aspeed/smc: Inject errors in DMA checksum
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

From: Cédric Le Goater <clg@kaod.org>

Emulate read errors in the DMA Checksum Register for high frequencies
and optimistic settings of the Read Timing Compensation Register. This
will help in tuning the SPI timing calibration algorithm. Errors are
only injected when the property "inject_failure" is set to true as
suggested by Philippe.

The values below are those to expect from the first flash device of
the FMC controller of a palmetto-bmc machine.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190904070506.1052-8-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 32ce6916f6c..5176ff6bf95 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -88,6 +88,7 @@ typedef struct AspeedSMCState {
 
     uint32_t num_cs;
     qemu_irq *cs_lines;
+    bool inject_failure;
 
     SSIBus *spi;
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 7a0cd7607fd..5c3436db5e8 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -869,6 +869,36 @@ static void aspeed_smc_dma_calibration(AspeedSMCState *s)
     s->regs[s->r_ctrl0 + cs] |= CE_CTRL_CLOCK_FREQ(hclk_div);
 }
 
+/*
+ * Emulate read errors in the DMA Checksum Register for high
+ * frequencies and optimistic settings of the Read Timing Compensation
+ * Register. This will help in tuning the SPI timing calibration
+ * algorithm.
+ */
+static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
+{
+    uint8_t delay =
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_MASK;
+    uint8_t hclk_mask =
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MASK;
+
+    /*
+     * Typical values of a palmetto-bmc machine.
+     */
+    switch (aspeed_smc_hclk_divisor(hclk_mask)) {
+    case 4 ... 16:
+        return false;
+    case 3: /* at least one HCLK cycle delay */
+        return (delay & 0x7) < 1;
+    case 2: /* at least two HCLK cycle delay */
+        return (delay & 0x7) < 2;
+    case 1: /* (> 100MHz) is above the max freq of the controller */
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Accumulate the result of the reads to provide a checksum that will
  * be used to validate the read timing settings.
@@ -905,6 +935,11 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
         s->regs[R_DMA_FLASH_ADDR] += 4;
         s->regs[R_DMA_LEN] -= 4;
     }
+
+    if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
+        s->regs[R_DMA_CHECKSUM] = 0xbadc0de;
+    }
+
 }
 
 static void aspeed_smc_dma_rw(AspeedSMCState *s)
@@ -1185,6 +1220,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
 
 static Property aspeed_smc_properties[] = {
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
+    DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, false),
     DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
     DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-- 
2.20.1


