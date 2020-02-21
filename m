Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEFC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CF02073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7cgiyUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CF02073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j584w-0003RX-GK
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j581z-0006Th-Sz
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j581y-0002Sy-RO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:47 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j581y-0002S1-LN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id c9so1984161wrw.8
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=liKE80VVvI3xFYB7GeLv6rT6WhoDLIG/p/+a4APFNGA=;
 b=F7cgiyUfqcfdTAau1Et6xpUEu5B3oVvLi9j1vmcHa5Alm0cCsJ2HHfar2fcILyY3zW
 06KAXNe2QR++HqH0rYdB5IWG9EaOMsbKPORti0jdigEUPGnG2aRetKWNrumc5+d/Hx/F
 FLddP0bQIpKc3dEbaGGrubSVEj+XKeLBIolEaU4C6ciuJj1SIeNusJUT7VrqvM+mXIvR
 sjJLiT1O6Iw/yHHvHipVXv5FqKr/HbLc6+8odktHDqOeFbK+C0PGPcxlHaZYGWIzXKyV
 APBy3DtBq5gUYtXtBwamyt8CuPcd+1APvV0Bktu8xXBSOhhsQjDr/GLFImuJiYrlIbx3
 GRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=liKE80VVvI3xFYB7GeLv6rT6WhoDLIG/p/+a4APFNGA=;
 b=V+L0lwhUS16rHr01+/mzwL12KYThiKsMN2c6nIH//TNxLhXw4ZyviB2J8AkGmTXBhc
 4q7asY0hnPOHxG67hiPVZTGWne2RZShXZxWDV/4hn+d9Ea1nL38HSg1/hBFEHChI09vW
 tzzFH5Z9sRYRH50pCViIhpvr2mQ2TewMgwzVEXCHH7APcWYKIs7Kzethg4QrUr1cOshT
 DTlMbCQCJ5YLJcBr+0z2YGnTYHH17mqdx7kYyFw03G06amxY4yNV4FD8TWh6XWTxM3vq
 f5DGVGb2fFs3xaJKEW1DYvSgaLbOrel5XF+FDITuD36n2rVjlt/iyNcpQW1uzQF7Yf1s
 pgFQ==
X-Gm-Message-State: APjAAAVu6Kl9RliM1MTp87wOpW5jDEAMi3Nf8U9iG8KeP2aXspxkmZOt
 gAsXXNU2hovChWpThXSAvqOIXyyx5jBDIg==
X-Google-Smtp-Source: APXvYqwLecQJJL9Tiu+o7FhiDRZje5DvZLb/97dMmwnGH8Sr4ccFgTcsGDylLHX71b1klOgWNp9aww==
X-Received: by 2002:adf:f084:: with SMTP id n4mr48353401wro.200.1582290465278; 
 Fri, 21 Feb 2020 05:07:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/52] aspeed/scu: Implement chip ID register
Date: Fri, 21 Feb 2020 13:06:50 +0000
Message-Id: <20200221130740.7583-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

From: Joel Stanley <joel@jms.id.au>

This returns a fixed but non-zero value for the chip id.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200121013302.43839-3-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_scu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 6cb388330a8..9d7482a9df1 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -77,6 +77,8 @@
 #define CPU2_BASE_SEG4       TO_REG(0x110)
 #define CPU2_BASE_SEG5       TO_REG(0x114)
 #define CPU2_CACHE_CTRL      TO_REG(0x118)
+#define CHIP_ID0             TO_REG(0x150)
+#define CHIP_ID1             TO_REG(0x154)
 #define UART_HPLL_CLK        TO_REG(0x160)
 #define PCIE_CTRL            TO_REG(0x180)
 #define BMC_MMIO_CTRL        TO_REG(0x184)
@@ -115,6 +117,8 @@
 #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
 #define AST2600_RNG_CTRL          TO_REG(0x524)
 #define AST2600_RNG_DATA          TO_REG(0x540)
+#define AST2600_CHIP_ID0          TO_REG(0x5B0)
+#define AST2600_CHIP_ID1          TO_REG(0x5B4)
 
 #define AST2600_CLK TO_REG(0x40)
 
@@ -182,6 +186,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
      [CPU2_BASE_SEG1]  = 0x80000000U,
      [CPU2_BASE_SEG4]  = 0x1E600000U,
      [CPU2_BASE_SEG5]  = 0xC0000000U,
+     [CHIP_ID0]        = 0x1234ABCDU,
+     [CHIP_ID1]        = 0x88884444U,
      [UART_HPLL_CLK]   = 0x00001903U,
      [PCIE_CTRL]       = 0x0000007BU,
      [BMC_DEV_ID]      = 0x00002402U
@@ -307,6 +313,8 @@ static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
     case RNG_DATA:
     case FREE_CNTR4:
     case FREE_CNTR4_EXT:
+    case CHIP_ID0:
+    case CHIP_ID1:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -620,6 +628,8 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     case AST2600_RNG_DATA:
     case AST2600_SILICON_REV:
     case AST2600_SILICON_REV2:
+    case AST2600_CHIP_ID0:
+    case AST2600_CHIP_ID1:
         /* Add read only registers here */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
@@ -648,6 +658,9 @@ static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
     [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
     [AST2600_HPLL_PARAM]        = 0x1000405F,
+    [AST2600_CHIP_ID0]          = 0x1234ABCD,
+    [AST2600_CHIP_ID1]          = 0x88884444,
+
 };
 
 static void aspeed_ast2600_scu_reset(DeviceState *dev)
-- 
2.20.1


