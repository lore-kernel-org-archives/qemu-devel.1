Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59021C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E2B20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRpOWJ6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E2B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAdd-00063i-9b
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaY-0000R1-RA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaX-0002mR-Hv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaX-0002c4-94
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id n8so21058575wmc.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1aHjPvUHnsNDgHEP2zgBF6uXgi4tw5ct0zaFNIjPWRQ=;
 b=GRpOWJ6F1159FOtGGpykObhsKSHyGq/9oInvtuF9kywsIgsV7tDLoHY+7OmbgIqgmM
 pVE/e3ysr6RVNn7KzV6C3ZNOJaOGydDmfl+pBZheeJPPObveln6sG+C9z5ZyBtOUrJFF
 +87QQB2ycwum3LILrfRgFjPpfGqbdxoTcb5DGU9zoKJCz75S+9kELRhUA/0jC82VSJG5
 jlq5tTobP0KjAY7Z5TwuAVbyhWwiqBeB7ugCKsX3BqpmvmuuNXAHCPzim32trtA1m1DN
 mGekE7k6f3N0V2EfU565c6bb5TOyBmFw3a3Ie7+igcTLGQm3MikJOEvtALDMEE63H2yb
 GX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1aHjPvUHnsNDgHEP2zgBF6uXgi4tw5ct0zaFNIjPWRQ=;
 b=YJ6wWe6jyOPqXgHHkqpCgp2qQXjp5Id09UFrWNdUNcbH9z36U7U3+Zr1UBcvx7ByEC
 mZ0qt0iv99rLtAz6eHlXUTK+798YYDbsy/faijORLH2aav86D+Quo8Qp/0BJXik+jCgU
 mPoyWi4uRxNqCkWVrJ0sUfOAALekUrLYCzctmYTGQzMki3ffkvksRRxsRhS26kb0oToJ
 3/+0eVC2Gl3AVIygIo5n1c262TlHinTmG2sznzpbXy+bOH+jp6bdSYHdO7r3VXLuQkWM
 ZZm8iAMRP88Lx/WQer1AgrXSocrKfBppl4tWgIJv44zHExF4Gwzn+6ibgbZy/dNawgHp
 qTZw==
X-Gm-Message-State: ANhLgQ2YroL78OEoCpw7lNGQTBMfrvpfDDvkgLM7oclrOCiZozJqplZX
 IqmWT+Z+Gy/pWYFnx8Dplf4XHYt+qRuDAQ==
X-Google-Smtp-Source: ADFU+vs5ESMt8uxj2+/VSbRxFG84FuEclW67kHN6AAUWLv//YitQUw0CqC0/lbJGuUytUkfDoxsXqQ==
X-Received: by 2002:a1c:b154:: with SMTP id a81mr4926538wmf.175.1584445247947; 
 Tue, 17 Mar 2020 04:40:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] hw/arm/fsl-imx6: Wire up USB controllers
Date: Tue, 17 Mar 2020 11:40:33 +0000
Message-Id: <20200317114039.26914-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

With this patch, the USB controllers on 'sabrelite' are detected
and can be used to boot the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200313014551.12554-6-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h |  6 ++++++
 hw/arm/fsl-imx6.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 60eadccb421..973bcb72f7f 100644
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
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2b..e095e4abc6f 100644
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
-- 
2.20.1


