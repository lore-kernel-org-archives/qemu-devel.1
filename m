Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC08CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E316321D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpGJuwyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316321D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEnX-0006HB-G1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEij-0000LL-LV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEii-0002LA-EH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEii-0002Km-7b; Thu, 17 Oct 2019 18:58:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so4174770wmd.3;
 Thu, 17 Oct 2019 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wn44savEe+flJq53w0kELlQpNWIaC5iY2joSfr7hWdU=;
 b=qpGJuwyUINs2+y1Lr/g9dGA0RrPnzmRG+jKIso5SuM6WgbkjkgwgQghSkX3EHP5MtF
 0gzWwjtCz73x/lRc4CA8gzwLBN5/5qXZ5nfd7GMlnkt58ZW4IFnhxL8PjV0lj+b0U9aL
 Ixm/XVRuQ426sLRAxxfjlJbRdRY3n4n/t734vnlh3kSTaQbkBx+49ZK5miHrMe3N7kpM
 ouia4ZilNq30YiDGVyWF5h8jyBGI5ki4Il+PQ7gn00FDRjyYqenIYn6hQZys2qioR1+j
 LD1f3Oisu/AudRgrQVprB2FHTwnuJa1mYgYIsowpMgMHHgSlZV51HjJf4scVai9D1Ez8
 EnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wn44savEe+flJq53w0kELlQpNWIaC5iY2joSfr7hWdU=;
 b=KhKxrz3fRLLfmRflN0U4wUZ2mNsaqUE80heQKT/Crp0u7hlIH4BtwLL5lThn8Wfv8a
 RE2VNEzg2M2UxKQ6qCOvqxBfYGklTnJQdHssV1nAFPe16Igi7+lr4sWJ0IhsPbWNFutM
 rKnYzFxBrjbpJ0Lz+ivyYbzAo0+AKKlm88AKnXf1nFTHLrWHhNc3OdtokKkvLalqkrK8
 xY3FDOhLk3lbY2sfXVN3MAM6/tE+FK0RX2gHa/UMg43EAZr1eB+XMRo/xgXxf7a2j8IS
 TT+oZ6g4IV7iNLn0A8cvRurLeERwUeFugfkfc+BR6tbOVl6hemMpmKM2jXJjJSx1QAXB
 owng==
X-Gm-Message-State: APjAAAUhAJ1j/IKRLdSolTMnT7QVK9T6XKPLH0x9bOrGPQOXr4rN4Ggx
 Qb+M1Kthi5voDwYkLANqIg47f1ZQ
X-Google-Smtp-Source: APXvYqwxUPvjTtX6r658QRECOZC7LX/V5FW1MG6wfJZeK8dJvNuQRgDbGTaC6y0bQOQvfqOA5dIa0A==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr4665604wmb.77.1571353090326; 
 Thu, 17 Oct 2019 15:58:10 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] hw/arm/bcm2835_peripherals: Use the thermal sensor
 block
Date: Fri, 18 Oct 2019 00:57:52 +0200
Message-Id: <20191017225800.6946-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Rob Herring <robh@kernel.org>, Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Map the thermal sensor in the BCM2835 block.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 13 +++++++++++++
 include/hw/arm/bcm2835_peripherals.h |  2 ++
 include/hw/arm/raspi_platform.h      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index fdcf616c56..70bf927a02 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -111,6 +111,10 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
+    /* Thermal */
+    sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal),
+                          TYPE_BCM2835_THERMAL);
+
     /* GPIO */
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_BCM2835_GPIO);
@@ -321,6 +325,15 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                                   INTERRUPT_DMA0 + n));
     }
 
+    /* THERMAL */
+    object_property_set_bool(OBJECT(&s->thermal), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
+
     /* GPIO */
     object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
     if (err) {
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 62a4c7b559..be7ad9b499 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -20,6 +20,7 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
 #include "hw/misc/bcm2835_mbox.h"
+#include "hw/misc/bcm2835_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
@@ -53,6 +54,7 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
     UnimplementedDeviceState spi[1];
     UnimplementedDeviceState i2c[3];
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index cdcbca943f..61b04a1bd4 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -48,6 +48,7 @@
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
 #define OTP_OFFSET              0x20f000
+#define THERMAL_OFFSET          0x212000
 #define BSC_SL_OFFSET           0x214000 /* SPI slave */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC1_OFFSET            0x300000
-- 
2.21.0


