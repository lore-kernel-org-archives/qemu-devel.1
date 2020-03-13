Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8718F206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeQLYKvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8718F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZVC-0007WX-PM
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCZOn-0001TH-37
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCZOl-0006DY-Pr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCZOl-0006BU-JG; Thu, 12 Mar 2020 21:46:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id 2so4200001pfg.12;
 Thu, 12 Mar 2020 18:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VLW3DJHaRDJANB3ze17lSXDJvZ0yOVqltYdOkgjsvlU=;
 b=JeQLYKvwbvJ9ybhbeLLKLbb87c/jmKgGk+fVHxnhZSECwWGvMo8mlneXSD4fY+hkHc
 xqtGrQ9Qiyg9czjDnnTsIPNMTvvdxN1LMJUneDgYUZh1Wwijhk5W/GW9jgV2tJN40h5Y
 vknHAKxI38e40DfCzNNEHcwvQsPNPB2Mr3R5iJIWYDgB54dkhbGWmMbuM5MNcijbDT2D
 mstTqhC0GI0mR49SNJayh0eiDB+44qCXHmlLBj97iMMEjQUKC/AbN9sFeGPNUa5uNMpo
 PRlqk8Zg+LR0s87U5w1q6BJT/FuTnCRS9tPEOITSCZMwLC2eEG+cZO7MZg0sjS+4k6sj
 CNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=VLW3DJHaRDJANB3ze17lSXDJvZ0yOVqltYdOkgjsvlU=;
 b=QKUFqUx4IK0I6c78pavNIIekoABfAnsnSBfXubV1JMcXpUK3tfMtxwNJbSiwrKskKm
 CYfcFgCj4V1kz/IfQQYAVMTXth9GMGYdPdrJTG4vulkf4z8SemdN1bQ0cURdk5ugyXz+
 UfAJ2xKR1peWUV0IZOTAavJg7PxzmfNaVBRffM+HYrAxNSMsfm8R1H1Ko/ZQdmnOiVD3
 vyXyBhUVJvU/Ry6oEk4LOZsQ3niloagW2B/ZoKenC6eWv5chbDt3CsyXk0wfheptLGRR
 it3IRm3azDuG55flzk5s09JHmBTo5pKtFzo5jptnswn0DBq5B7WbQGn2lWiC75L/n+tH
 OJGg==
X-Gm-Message-State: ANhLgQ2eRUEER/PGaocG4IHV2xpSBcjkhNUuP5o2EYM8NyAQn2Q6uD0G
 4+xaizYUea7EpspTo0IVV50=
X-Google-Smtp-Source: ADFU+vsT5GyYhV2RB3lKgFZNVmQh481ONE5J7bQM6/jRw24zGYO/x2JGj1Ms9n9YUtutRoQsvtNQ0g==
X-Received: by 2002:a63:c4e:: with SMTP id 14mr10500397pgm.444.1584063962756; 
 Thu, 12 Mar 2020 18:46:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 17sm24433416pfu.166.2020.03.12.18.46.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 18:46:02 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 5/5] hw/arm/fsl-imx6: Wire up USB controllers
Date: Thu, 12 Mar 2020 18:45:51 -0700
Message-Id: <20200313014551.12554-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313014551.12554-1-linux@roeck-us.net>
References: <20200313014551.12554-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch, the USB controllers on 'sabrelite' are detected
and can be used to boot the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Wire up USB and USB PHY controllers separately.
    The number of USB controllers does not match the number of USB PHYs,
    and they are logically different. 
v2: Use USB PHY emulation

 hw/arm/fsl-imx6.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2..e095e4abc6 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
@@ -86,6 +87,17 @@ static void fsl_imx6_init(Object *obj)
                               TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
+        snprintf(name, NAME_SIZE, "usbphy%d", i);
+        sysbus_init_child_obj(obj, name, &s->usbphy[i], sizeof(s->usbphy[i]),
+                              TYPE_IMX_USBPHY);
+    }
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+    }
+
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
@@ -349,6 +361,30 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             esdhc_table[i].irq));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
+        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
+                        FSL_IMX6_USBPHY1_ADDR + i * 0x1000);
+    }
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        static const int FSL_IMX6_USBn_IRQ[] = {
+            FSL_IMX6_USB_OTG_IRQ,
+            FSL_IMX6_USB_HOST1_IRQ,
+            FSL_IMX6_USB_HOST2_IRQ,
+            FSL_IMX6_USB_HOST3_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                        FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_USBn_IRQ[i]));
+    }
+
     /* Initialize all ECSPI */
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         static const struct {
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 60eadccb42..973bcb72f7 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -30,6 +30,8 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/usb/chipidea.h"
+#include "hw/usb/imx-usb-phy.h"
 #include "exec/memory.h"
 #include "cpu.h"
 
@@ -44,6 +46,8 @@
 #define FSL_IMX6_NUM_ESDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
 #define FSL_IMX6_NUM_WDTS 2
+#define FSL_IMX6_NUM_USB_PHYS 2
+#define FSL_IMX6_NUM_USBS 4
 
 typedef struct FslIMX6State {
     /*< private >*/
@@ -62,6 +66,8 @@ typedef struct FslIMX6State {
     SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
     IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
     IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
+    IMXUSBPHYState usbphy[FSL_IMX6_NUM_USB_PHYS];
+    ChipideaState  usb[FSL_IMX6_NUM_USBS];
     IMXFECState    eth;
     MemoryRegion   rom;
     MemoryRegion   caam;
-- 
2.17.1


