Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A88C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC5421734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIsnKYpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC5421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugch-0005M0-He
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRl-0000Uz-KZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRj-0003xX-Qq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:05 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRi-0003uI-Ps
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so2961679wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2mI/EOAKFi7f/eA2+s7J/J9un9r8CN/tUEvUeiWqW7U=;
 b=NIsnKYpuXWwZncUD1ENk8RtMdeM8jAcT0C0h9Z5PBqaaw0qcRIHx+jR0zC6cPQYqYr
 sc9pWkaVQ50WCq6n0DvZFIrpTHuj9ZCzoczotDgDaasYlIMOMM9B730mBuHauG7kQaaw
 u887w4SEzGsWSdFiXjglk1behc/nvlN+Xshq0Azia3LgTe5cWfUIOvXcNsFdhMTO+XWe
 z7Nq2TMfoqy3rYU1tHG6t3L9OzT2lazFcGXJMKyzl4XsNwOWb/lZDB4jmasN8CyLwpQ9
 HT4fXXio65EMPh1tMpNyElLGqmFhKqwe5Ju3E3ESkuAtW5LDzU5HaJ17XtDgkSIUYoHA
 rb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2mI/EOAKFi7f/eA2+s7J/J9un9r8CN/tUEvUeiWqW7U=;
 b=B/xDaX0ojXr9jJ9x+8U+s1lFka5JZczVSAsUJ8aDUjRKZWNQxkeSyGyXDULvPzG5I6
 EJfRnaHpxbVufGVtlFDzdQ14gmyd9A7JfY70za4J/NJX1GUDxIAWQVFxLaNOswnDCVy9
 cQ5T8EJrk9PmpHsbESlPfhOGE5M64PI7xHlyiWPqV1vA/5WY6eLHpq/OHHnEuzh+qlLY
 Vn5BW/EfQIWpOoGkpEz/3rk3yYRikEt+FjhQ3yoNHObvmAYtpdV6ZmAgRBVVjyy53FPv
 zonH7Y1ounpRAgVQ/RxY8LzKtpfX1lJC4p6Rp/bxnAELxJKbn2wE7zMxyVqVVFFT2y8U
 QLhA==
X-Gm-Message-State: APjAAAU5vdeXGYQXnbiEoWzAr2/J97gGJ0eVUVfIei6LdpR5sLINCQpJ
 NE+oserZzw6BST1yEgGzGX0WT5i0kNMFeg==
X-Google-Smtp-Source: APXvYqy/fAJIBejgM0wOCqYQB9/HCw/xillSQiqoP38fasDYLYETiPDuDnsWpDxM/eRcGN41wYDlsw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4552903wmi.37.1579793460755; 
 Thu, 23 Jan 2020 07:31:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] hw/char/exynos4210_uart: Convert to support tracing
Date: Thu, 23 Jan 2020 15:30:37 +0000
Message-Id: <20200123153041.4248-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Replace debug code with tracing to aid debugging.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-5-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 96 ++++++++++++---------------------------
 hw/char/trace-events      | 17 +++++++
 2 files changed, 47 insertions(+), 66 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 7e5c5ce789b..b3199df865e 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -31,45 +31,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 
-#undef DEBUG_UART
-#undef DEBUG_UART_EXTEND
-#undef DEBUG_IRQ
-#undef DEBUG_Rx_DATA
-#undef DEBUG_Tx_DATA
-
-#define DEBUG_UART            0
-#define DEBUG_UART_EXTEND     0
-#define DEBUG_IRQ             0
-#define DEBUG_Rx_DATA         0
-#define DEBUG_Tx_DATA         0
-
-#if DEBUG_UART
-#define  PRINT_DEBUG(fmt, args...)  \
-        do { \
-            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##args); \
-        } while (0)
-
-#if DEBUG_UART_EXTEND
-#define  PRINT_DEBUG_EXTEND(fmt, args...) \
-        do { \
-            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##args); \
-        } while (0)
-#else
-#define  PRINT_DEBUG_EXTEND(fmt, args...) \
-        do {} while (0)
-#endif /* EXTEND */
-
-#else
-#define  PRINT_DEBUG(fmt, args...)  \
-        do {} while (0)
-#define  PRINT_DEBUG_EXTEND(fmt, args...) \
-        do {} while (0)
-#endif
-
-#define  PRINT_ERROR(fmt, args...) \
-        do { \
-            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##args); \
-        } while (0)
+#include "trace.h"
 
 /*
  *  Offsets for UART registers relative to SFR base address
@@ -193,8 +155,7 @@ typedef struct Exynos4210UartState {
 } Exynos4210UartState;
 
 
-#if DEBUG_UART
-/* Used only for debugging inside PRINT_DEBUG_... macros */
+/* Used only for tracing */
 static const char *exynos4210_uart_regname(hwaddr  offset)
 {
 
@@ -208,7 +169,6 @@ static const char *exynos4210_uart_regname(hwaddr  offset)
 
     return NULL;
 }
-#endif
 
 
 static void fifo_store(Exynos4210UartFIFO *q, uint8_t ch)
@@ -271,7 +231,7 @@ static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState
         break;
     default:
         level = 0;
-        PRINT_ERROR("Wrong UART channel number: %d\n", s->channel);
+        trace_exynos_uart_channel_error(s->channel);
     }
 
     return level;
@@ -297,14 +257,10 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 
     if (s->reg[I_(UINTP)]) {
         qemu_irq_raise(s->irq);
-
-#if DEBUG_IRQ
-        fprintf(stderr, "UART%d: IRQ has been raised: %08x\n",
-                s->channel, s->reg[I_(UINTP)]);
-#endif
-
+        trace_exynos_uart_irq_raised(s->channel, s->reg[I_(UINTP)]);
     } else {
         qemu_irq_lower(s->irq);
+        trace_exynos_uart_irq_lowered(s->channel);
     }
 }
 
@@ -348,7 +304,7 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
-    PRINT_DEBUG("UART%d: speed: %d, parity: %c, data: %d, stop: %d\n",
+    trace_exynos_uart_update_params(
                 s->channel, speed, parity, data_bits, stop_bits);
 }
 
@@ -358,8 +314,8 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
     uint8_t ch;
 
-    PRINT_DEBUG_EXTEND("UART%d: <0x%04x> %s <- 0x%08llx\n", s->channel,
-        offset, exynos4210_uart_regname(offset), (long long unsigned int)val);
+    trace_exynos_uart_write(s->channel, offset,
+                            exynos4210_uart_regname(offset), val);
 
     switch (offset) {
     case ULCON:
@@ -373,12 +329,12 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         if (val & UFCON_Rx_FIFO_RESET) {
             fifo_reset(&s->rx);
             s->reg[I_(UFCON)] &= ~UFCON_Rx_FIFO_RESET;
-            PRINT_DEBUG("UART%d: Rx FIFO Reset\n", s->channel);
+            trace_exynos_uart_rx_fifo_reset(s->channel);
         }
         if (val & UFCON_Tx_FIFO_RESET) {
             fifo_reset(&s->tx);
             s->reg[I_(UFCON)] &= ~UFCON_Tx_FIFO_RESET;
-            PRINT_DEBUG("UART%d: Tx FIFO Reset\n", s->channel);
+            trace_exynos_uart_tx_fifo_reset(s->channel);
         }
         break;
 
@@ -390,9 +346,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
             /* XXX this blocks entire thread. Rewrite to use
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
-#if DEBUG_Tx_DATA
-            fprintf(stderr, "%c", ch);
-#endif
+            trace_exynos_uart_tx(s->channel, ch);
             s->reg[I_(UTRSTAT)] |= UTRSTAT_TRANSMITTER_EMPTY |
                     UTRSTAT_Tx_BUFFER_EMPTY;
             s->reg[I_(UINTSP)]  |= UINTSP_TXD;
@@ -403,8 +357,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
     case UINTP:
         s->reg[I_(UINTP)] &= ~val;
         s->reg[I_(UINTSP)] &= ~val;
-        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x\n",
-                    s->channel, offset, s->reg[I_(UINTP)]);
+        trace_exynos_uart_intclr(s->channel, s->reg[I_(UINTP)]);
         exynos4210_uart_update_irq(s);
         break;
     case UTRSTAT:
@@ -412,7 +365,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
     case UFSTAT:
     case UMSTAT:
     case URXH:
-        PRINT_DEBUG("UART%d: Trying to write into RO register: %s [%04x]\n",
+        trace_exynos_uart_ro_write(
                     s->channel, exynos4210_uart_regname(offset), offset);
         break;
     case UINTSP:
@@ -439,6 +392,8 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
     case UERSTAT: /* Read Only */
         res = s->reg[I_(UERSTAT)];
         s->reg[I_(UERSTAT)] = 0;
+        trace_exynos_uart_read(s->channel, offset,
+                               exynos4210_uart_regname(offset), res);
         return res;
     case UFSTAT: /* Read Only */
         s->reg[I_(UFSTAT)] = fifo_elements_number(&s->rx) & 0xff;
@@ -446,20 +401,22 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
             s->reg[I_(UFSTAT)] |= UFSTAT_Rx_FIFO_FULL;
             s->reg[I_(UFSTAT)] &= ~0xff;
         }
+        trace_exynos_uart_read(s->channel, offset,
+                               exynos4210_uart_regname(offset),
+                               s->reg[I_(UFSTAT)]);
         return s->reg[I_(UFSTAT)];
     case URXH:
         if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
             if (fifo_elements_number(&s->rx)) {
                 res = fifo_retrieve(&s->rx);
-#if DEBUG_Rx_DATA
-                fprintf(stderr, "%c", res);
-#endif
+                trace_exynos_uart_rx(s->channel, res);
                 if (!fifo_elements_number(&s->rx)) {
                     s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_BUFFER_DATA_READY;
                 } else {
                     s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
                 }
             } else {
+                trace_exynos_uart_rx_error(s->channel);
                 s->reg[I_(UINTSP)] |= UINTSP_ERROR;
                 exynos4210_uart_update_irq(s);
                 res = 0;
@@ -468,15 +425,22 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
             s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_BUFFER_DATA_READY;
             res = s->reg[I_(URXH)];
         }
+        trace_exynos_uart_read(s->channel, offset,
+                               exynos4210_uart_regname(offset), res);
         return res;
     case UTXH:
-        PRINT_DEBUG("UART%d: Trying to read from WO register: %s [%04x]\n",
-                    s->channel, exynos4210_uart_regname(offset), offset);
+        trace_exynos_uart_wo_read(s->channel, exynos4210_uart_regname(offset),
+                                  offset);
         break;
     default:
+        trace_exynos_uart_read(s->channel, offset,
+                               exynos4210_uart_regname(offset),
+                               s->reg[I_(offset)]);
         return s->reg[I_(offset)];
     }
 
+    trace_exynos_uart_read(s->channel, offset, exynos4210_uart_regname(offset),
+                           0);
     return 0;
 }
 
@@ -555,7 +519,7 @@ static void exynos4210_uart_reset(DeviceState *dev)
     fifo_reset(&s->rx);
     fifo_reset(&s->tx);
 
-    PRINT_DEBUG("UART%d: Rx FIFO size: %d\n", s->channel, s->rx.size);
+    trace_exynos_uart_rxsize(s->channel, s->rx.size);
 }
 
 static const VMStateDescription vmstate_exynos4210_uart_fifo = {
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2ce7f2f9987..ba28b45b532 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -77,3 +77,20 @@ cmsdk_apb_uart_set_params(int speed) "CMSDK APB UART: params set to %d 8N1"
 # nrf51_uart.c
 nrf51_uart_read(uint64_t addr, uint64_t r, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
 nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+
+# exynos4210_uart.c
+exynos_uart_irq_raised(uint32_t channel, uint32_t reg) "UART%d: IRQ raised: 0x%08"PRIx32
+exynos_uart_irq_lowered(uint32_t channel) "UART%d: IRQ lowered"
+exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d"
+exynos_uart_write(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s <- 0x%" PRIx64
+exynos_uart_read(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s -> 0x%" PRIx64
+exynos_uart_rx_fifo_reset(uint32_t channel) "UART%d: Rx FIFO Reset"
+exynos_uart_tx_fifo_reset(uint32_t channel) "UART%d: Tx FIFO Reset"
+exynos_uart_tx(uint32_t channel, uint8_t ch) "UART%d: Tx 0x%02"PRIx32
+exynos_uart_intclr(uint32_t channel, uint32_t reg) "UART%d: interrupts cleared: 0x%08"PRIx32
+exynos_uart_ro_write(uint32_t channel, const char *name, uint32_t reg) "UART%d: Trying to write into RO register: %s [0x%04"PRIx32"]"
+exynos_uart_rx(uint32_t channel, uint8_t ch) "UART%d: Rx 0x%02"PRIx32
+exynos_uart_rx_error(uint32_t channel) "UART%d: Rx error"
+exynos_uart_wo_read(uint32_t channel, const char *name, uint32_t reg) "UART%d: Trying to read from WO register: %s [0x%04"PRIx32"]"
+exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
+exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
-- 
2.20.1


