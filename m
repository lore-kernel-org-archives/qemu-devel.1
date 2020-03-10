Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB04C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC6E222C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayp+j++J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC6E222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBm93-0006Mv-KU
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBm3S-0008VF-SX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBm3R-0000ju-LP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBm3O-0000Zf-RW; Tue, 10 Mar 2020 17:04:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id b1so6861811pgm.8;
 Tue, 10 Mar 2020 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F4gBQYAuwGb2CicEJbL46QHlOPvhRttRRSCsd9S6VPQ=;
 b=Ayp+j++J9zU1lASlQkdSCv1uarzkCFvdjwRAUR7OXGif6PcORgzkkjSX6j03JJVeFx
 RxkR+nUVYJiFW1HgypCUEboriFOSgblHOx6fQ1PQJ8mwsUCtaGLXXuDM+UJcEhcwCrNy
 S4qpyIA0UCbSJ2b95nWjQO8mxZtOHOPRaodpqgLxvWx3VB3Qz65fDSVOGr2wpfkvsYAV
 C79ff3M1xrHVldd5KZsw2WKY+2Hff/ClLGmwvWrsPpCOyW2jzxBj/QeW0QPANsfYW4zN
 +E4qF5m+sR1q+9JrcKR77aMBlFQu03l3BDHCNoGFcenHwiZEN+nRcnN8dGxoIsJRkKg6
 gTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=F4gBQYAuwGb2CicEJbL46QHlOPvhRttRRSCsd9S6VPQ=;
 b=FampH0nVxSi5ek7CIpTIYyGSgTHZQUfycCtQ867+cDs4i/bgVpyHKyGMGqojfFruc6
 SOPMe9+FWtC6ZQZ/pMKK/KFOlwgKp1kFnq5vDesBY+FrLA29yxzz0WHW3clL3hsGBr1o
 62QsnY8gvtDlWHYaroF3Nxg7oYf+qsIsHgVMtB8cAU9LJpyNWImF7lb9s4vIsm7/X98G
 q+LEEjy29R6+7KrYGtkXzck7VlLe2ySRn71kBgdK/dq42MSIEn9UxgbC1kuhshRj0hZ1
 vNE6FpAio/i9kp6lwI8CPfxAOz3Hs8kCzs7tAscLrNys0Tr3LJALs/YlkQkyRnKd4Mf+
 2c3Q==
X-Gm-Message-State: ANhLgQ0GR4nfp8yvLEcLA/lQYyX4x4uVS/xAPzbb9dMrABn7Ij+aX0Py
 S3YJQr8dhE5d+wkQWjSBNV8=
X-Google-Smtp-Source: ADFU+vu0MZFMg3uXPX7iG4ZdXGHakMzAureYSy26yziFuufIH7ohTSYgEYTkxkgVaKCY1TDVSKFntA==
X-Received: by 2002:a63:f50e:: with SMTP id w14mr22536088pgh.363.1583874281914; 
 Tue, 10 Mar 2020 14:04:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id z1sm6981469pgz.79.2020.03.10.14.04.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 10 Mar 2020 14:04:41 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/3] hw/arm/fsl-imx6: Wire up USB controllers
Date: Tue, 10 Mar 2020 14:04:34 -0700
Message-Id: <20200310210434.31544-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310210434.31544-1-linux@roeck-us.net>
References: <20200310210434.31544-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
v2: Use USB PHY emulation

 hw/arm/fsl-imx6.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2..92b3955817 100644
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
@@ -86,6 +87,15 @@ static void fsl_imx6_init(Object *obj)
                               TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+        snprintf(name, NAME_SIZE, "usbphy%d", i);
+        sysbus_init_child_obj(obj, name, &s->usbphy[i], sizeof(s->usbphy[i]),
+                              TYPE_IMX_USBPHY);
+    }
+
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
@@ -349,6 +359,30 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             esdhc_table[i].irq));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        static const int FSL_IMX6_USBn_IRQ[] = {
+            FSL_IMX6_USB_OTG_IRQ,
+            FSL_IMX6_USB_HOST1_IRQ,
+            FSL_IMX6_USB_HOST2_IRQ,
+            FSL_IMX6_USB_HOST3_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
+                        FSL_IMX6_USBPHY1_ADDR + i * 0x1000);
+
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                        FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_USBn_IRQ[i]));
+    }
+
     /* Initialize all ECSPI */
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         static const struct {
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 60eadccb42..edc3fce3fa 100644
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
 
@@ -44,6 +46,7 @@
 #define FSL_IMX6_NUM_ESDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
 #define FSL_IMX6_NUM_WDTS 2
+#define FSL_IMX6_NUM_USBS 4
 
 typedef struct FslIMX6State {
     /*< private >*/
@@ -62,6 +65,8 @@ typedef struct FslIMX6State {
     SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
     IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
     IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
+    IMXUSBPHYState usbphy[FSL_IMX6_NUM_USBS];
+    ChipideaState  usb[FSL_IMX6_NUM_USBS];
     IMXFECState    eth;
     MemoryRegion   rom;
     MemoryRegion   caam;
-- 
2.17.1


