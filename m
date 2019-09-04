Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E3C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBCF21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJrJq6GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBCF21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5YyQ-0007cI-Se
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqY-0001RE-TA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqX-00072i-MZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqX-00072B-FN; Wed, 04 Sep 2019 13:13:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id l16so3792997wrv.12;
 Wed, 04 Sep 2019 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1eynEPflF1e1UUeOg/DcqC+CT8yj8xk66WHwIPsvafI=;
 b=VJrJq6GTewwRk9jGNCp+yxTdikKnPNc1rf1niLHL8r3agvwLJbtqOXuZHEN6JUdGvY
 inluAryNWD/heqaXwr02jlJxeM2NFNObbscUYHi4yGvoR4Q3SbWvsf3wDkZFOqZ9y2ny
 um8aOTfAw2y8epiFPxlIF6q98xgYxQ4sDR/7ffw+TvVP/x6zeVbxjUbJCjk44RAfyua2
 ve5DZUyHeGMwJwzNPic2AK3hCH+EeZ3m+YEgKRhF32bDGYTaRyxB4XEGz+a6STmuq41/
 6+q/ypSYV1KXeZNiDNjOBm3InswiSOKxSgiLBcp+aAWRWrNn5YJsgPUAXhPMLFpqb0BQ
 zIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1eynEPflF1e1UUeOg/DcqC+CT8yj8xk66WHwIPsvafI=;
 b=So6CpoFraA6ty3usiZw7/AMio7ZXCM9a2eeQBJlu1dZh8exC0JMxItoSELJZw/7zX4
 qtlFoW8xcsOfzyMjxLpdS4kPZpQc9NIlzEIPR7TDNGAK6ouamqfZW8Z+G86FGCHNLmbJ
 NAA2cGuu0G/JXL14ODw6o+qHXuLej0XKDqSIsVwp8tKWwmPVG0I8ZBPRZsxu9OLaAiUe
 uarOOwplSIyUNNsul3JtIx5U7sJ29eNuYJpMS/jGvrexx6bxIaJeu6mnVF/eh7kirshc
 Xk0vwBUm5yROpfdNm7Bf/NBsH9ERu4qRgMK25Z83K2UdxMUtAwoWuWauqREVj+8m24Xx
 K9Bg==
X-Gm-Message-State: APjAAAUlAstgfvOp785WN4/Otk1WQAbaWL8wEBgVt53wgN4XaKPGjSt/
 NnPfI22eEdsHuW5xaoJekoM=
X-Google-Smtp-Source: APXvYqweDvge05OfkFn6VpTh3kWu8MIrRmDSBzbKOdRwEqMAl8rDBQu/7YQHq4LNVVg/7ak/mwygsw==
X-Received: by 2002:a05:6000:12:: with SMTP id
 h18mr14702283wrx.156.1567617208542; 
 Wed, 04 Sep 2019 10:13:28 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:07 +0200
Message-Id: <20190904171315.8354-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 06/14] hw/arm/bcm2835: Rename some definitions
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

The UART1 is part of the AUX peripheral,
the PCM_CLOCK (yet unimplemented) is part of the CPRMAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c    | 4 ++--
 include/hw/arm/raspi_platform.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8984e2e91f..270357b5a8 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -175,7 +175,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, UART1_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, AUX_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->aux), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->aux), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
@@ -268,7 +268,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, EMMC_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 10083d33df..6f7db85bab 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -39,7 +39,7 @@
                                                       * Doorbells & Mailboxes */
 #define PM_OFFSET               0x100000 /* Power Management, Reset controller
                                           * and Watchdog registers */
-#define PCM_CLOCK_OFFSET        0x101098
+#define CPRMAN_OFFSET           0x101000 /* Clock Management */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
@@ -47,11 +47,11 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
-#define UART1_OFFSET            0x215000
-#define EMMC_OFFSET             0x300000
+#define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
+#define EMMC1_OFFSET            0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
-#define USB_OFFSET              0x980000 /* DTC_OTG USB controller */
+#define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
 /* GPU interrupts */
-- 
2.20.1


