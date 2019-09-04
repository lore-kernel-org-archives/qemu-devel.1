Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FCDC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1532087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf+OuKsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1532087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z5M-0007mC-Ta
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqi-0001gu-MK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqg-00078Z-6o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqf-00078D-Ue; Wed, 04 Sep 2019 13:13:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id k2so4122546wmj.4;
 Wed, 04 Sep 2019 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NE6SSY/l1bK6cwQa5Wl0c6DT5cjmpSFoKjbT7RMOdm4=;
 b=tf+OuKsye8v2L5UnAN3fHr9YkveMzJ6mLlvXQ2pCwp4wh14jbwJ0jf9Hk/JpTEcQb+
 L6KiTFqhg/HS82Jf6wQqK2pDKhAsXFb48k85HubQWf/WIG2qRwH03piaU/BpUQHBD0nj
 l+6RjDP59uAqrgZlOvT95F0Vs30c8FVWGD8HOOM0bIgB/7ByGnHnSFwxX3F+u/mtnDyd
 +zIJWaR4AKQ34bksY0xVEMFt4Z51UuvBonpS2BQGre1oAmZvd9+LSiv6AFGy5M8LZOVt
 biuP2QufVrfB3Z8jMwG28EAiSTTo4bzCEHoKr4mqZ3IGF4jR5OjWYyJwckNnb4PqIwUX
 BzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NE6SSY/l1bK6cwQa5Wl0c6DT5cjmpSFoKjbT7RMOdm4=;
 b=n56k98BerMwwtwuH2nOoq/NO/PjKqvZt8ra2hHVbCmO4U6rOb9Ev6RSBYRzsPLycIg
 l3eFiEVOUtBZh4HZ+sfM++zBA9d6reHm+BmJpaGLFYBbjGtfuriKUMph3OVmECe0nuiV
 ShCNGtznzapKNxhpAXVFoHZGydlvQF2n8s/Ax5l/IzPRKEMw8Kv4ny/iGBdZnRAfePU2
 uB065oPSSOt2g8CEc6t74xUWollxeRWvjGAnpql9hJtx8K6ygPC5COkmqOfY/j0ReReg
 nzske1Fw+4hXS0em/Nb0B3Z098VKhMC2+n5YcnQJeFR83JOGreQspdif2m1YjFPuILJn
 ZcTw==
X-Gm-Message-State: APjAAAWoIjLpSoA0lFfPU7yU8Wf3J+fjJOw42+lIhUUixTGztwYIsgAw
 whqUIqegfldXNydrveKyNLU=
X-Google-Smtp-Source: APXvYqwFSYsbttIU/tjb8ffAIt6AAQPx79wbQz0OpkDyMItRt/JcBjQCC2gXebQVlqQVyD9ZkP2Kzw==
X-Received: by 2002:a1c:a003:: with SMTP id j3mr5284778wme.42.1567617216983;
 Wed, 04 Sep 2019 10:13:36 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:12 +0200
Message-Id: <20190904171315.8354-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 11/14] hw/arm/bcm2835_peripherals: Map various
 BCM2838 blocks
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

The BCM2838 provides more peripherals.
Add them as 'unimplemented' so we can track when/how firmware
and kernel access them.

Based on various sources:

* U-boot: https://github.com/raspberrypi/firmware/tree/next/boot

  - arch/arm/dts/bcm283x.dtsi
  - arch/arm/dts/bcm2838.dtsi
  - arch/arm/dts/bcm2838-rpi-4-b.dts

* Arnd Bergmann analysis: https://www.cnx-software.com/2019/06/24/raspberry-pi-4-features-broadcom-bcm2711-processor-up-to-4gb-ram/#comment-563948

* Linux: https://patchwork.kernel.org/patch/11053097/

  - arch/arm/boot/dts/bcm283x.dtsi
  - arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
  - arch/arm/boot/dts/bcm2711.dtsi
  - arch/arm/boot/dts/bcm2711-rpi-4-b.dts

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO: At least use proper pl011[2] and pl011[3]
---
 hw/arm/bcm2835_peripherals.c         | 23 +++++++++++++++++++----
 include/hw/arm/bcm2835_peripherals.h |  8 ++++++--
 include/hw/arm/raspi_platform.h      | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index be6270b8ef..72287d5921 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -342,15 +342,30 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->a2w, "bcm2835-a2w", 0x102000, 0x1000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
-    create_unimp(s, &s->spi0, "bcm2835-spi0", SPI0_OFFSET, 0x20);
+    create_unimp(s, &s->uartu[2], "!pl011[2]", UART2_OFFSET, 0x100);
+    create_unimp(s, &s->uartu[3], "!pl011[3]", UART3_OFFSET, 0x100);
+    create_unimp(s, &s->uartu[4], "!pl011[4]", UART4_OFFSET, 0x100);
+    create_unimp(s, &s->uartu[5], "!pl011[5]", UART5_OFFSET, 0x100);
+    create_unimp(s, &s->spi[0], "bcm2835-spi[0]", SPI0_OFFSET, 0x20);
+    create_unimp(s, &s->spi[3], "bcm2835-spi[3]", SPI3_OFFSET, 0x20);
+    create_unimp(s, &s->spi[4], "bcm2835-spi[4]", SPI4_OFFSET, 0x20);
+    create_unimp(s, &s->spi[5], "bcm2835-spi[5]", SPI5_OFFSET, 0x20);
+    create_unimp(s, &s->spi[6], "bcm2835-spi[6]", SPI6_OFFSET, 0x20);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[0], "bcm2835-i2c[0]", BSC0_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[1], "bcm2835-i2c[1]", BSC1_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[2], "bcm2835-i2c[2]", BSC2_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[3], "bcm2835-i2c[3]", BSC3_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[4], "bcm2835-i2c[4]", BSC4_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[5], "bcm2835-i2c[5]", BSC5_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[6], "bcm2835-i2c[6]", BSC6_OFFSET, 0x20);
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
     create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x100);
+    create_unimp(s, &s->xhci, "bcm2838-xhci", USB_XHCI_OFFSET, 0x100000);
+    create_unimp(s, &s->argon, "bcm2838-argon", ARGON_OFFSET, 4 * 0x10000);
+    create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x10000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 44a182b399..2e5f243b39 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -42,6 +42,7 @@ typedef struct BCM2835PeripheralState {
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
     PL011State uart0;
+    UnimplementedDeviceState uartu[6];
     BCM2835AuxState aux;
     BCM2835FBState fb;
     BCM2835DMAState dma;
@@ -53,14 +54,17 @@ typedef struct BCM2835PeripheralState {
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
     UnimplementedDeviceState i2s;
-    UnimplementedDeviceState spi0;
-    UnimplementedDeviceState i2c[3];
+    UnimplementedDeviceState spi[7];
+    UnimplementedDeviceState i2c[7];
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
     UnimplementedDeviceState dwc2;
+    UnimplementedDeviceState xhci;
+    UnimplementedDeviceState argon;
+    UnimplementedDeviceState v3d;
     UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index c6f4985522..0ea547669f 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -49,10 +49,22 @@
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000 /* PL011 */
+#define UART2_OFFSET            0x201400 /* PL011 */
+#define UART3_OFFSET            0x201600 /* PL011 */
+#define UART4_OFFSET            0x201800 /* PL011 */
+#define UART5_OFFSET            0x201a00 /* PL011 */
 #define MMCI0_OFFSET            0x202000 /* Legacy MMC */
 #define I2S_OFFSET              0x203000 /* PCM */
 #define SPI0_OFFSET             0x204000 /* SPI master */
+#define SPI3_OFFSET             0x204600
+#define SPI4_OFFSET             0x204800
+#define SPI5_OFFSET             0x204a00
+#define SPI6_OFFSET             0x204c00
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
+#define BSC3_OFFSET             0x205600
+#define BSC4_OFFSET             0x205800
+#define BSC5_OFFSET             0x205a00
+#define BSC6_OFFSET             0x205c00
 #define PIXV0_OFFSET            0x206000
 #define PIXV1_OFFSET            0x207000
 #define DPI_OFFSET              0x208000
@@ -84,6 +96,8 @@
 #define DBUS_OFFSET             0x900000
 #define AVE0_OFFSET             0x910000
 #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
+#define USB_XHCI_OFFSET         0x9c0000 /* generic-xhci controller */
+#define ARGON_OFFSET            0xb00000
 #define V3D_OFFSET              0xc00000
 #define SDRAMC_OFFSET           0xe00000
 #define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller */
-- 
2.20.1


