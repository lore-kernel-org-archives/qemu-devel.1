Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1B920659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdOgtxtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1B920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgs3-0003C2-S7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyP-0008Tc-6D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyN-00016O-58
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyM-00015w-UY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z11so3426845wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vzBTgyNx8Q8kNnyl3gqBcooBFcldGb6ykyZpy3nNnJw=;
 b=ZdOgtxtv3jAqST3lumMDv45pApUp8tB4HQv8KafsqwK89KgERk35wv7DkRTHj5Nf8r
 HyacBEeu9r7nKvcOex/6DSikjL6K8XQBTl8GIwDhhQFrSh3zHrwHlsE6SR5KxTEFBBdj
 mbeOp+PusLIFS5Wa30HCW7BQ94y6wX0cQLZzb90vBILu3gVj8qN5MgULBg2qnmVFu/Pi
 VE4gmNZBiCa+v52yFijdtMFm1pqVTajKzKWn2YjhISWS29I0lVP0pgCP+lW2D+9AIKg8
 2pY91TserMHUguIpLVmKomBswt0L6JBVsJk5IOsaIE00Zst8NL6QEfNeJ+4n+eb+zNWz
 c6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vzBTgyNx8Q8kNnyl3gqBcooBFcldGb6ykyZpy3nNnJw=;
 b=reSJiFus1K0HpQlgcjmPPeNjieIQd7eS/ScaMIqvAHg+sgyCkxpaVowKoi3JnWUPzp
 xV+trkWkgtsj8npqDw4o126WFgKFOh9XxwB4E7xj1dzib0D3InPFBVhZLj48O5ClWhxi
 F5RSM/zNmkUFno/IJSrNnBaBIT3jd1swELH2VoGqbF6Raj9JDUE9F1pp9M24bLi3pceZ
 X0OH7H6pFS+sCBJy/69+FVDg2dv9hwUqJeJsPAPQl7pEMRoHS7TfPJIBUoUUwwuRwlvF
 2VREkdvdLYuBpCcYUTSmH/HCLUR6xRJWApdagW9T0ECzUfqxautc/6xSdj91AlTdyVSY
 im/w==
X-Gm-Message-State: APjAAAVl8b7lHb1OuBRCvjI2uDOQKEq0l/fq1i5WrcqNAFjKJ9ikO3Vf
 G4TBJDNFmlB/l3rdTTSTHhhqXjTgs2U=
X-Google-Smtp-Source: APXvYqzmuliKA2Z5sbHlqe/Vs+cFokL40PNv/HImGjdW5grdSh4o88oKo8/RX8sa0tp3MqJDemBknA==
X-Received: by 2002:a05:6000:4f:: with SMTP id
 k15mr4417035wrx.137.1571934505498; 
 Thu, 24 Oct 2019 09:28:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/51] hw/timer/bcm2835: Add the BCM2835 SYS_timer
Date: Thu, 24 Oct 2019 17:27:19 +0100
Message-Id: <20191024162724.31675-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add the 64-bit free running timer. Do not model the COMPARE register
(no IRQ generated).
This timer is used by Linux kernel and recently U-Boot:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/bcm2835_timer.c?h=v3.7
https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19

Datasheet used:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-4-f4bug@amsat.org
[PMM: squashed in switch to using memset in reset]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/Makefile.objs            |   1 +
 include/hw/timer/bcm2835_systmr.h |  33 ++++++
 hw/timer/bcm2835_systmr.c         | 163 ++++++++++++++++++++++++++++++
 hw/timer/trace-events             |   5 +
 4 files changed, 202 insertions(+)
 create mode 100644 include/hw/timer/bcm2835_systmr.h
 create mode 100644 hw/timer/bcm2835_systmr.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c9692..696cda59052 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
+common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
new file mode 100644
index 00000000000..c0bc5c81270
--- /dev/null
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -0,0 +1,33 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2835_SYSTIMER_H
+#define BCM2835_SYSTIMER_H
+
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
+#define BCM2835_SYSTIMER(obj) \
+    OBJECT_CHECK(BCM2835SystemTimerState, (obj), TYPE_BCM2835_SYSTIMER)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    struct {
+        uint32_t status;
+        uint32_t compare[4];
+    } reg;
+} BCM2835SystemTimerState;
+
+#endif
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
new file mode 100644
index 00000000000..3387a6214a2
--- /dev/null
+++ b/hw/timer/bcm2835_systmr.c
@@ -0,0 +1,163 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
+ * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
+ *
+ * Only the free running 64-bit counter is implemented.
+ * The 4 COMPARE registers and the interruption are not implemented.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "hw/timer/bcm2835_systmr.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+REG32(CTRL_STATUS,  0x00)
+REG32(COUNTER_LOW,  0x04)
+REG32(COUNTER_HIGH, 0x08)
+REG32(COMPARE0,     0x0c)
+REG32(COMPARE1,     0x10)
+REG32(COMPARE2,     0x14)
+REG32(COMPARE3,     0x18)
+
+static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
+{
+    bool enable = !!s->reg.status;
+
+    trace_bcm2835_systmr_irq(enable);
+    qemu_set_irq(s->irq, enable);
+}
+
+static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
+                                          unsigned timer_index)
+{
+    /* TODO fow now, since neither Linux nor U-boot use these timers. */
+    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
+                  timer_index);
+}
+
+static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+    uint64_t r = 0;
+
+    switch (offset) {
+    case A_CTRL_STATUS:
+        r = s->reg.status;
+        break;
+    case A_COMPARE0 ... A_COMPARE3:
+        r = s->reg.compare[(offset - A_COMPARE0) >> 2];
+        break;
+    case A_COUNTER_LOW:
+    case A_COUNTER_HIGH:
+        /* Free running counter at 1MHz */
+        r = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+        r >>= 8 * (offset - A_COUNTER_LOW);
+        r &= UINT32_MAX;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+    trace_bcm2835_systmr_read(offset, r);
+
+    return r;
+}
+
+static void bcm2835_systmr_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+
+    trace_bcm2835_systmr_write(offset, value);
+    switch (offset) {
+    case A_CTRL_STATUS:
+        s->reg.status &= ~value; /* Ack */
+        bcm2835_systmr_update_irq(s);
+        break;
+    case A_COMPARE0 ... A_COMPARE3:
+        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
+        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
+        break;
+    case A_COUNTER_LOW:
+    case A_COUNTER_HIGH:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only ofs 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps bcm2835_systmr_ops = {
+    .read = bcm2835_systmr_read,
+    .write = bcm2835_systmr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_systmr_reset(DeviceState *dev)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
+
+    memset(&s->reg, 0, sizeof(s->reg));
+}
+
+static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
+                          s, "bcm2835-sys-timer", 0x20);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static const VMStateDescription bcm2835_systmr_vmstate = {
+    .name = "bcm2835_sys_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
+        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_systmr_realize;
+    dc->reset = bcm2835_systmr_reset;
+    dc->vmsd = &bcm2835_systmr_vmstate;
+}
+
+static const TypeInfo bcm2835_systmr_info = {
+    .name = TYPE_BCM2835_SYSTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835SystemTimerState),
+    .class_init = bcm2835_systmr_class_init,
+};
+
+static void bcm2835_systmr_register_types(void)
+{
+    type_register_static(&bcm2835_systmr_info);
+}
+
+type_init(bcm2835_systmr_register_types);
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142cd..0aa399ac69a 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -87,3 +87,8 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# bcm2835_systmr.c
+bcm2835_systmr_irq(bool enable) "timer irq state %u"
+bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
+bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
-- 
2.20.1


