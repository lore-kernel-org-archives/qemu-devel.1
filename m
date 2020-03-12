Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67710C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335FB206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsXSJ/vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335FB206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR0X-0005xw-9O
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxR-0008LW-8l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxQ-00057c-0H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxP-000572-P7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id d5so8026708wrc.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ubre2v1uHL3eoMEypp4g/yeKbGebypuneeqbWFZfkPA=;
 b=fsXSJ/vtvTK6AA6hJsCSFGo9dRmDrLSwm2qQeXKggynijD99UcyRZwg7WmT4p89N3D
 hlBlZQ7P910gY6+gmqp5eWzSydQnx7Af3lbnP6Q4MOfNkktGivRcIQSaK9ToWWnxA60a
 TxU5eAd9hqOQi1adY/MyUUHYWobwDz9RTK9OphLFo6cTN7HqmbM62fT9MSBNeu1fwGEp
 Qje1tbIfndADn9mPJ8ZHogppXGpWyiVaT2TeWWsEP2w0CigFlrSYikxGyR+6HyVtGoxJ
 JkOej5Nq5cVfIeZrC3VIKfNKgX0N80QXMLpFIDazMeDE+nhcxSJZrQhf6y/Foq3DYUDU
 CV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ubre2v1uHL3eoMEypp4g/yeKbGebypuneeqbWFZfkPA=;
 b=fb9xnBCEimrhiDN3RqzmkpvsPKvrd71L2y3kwY1WETiuOgmDmUesT3+vbVYSddrmK9
 Lpm+rcTPHsWxaTn6PNBMKUiOlA/qdVKymI6OqfkCQwlDYGAWeL9RercVCjU9gH3AydEH
 ArbzT8M6DWcBzbnW9GRU9qeUxSTsnSyGkr6ysO0fVUj6LvqhPCYNNA8VZAiv3QGPXMrW
 bxEMqd26YQpKZ5ulYF5+TwtC/Yzig96HM+fkVZodH/xdbiaTKjJMwN+71+cBEze6Bk0S
 IvzTXk8rzpp9VjTuZZ8qbymSNnUgGHMGw52EBu3fQ7kAY0Mi2yOzPD9ep0YCzOlHTzL6
 Hf8A==
X-Gm-Message-State: ANhLgQ3mOFfSJTPmbt024LC6x+s6dyt5aOcvATASaUDBwi27FFnL/nYf
 DzF8tSrInUDiAu6Rp8arQPAJYk10bF+17A==
X-Google-Smtp-Source: ADFU+vvW1JtIPMVO3cZqLBhulLpT5u5eaprS/e33cv5CBubkEpI2uOhvChkiYnK/ocYTGiOTeUh6YA==
X-Received: by 2002:adf:f94f:: with SMTP id q15mr11743394wrr.65.1584031514350; 
 Thu, 12 Mar 2020 09:45:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] hw/arm/fsl-imx25: Wire up USB controllers
Date: Thu, 12 Mar 2020 16:44:34 +0000
Message-Id: <20200312164459.25924-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

i.MX25 supports two USB controllers. Let's wire them up.

With this patch, imx25-pdk can boot from both USB ports.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200310215146.19688-3-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h |  9 +++++++++
 hw/arm/fsl-imx25.c         | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 4e2d4868cda..5e196bbf059 100644
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
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index f977c42426b..a3f829f4366 100644
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
-- 
2.20.1


