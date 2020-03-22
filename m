Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140FC54FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB30206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VugeFxnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB30206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG83x-0007Ul-P6
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80O-0002tW-HQ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80M-0002kx-Lk
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:36 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80M-0002jy-44; Sun, 22 Mar 2020 17:19:34 -0400
Received: by mail-pl1-x643.google.com with SMTP id x1so978053plm.4;
 Sun, 22 Mar 2020 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yJSNMH7F2JV82ctJF/qnhkJrlNBkApOpJ7cdZGhHOO8=;
 b=VugeFxnjOCdQElNIcmmGZWHigkfdENFH70/Qhq41d1VWtv/BFrHz4NPUl90PT348yP
 4sjLSYOZktLgum6p84RfhpK10agrmOtsOxjNGa4q2OraQcw9s0U2p6q5FtjunfDqaDDj
 sCIlzXCK3QHgV1wzXcQg41VYm46NTomO4V6fnC8oypVMc9WUrUWBDJ+ZRfaHMPTUM13X
 lIthN+Ffc6cMf6tuMuR3s96NfozAA2eK9gKb4k2WNuMJMd1ffqgIWArj//OvuXbou9TL
 kiySJLBRnykO9l8dqSnnwMXWmAwLEAUKCoRSsDktMVgxtGAAwnGrFk1/Ixp0myiT7dk8
 3IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yJSNMH7F2JV82ctJF/qnhkJrlNBkApOpJ7cdZGhHOO8=;
 b=NlX7tn/7+PovQ0MeV3T8Qt0u7jSpNAP0dZqh5VWSDVGFSiBVOjyReAQQPAGpZJ2dYV
 F7fTBy8HVI11kmtubAwitm1tUmU2PU7z0I4Ej7MldrZ0d307g5way1cW7i962mqwl1Fu
 cedL4CrzGb7cdfx3lNW6IbCPq8dTjsd0UBpu5mPFBvkRJmNrfCeNZ63ELGRzrJZ/FwhO
 Ei/c5mrfv8gLMkx9rfsi5agHt98vpZtISosRmPKvTZehF6+bi+LO6pSj2cJkhakmJey3
 yUNjKBAfGdAKvP/HiybtlKNyaFgTATZuPXaxJ9mUarCCp4evZUquCrUyS5ffY8N64e2a
 53Gg==
X-Gm-Message-State: ANhLgQ13fPYfiI1s7d/EL8ujuPjwxayLl71LkswIG+iNEZcLLqIhxx87
 FfHDIYO7VKiCcQ7Qr+PAw34=
X-Google-Smtp-Source: ADFU+vtZDA6xcJllt8OlY89q2EtKeMMijLLy8Osov68QCMZh2dIZ3T+m+2R3csFBu5HCP0XFXJE0GQ==
X-Received: by 2002:a17:90a:3589:: with SMTP id
 r9mr21582090pjb.196.1584911972250; 
 Sun, 22 Mar 2020 14:19:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id f64sm12030420pfb.72.2020.03.22.14.19.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:31 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/8] hw/arm/fsl-imx31: Wire up watchdog
Date: Sun, 22 Mar 2020 14:19:15 -0700
Message-Id: <20200322211919.11335-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch, the watchdog on i.MX31 emulations is fully operational.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Select WDT_IMX2 explicitly
    Added Philippe's Reviewed-by: tag

 hw/arm/Kconfig             | 1 +
 hw/arm/fsl-imx31.c         | 6 ++++++
 include/hw/arm/fsl-imx31.h | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 54a49aeabd..9c77f4cbb4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -366,6 +366,7 @@ config FSL_IMX31
     select SERIAL
     select IMX
     select IMX_I2C
+    select WDT_IMX2
     select LAN9118
 
 config FSL_IMX6
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 8472d2e911..1e7959863d 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -63,6 +63,8 @@ static void fsl_imx31_init(Object *obj)
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
     }
+
+    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
 }
 
 static void fsl_imx31_realize(DeviceState *dev, Error **errp)
@@ -205,6 +207,10 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                             gpio_table[i].irq));
     }
 
+    /* Watchdog */
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
+
     /* On a real system, the first 16k is a `secure boot rom' */
     memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index ac5ca9826a..dd8561b309 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/timer/imx_epit.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -49,6 +50,7 @@ typedef struct FslIMX31State {
     IMXEPITState   epit[FSL_IMX31_NUM_EPITS];
     IMXI2CState    i2c[FSL_IMX31_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX31_NUM_GPIOS];
+    IMX2WdtState   wdt;
     MemoryRegion   secure_rom;
     MemoryRegion   rom;
     MemoryRegion   iram;
@@ -87,6 +89,8 @@ typedef struct FslIMX31State {
 #define FSL_IMX31_GPIO1_SIZE            0x4000
 #define FSL_IMX31_GPIO2_ADDR            0x53FD0000
 #define FSL_IMX31_GPIO2_SIZE            0x4000
+#define FSL_IMX31_WDT_ADDR              0x53FDC000
+#define FSL_IMX31_WDT_SIZE              0x4000
 #define FSL_IMX31_AVIC_ADDR             0x68000000
 #define FSL_IMX31_AVIC_SIZE             0x100
 #define FSL_IMX31_SDRAM0_ADDR           0x80000000
-- 
2.17.1


