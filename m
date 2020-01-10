Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13704C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFAB2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvDvKQ8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFAB2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq1A3-0008Ue-1B
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iq14X-0000e3-GI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iq14W-0007Ca-5H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:57 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iq14T-00072A-H9; Fri, 10 Jan 2020 15:39:53 -0500
Received: by mail-pj1-x1044.google.com with SMTP id kx11so1422669pjb.4;
 Fri, 10 Jan 2020 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kFcujy5Zx7eAN8ANMQIMiKXRM7AFrv0aiyTTDTv0DLU=;
 b=QvDvKQ8/BM0nJbYud/2NJPBkiA2ey9H06quY9d54iyPwLKEpMos+p/HpgCmMXH0zvC
 jsfm4sIGo8eX/lp64nK6fWyUa+gwbweEG1BGwtmppT9YiZky0EJCsMgeHXJa8Ouc9QZ+
 ZZPzNq0sFc6DBInHIvRy8MsGfVF8ZVomGoIKVPtKzInSzPG1rJ4SEM2+Qufvq6mYfbuO
 oy2cQpHVsy4/fFHpNoI+T0DaBkUIyuNuuqrHiV1VLT8Ulpt2SRZrDKto7SkJVRc+7ruL
 9m5NQ799VP83XLrO3H/MMoP4UtYEEFp4T0Jn+z6bKe5Rt+/tGaMtn5KhvBJDpdxC9rKh
 6aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=kFcujy5Zx7eAN8ANMQIMiKXRM7AFrv0aiyTTDTv0DLU=;
 b=NdO58mKYKWOqR5fV3I/hjvq64T0YWrqYjiKnmdxeJ5kyqetVrVpBXoyw4YEHckaQFf
 w1+NNmMmok62Ox4vMp5n98ql0DxuoiBwCvBSPcZdtT15fGfzWgfYrtLE2P/UcyXJrpm7
 XBOgDuicH+/oDnwTwm/qoPgfQzxsRaSiWJeXB/v49eqThClIKEkwSX868iiAv/+rE2AZ
 JUWhv6FQPLadMX4RYzACLcrfa+MwDC05h9JPVVT0VrAB0o2ezwtm84mb0AA13Qcjd02/
 umHDWkDlzhPULQE0GVyM60ZR2bYNoUiRGUTyX3LuxJg/VY2KqpfwLPlHM26C/iEzvsaZ
 5UyQ==
X-Gm-Message-State: APjAAAVglz7d5lcDYvmygmKHEcs8HqQaL8jMt2VBOjDbs8WrKoHF5Zu7
 8gHkhVwCWBAW+s9vkAcjGFM=
X-Google-Smtp-Source: APXvYqxqGjsNB6FZJYAmqJt3D9LIL6WDryKGuREiNIdZ0R11mQ0AgxFcpDiXFVdeumbTqbPwdUYKzA==
X-Received: by 2002:a17:90a:fa10:: with SMTP id
 cm16mr7284493pjb.129.1578688792599; 
 Fri, 10 Jan 2020 12:39:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r8sm3604335pjo.22.2020.01.10.12.39.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Jan 2020 12:39:52 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>
Subject: [PATCH 5/6] hw/char/exynos4210_uart: Add receive DMA support
Date: Fri, 10 Jan 2020 12:39:41 -0800
Message-Id: <20200110203942.5745-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110203942.5745-1-linux@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support receive DMA, we need to inform the DMA controller if receive data
is available. Otherwise the DMA controller keeps requesting data, causing
receive errors.

Implement this using an interrupt line. The instantiating code then needs
to connect the interrupt with the matching DMA controller GPIO pin.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/char/exynos4210_uart.c | 24 ++++++++++++++++++++++++
 hw/char/trace-events      |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 61134a7bdc..e23799f93b 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -154,6 +154,7 @@ typedef struct Exynos4210UartState {
 
     CharBackend       chr;
     qemu_irq          irq;
+    qemu_irq          dmairq;
 
     uint32_t channel;
 
@@ -261,6 +262,24 @@ exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210UartState *s)
     return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
 }
 
+/*
+ * Update Rx DMA busy signal if Rx DMA is enabled. For simplicity,
+ * mark DMA as busy if DMA is enabled and the receive buffer is empty.
+ */
+static void exynos4210_uart_update_dmabusy(Exynos4210UartState *s)
+{
+    bool rx_dma_enabled = (s->reg[I_(UCON)] & 0x03) == 0x02;
+    uint32_t count = fifo_elements_number(&s->rx);
+
+    if (rx_dma_enabled && !count) {
+        qemu_irq_raise(s->dmairq);
+        trace_exynos_uart_dmabusy(s->channel);
+    } else {
+        qemu_irq_lower(s->dmairq);
+        trace_exynos_uart_dmaready(s->channel);
+    }
+}
+
 static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 {
     /*
@@ -282,10 +301,12 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
         count = fifo_elements_number(&s->rx);
         if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
             count >= exynos4210_uart_Rx_FIFO_trigger_level(s)) {
+            exynos4210_uart_update_dmabusy(s);
             s->reg[I_(UINTSP)] |= UINTSP_RXD;
             timer_del(s->fifo_timeout_timer);
         }
     } else if (s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) {
+        exynos4210_uart_update_dmabusy(s);
         s->reg[I_(UINTSP)] |= UINTSP_RXD;
     }
 
@@ -311,6 +332,7 @@ static void exynos4210_uart_timeout_int(void *opaque)
         (s->reg[I_(UCON)] & (1 << 11))) {
         s->reg[I_(UINTSP)] |= UINTSP_RXD;
         s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_TIMEOUT;
+        exynos4210_uart_update_dmabusy(s);
         exynos4210_uart_update_irq(s);
     }
 }
@@ -499,6 +521,7 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
             s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_BUFFER_DATA_READY;
             res = s->reg[I_(URXH)];
         }
+        exynos4210_uart_update_dmabusy(s);
         trace_exynos_uart_read(s->channel, offset,
                                exynos4210_uart_regname(offset), res);
         return res;
@@ -654,6 +677,7 @@ static void exynos4210_uart_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 
     sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(dev, &s->dmairq);
 }
 
 static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index cb73fee6a9..6f938301d9 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -79,6 +79,8 @@ nrf51_uart_read(uint64_t addr, uint64_t r, unsigned int size) "addr 0x%" PRIx64
 nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
 
 # exynos4210_uart.c
+exynos_uart_dmabusy(uint32_t channel) "UART%d: DMA busy (Rx buffer empty)"
+exynos_uart_dmaready(uint32_t channel) "UART%d: DMA ready"
 exynos_uart_irq_raised(uint32_t channel, uint32_t reg) "UART%d: IRQ raised: 0x%08"PRIx32
 exynos_uart_irq_lowered(uint32_t channel) "UART%d: IRQ lowered"
 exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop, uint64_t wordtime) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d wordtime: %"PRId64"ns"
-- 
2.17.1


