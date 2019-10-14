Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80519ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EF120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tge074b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EF120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3MU-00053n-4n
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qX-0004sM-BR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qV-0007zm-La
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qV-0007yd-Ek
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 7so17878120wme.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KUMye//Fbkf+9msDoqPyPXUdss42C+DBua4/Sjth1Gs=;
 b=Tge074b3W0MMVzRgckggTMV4kPX4AcUcOfsUTR4+rHmLSYdkDugO+yD7muLYc9bcCY
 oBv54bIvrVBdmCpjRHo51t5gT4zZIqw6REx154wpKYeRgrEt17pyuDMIR7AK5UzOjvnD
 1WZ33/FN2W/iGVvC8GJjBJJfdfZ7d6GLM2yTf2WZVM4pW0nvvcL1PrS5YaS9lR2vTRGY
 Ncnl1tmp76QUwUPorJVF2uXR8xvZLRYNCWKQPyxzK60x2nyoae3Hhojyz9Frk59ytVgP
 T+tcZ6WHEcGG++8EU5gTICzRkK3nP1qZKQkbY0I3iIrxn3pp818TwPti57uE1/pMt2Iu
 MLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KUMye//Fbkf+9msDoqPyPXUdss42C+DBua4/Sjth1Gs=;
 b=Wf5cc/s6gDXyer2vXGr+ULwhdpyTZc+J1yYYprpVJCWY8/WdsZtNisaeeX7aakGIOr
 tM8PL0cShfESi2bQuKcbMjZP8qW6bdossUtsft7VaC6qgwdYJls1RRFl6vCcJOwXCrNy
 m736LJvmNbsLTmCwnElZx2wpv4asIseOWHdPq4jmsrqJ4n2Llx95eV+XE/LQYA72AteO
 V4vesiTlEqtWmDhXDsSO1pOjMP7AqvNyJ9kBOL8o34bSeLe2PNgiP793nhI7QDArGBdL
 TeGYt5lI7KhTPd+R/a7sWqOqzh49fkhDXYLkYxOEQp8n8Ssu1u/wNnqIaM1Z8DRE8qdm
 +XWw==
X-Gm-Message-State: APjAAAXqht6YcRavmDyo83Dw7aLij6V3XvYFXkSw1xt7ti8M8BMhXOkv
 Ms8Msm5+L9B2IhFruKM5AVtjKhLdGxhACA==
X-Google-Smtp-Source: APXvYqwJZV5jovGQR6p1DWKQUpngLV20qGAsJrX1RoPMw21bYWudfl7BauwJoquwY6rWAGdqeiVlBg==
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr15079408wmt.108.1571069118077; 
 Mon, 14 Oct 2019 09:05:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/68] aspeed/timer: Introduce an object class per SoC
Date: Mon, 14 Oct 2019 17:03:39 +0100
Message-Id: <20191014160404.19553-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

From: Cédric Le Goater <clg@kaod.org>

The most important changes will be on the register range 0x34 - 0x3C
memops. Introduce class read/write operations to handle the
differences between SoCs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/aspeed_timer.h |  15 +++++
 hw/arm/aspeed_soc.c             |   3 +-
 hw/timer/aspeed_timer.c         | 107 ++++++++++++++++++++++++++++----
 3 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 1fb949e1671..a791fee276f 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -28,6 +28,9 @@
 #define ASPEED_TIMER(obj) \
     OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
 #define TYPE_ASPEED_TIMER "aspeed.timer"
+#define TYPE_ASPEED_2400_TIMER TYPE_ASPEED_TIMER "-ast2400"
+#define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
+
 #define ASPEED_TIMER_NR_TIMERS 8
 
 typedef struct AspeedTimer {
@@ -60,4 +63,16 @@ typedef struct AspeedTimerCtrlState {
     AspeedSCUState *scu;
 } AspeedTimerCtrlState;
 
+#define ASPEED_TIMER_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedTimerClass, (klass), TYPE_ASPEED_TIMER)
+#define ASPEED_TIMER_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedTimerClass, (obj), TYPE_ASPEED_TIMER)
+
+typedef struct AspeedTimerClass {
+    SysBusDeviceClass parent_class;
+
+    uint64_t (*read)(AspeedTimerCtrlState *s, hwaddr offset);
+    void (*write)(AspeedTimerCtrlState *s, hwaddr offset, uint64_t value);
+} AspeedTimerClass;
+
 #endif /* ASPEED_TIMER_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c3821a56273..26e03486f9b 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -182,8 +182,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
                           TYPE_ASPEED_RTC);
 
+    snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
-                          sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
+                          sizeof(s->timerctrl), typename);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 2bda826882d..c78bc1bd2d2 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -253,13 +253,8 @@ static uint64_t aspeed_timer_read(void *opaque, hwaddr offset, unsigned size)
     case 0x40 ... 0x8c: /* Timers 5 - 8 */
         value = aspeed_timer_get_value(&s->timers[(offset >> 4) - 1], reg);
         break;
-    /* Illegal */
-    case 0x38:
-    case 0x3C:
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
-                __func__, offset);
-        value = 0;
+        value = ASPEED_TIMER_GET_CLASS(s)->read(s, offset);
         break;
     }
     trace_aspeed_timer_read(offset, size, value);
@@ -453,12 +448,8 @@ static void aspeed_timer_write(void *opaque, hwaddr offset, uint64_t value,
     case 0x40 ... 0x8c:
         aspeed_timer_set_value(s, (offset >> TIMER_NR_REGS) - 1, reg, tv);
         break;
-    /* Illegal */
-    case 0x38:
-    case 0x3C:
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
-                __func__, offset);
+        ASPEED_TIMER_GET_CLASS(s)->write(s, offset, value);
         break;
     }
 }
@@ -472,6 +463,64 @@ static const MemoryRegionOps aspeed_timer_ops = {
     .valid.unaligned = false,
 };
 
+static uint64_t aspeed_2400_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
+{
+    uint64_t value;
+
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        value = 0;
+        break;
+    }
+    return value;
+}
+
+static void aspeed_2400_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
+                                    uint64_t value)
+{
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        break;
+    }
+}
+
+static uint64_t aspeed_2500_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
+{
+    uint64_t value;
+
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        value = 0;
+        break;
+    }
+    return value;
+}
+
+static void aspeed_2500_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
+                                    uint64_t value)
+{
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        break;
+    }
+}
+
 static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 {
     AspeedTimer *t = &s->timers[id];
@@ -570,11 +619,47 @@ static const TypeInfo aspeed_timer_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedTimerCtrlState),
     .class_init = timer_class_init,
+    .class_size = sizeof(AspeedTimerClass),
+    .abstract   = true,
+};
+
+static void aspeed_2400_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
+
+    dc->desc = "ASPEED 2400 Timer";
+    awc->read = aspeed_2400_timer_read;
+    awc->write = aspeed_2400_timer_write;
+}
+
+static const TypeInfo aspeed_2400_timer_info = {
+    .name = TYPE_ASPEED_2400_TIMER,
+    .parent = TYPE_ASPEED_TIMER,
+    .class_init = aspeed_2400_timer_class_init,
+};
+
+static void aspeed_2500_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
+
+    dc->desc = "ASPEED 2500 Timer";
+    awc->read = aspeed_2500_timer_read;
+    awc->write = aspeed_2500_timer_write;
+}
+
+static const TypeInfo aspeed_2500_timer_info = {
+    .name = TYPE_ASPEED_2500_TIMER,
+    .parent = TYPE_ASPEED_TIMER,
+    .class_init = aspeed_2500_timer_class_init,
 };
 
 static void aspeed_timer_register_types(void)
 {
     type_register_static(&aspeed_timer_info);
+    type_register_static(&aspeed_2400_timer_info);
+    type_register_static(&aspeed_2500_timer_info);
 }
 
 type_init(aspeed_timer_register_types)
-- 
2.20.1


