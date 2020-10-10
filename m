Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3841C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A60E22283
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="VyKGCN5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A60E22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFUb-0003aF-83
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNN-0001vz-8T; Sat, 10 Oct 2020 09:57:33 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFNL-0004KK-2U; Sat, 10 Oct 2020 09:57:32 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 271ADC60430;
 Sat, 10 Oct 2020 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338225;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MO0Muj7yuPd6SWwH9hfY/l2s1zABrTHCErTOwR/d+QM=;
 b=VyKGCN5QIjRI7lfg0PhLOl/QWGjzATW1evA45KI0zttBsY+wX8+tVXB6HUw7eGHA+ezxJu
 LRASA7I4JrKTk01ee8UvEI3X8ZkbojiWGIEKDJOgtc8w0meN1t1npHzORFHdM6WQBKaKGk
 1zwdTZYs0dZRwXj7G+DTqUTPFe4j1wCgNjJL54oHO5LnOMGX5+bnIra4TxzHad6p2o/hnR
 nZzDfWx7WBGHS9gzPgH2IgXfhj88ewRVTV0VfmigESOmrbq/yQX4EtEkmTb+LrvLLIeGtD
 96Ud+QVb01EUE58ZAwYGtrksGHbK4Gu7OSeNedgdoGiLP902MdBvSgYIRaylxQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/15] hw/char/pl011: add a clock input
Date: Sat, 10 Oct 2020 15:57:58 +0200
Message-Id: <20201010135759.437903-15-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338225;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MO0Muj7yuPd6SWwH9hfY/l2s1zABrTHCErTOwR/d+QM=;
 b=c4Q/LOVSRYkWzOjsKAksjneVu7kCNqHzBadCdMH4ni7Q5a2mRc1SFB67weVaEGOsAzVtNm
 c2elRaLO97F3FpE9atIdMQKcqKcXHUiRLjCdhSW5S8qPNTARMIwF+f98ZV7OuJ9MBshC2X
 Xcp3uYr/BEALZwFomQ6GL248HFJJ2MgJVDOcMTKSn6/T49KGJzd9ky+trEANOYhZCTbIGY
 nt9NDl5gs/ChEvjKcXJxTgE++S4BA6B5h/AY9x492Z86lfHzGxTcqYmApeqkr/nsWAcoiD
 QQRDDgKY5Poi5kszAX6Vq359QuI0QX2yBI22SFVinZT96mwNteMUNdLGhiNO3A==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338225; a=rsa-sha256; cv=none;
 b=RsdEL03PPkV8VqFq0egcQRfhRUVbItmv/zDH1ZdZL8MzDhx1zNCdgV3ZnxSne2GKtHJVsNH0YbH15QyM7EP6YSbEAwSWpknynKeIqXCRJUxvgnogYOBA8t94xdHGvteVtfZcjB21s50wOqkQ8WpZDRijTIGeEgeYUPfwg+gIkINJYxCvQufUEhBz9/qFUEGpePWd2GUVPKY1psBurGL5Q9lY906HPnjq2/zvu1fSc70UyPf/XzTd6x0lr4fF8bqkdeukWrFqRGkEcPcE53P+03sA7Y+9qGDJ2PIjSqIRWu8m7hQtqH5xRyTci1OV/iS4GOMRuK9Mm/kshPdGmnBv2Q==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a clock input to the PL011 UART so we can compute the current baud
rate and trace it. This is intended for developers who wish to use QEMU
to e.g. debug their firmware or to figure out the baud rate configured
by an unknown/closed source binary.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/char/pl011.h |  1 +
 hw/char/pl011.c         | 45 +++++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events    |  1 +
 3 files changed, 47 insertions(+)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index a91ea50e11..33e5e5317b 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -47,10 +47,11 @@ struct PL011State {
     int read_pos;
     int read_count;
     int read_trigger;
     CharBackend chr;
     qemu_irq irq[6];
+    Clock *clk;
     const unsigned char *id;
 };
 
 static inline DeviceState *pl011_create(hwaddr addr,
                                         qemu_irq irq,
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 13e784f9d9..ede16c781c 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -20,10 +20,11 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/pl011.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
@@ -167,10 +168,29 @@ static void pl011_set_read_trigger(PL011State *s)
     else
 #endif
         s->read_trigger = 1;
 }
 
+static unsigned int pl011_get_baudrate(const PL011State *s)
+{
+    uint64_t clk;
+
+    if (s->fbrd == 0) {
+        return 0;
+    }
+
+    clk = clock_get_hz(s->clk);
+    return (clk / ((s->ibrd << 6) + s->fbrd)) << 2;
+}
+
+static void pl011_trace_baudrate_change(const PL011State *s)
+{
+    trace_pl011_baudrate_change(pl011_get_baudrate(s),
+                                clock_get_hz(s->clk),
+                                s->ibrd, s->fbrd);
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
     PL011State *s = (PL011State *)opaque;
     unsigned char ch;
@@ -196,13 +216,15 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 8: /* UARTUARTILPR */
         s->ilpr = value;
         break;
     case 9: /* UARTIBRD */
         s->ibrd = value;
+        pl011_trace_baudrate_change(s);
         break;
     case 10: /* UARTFBRD */
         s->fbrd = value;
+        pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & 0x10) {
             s->read_count = 0;
@@ -284,16 +306,33 @@ static void pl011_event(void *opaque, QEMUChrEvent event)
 {
     if (event == CHR_EVENT_BREAK)
         pl011_put_fifo(opaque, 0x400);
 }
 
+static void pl011_clock_update(void *opaque)
+{
+    PL011State *s = PL011(opaque);
+
+    pl011_trace_baudrate_change(s);
+}
+
 static const MemoryRegionOps pl011_ops = {
     .read = pl011_read,
     .write = pl011_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static const VMStateDescription vmstate_pl011_clock = {
+    .name = "pl011/clock",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(clk, PL011State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_pl011 = {
     .name = "pl011",
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
@@ -312,10 +351,14 @@ static const VMStateDescription vmstate_pl011 = {
         VMSTATE_UINT32(ifl, PL011State),
         VMSTATE_INT32(read_pos, PL011State),
         VMSTATE_INT32(read_count, PL011State),
         VMSTATE_INT32(read_trigger, PL011State),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pl011_clock,
+        NULL
     }
 };
 
 static Property pl011_properties[] = {
     DEFINE_PROP_CHR("chardev", PL011State, chr),
@@ -332,10 +375,12 @@ static void pl011_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
 
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s);
+
     s->read_trigger = 1;
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0x90;
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 609df10fed..81026f6612 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -63,10 +63,11 @@ pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
+pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_uart_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_uart_reset(void) "CMSDK APB UART: reset"
-- 
2.28.0


