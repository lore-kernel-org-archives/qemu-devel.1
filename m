Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F3C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AB92073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbX0qO5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB92073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FoZ-00055x-7d
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgi-0004Av-RU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgh-0001Qh-Fr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgh-0001GD-5P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id t3so6978624wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kec+6YUQYfqYLzCYTZScAog/TIHEyy7ZDa+Goaadib4=;
 b=PbX0qO5sj8ysdGwyoOnslIPqIYt5Q3QW5o238rnLWVMmBUPFKUcriZWP9xES/Yfc5L
 3yHOU41e/cguUoRHgvQk/FQEAZDe24odCEjHnMp45cDNn6AZlk7A87Zl6/9fW5/uP2Fm
 w4rIgLcZxC8FnhDi6nGVjNjhyld+qb2YxUosjhffkd0E3K0U+lvOuIjEZbVJgAFdK4RS
 TTKdSfK1mlbPzCr0tKPBvRLy7NTD3qtIoUEcGRtYtBXlsa7BcYpV1nOs6b+rLK7K73pi
 4UOaqqm5bCR59XqSxNp6djI4g4ILx7KJHds8Ut/oEUmPw0urevokxoMbpOpQkjkoUDsN
 4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kec+6YUQYfqYLzCYTZScAog/TIHEyy7ZDa+Goaadib4=;
 b=IeAjZ4Im7DatevAXf4Nyb8Fzwu5xZVuS1cTbOiO5ASqB3mSJpq4U4VV+WQ3UPBJFkp
 fRHZ2m4Lt+FAeDFa4S1SwVXaoOcw5I4Wxi99KWG60KMcMyH105p1QSC57LiSext8D5ec
 HD2ACaUST5ZbpR7pqs71ubHVVeDlVXDzMQPjr2XvTDd+wT5/AEorZlsaGGr1Kclte/bI
 AAfUmQiNGlVv255EbtfWJJL9zO5cDCHgpprhNQteT4xzqejXi0rWs3YILZx+OiLIfvaJ
 wnBSYHfT90ml2Fq4RKtaZtltU3OAjw5Y3YxUgZ46jKWb+aBFNDiAFuoLmwQ5uQBAIU/2
 FVfg==
X-Gm-Message-State: APjAAAUmSxRC3Ne/w6kmFb9/ujbXPmCmR2zpRKEdfekhfObS+FZLF2FK
 NEm3N9M8vgWSvhW+ggmkcBdVfA0WCrs=
X-Google-Smtp-Source: APXvYqwvvQaeclkoFGqzmfO2NBPyFaFetpXzOwQm36Imw5cR+prg4nBn1nJ3Pm3epPMZfHNCoaTPqA==
X-Received: by 2002:adf:e781:: with SMTP id n1mr23601555wrm.56.1581604910108; 
 Thu, 13 Feb 2020 06:41:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/46] i.MX: Add support for WDT on i.MX6
Date: Thu, 13 Feb 2020 14:41:01 +0000
Message-Id: <20200213144145.818-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Roman Kapl <rka@sysgo.com>

Uses the i.MX2 rudimentary watchdog driver.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Message-id: 20200207095529.11309-1-rka@sysgo.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: removed accidental duplicate #include line]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h |  3 +++
 hw/arm/fsl-imx6.c         | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 1265a55c3b0..60eadccb421 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -21,6 +21,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
+#include "hw/misc/imx2_wdt.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
@@ -42,6 +43,7 @@
 #define FSL_IMX6_NUM_GPIOS 7
 #define FSL_IMX6_NUM_ESDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
+#define FSL_IMX6_NUM_WDTS 2
 
 typedef struct FslIMX6State {
     /*< private >*/
@@ -59,6 +61,7 @@ typedef struct FslIMX6State {
     IMXGPIOState   gpio[FSL_IMX6_NUM_GPIOS];
     SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
     IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
+    IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
     IMXFECState    eth;
     MemoryRegion   rom;
     MemoryRegion   caam;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 552145b24ec..ecc62855f2b 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -91,6 +91,12 @@ static void fsl_imx6_init(Object *obj)
         sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
                               TYPE_IMX_SPI);
     }
+    for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
+        snprintf(name, NAME_SIZE, "wdt%d", i);
+        sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
+                              TYPE_IMX2_WDT);
+    }
+
 
     sysbus_init_child_obj(obj, "eth", &s->eth, sizeof(s->eth), TYPE_IMX_ENET);
 }
@@ -383,6 +389,21 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->a9mpcore),
                                         FSL_IMX6_ENET_MAC_1588_IRQ));
 
+    /*
+     * Watchdog
+     */
+    for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
+        static const hwaddr FSL_IMX6_WDOGn_ADDR[FSL_IMX6_NUM_WDTS] = {
+            FSL_IMX6_WDOG1_ADDR,
+            FSL_IMX6_WDOG2_ADDR,
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
+    }
+
     /* ROM memory */
     memory_region_init_rom(&s->rom, NULL, "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
-- 
2.20.1


