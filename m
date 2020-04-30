Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A465C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F2020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewe90wtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F2020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7pb-0007Cq-CU
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jb-00030z-9k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jY-0000O7-1M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jX-0000NF-FZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id k12so1506349wmj.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Bv21gUxQEXbHx9QjPDLTw+zQjUFcUK0aZU/JKd/dXGI=;
 b=ewe90wtbwHyZMzb5+G3nGU3PJKeTTzPt7R/zzVfelChwrwW/K9ZqPv/Xd4mBM8wnB/
 4S5iHj92twVFjvPQatPGd542VYvkHzmui+RiYCfdO7Dfh2T6/LNGV4nU1jM2hkV1MfWv
 FNw3V4QXtBi5QeClPNebqf75A6rKnucT+e1duyb2YV5OSjRO454JsleAfHmqiCcQ0ySj
 32meq9mUJvFMWtnlKaqWJZwtSdub/0jW5sJNoxM13wYd0J732xSDVyMA69fTCpyPQBxq
 pu8z35viOyJknwLr83Adz8znzA34khjg9f0xn+vL1WG8MCbN/WhQPdFQOmQBi7Q7qpx4
 zC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bv21gUxQEXbHx9QjPDLTw+zQjUFcUK0aZU/JKd/dXGI=;
 b=oO2NMSuhoAP2WSr02bEprabZDjMm2Ni66HS8cq7XcFv2CuqKrPXlrO5xFox66LVDft
 k063xEhBdDUM0xfMAIsKUgOLT1TdrXSei/k+KlvbhXeqmsjdpgCVFo/E8NyDVqS/Yfqh
 6+fpkH/dF4yRTa9PKk7cC8MdEVdVv+1ek9J7EqceyjsMxlvfQA2B/R1nLXOeSwWU+izb
 0WdsjR97I9oSAER5x3ezENKYb9UlF5Pr3IKT3JY3ujPXJJdjgXUFToZvmJjP9Q/EmlzE
 3saral3BiGTz9TNTsbdpKP6oM+iyPaKcScFFOM/xsuukRrjHCCk1qPq8A2ebjgDpmXh+
 Sz/A==
X-Gm-Message-State: AGi0PubYVpDIRKWftj1UEQs+UBC9kb35oFIrNDQchWCu0xM7cfHEJ20a
 gDeudMrryQcAfYeSAkcofzcH7ZULSAI9yA==
X-Google-Smtp-Source: APiQypKvq68rx7KekmOFsDuFPt4TrZY8x00aPYhqGio4sfMHG4utobtcW8fpVxQVpGE9l7UUYRsOjQ==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr2414641wmc.29.1588247521327; 
 Thu, 30 Apr 2020 04:52:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] hw/char/cadence_uart: add clock support
Date: Thu, 30 Apr 2020 12:51:26 +0100
Message-Id: <20200430115142.13430-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::331
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

From: Damien Hedde <damien.hedde@greensocs.com>

Switch the cadence uart to multi-phase reset and add the
reference clock input.

The input clock frequency is added to the migration structure.

The reference clock controls the baudrate generation. If it disabled,
any input characters and events are ignored.

If this clock remains unconnected, the uart behaves as before
(it default to a 50MHz ref clock).

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200406135251.157596-8-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/cadence_uart.h |  1 +
 hw/char/cadence_uart.c         | 73 +++++++++++++++++++++++++++++-----
 hw/char/trace-events           |  3 ++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index 47cec956c4b..2a179a572fc 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -49,6 +49,7 @@ typedef struct {
     CharBackend chr;
     qemu_irq irq;
     QEMUTimer *fifo_trigger_handle;
+    Clock *refclk;
 } CadenceUARTState;
 
 static inline DeviceState *cadence_uart_create(hwaddr addr,
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 22e47972f15..e196906c923 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -31,6 +31,8 @@
 #include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "trace.h"
 
 #ifdef CADENCE_UART_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -97,7 +99,7 @@
 #define LOCAL_LOOPBACK         (0x2 << UART_MR_CHMODE_SH)
 #define REMOTE_LOOPBACK        (0x3 << UART_MR_CHMODE_SH)
 
-#define UART_INPUT_CLK         50000000
+#define UART_DEFAULT_REF_CLK (50 * 1000 * 1000)
 
 #define R_CR       (0x00/4)
 #define R_MR       (0x04/4)
@@ -171,12 +173,15 @@ static void uart_send_breaks(CadenceUARTState *s)
 static void uart_parameters_setup(CadenceUARTState *s)
 {
     QEMUSerialSetParams ssp;
-    unsigned int baud_rate, packet_size;
+    unsigned int baud_rate, packet_size, input_clk;
+    input_clk = clock_get_hz(s->refclk);
 
-    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ?
-            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
+    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ? input_clk / 8 : input_clk;
+    baud_rate /= (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
+    trace_cadence_uart_baudrate(baud_rate);
+
+    ssp.speed = baud_rate;
 
-    ssp.speed = baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
     packet_size = 1;
 
     switch (s->r[R_MR] & UART_MR_PAR) {
@@ -215,6 +220,13 @@ static void uart_parameters_setup(CadenceUARTState *s)
     }
 
     packet_size += ssp.data_bits + ssp.stop_bits;
+    if (ssp.speed == 0) {
+        /*
+         * Avoid division-by-zero below.
+         * TODO: find something better
+         */
+        ssp.speed = 1;
+    }
     s->char_tx_time = (NANOSECONDS_PER_SECOND / ssp.speed) * packet_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 }
@@ -340,6 +352,11 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
     CadenceUARTState *s = opaque;
     uint32_t ch_mode = s->r[R_MR] & UART_MR_CHMODE;
 
+    /* ignore characters when unclocked or in reset */
+    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
+        return;
+    }
+
     if (ch_mode == NORMAL_MODE || ch_mode == ECHO_MODE) {
         uart_write_rx_fifo(opaque, buf, size);
     }
@@ -353,6 +370,11 @@ static void uart_event(void *opaque, QEMUChrEvent event)
     CadenceUARTState *s = opaque;
     uint8_t buf = '\0';
 
+    /* ignore characters when unclocked or in reset */
+    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
+        return;
+    }
+
     if (event == CHR_EVENT_BREAK) {
         uart_write_rx_fifo(opaque, &buf, 1);
     }
@@ -462,9 +484,9 @@ static const MemoryRegionOps uart_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void cadence_uart_reset(DeviceState *dev)
+static void cadence_uart_reset_init(Object *obj, ResetType type)
 {
-    CadenceUARTState *s = CADENCE_UART(dev);
+    CadenceUARTState *s = CADENCE_UART(obj);
 
     s->r[R_CR] = 0x00000128;
     s->r[R_IMR] = 0;
@@ -473,6 +495,11 @@ static void cadence_uart_reset(DeviceState *dev)
     s->r[R_BRGR] = 0x0000028B;
     s->r[R_BDIV] = 0x0000000F;
     s->r[R_TTRIG] = 0x00000020;
+}
+
+static void cadence_uart_reset_hold(Object *obj)
+{
+    CadenceUARTState *s = CADENCE_UART(obj);
 
     uart_rx_reset(s);
     uart_tx_reset(s);
@@ -491,6 +518,14 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
                              uart_event, NULL, s, NULL, true);
 }
 
+static void cadence_uart_refclk_update(void *opaque)
+{
+    CadenceUARTState *s = opaque;
+
+    /* recompute uart's speed on clock change */
+    uart_parameters_setup(s);
+}
+
 static void cadence_uart_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -500,9 +535,23 @@ static void cadence_uart_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
 
+    s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
+            cadence_uart_refclk_update, s);
+    /* initialize the frequency in case the clock remains unconnected */
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+
     s->char_tx_time = (NANOSECONDS_PER_SECOND / 9600) * 10;
 }
 
+static int cadence_uart_pre_load(void *opaque)
+{
+    CadenceUARTState *s = opaque;
+
+    /* the frequency will be overriden if the refclk field is present */
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+    return 0;
+}
+
 static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s = opaque;
@@ -521,8 +570,9 @@ static int cadence_uart_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_cadence_uart = {
     .name = "cadence_uart",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 2,
+    .pre_load = cadence_uart_pre_load,
     .post_load = cadence_uart_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
@@ -534,8 +584,9 @@ static const VMStateDescription vmstate_cadence_uart = {
         VMSTATE_UINT32(tx_count, CadenceUARTState),
         VMSTATE_UINT32(rx_wpos, CadenceUARTState),
         VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
+        VMSTATE_CLOCK_V(refclk, CadenceUARTState, 3),
         VMSTATE_END_OF_LIST()
-    }
+    },
 };
 
 static Property cadence_uart_properties[] = {
@@ -546,10 +597,12 @@ static Property cadence_uart_properties[] = {
 static void cadence_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = cadence_uart_realize;
     dc->vmsd = &vmstate_cadence_uart;
-    dc->reset = cadence_uart_reset;
+    rc->phases.enter = cadence_uart_reset_init;
+    rc->phases.hold  = cadence_uart_reset_hold;
     device_class_set_props(dc, cadence_uart_properties);
   }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 6f938301d98..d20eafd56f8 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -97,3 +97,6 @@ exynos_uart_wo_read(uint32_t channel, const char *name, uint32_t reg) "UART%d: T
 exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
 exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
 exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d: Rx timeout stat=0x%x intsp=0x%x"
+
+# hw/char/cadence_uart.c
+cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
-- 
2.20.1


