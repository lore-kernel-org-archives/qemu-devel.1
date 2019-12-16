Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D50206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzpo0ZM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D50206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoVS-0003Al-7s
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFY-0007Um-E6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFW-0007cx-Tg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:16 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFW-0007aQ-Mr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:14 -0500
Received: by mail-wm1-x343.google.com with SMTP id d139so4753571wmd.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zjLDEF6DNpTRDBT/Aj8pPr1zY4WR/x86sRDNZnQ+teI=;
 b=Pzpo0ZM30HNU4Hjs/QeBMlEflKlfmY/0QOzkC15wMBVjF/nh6nI7OgewcVTdp3zIfJ
 jPdxUiTGo1nKYLijZqxtX3jh6UMs4Js2OwFN/ysKJZ5HZhdtdLd02AYT+/oYCJUVeFBN
 jc0wZ0kWsfHw48aGz/1/vTvpr7mX/3ySvpSO+g0iwoi/qj5aqEdMtvo/9JwLptPij4t9
 rMm7TXWvVaK+zngaKJWO2Z+57lqu6ISlp1bprsy0GEQHzipM5YAXcYseMPYXmt09bRKN
 /uSUfjU6AKms7vefmzURFPZZRO3dH0DCJM8F+jJgjc/pWW+igywwwA5q83MqE5OY5oq4
 Si2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zjLDEF6DNpTRDBT/Aj8pPr1zY4WR/x86sRDNZnQ+teI=;
 b=scady/4A562Pm5Ux2UBbMvrqtbxwTAQ/CitZBZz9nMzFZ9t+c7UqzGAj6E0b/btPOM
 jgfo45jmSaCy09lOCvfIpcQ+5TqtY3PBNlDwL/QNhyO7OZle4Q/PDbTkRAOCaQ3z00Rr
 Q5eeeJYP4FLfiTtyhUYTOmSMvNuOVM8joKKMQlZ11OSwHYG3zTzGFzDwnkLIwLaB2CJq
 06aF4VhaPLQpBtpk5TSVSNmYPuNLIMmNdxKF1Rm3UqUB8Qt6b2H8w67aFglwoAbjpv4W
 O1cGDxDuYtPTQ6hq3YtCuronlOJj04MC7bGxGekglsQE+gYRzbF1dPKGrmqlJHpfCdVM
 sntQ==
X-Gm-Message-State: APjAAAWDxPKNNC+t88VatBVdTx7XQ9g/01y8aNuwYwFnPLGlLmF1C5kq
 FvD5lZ55f+ar+yG+mJKmAPiusM5Eqa1l9A==
X-Google-Smtp-Source: APXvYqynOhd5Ws1YR+/xNHtr33lTCp7tHhfzFdQwdudje8i5uaBb6+jX+toelZnNSuopJH30abhMFQ==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr28846402wmc.132.1576494553428; 
 Mon, 16 Dec 2019 03:09:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/34] aspeed: Add a DRAM memory region at the SoC level
Date: Mon, 16 Dec 2019 11:08:35 +0000
Message-Id: <20191216110904.30815-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Currently, we link the DRAM memory region to the FMC model (for DMAs)
through a property alias at the SoC level. The I2C model will need a
similar region for DMA support, add a DRAM region property at the SoC
level for both model to use.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast2600.c     | 7 +++++--
 hw/arm/aspeed_soc.c         | 9 +++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 495c08be1b8..e84380984f7 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSoCState {
     ARMCPU cpu[ASPEED_CPUS_NUM];
     uint32_t num_cpus;
     A15MPPrivState     a7mpcore;
+    MemoryRegion *dram_mr;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931887ac681..a403c2aae06 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -158,8 +158,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
                           typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
-    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
-                              &error_abort);
 
     for (i = 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
@@ -362,6 +360,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* FMC, The number of CS is set at the board level */
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index f4fe243458f..dd1ee0e3336 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -175,8 +175,6 @@ static void aspeed_soc_init(Object *obj)
                           typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
-    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
-                              &error_abort);
 
     for (i = 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
@@ -323,6 +321,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
+    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
@@ -429,6 +432,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
+    DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


