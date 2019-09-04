Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F26CC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EB521726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCxCS6Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EB521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Yud-0004YU-3L
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqb-0001VI-IK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqZ-00074U-NI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqZ-00072y-Dn; Wed, 04 Sep 2019 13:13:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id n10so4720856wmj.0;
 Wed, 04 Sep 2019 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sXtrRzxkxK0K9P/W8U2rNzxCRQ7eLCmvy8NMXNF7RAI=;
 b=oCxCS6FqPq4T8AYwoAt2MaY29fD70wrSp6iwdIILqHVKo05XTx0jvov5dfkV5U6zKq
 xIHo9u51OtaQYk4130N0jB6ERc1znoUjxZU4zPPfxvNzSvq+QQaIV8HC6sBn+XXvaTC1
 BB86b5kPIQw20kWxm3FWczGXwyiKHAE14B1BMx8kT0yn/BUlc4VfGXSuxaile0+Cm79G
 ulZRkuNzwrPiX+KeYSnuHS5K6vMPoOcW87sCkUgO4vZEj4/ibmDV+lqSC5r6YnAZBAku
 peTBF1ilUtAdqpANqBMTWlNpBAFuZApJ5TN11glga1O9QavtLQL9y0m2ydDvPkbTe1o/
 BRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sXtrRzxkxK0K9P/W8U2rNzxCRQ7eLCmvy8NMXNF7RAI=;
 b=DSF5ls/rurAbFWYF1vG0WeP0AtAwpL/XQIhLSU5xTCvdacS9Z4f9vems1aRL9WN70K
 /SVtSXC/uUjx8uY5bxVIHCtrCVvk5oPRNN18cxTPZ4fWo2MR0h96enaMW12CATPpNqsQ
 0Fh4foFEQTLjfaAnTMxPE12x2qqTKozJuvS2N7d53mUiCIrKWu38RM+jYB50I5+ZPre3
 J50Q9/U7LGGsW/EYFo36ba4gIOiiCXRq4a0uhFb5CMcDJS30ODOy01Vc2FbmuZuMzu/R
 bqWCAqLhb/ti5BOV+fgyMWWueeWJT+dM5dE7s2LBUnIrfO7RDgFNLZELnGWOAAMR13nP
 Hrcw==
X-Gm-Message-State: APjAAAX5IlOKEuH7kldkGLTBOlN4I1PbJbMsd0iwpK0NMcTnpZY0bJH8
 4ZCi5LM7n4Zsi+sYasUU6vU=
X-Google-Smtp-Source: APXvYqwfAn1HRpGuxoX/TaMe08SL/VCYcXYjH+vAs2akeCzqUB1DKZ68NQ2oc+blpGNZtZ7nR+70PA==
X-Received: by 2002:a1c:f103:: with SMTP id p3mr5113430wmh.18.1567617210393;
 Wed, 04 Sep 2019 10:13:30 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:08 +0200
Message-Id: <20190904171315.8354-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 07/14] hw/arm/bcm2835: Add various
 unimplemented peripherals
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
datasheet from February 06 2012:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 30 ++++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h | 14 +++++++++++++
 include/hw/arm/raspi_platform.h      |  8 ++++++++
 3 files changed, 52 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 270357b5a8..be6270b8ef 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -22,6 +22,20 @@
 /* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
 #define BCM2835_SDHC_CAPAREG 0x52134b4
 
+static void create_unimp(BCM2835PeripheralState *ps,
+                         UnimplementedDeviceState *uds,
+                         const char *name, hwaddr ofs, hwaddr size)
+{
+    sysbus_init_child_obj(OBJECT(ps), name, uds,
+                          sizeof(UnimplementedDeviceState),
+                          TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(uds), "name", name);
+    qdev_prop_set_uint64(DEVICE(uds), "size", size);
+    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    memory_region_add_subregion(&ps->peri_mr, ofs,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0));
+}
+
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
@@ -322,6 +336,22 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    create_unimp(s, &s->pm, "bcm2835-pm", PM_OFFSET, 0x1000);
+    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
+    create_unimp(s, &s->a2w, "bcm2835-a2w", 0x102000, 0x1000);
+    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
+    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
+    create_unimp(s, &s->spi0, "bcm2835-spi0", SPI0_OFFSET, 0x20);
+    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
+    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
+    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
+    create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
+    create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
+    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x100);
+    create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 6b17f6a382..44a182b399 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -23,6 +23,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 #define BCM2835_PERIPHERALS(obj) \
@@ -37,6 +38,9 @@ typedef struct BCM2835PeripheralState {
     MemoryRegion ram_alias[4];
     qemu_irq irq, fiq;
 
+    UnimplementedDeviceState pm;
+    UnimplementedDeviceState cprman;
+    UnimplementedDeviceState a2w;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
@@ -48,6 +52,16 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    UnimplementedDeviceState i2s;
+    UnimplementedDeviceState spi0;
+    UnimplementedDeviceState i2c[3];
+    UnimplementedDeviceState otp;
+    UnimplementedDeviceState dbus;
+    UnimplementedDeviceState ave0;
+    UnimplementedDeviceState bscsl;
+    UnimplementedDeviceState smi;
+    UnimplementedDeviceState dwc2;
+    UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 6f7db85bab..069edab526 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -40,6 +40,7 @@
 #define PM_OFFSET               0x100000 /* Power Management, Reset controller
                                           * and Watchdog registers */
 #define CPRMAN_OFFSET           0x101000 /* Clock Management */
+#define AVS_OFFSET              0x103000 /* Audio Video Standard */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
@@ -47,11 +48,18 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
+#define OTP_OFFSET              0x20f000
+#define AVSP_OFFSET             0x130000
+#define BSC_SL_OFFSET           0x214000 /* SPI slave */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC1_OFFSET            0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
+#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
+#define DBUS_OFFSET             0x900000
+#define AVE0_OFFSET             0x910000
 #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
+#define SDRAMC_OFFSET           0xe00000
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
 /* GPU interrupts */
-- 
2.20.1


