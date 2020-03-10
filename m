Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A7C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B385215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlMDPBBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B385215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmnq-0006D7-M9
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBmn6-0005Hv-DG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBmn5-00073A-6M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:51:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBmn2-0006vw-Nv; Tue, 10 Mar 2020 17:51:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id m5so39675pgg.0;
 Tue, 10 Mar 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DBYFIldccRLrR0tdp5iDCeyHIyqYrrHiZr1tvZTudAk=;
 b=AlMDPBBpU1/mwsaAGrq3I2eZ3BMxYsb0ZgyzmtIsC8s5+PjlgRYALFbOBXO2Shzr/d
 cmfwhz5PiZC9bWN5gBj45Y+oAKhW8men1pbn5+xih6EZRexLVxo4QKH8Uj/SKyyeBRXC
 MgeVRrd+RaH7Svww2wyhmcJBjkLD3QPbnReTp/K+SSg6ylJP1WmdXdyq4ys4v988KpUS
 a/ocVqxK/ADJDNsf+X6Zl0HN37zT5ONPNpIEh7xm0/pmNBv6HzHrsyivVNe8RzwAZKOD
 nF9Pb3TAQTEIIRYqrpijKCsTaJuWT8/y3faDOYzlDTavCR2uFk3u7cxBg3SbtMxnd/ep
 tqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=DBYFIldccRLrR0tdp5iDCeyHIyqYrrHiZr1tvZTudAk=;
 b=R8dFcfPB/Dsv+GERYS1630N3dWP1aB6oG+BFdwmARzZaWzh6xGJAr7LUMoGIdAy/ln
 HNtXwzFN+Z934kOK641CMdwh0tTsTD16o2pKVh+f65TliwEUFTKQ3NPZxPU6Vk1AvZDt
 gC7it6C1GneFxo7WNM4gVHM1rg9DMwsCKu4ts377DOEmQxdBpBQ7IRfdTYSpSiDWIV7/
 cwJT86cqzyRQRWHvEJEw85U6nC2HucakAJcqc628YhI7WhBxfalubocarhzsMa8A1Olx
 7460tg/VSXJoRNBn2h3/wAyT7RdYZDON92wFHXEULImy6BT8Uu0Gcxkfb6bsFsX/CG/S
 DEPg==
X-Gm-Message-State: ANhLgQ1bKmDNLOvQ7UpYa6SVdQvUa8NRg9b1rQcsps+YpRAI4Rdpk991
 HhiMaVeu2efFxz2gy3iDPWI=
X-Google-Smtp-Source: ADFU+vtQSkRqjnF3RGGxMv4D26+rvr53v0XkpW9D9j5/nLHgbF87DVQuLKFhtGttwNMwxrRLubtJnw==
X-Received: by 2002:a63:155c:: with SMTP id 28mr22139082pgv.176.1583877111776; 
 Tue, 10 Mar 2020 14:51:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h2sm3081752pjc.7.2020.03.10.14.51.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 10 Mar 2020 14:51:51 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] hw/arm/fsl-imx25: Wire up USB controllers
Date: Tue, 10 Mar 2020 14:51:46 -0700
Message-Id: <20200310215146.19688-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310215146.19688-1-linux@roeck-us.net>
References: <20200310215146.19688-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

i.MX25 supports two USB controllers. Let's wire them up.

With this patch, imx25-pdk can boot from both USB ports.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx25.c         | 24 ++++++++++++++++++++++++
 include/hw/arm/fsl-imx25.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index f977c42426..a3f829f436 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -81,6 +81,12 @@ static void fsl_imx25_init(Object *obj)
         sysbus_init_child_obj(obj, "sdhc[*]", &s->esdhc[i], sizeof(s->esdhc[i]),
                               TYPE_IMX_USDHC);
     }
+
+    for (i = 0; i < FSL_IMX25_NUM_USBS; i++) {
+        sysbus_init_child_obj(obj, "usb[*]", &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+    }
+
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -278,6 +284,24 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             esdhc_table[i].irq));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX25_NUM_USBS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX25_NUM_USBS] = {
+            { FSL_IMX25_USB1_ADDR, FSL_IMX25_USB1_IRQ },
+            { FSL_IMX25_USB2_ADDR, FSL_IMX25_USB2_IRQ },
+        };
+
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->avic),
+                                            usb_table[i].irq));
+    }
+
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 4e2d4868cd..5e196bbf05 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -28,6 +28,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/sd/sdhci.h"
+#include "hw/usb/chipidea.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -40,6 +41,7 @@
 #define FSL_IMX25_NUM_I2CS 3
 #define FSL_IMX25_NUM_GPIOS 4
 #define FSL_IMX25_NUM_ESDHCS 2
+#define FSL_IMX25_NUM_USBS 2
 
 typedef struct FslIMX25State {
     /*< private >*/
@@ -57,6 +59,7 @@ typedef struct FslIMX25State {
     IMXI2CState    i2c[FSL_IMX25_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
     SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
+    ChipideaState  usb[FSL_IMX25_NUM_USBS];
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
@@ -226,6 +229,10 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
 #define FSL_IMX25_GPIO2_SIZE    0x4000
+#define FSL_IMX25_USB1_ADDR     0x53FF4000
+#define FSL_IMX25_USB1_SIZE     0x0200
+#define FSL_IMX25_USB2_ADDR     0x53FF4400
+#define FSL_IMX25_USB2_SIZE     0x0200
 #define FSL_IMX25_AVIC_ADDR     0x68000000
 #define FSL_IMX25_AVIC_SIZE     0x4000
 #define FSL_IMX25_IRAM_ADDR     0x78000000
@@ -259,5 +266,7 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO4_IRQ     23
 #define FSL_IMX25_ESDHC1_IRQ    9
 #define FSL_IMX25_ESDHC2_IRQ    8
+#define FSL_IMX25_USB1_IRQ      37
+#define FSL_IMX25_USB2_IRQ      35
 
 #endif /* FSL_IMX25_H */
-- 
2.17.1


