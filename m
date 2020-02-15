Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA0C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D6820718
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D6820718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2sig-0007cJ-Bk
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 03:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j2si4-00073u-UW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j2si3-0001A7-Hj
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:21:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36942 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j2si0-00014E-0y; Sat, 15 Feb 2020 03:21:52 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BD29D85176AFA43D24D7;
 Sat, 15 Feb 2020 16:21:46 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Feb 2020 16:21:36 +0800
From: <pannengyuan@huawei.com>
To: <balrogg@gmail.com>, <peter.maydell@linaro.org>,
 <mark.cave-ayland@ilande.co.uk>, <david@gibson.dropbear.id.au>,
 <edgar.iglesias@gmail.com>, <alistair@alistair23.me>
Subject: [PATCH 2/2] hw: move timer_new from init() into realize() to avoid
 memleaks
Date: Sat, 15 Feb 2020 16:37:15 +0800
Message-ID: <20200215083715.5147-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
Meanwhile, do the null check in mos6522_reset() to avoid null deref if we move timer_new into realize().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/arm/pxa2xx.c        | 17 +++++++++++------
 hw/arm/spitz.c         |  8 +++++++-
 hw/arm/strongarm.c     | 18 ++++++++++++------
 hw/misc/mos6522.c      | 14 ++++++++++++--
 hw/timer/cadence_ttc.c | 16 +++++++++++-----
 5 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b33f8f1351..56a36202d7 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1134,18 +1134,22 @@ static void pxa2xx_rtc_init(Object *obj)
     s->last_rtcpicr = 0;
     s->last_hz = s->last_sw = s->last_pi = qemu_clock_get_ms(rtc_clock);
 
+    sysbus_init_irq(dev, &s->rtc_irq);
+
+    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
+                          "pxa2xx-rtc", 0x10000);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void pxa2xx_rtc_realize(DeviceState *dev, Error **errp)
+{
+    PXA2xxRTCState *s = PXA2XX_RTC(dev);
     s->rtc_hz    = timer_new_ms(rtc_clock, pxa2xx_rtc_hz_tick,    s);
     s->rtc_rdal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal1_tick, s);
     s->rtc_rdal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal2_tick, s);
     s->rtc_swal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal1_tick, s);
     s->rtc_swal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal2_tick, s);
     s->rtc_pi    = timer_new_ms(rtc_clock, pxa2xx_rtc_pi_tick,    s);
-
-    sysbus_init_irq(dev, &s->rtc_irq);
-
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
-                          "pxa2xx-rtc", 0x10000);
-    sysbus_init_mmio(dev, &s->iomem);
 }
 
 static int pxa2xx_rtc_pre_save(void *opaque)
@@ -1203,6 +1207,7 @@ static void pxa2xx_rtc_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PXA2xx RTC Controller";
     dc->vmsd = &vmstate_pxa2xx_rtc_regs;
+    dc->realize = pxa2xx_rtc_realize;
 }
 
 static const TypeInfo pxa2xx_rtc_sysbus_info = {
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index e001088103..cbfa6934cf 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -524,11 +524,16 @@ static void spitz_keyboard_init(Object *obj)
 
     spitz_keyboard_pre_map(s);
 
-    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
     qdev_init_gpio_in(dev, spitz_keyboard_strobe, SPITZ_KEY_STROBE_NUM);
     qdev_init_gpio_out(dev, s->sense, SPITZ_KEY_SENSE_NUM);
 }
 
+static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
+{
+    SpitzKeyboardState *s = SPITZ_KEYBOARD(dev);
+    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
+}
+
 /* LCD backlight controller */
 
 #define LCDTG_RESCTL	0x00
@@ -1115,6 +1120,7 @@ static void spitz_keyboard_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_spitz_kbd;
+    dc->realize = spitz_keyboard_realize;
 }
 
 static const TypeInfo spitz_keyboard_info = {
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index cd8a99aaf2..3010d765bb 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -399,9 +399,6 @@ static void strongarm_rtc_init(Object *obj)
     s->last_rcnr = (uint32_t) mktimegm(&tm);
     s->last_hz = qemu_clock_get_ms(rtc_clock);
 
-    s->rtc_alarm = timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s);
-    s->rtc_hz = timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
-
     sysbus_init_irq(dev, &s->rtc_irq);
     sysbus_init_irq(dev, &s->rtc_hz_irq);
 
@@ -410,6 +407,13 @@ static void strongarm_rtc_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
+static void strongarm_rtc_realize(DeviceState *dev, Error **errp)
+{
+    StrongARMRTCState *s = STRONGARM_RTC(dev);
+    s->rtc_alarm = timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s);
+    s->rtc_hz = timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
+}
+
 static int strongarm_rtc_pre_save(void *opaque)
 {
     StrongARMRTCState *s = opaque;
@@ -451,6 +455,7 @@ static void strongarm_rtc_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "StrongARM RTC Controller";
     dc->vmsd = &vmstate_strongarm_rtc_regs;
+    dc->realize = strongarm_rtc_realize;
 }
 
 static const TypeInfo strongarm_rtc_sysbus_info = {
@@ -1240,15 +1245,16 @@ static void strongarm_uart_init(Object *obj)
                           "uart", 0x10000);
     sysbus_init_mmio(dev, &s->iomem);
     sysbus_init_irq(dev, &s->irq);
-
-    s->rx_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_rx_to, s);
-    s->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, s);
 }
 
 static void strongarm_uart_realize(DeviceState *dev, Error **errp)
 {
     StrongARMUARTState *s = STRONGARM_UART(dev);
 
+    s->rx_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       strongarm_uart_rx_to,
+                                       s);
+    s->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, s);
     qemu_chr_fe_set_handlers(&s->chr,
                              strongarm_uart_can_receive,
                              strongarm_uart_receive,
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 19e154b870..980eda7599 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
     s->timers[0].frequency = s->frequency;
     s->timers[0].latch = 0xffff;
     set_counter(s, &s->timers[0], 0xffff);
-    timer_del(s->timers[0].timer);
+    if (s->timers[0].timer) {
+        timer_del(s->timers[0].timer);
+    }
 
     s->timers[1].frequency = s->frequency;
     s->timers[1].latch = 0xffff;
-    timer_del(s->timers[1].timer);
+    if (s->timers[1].timer) {
+        timer_del(s->timers[1].timer);
+    }
 }
 
 static void mos6522_init(Object *obj)
@@ -485,6 +489,11 @@ static void mos6522_init(Object *obj)
     for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
         s->timers[i].index = i;
     }
+}
+
+static void mos6522_realize(DeviceState *dev, Error **errp)
+{
+    MOS6522State *s = MOS6522(dev);
 
     s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
     s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
@@ -502,6 +511,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
 
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
+    dc->realize = mos6522_realize;
     device_class_set_props(dc, mos6522_properties);
     mdc->parent_reset = dc->reset;
     mdc->set_sr_int = mos6522_set_sr_int;
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 5e3128c1e3..b0ba6b2bba 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -412,16 +412,21 @@ static void cadence_timer_init(uint32_t freq, CadenceTimerState *s)
 static void cadence_ttc_init(Object *obj)
 {
     CadenceTTCState *s = CADENCE_TTC(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
+                          "timer", 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void cadence_ttc_realize(DeviceState *dev, Error **errp)
+{
+    CadenceTTCState *s = CADENCE_TTC(dev);
     int i;
 
     for (i = 0; i < 3; ++i) {
         cadence_timer_init(133000000, &s->timer[i]);
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->timer[i].irq);
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->timer[i].irq);
     }
-
-    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
-                          "timer", 0x1000);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
 static int cadence_timer_pre_save(void *opaque)
@@ -479,6 +484,7 @@ static void cadence_ttc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_cadence_ttc;
+    dc->realize = cadence_ttc_realize;
 }
 
 static const TypeInfo cadence_ttc_info = {
-- 
2.18.2


