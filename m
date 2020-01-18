Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D50C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF4B2469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca4FcaZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4B2469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isrJK-0005v1-4e
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isrBQ-0004Dl-1X
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isrBO-0002F3-7r
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:47 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isrBK-0002C9-Hg; Sat, 18 Jan 2020 11:42:42 -0500
Received: by mail-yw1-xc44.google.com with SMTP id n184so15871828ywc.3;
 Sat, 18 Jan 2020 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=td1yGNfjfUpZYYkn6uLD6QjKcoSaUeLpRJm2pQ2sVF0=;
 b=ca4FcaZb5GX65G3hmHJPY1QlbOvNrOHwT1dnJqlXa/LF3/ovvLiY3yAJOPZVZok7EI
 pKirS/6AdRtlrQTtttckovGbhDz0qwOkK3QnVsqZ0Ut40HaAvAPxrqs2G/BfDaj4SP2z
 toc7hFXuPVgOSuMEAfdkSkI1H1Iv6Jg8Xn/ywGbAji53kYLQD+nSFQx80ztA+2+wYpRQ
 zYCou7+NC1I4avbhzrk8oo8GQ9c+OaKOhwJtktUMvNL7PsroLmaRM0ZQHWKjT032TvfE
 Ra5LFkURtfFhT4X53jmNgsqiodixrRbA4COuyo/pvIb8g+fwTkrG6BU4YFl9us0YtPbx
 J65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=td1yGNfjfUpZYYkn6uLD6QjKcoSaUeLpRJm2pQ2sVF0=;
 b=FDFrxvwd82F6F7NsU15fM6Kbb4BmB7n+wAM7VGrIPvcO3jjxFjRm4PYFvHWu2wwoEr
 ApP4C1vJaSdByXuwjIHC5HW2RvxI0YyE9R4wyWzqXh93M4SUt0mGcCYggzk4QCaobpLk
 qIMi1KQJyaOy1xjmFWou53KQNfZGcyQ6H/pAn8h4gaclJ8PN/Uy10r70HK3ArllkfQEb
 628f/An8Yj4NfSp3tPsHd/YsnvBGO5diTaHhK4I1DiER5aIQA2gJNCQTiKMmuudnK/qZ
 uavrYtjJJDdcmWDSIcjBrQo06I7/fK7KYBrZ9DhhDBqDy184GQ+tE5062fczDlTdhYMA
 FuOA==
X-Gm-Message-State: APjAAAXCYCGaPDbGWraylawUMOiOsFpbPuh1yRlcOIEiANyp07mM29mQ
 SeHQhWpv8OpLGB2/XEJ01ek=
X-Google-Smtp-Source: APXvYqxzT2iCBuP8bEXAyyy8Lg49yR1L2KxIPOS1WIxgvWDJv08BLC+Qag6pY81Dg4gKTUFzisDyZw==
X-Received: by 2002:a0d:f106:: with SMTP id a6mr29070376ywf.318.1579365761873; 
 Sat, 18 Jan 2020 08:42:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h203sm12623797ywb.98.2020.01.18.08.42.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 18 Jan 2020 08:42:41 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/7] hw/char/exynos4210_uart: Implement Rx FIFO level
 triggers and timeouts
Date: Sat, 18 Jan 2020 08:42:27 -0800
Message-Id: <20200118164229.22539-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118164229.22539-1-linux@roeck-us.net>
References: <20200118164229.22539-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The driver already implements a receive FIFO, but it does not
handle receive FIFO trigger levels and timeout. Implement the
missing functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Call exynos4210_uart_rx_timeout_set() from new post_load function
    to set the receive timeout timer.
    Add timer to vmstate_exynos4210_uart.

 hw/char/exynos4210_uart.c | 122 ++++++++++++++++++++++++++++++--------
 hw/char/trace-events      |   3 +-
 2 files changed, 99 insertions(+), 26 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 5d48701b6d..63ea9663f2 100644
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
@@ -376,12 +445,17 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         exynos4210_uart_update_irq(s);
         break;
     case UCON:
+        s->reg[I_(UCON)] = val;
+        exynos4210_uart_rx_timeout_set(s);
+        exynos4210_uart_update_irq(s);
+        break;
     case UMCON:
     default:
         s->reg[I_(offset)] = val;
         break;
     }
 }
+
 static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -461,7 +535,6 @@ static int exynos4210_uart_can_receive(void *opaque)
     return fifo_empty_elements_number(&s->rx);
 }
 
-
 static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
@@ -469,24 +542,17 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 
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
@@ -527,6 +593,7 @@ static int exynos4210_uart_post_load(void *opaque, int version_id)
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
 
     exynos4210_uart_update_parameters(s);
+    exynos4210_uart_rx_timeout_set(s);
 
     return 0;
 }
@@ -553,6 +620,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
                        vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
         VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
                              EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)),
+        VMSTATE_TIMER_PTR(fifo_timeout_timer, Exynos4210UartState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -588,6 +656,10 @@ static void exynos4210_uart_init(Object *obj)
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
index ba28b45b53..cb73fee6a9 100644
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
2.17.1


