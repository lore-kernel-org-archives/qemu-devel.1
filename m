Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195AC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2902253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lK+sgxVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2902253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugj7-0005Yt-Qh
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRo-0000WD-KZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRn-0003zu-7e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:08 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRm-0003yW-SD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so3565372wru.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dRI9oGwUBma3PKFdZ9vN+7KmPWjMM/8sjfA19pvxDs4=;
 b=lK+sgxVsHoMhCyDfv4fyV46lNtzwp+gjCDjAjplljaIuit+4QSVUDtxwiMWU0+Swkq
 hUK9TurCL8JXsg6gCpLk5cAJCZLwvGol0tIBU7yncvavE0mUVtjT8o6M32Ovf2dibA6a
 +5QIvkFBTXJYu5UVeO7O+IgJpT5g9nJTDbp7nsUVnEtoWhidKhogYfV6IfCCOWKEkWiC
 EyA9pDmsNmTEPhwDHjtWrox/wuk7zj4rxLPx2LjY48krlJya/zlbox+Q3AUIRJOkXZqm
 1OzWCV3wM561/qvHOz1RhXcHHIwBbVfTOY6qrxYjLuY9YHSnu5nyhK5WbhEKv++VwIyQ
 wHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dRI9oGwUBma3PKFdZ9vN+7KmPWjMM/8sjfA19pvxDs4=;
 b=OpDDyguZRZHZ9LNbJwhKf5TKJVY1uYZCO7dePfhFKuU/hxGze5xpJrnajxkgRa296y
 GZy2OGLs01Ulf3R4S+bu3sMc0S7I/XVE4vQuvXUKXK2SHGgbJPNtJDwr8NRVL9lyoBPx
 C+UWFdCCcWGkhRj6k1l3tQUgZDCItkTvhPbv49Ii8RYHisoC0CgFQJgFrJoXeBdiZeaV
 aVw9ULxvflYi0GR4mk0Be+lCwUudZmOUKzEdk0FvGJikUok+wxrK5qOl8aUAG0f8xvXw
 CI0SbPIJMjNmsTz4HOfvLTH4qIhyI00nleTuEAyNHryPrqVpTSJIQj3MiuGAKJSSBOzp
 PmgQ==
X-Gm-Message-State: APjAAAWvB+zRl0hVafpgNFXBMeYHoLk07UR4QviGXTc5WZ6PWFgOJqpQ
 XPgalRMEmKrvKdossOHv34PX/9l4CJT15w==
X-Google-Smtp-Source: APXvYqy8lxtElJKYHmLnHnkhSBo35lqIcpdGAVYxbgAN71OUUegDJOePv6V4fr4l0yllE0LWJ3MQWw==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr18304286wrn.83.1579793464768; 
 Thu, 23 Jan 2020 07:31:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.31.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:31:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] hw/arm/exynos4210: Connect serial port DMA busy signals
 with pl330
Date: Thu, 23 Jan 2020 15:30:41 +0000
Message-Id: <20200123153041.4248-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

The Exynos4210 serial driver uses an interrupt line to signal if receive
data is available. Connect that interrupt with the DMA controller's
'peripheral busy' gpio pin to stop the DMA if there is no more receive
data available. Without this patch, receive DMA runs wild and fills the
entire receive DMA buffer with invalid data.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-9-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 7701a3fa8bd..59a27bdd68f 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -166,8 +166,8 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static void pl330_create(uint32_t base, qemu_or_irq *orgate, qemu_irq irq,
-                         int nreq, int nevents, int width)
+static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
+                                 qemu_irq irq, int nreq, int nevents, int width)
 {
     SysBusDevice *busdev;
     DeviceState *dev;
@@ -196,6 +196,7 @@ static void pl330_create(uint32_t base, qemu_or_irq *orgate, qemu_irq irq,
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(DEVICE(orgate), i));
     }
     qdev_connect_gpio_out(DEVICE(orgate), 0, irq);
+    return dev;
 }
 
 static void exynos4210_realize(DeviceState *socdev, Error **errp)
@@ -204,7 +205,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     MemoryRegion *system_mem = get_system_memory();
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
-    DeviceState *dev;
+    DeviceState *dev, *uart[4], *pl330[3];
     int i, n;
 
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
@@ -390,19 +391,19 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
 
     /*** UARTs ***/
-    exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
+    uart[0] = exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
                            EXYNOS4210_UART0_FIFO_SIZE, 0, serial_hd(0),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 0)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
+    uart[1] = exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
                            EXYNOS4210_UART1_FIFO_SIZE, 1, serial_hd(1),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 1)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
+    uart[2] = exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
                            EXYNOS4210_UART2_FIFO_SIZE, 2, serial_hd(2),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 2)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
+    uart[3] = exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
                            EXYNOS4210_UART3_FIFO_SIZE, 3, serial_hd(3),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 3)]);
 
@@ -450,12 +451,27 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
-    pl330_create(EXYNOS4210_PL330_BASE0_ADDR, &s->pl330_irq_orgate[0],
-                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 32, 32);
-    pl330_create(EXYNOS4210_PL330_BASE1_ADDR, &s->pl330_irq_orgate[1],
-                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 32, 32);
-    pl330_create(EXYNOS4210_PL330_BASE2_ADDR, &s->pl330_irq_orgate[2],
-                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 31, 64);
+    pl330[0] = pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
+                            &s->pl330_irq_orgate[0],
+                            s->irq_table[exynos4210_get_irq(21, 0)],
+                            32, 32, 32);
+    pl330[1] = pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
+                            &s->pl330_irq_orgate[1],
+                            s->irq_table[exynos4210_get_irq(21, 1)],
+                            32, 32, 32);
+    pl330[2] = pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
+                            &s->pl330_irq_orgate[2],
+                            s->irq_table[exynos4210_get_irq(20, 1)],
+                            1, 31, 64);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[0]), 1,
+                       qdev_get_gpio_in(pl330[0], 15));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[1]), 1,
+                       qdev_get_gpio_in(pl330[1], 15));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[2]), 1,
+                       qdev_get_gpio_in(pl330[0], 17));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[3]), 1,
+                       qdev_get_gpio_in(pl330[1], 17));
 }
 
 static void exynos4210_init(Object *obj)
-- 
2.20.1


