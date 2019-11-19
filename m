Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FCC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE74F20409
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5E3SN/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE74F20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3hK-00008j-Id
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bo-0003NX-7f
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bn-0004Bh-3A
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bm-0004BB-Eu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id n1so23814672wra.10
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8XC9VRBYxoao7D5gAki2M8EB8ioO9WQynWtrDET/dPw=;
 b=W5E3SN/WiKih3KXsrg6VDeKWOGgAKXPzuWZZspBGFDZYLFnVt8kyoR1sXcL7NE7uvS
 aS4vA9D8JCkyOdQd2nLb40qbBhwDgXMiwTcnCk5sVJo++Uu1g3VGzde2Mf1f0tjfntEx
 rmAcwGa6Ujyu2dcTwtcHNYiAXqvBSa2NUcEhU1D0Divo/acQkGLJHzIeVlhbUZqn+fI4
 vRM+cWOjIOwBhNkl1gGDv5643Zflqo0BSywax/Tn9wFDo/61V5edGG0uuVDuPEncB2WD
 9H1mUjqf5NtjIoDbAuYUNOTsQodaWf8TjdpKTusmnhZpQBC1fhxrQIYRp9hKHD8nSlt4
 ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XC9VRBYxoao7D5gAki2M8EB8ioO9WQynWtrDET/dPw=;
 b=n99z3RpVOEPACq5NnIfN0Ay9plklfLT5J4UXs4zjoCZIZhgoVUTrCAxXZUOtvPZ+sa
 GxAKGY9QL3pKmpOA85M5o58WUDikufS41DVLqSdT38ciJV5kna13WghzfUTnWhJZPDw3
 bpkbq0v3oBUPFhf1OmdvVT89sf4znLzm9CuX3IfB0ayrCiv3bXPlTGbZgG+mRILkZQPk
 P+1hmfC8kJS7uwX7ZL4kW1hXKodIOygLnzzUh+Xq52o1R2MOy+jTL8XUxE6zmg4iKVcI
 GI+CnJn9WhPrg1HhmP06aEKXLzsR0+ZzG1O1ovXjRJ0S1WUft6ai4SLboboyzvKAIIE/
 TeBQ==
X-Gm-Message-State: APjAAAX9PQaBiTggUHY+hwyB6QyGclJtS/rT5sin7pUet03hE4vhRnEN
 lCp/jUUFN4+5+sDzeHAzlE2Gh9ew/GCs4g==
X-Google-Smtp-Source: APXvYqxLcDGuFsrPwZ71N5GxzYJVz5CrIMjD+ZM8fLBHkhGFOXKiB46cyIiXx2hfG+ttmPM5bZpvxw==
X-Received: by 2002:adf:b686:: with SMTP id j6mr26170818wre.186.1574170313060; 
 Tue, 19 Nov 2019 05:31:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] ssi: xilinx_spips: Skip spi bus update for a few register
 writes
Date: Tue, 19 Nov 2019 13:31:41 +0000
Message-Id: <20191119133145.31466-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

A few configuration register writes need not update the spi bus state, so just
return after the register write.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1573830705-14579-1-git-send-email-sai.pavan.boddu@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c712ca8..0d6c2e1a61d 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -109,6 +109,7 @@
 #define R_GPIO              (0x30 / 4)
 #define R_LPBK_DLY_ADJ      (0x38 / 4)
 #define R_LPBK_DLY_ADJ_RESET (0x33)
+#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
 #define R_TXD1              (0x80 / 4)
 #define R_TXD2              (0x84 / 4)
 #define R_TXD3              (0x88 / 4)
@@ -139,6 +140,8 @@
 #define R_LQSPI_STS         (0xA4 / 4)
 #define LQSPI_STS_WR_RECVD      (1 << 1)
 
+#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
+#define R_ECO               (0xF8 / 4)
 #define R_MOD_ID            (0xFC / 4)
 
 #define R_GQSPI_SELECT          (0x144 / 4)
@@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
 {
     int mask = ~0;
     XilinxSPIPS *s = opaque;
+    bool try_flush = true;
 
     DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
     addr >>= 2;
@@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
         tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
                       s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
+    /* Skip SPI bus update for below registers writes */
+    case R_GPIO:
+    case R_LPBK_DLY_ADJ:
+    case R_IOU_TAPDLY_BYPASS:
+    case R_DUMMY_CYCLE_EN:
+    case R_ECO:
+        try_flush = false;
+        break;
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_check_flush(s);
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_update_ixr(s);
+    if (try_flush) {
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_check_flush(s);
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_update_ixr(s);
+    }
 }
 
 static const MemoryRegionOps spips_ops = {
-- 
2.20.1


