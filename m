Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EBAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529CF2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Won5PYxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529CF2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fyg-00031z-F6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhM-0004kU-TV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhC-0002HH-Oa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhC-0002Ee-I2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id w12so6997298wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=B4itb9kIDkgDxpdKjzasmbvHH8eIShpCoXlgDew/PyI=;
 b=Won5PYxRo25UM/ElpmKlqGBZOZhrYjMfXAHJJmpp96LwZMFFc4k2vT/+PPFXp3Ww1K
 TowLse4c00bLeW2WGYXwMab/2wjdYF9Pp42TE3lHWfcd8quf149KVEUVuP6L3E9q68fm
 OocJQAWpuIQTB+RP3UHFglhZ7CuRtgnHG6IEQKIJ7aPPru9uhjCsv53tQCHxLfbDr/5l
 yGF0RqURA1wRMr6rciMrZ8UUnpgtP2dx+YysbO+G46oo6GMcFFH7LOkBEWUmGPkFIUbx
 DO9EQ2jjYoeZssNL8Bwvq94XstmCO7pseCgbCTKekrZeLu/pfAw8f23Sokm1+0hof5mR
 mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4itb9kIDkgDxpdKjzasmbvHH8eIShpCoXlgDew/PyI=;
 b=alEahApgIuw8t5AJo/KNq3Z+oq39AqRG8poK/i4lHnv5CL9hV4qFZXvwgpnHK/mg10
 bf1cYLCA8KeOVwJfGkrRH2XUudAx34sk8W6SWtRX0HPhB0C5yVbuuwxjLSv26e96Fm/7
 5Zky/TBShZ+HEcwa9H9UG8yLGguC9QLDuxf/MN+IR1NLemLncKIpdtqCzlyRW4/9BpID
 /hVJaPmMv1tAML6RkrRRAaCdMz2MHxcG/ubm4Xu+36Vvzy0bmH7ybqwti0qPy+5QB58B
 sJHEJhCoogoIUWjPFOD7hRvSW8QRqEZ2OLHQwpeOvQpG2NVT33xKoxM1QEHp0WDPnt99
 gFfA==
X-Gm-Message-State: APjAAAVAbO2P3d547Tplwnhf1BFU5zpozoMbI3vktol2FRDH7lHwVfXr
 lYI9GHCNA5qcM1JXnYWLBveb9K0Dej8=
X-Google-Smtp-Source: APXvYqzKZZVhegR/5a/95BpbLA6+ofciBM0xPKzrgryWbg9L/8pzT6WocNomELXevcaIkTUPH0y+1w==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr21287909wrq.137.1581604943047; 
 Thu, 13 Feb 2020 06:42:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/46] hw/arm: ast2600: Wire up EHCI controllers
Date: Thu, 13 Feb 2020 14:41:30 +0000
Message-Id: <20200213144145.818-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
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

From: Guenter Roeck <linux@roeck-us.net>

Initialize EHCI controllers on AST2600 using the existing
TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
into Linux successfully instantiates a USB interface after
the necessary changes are made to its devicetree files.

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ehci-platform 1e6a3000.usb: EHCI Host Controller
ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
usb 1-1: new high-speed USB device number 2 using ehci-platform

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200207174548.9087-1-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 90cf1c755d3..446b44d31cf 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_FMC]       = 0x1E620000,
     [ASPEED_SPI1]      = 0x1E630000,
     [ASPEED_SPI2]      = 0x1E641000,
+    [ASPEED_EHCI1]     = 0x1E6A1000,
+    [ASPEED_EHCI2]     = 0x1E6A3000,
     [ASPEED_MII1]      = 0x1E650000,
     [ASPEED_MII2]      = 0x1E650008,
     [ASPEED_MII3]      = 0x1E650010,
@@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ADC]       = 78,
     [ASPEED_XDMA]      = 6,
     [ASPEED_SDHCI]     = 43,
+    [ASPEED_EHCI1]     = 5,
+    [ASPEED_EHCI2]     = 9,
     [ASPEED_EMMC]      = 15,
     [ASPEED_GPIO]      = 40,
     [ASPEED_GPIO_1_8V] = 11,
@@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
                               sizeof(s->spi[i]), typename);
     }
 
+    for (i = 0; i < sc->ehcis_num; i++) {
+        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
+                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+    }
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
                           typename);
@@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                         s->spi[i].ctrl->flash_window_base);
     }
 
+    /* EHCI */
+    for (i = 0; i < sc->ehcis_num; i++) {
+        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        sc->memmap[ASPEED_EHCI1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
+    }
+
     /* SDMC - SDRAM Memory Controller */
     object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
     if (err) {
@@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->silicon_rev  = AST2600_A0_SILICON_REV;
     sc->sram_size    = 0x10000;
     sc->spis_num     = 2;
+    sc->ehcis_num    = 2;
     sc->wdts_num     = 4;
     sc->macs_num     = 4;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
-- 
2.20.1


