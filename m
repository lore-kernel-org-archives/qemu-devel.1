Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1CBC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3AD22464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu3Kzr1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3AD22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugm0-0000xQ-PI
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRo-0000W9-J7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRl-0003yc-JC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRk-0003wu-2H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id t14so2967526wmi.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6T47eZ4vWB2mF6kI3SN4Zx+sefAzMAYpYuNqQIJE+Lc=;
 b=Cu3Kzr1Frz+eGQReEp/869Qizegwb0VG+Ej0QwZahzWiOuBuAo/+oyA26YHmT8uAK8
 PfTdIZD8oYiswWnnxXkAHnmtsLk8HmvNZxAsITXil8D5SYQaF1tandPpeASpwHQ9N0Bn
 cUgT19ym3dCxd/VhYIzTwPAFKlvIMX2n8feXm1bsAS3/G10V61dCzaJKBgfiewybnLMq
 F6Jjlq/ARHhsLsWLbjxdVpkscsr8QOSPWC/Scl3ndfZcQE0lfE8POrcf01gcp9l2PbQJ
 Cp8/xULJvLSMzLCAbwt54N3YuLCERd/e1RtSiY/qP26k3LfpqSJKyTcA/MtdNeTB6iAq
 bXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6T47eZ4vWB2mF6kI3SN4Zx+sefAzMAYpYuNqQIJE+Lc=;
 b=g74gZfoRTknxoGcVfW4BvBFgb4QGw63HVPq5UDA7TdK1eFjhTUbzMD6hQEgmQznGyq
 B13bcdn/N16wO76V0yeXoOXPk2QH8Yqz535YoOWFPsoWMoPaiRI6LuuWI1Iivm9HuSvB
 7wa+9dXHW4hW6ERzh0y4g3JCGiYNyLPTJCFhs41a+P37Wx/927sj1VSbI48kg8m344OH
 y2gQ7CLbwb/a1XsscrEAY7HJrbBRmdjZ/cT2l4TGMTIhWuKpGK2XTOSqCr4rMW1/CHm5
 ZjnKspZ6/u8IMxODDngTfgeAwUQZdIbG7MvcPshS4OyLTRKdWvZOWPa/Km70BR64BAKs
 NLtg==
X-Gm-Message-State: APjAAAV5UvRL+mG4WpotYCvM/7utFzmJen5IQET6+six1pFid7ulUxOJ
 ZIkvVX4Gb00v0sdMk3PkNDp73x6rHR1Ucw==
X-Google-Smtp-Source: APXvYqxpCLctWgIQ915fh5AZXlPHRtrym5KBXPZE74zgEC/8Uy35l6V8lnk8n/f/d+s9vYQ64I6vRw==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr4706813wmc.111.1579793462794; 
 Thu, 23 Jan 2020 07:31:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.31.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:31:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] hw/char/exynos4210_uart: Implement Rx FIFO level
 triggers and timeouts
Date: Thu, 23 Jan 2020 15:30:39 +0000
Message-Id: <20200123153041.4248-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

The driver already implements a receive FIFO, but it does not
handle receive FIFO trigger levels and timeout. Implement the
missing functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-7-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 117 ++++++++++++++++++++++++++++++--------
 hw/char/trace-events      |   3 +-
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 6ffbaddfff1..363393cc753 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/timer.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 
@@ -118,6 +119,7 @@ static const Exynos4210UartReg exynos4210_uart_regs[] = {
 #define ULCON_STOP_BIT_SHIFT  1
 
 /* UART Tx/Rx Status */
+#define UTRSTAT_Rx_TIMEOUT              0x8
 #define UTRSTAT_TRANSMITTER_EMPTY       0x4
 #define UTRSTAT_Tx_BUFFER_EMPTY         0x2
 #define UTRSTAT_Rx_BUFFER_DATA_READY    0x1
@@ -147,6 +149,9 @@ typedef struct Exynos4210UartState {
     Exynos4210UartFIFO   rx;
     Exynos4210UartFIFO   tx;
 
+    QEMUTimer *fifo_timeout_timer;
+    uint64_t wordtime;        /* word time in ns */
+
     CharBackend       chr;
     qemu_irq          irq;
 
@@ -209,15 +214,12 @@ static void fifo_reset(Exynos4210UartFIFO *q)
     q->rp = 0;
 }
 
-static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
+static uint32_t exynos4210_uart_FIFO_trigger_level(uint32_t channel,
+                                                   uint32_t reg)
 {
-    uint32_t level = 0;
-    uint32_t reg;
+    uint32_t level;
 
-    reg = (s->reg[I_(UFCON)] & UFCON_Tx_FIFO_TRIGGER_LEVEL) >>
-            UFCON_Tx_FIFO_TRIGGER_LEVEL_SHIFT;
-
-    switch (s->channel) {
+    switch (channel) {
     case 0:
         level = reg * 32;
         break;
@@ -231,12 +233,34 @@ static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState
         break;
     default:
         level = 0;
-        trace_exynos_uart_channel_error(s->channel);
+        trace_exynos_uart_channel_error(channel);
+        break;
     }
-
     return level;
 }
 
+static uint32_t
+exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
+{
+    uint32_t reg;
+
+    reg = (s->reg[I_(UFCON)] & UFCON_Tx_FIFO_TRIGGER_LEVEL) >>
+            UFCON_Tx_FIFO_TRIGGER_LEVEL_SHIFT;
+
+    return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
+}
+
+static uint32_t
+exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210UartState *s)
+{
+    uint32_t reg;
+
+    reg = ((s->reg[I_(UFCON)] & UFCON_Rx_FIFO_TRIGGER_LEVEL) >>
+            UFCON_Rx_FIFO_TRIGGER_LEVEL_SHIFT) + 1;
+
+    return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
+}
+
 static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 {
     /*
@@ -244,13 +268,25 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
      * transmit FIFO is smaller than the trigger level.
      */
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-
         uint32_t count = (s->reg[I_(UFSTAT)] & UFSTAT_Tx_FIFO_COUNT) >>
                 UFSTAT_Tx_FIFO_COUNT_SHIFT;
 
         if (count <= exynos4210_uart_Tx_FIFO_trigger_level(s)) {
             s->reg[I_(UINTSP)] |= UINTSP_TXD;
         }
+
+        /*
+         * Rx interrupt if trigger level is reached or if rx timeout
+         * interrupt is disabled and there is data in the receive buffer
+         */
+        count = fifo_elements_number(&s->rx);
+        if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
+            count >= exynos4210_uart_Rx_FIFO_trigger_level(s)) {
+            s->reg[I_(UINTSP)] |= UINTSP_RXD;
+            timer_del(s->fifo_timeout_timer);
+        }
+    } else if (s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) {
+        s->reg[I_(UINTSP)] |= UINTSP_RXD;
     }
 
     s->reg[I_(UINTP)] = s->reg[I_(UINTSP)] & ~s->reg[I_(UINTM)];
@@ -264,6 +300,21 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
     }
 }
 
+static void exynos4210_uart_timeout_int(void *opaque)
+{
+    Exynos4210UartState *s = opaque;
+
+    trace_exynos_uart_rx_timeout(s->channel, s->reg[I_(UTRSTAT)],
+                                 s->reg[I_(UINTSP)]);
+
+    if ((s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) ||
+        (s->reg[I_(UCON)] & (1 << 11))) {
+        s->reg[I_(UINTSP)] |= UINTSP_RXD;
+        s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_TIMEOUT;
+        exynos4210_uart_update_irq(s);
+    }
+}
+
 static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 {
     int speed, parity, data_bits, stop_bits;
@@ -302,10 +353,24 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
     ssp.data_bits = data_bits;
     ssp.stop_bits = stop_bits;
 
+    s->wordtime = NANOSECONDS_PER_SECOND * (data_bits + stop_bits + 1) / speed;
+
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
     trace_exynos_uart_update_params(
-                s->channel, speed, parity, data_bits, stop_bits);
+                s->channel, speed, parity, data_bits, stop_bits, s->wordtime);
+}
+
+static void exynos4210_uart_rx_timeout_set(Exynos4210UartState *s)
+{
+    if (s->reg[I_(UCON)] & 0x80) {
+        uint32_t timeout = ((s->reg[I_(UCON)] >> 12) & 0x0f) * s->wordtime;
+
+        timer_mod(s->fifo_timeout_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
+    } else {
+        timer_del(s->fifo_timeout_timer);
+    }
 }
 
 static void exynos4210_uart_write(void *opaque, hwaddr offset,
@@ -361,6 +426,10 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         exynos4210_uart_update_irq(s);
         break;
     case UTRSTAT:
+        if (val & UTRSTAT_Rx_TIMEOUT) {
+            s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_TIMEOUT;
+        }
+        break;
     case UERSTAT:
     case UFSTAT:
     case UMSTAT:
@@ -382,6 +451,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         break;
     }
 }
+
 static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -461,7 +531,6 @@ static int exynos4210_uart_can_receive(void *opaque)
     return fifo_empty_elements_number(&s->rx);
 }
 
-
 static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
@@ -469,24 +538,17 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
         if (fifo_empty_elements_number(&s->rx) < size) {
-            for (i = 0; i < fifo_empty_elements_number(&s->rx); i++) {
-                fifo_store(&s->rx, buf[i]);
-            }
+            size = fifo_empty_elements_number(&s->rx);
             s->reg[I_(UINTSP)] |= UINTSP_ERROR;
-            s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
-        } else {
-            for (i = 0; i < size; i++) {
-                fifo_store(&s->rx, buf[i]);
-            }
-            s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
         }
-        /* XXX: Around here we maybe should check Rx trigger level */
-        s->reg[I_(UINTSP)] |= UINTSP_RXD;
+        for (i = 0; i < size; i++) {
+            fifo_store(&s->rx, buf[i]);
+        }
+        exynos4210_uart_rx_timeout_set(s);
     } else {
         s->reg[I_(URXH)] = buf[0];
-        s->reg[I_(UINTSP)] |= UINTSP_RXD;
-        s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
     }
+    s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
 
     exynos4210_uart_update_irq(s);
 }
@@ -527,6 +589,7 @@ static int exynos4210_uart_post_load(void *opaque, int version_id)
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
 
     exynos4210_uart_update_parameters(s);
+    exynos4210_uart_rx_timeout_set(s);
 
     return 0;
 }
@@ -588,6 +651,10 @@ static void exynos4210_uart_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
+    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                         exynos4210_uart_timeout_int, s);
+    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
+
     /* memory mapping */
     memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
                           "exynos4210.uart", EXYNOS4210_UART_REGS_MEM_SIZE);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index ba28b45b532..cb73fee6a9d 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -81,7 +81,7 @@ nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PR
 # exynos4210_uart.c
 exynos_uart_irq_raised(uint32_t channel, uint32_t reg) "UART%d: IRQ raised: 0x%08"PRIx32
 exynos_uart_irq_lowered(uint32_t channel) "UART%d: IRQ lowered"
-exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d"
+exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop, uint64_t wordtime) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d wordtime: %"PRId64"ns"
 exynos_uart_write(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s <- 0x%" PRIx64
 exynos_uart_read(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s -> 0x%" PRIx64
 exynos_uart_rx_fifo_reset(uint32_t channel) "UART%d: Rx FIFO Reset"
@@ -94,3 +94,4 @@ exynos_uart_rx_error(uint32_t channel) "UART%d: Rx error"
 exynos_uart_wo_read(uint32_t channel, const char *name, uint32_t reg) "UART%d: Trying to read from WO register: %s [0x%04"PRIx32"]"
 exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
 exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
+exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d: Rx timeout stat=0x%x intsp=0x%x"
-- 
2.20.1


