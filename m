Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E30EC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDD021479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMINlJEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDD021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4hF-0001ke-HL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Xp-0008KS-SE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Xm-0006aA-Bg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:09:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Xm-0006XT-39
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:08:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so15367038wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ehjkWhdt19qHAzsl/X1nqYdNDUK2w3SB8ITjOfQ+4TI=;
 b=KMINlJErVZ7iKNRZ2mGI6agJBxPZ5UynPiAegrlvS+4aFfDW8o0FtGInDe6SF0CBki
 ZQPVCCikM5C2JGisHOb48SJO1HAoam0gnTjtq6yrgmli6Pso7Ur7mHNJKFo9zzWseSSh
 UMXS1xxDohNFbhxWdlq8RgLz+1/EqhdngSUQk7wwEtrt/NkvLphuqrEsxj5Inky6Ijc4
 lC4HyzdbdBHaVxh6Moc1oNO0IKJ7H/IIWuOS6SSUOJbCHD+rrjmyuYpJLQbUwecLQJ0m
 uO+5ZOzBnESU8QnMlHp8gZ5pBxf9R9enZ56nKr7zF/4hgppj3kQy4gBBVtc5wlHUfOi0
 sw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ehjkWhdt19qHAzsl/X1nqYdNDUK2w3SB8ITjOfQ+4TI=;
 b=VMV3T2W4oWZJU92cq1to5fbvE8MMSeSpOg303d4fNZ4+mRKBknKwgRPcTKXWaRnQNH
 EsGYZok2KBCP8Fm4PnKY4fPzk2Xfg/BrN1XnEwBEcVKWrZQV5hl4egR3tZ6JtZTrs2wm
 0hX95nIilyB3gOatIZwLyEMJSW/K1Hi3IeYjwuf5EfV3ZWbJ8RpYlpbfLJsChA1WBPIy
 sWYbe/Yf4+1+7Zm2lKyNkfWEJi/BYyqPHLgzhIBx5CTELepWiiYxfyE+/R4N7w1++FxD
 yqIY5MYJ5qNw3+1PVIcnVwWibujqJi42I4DxotPK537T02NszNd+5+HQDUcxPa4fdzqY
 wDWQ==
X-Gm-Message-State: APjAAAXNG7A/iCQ7FtWLok3EOkkFdW96ky3rVoaNXmVfPCVF3hfMzYmL
 j+r7kjxY8VEI7WL9XcSNyYFE5INNI84hxg==
X-Google-Smtp-Source: APXvYqwgw42ETSsGk1LeD/uFWz5EaZ8D1CEOUaAm881AhiceVCqQ6nn9XTr7OlnlhxQ6tX9GCaQhcA==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr15985309wrn.88.1561999206838; 
 Mon, 01 Jul 2019 09:40:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:17 +0100
Message-Id: <20190701163943.22313-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: [Qemu-devel] [PULL 20/46] aspeed: add a RAM memory region container
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

The RAM memory region is defined after the SoC is realized when the
SDMC controller has checked that the defined RAM size for the machine
is correct. This is problematic for controller models requiring a link
on the RAM region, for DMA support in the SMC controller for instance.

Introduce a container memory region for the RAM that we can link into
the controllers early, before the SoC is realized. It will be
populated with the RAM region after the checks have be done.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-14-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5d73267da16..7f01df1b61d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -33,6 +33,7 @@ static struct arm_boot_info aspeed_board_binfo = {
 
 struct AspeedBoardState {
     AspeedSoCState soc;
+    MemoryRegion ram_container;
     MemoryRegion ram;
     MemoryRegion max_ram;
 };
@@ -159,6 +160,10 @@ static void aspeed_board_init(MachineState *machine,
     ram_addr_t max_ram_size;
 
     bmc = g_new0(AspeedBoardState, 1);
+
+    memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
+                       UINT32_MAX);
+
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
                             (sizeof(bmc->soc)), cfg->soc_name, &error_abort,
                             NULL);
@@ -193,16 +198,16 @@ static void aspeed_board_init(MachineState *machine,
                                         &error_abort);
 
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
+    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM], &bmc->ram);
+                                sc->info->memmap[ASPEED_SDRAM],
+                                &bmc->ram_container);
 
     max_ram_size = object_property_get_uint(OBJECT(&bmc->soc), "max-ram-size",
                                             &error_abort);
     memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
                           "max_ram", max_ram_size  - ram_size);
-    memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM] + ram_size,
-                                &bmc->max_ram);
+    memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max_ram);
 
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
-- 
2.20.1


