Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB8AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09756222F2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2EjhJop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09756222F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3eb-0005Bh-Vu
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bo-0003Nf-Ny
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bn-0004Bt-HU
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bn-0004Ba-BM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id z10so23823812wrs.12
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6sVtcsXVTj567xQbM+Cap2mzh1eDz0KNX+fPLM9xQRI=;
 b=y2EjhJopOcbgtfvuPu48S/Zf26HmoYAqvOmEswb6rYbtYx0Uq8nBU4Eg3HWICB91wN
 nRQeiIUYXf9Hl/VMOegvwQdGUnD8NNC7a5Spi2cVMDwhotXBZigsdtJYSoNY0fKqJMov
 fTO+yNLJyzJqi7adS6+1xhq9sHeOpaMtSXF0P+KvYoWf0qW0hRsSHKU2iF6yc8x43xUH
 gKX+XdXQHR/7bA/X6LTTQz3dfGSOva2hjkKfAFk8gnDytMKGGBTPNRVdtG1BNTJTx2N8
 tx+d7OIeBQ3EKcfjRvLRw0FGRvSeoxIVSH5M/FDi8sCuvz7Yjmxhpqrjv2McFv7XyHqD
 gkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6sVtcsXVTj567xQbM+Cap2mzh1eDz0KNX+fPLM9xQRI=;
 b=X1iW24FUc1GIVblLDJkRMXSx7ZmArcimED9L68DFXXb2fJH7ZvFfHsD/0qC6PZzW9M
 0iI4GlamSm2N5ltuIv+OtmgZ00qMU24euGasahjaMKvi40g46hRAXi2bTcgGA9g1uPIn
 5w4q/R3uDw93+OkrCt+HceacDOZl7mUSdCWs3SA6PIjftgdldGP2GgnNMAkcMaoifWON
 ioYew1jKUeU7b119DthC2vkK73RbKZALPexua2l0N2U52194Di6CBwbX0ZKH1aCOLKbe
 RWvit0qxzyHUfogXCWJvSrlWDd/Goe87o3gxbEIO1eVbiaGZL8+QSsdlJyhg6iEqzgLF
 mIFA==
X-Gm-Message-State: APjAAAVloMsBMDXJn0A7DNHvSojRKZmcm+YwEkpF1MW2wvjemW7FYMDq
 0d3S/sUT9UQRSC+K8Waq7L/OpZosv2lEwQ==
X-Google-Smtp-Source: APXvYqxz5mQwfKps79YUHPI8G+qIold8yDqfTyPbMQ7pCMvduWA4w6wU3uF0wvFwIboOCQ+k9Q1/ZA==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr38750489wrq.185.1574170314125; 
 Tue, 19 Nov 2019 05:31:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] net/cadence_gem: Set PHY autonegotiation restart status
Date: Tue, 19 Nov 2019 13:31:42 +0000
Message-Id: <20191119133145.31466-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Linus Ziegert <linus.ziegert+qemu@holoplot.com>

The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
PHY when autonegotiation is started.
Recently the kernel started to read back the PHY's AN_RESTART
bit and now checks whether the autonegotiation is complete and
the bit was cleared [1]. Otherwise the link status is down.

The emulated PHY needs to clear AN_RESTART immediately to inform
the kernel driver about the completion of autonegotiation phase.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c36757eb9dee

Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191104181604.21943-1-linus.ziegert+qemu@holoplot.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f9cb5ab955..b8be73dc558 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -271,9 +271,10 @@
 #define PHY_REG_EXT_PHYSPCFC_ST   27
 #define PHY_REG_CABLE_DIAG   28
 
-#define PHY_REG_CONTROL_RST  0x8000
-#define PHY_REG_CONTROL_LOOP 0x4000
-#define PHY_REG_CONTROL_ANEG 0x1000
+#define PHY_REG_CONTROL_RST       0x8000
+#define PHY_REG_CONTROL_LOOP      0x4000
+#define PHY_REG_CONTROL_ANEG      0x1000
+#define PHY_REG_CONTROL_ANRESTART 0x0200
 
 #define PHY_REG_STATUS_LINK     0x0004
 #define PHY_REG_STATUS_ANEGCMPL 0x0020
@@ -1345,7 +1346,7 @@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t val)
         }
         if (val & PHY_REG_CONTROL_ANEG) {
             /* Complete autonegotiation immediately */
-            val &= ~PHY_REG_CONTROL_ANEG;
+            val &= ~(PHY_REG_CONTROL_ANEG | PHY_REG_CONTROL_ANRESTART);
             s->phy_regs[PHY_REG_STATUS] |= PHY_REG_STATUS_ANEGCMPL;
         }
         if (val & PHY_REG_CONTROL_LOOP) {
-- 
2.20.1


