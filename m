Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10CDC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEDF20873
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRfqIlaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEDF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vrp-0003ny-Oy
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqP-0001wZ-Bz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqN-0000HS-AG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:37 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:37441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1vqN-0000Gv-2g
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:35 -0500
Received: by mail-pf1-x42c.google.com with SMTP id p14so1574467pfn.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=t+heuPCnD3JsKvwBY/MCThDAT9aQxwgT2Kl/rkMM4J0=;
 b=CRfqIlaRGARmD6Z7Q5SiFgZYvbISys/HS8tWZtvgExar6REnm+8pH3rPXkJWM9vERO
 bHecSJUSurctfaIxC6oGSuNA2TeO+4tKp2f+mkQ2GBKN+GSuuC6HBQ52WKy2dLomT5ra
 HBq+QW8XhCR5WSIkXYbmc+YvoqHU2mnNQ5JcCP5bbff+Bz+Tuo1HtzyiFU6rOmTD/Qip
 lzQUCcCHd2L+0RLG0mXg+zsQthl6QOPtLgMRWPHxlE1XRxMBIeSYA/RiHRnFE6XFSMVs
 23Xn4AgWy3C77Hv1fGmZMqc209Kx5ZbWB7/mtv8oSMpk4bbXhN8/0rk+/2bQJ6LxA24T
 J8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=t+heuPCnD3JsKvwBY/MCThDAT9aQxwgT2Kl/rkMM4J0=;
 b=NiRBjaqQq0V5o/hFcDzsySX97hWNPHqcgztIgmxgKq0AcD3n9sH7zq/j1xJd1qzfq7
 yXMBJdcUeGkEXYf4HDhZHKQ15Le65bDJ0PBX7RI6JMNAuwL0NpbyY+VxJKxbYbBmGfKU
 4HTNEcHeK5ctxeUDLJct7EF3wzCJTbPJv0B8LpZyuIxegLTvb1sYx/+IUtybf2yh26bc
 A8nT2/ZHWDCAlg0TrzMwMyagmHecNinzwgmOY5ffW6GkIJIOxaRp0dYd4GnaO5yAyk+d
 S25Fjx8petsbn9LmWKTInQs8vggpipWoXFDuy3Uifxau8P3PcIXhwZZA31JhBCicvLoX
 SXXQ==
X-Gm-Message-State: APjAAAWOXwHp//on7PJLiHfVBp25R89cErqe3z8b02SvuuhByNn4uGce
 e0fJpnfx01Z8KWb1DWRbSGRpDz6JLxI=
X-Google-Smtp-Source: APXvYqwPL7+79o+6+edrJdOlszBmcVMIEO86MJYhINBtyWvKjN+QhVMeZq7w4ifykEy1SsKfSKW/bQ==
X-Received: by 2002:a63:d441:: with SMTP id i1mr10151548pgj.426.1581528633503; 
 Wed, 12 Feb 2020 09:30:33 -0800 (PST)
Received: from localhost ([2620:0:1000:fd28:dc94:91b3:e554:4ae7])
 by smtp.gmail.com with ESMTPSA id c19sm1676980pfc.144.2020.02.12.09.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 09:30:32 -0800 (PST)
Subject: [PULL 3/5] hw: rtc: Add Goldfish RTC device
Date: Wed, 12 Feb 2020 09:29:19 -0800
Message-Id: <20200212172921.36796-4-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212172921.36796-1-palmerdabbelt@google.com>
References: <20200212172921.36796-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Anup Patel <Anup.Patel@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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

From: Anup Patel <Anup.Patel@wdc.com>

This patch adds model for Google Goldfish virtual platform RTC device.

We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
for providing real date-time to Guest Linux. The corresponding Linux
driver for Goldfish RTC device is already available in upstream Linux.

For now, VM migration support is available but untested for Goldfish RTC
device. It will be hardened in-future when we implement VM migration for
KVM RISC-V.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 285 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 5 files changed, 339 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 3dc2dd6888..f06e133b8a 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -22,3 +22,6 @@ config MC146818RTC
 
 config SUN4V_RTC
     bool
+
+config GOLDFISH_RTC
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 8dc9fcd3a9..aa208d0d10 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
+common-obj-$(CONFIG_GOLDFISH_RTC) += goldfish_rtc.o
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
new file mode 100644
index 0000000000..01e9d2b083
--- /dev/null
+++ b/hw/rtc/goldfish_rtc.c
@@ -0,0 +1,285 @@
+/*
+ * Goldfish virtual platform RTC
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * For more details on Google Goldfish virtual platform refer:
+ * https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-2.0-release/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/rtc/goldfish_rtc.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+
+#include "trace.h"
+
+#define RTC_TIME_LOW            0x00
+#define RTC_TIME_HIGH           0x04
+#define RTC_ALARM_LOW           0x08
+#define RTC_ALARM_HIGH          0x0c
+#define RTC_IRQ_ENABLED         0x10
+#define RTC_CLEAR_ALARM         0x14
+#define RTC_ALARM_STATUS        0x18
+#define RTC_CLEAR_INTERRUPT     0x1c
+
+static void goldfish_rtc_update(GoldfishRTCState *s)
+{
+    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
+}
+
+static void goldfish_rtc_interrupt(void *opaque)
+{
+    GoldfishRTCState *s = (GoldfishRTCState *)opaque;
+
+    s->alarm_running = 0;
+    s->irq_pending = 1;
+    goldfish_rtc_update(s);
+}
+
+static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
+{
+    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
+}
+
+static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
+{
+    timer_del(s->timer);
+    s->alarm_running = 0;
+}
+
+static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
+{
+    uint64_t ticks = goldfish_rtc_get_count(s);
+    uint64_t event = s->alarm_next;
+
+    if (event <= ticks) {
+        goldfish_rtc_clear_alarm(s);
+        goldfish_rtc_interrupt(s);
+    } else {
+        /*
+         * We should be setting timer expiry to:
+         *     qemu_clock_get_ns(rtc_clock) + (event - ticks)
+         * but this is equivalent to:
+         *     event - s->tick_offset
+         */
+        timer_mod(s->timer, event - s->tick_offset);
+        s->alarm_running = 1;
+    }
+}
+
+static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
+                                  unsigned size)
+{
+    GoldfishRTCState *s = opaque;
+    uint64_t r = 0;
+
+    switch (offset) {
+    case RTC_TIME_LOW:
+        r = goldfish_rtc_get_count(s) & 0xffffffff;
+        break;
+    case RTC_TIME_HIGH:
+        r = goldfish_rtc_get_count(s) >> 32;
+        break;
+    case RTC_ALARM_LOW:
+        r = s->alarm_next & 0xffffffff;
+        break;
+    case RTC_ALARM_HIGH:
+        r = s->alarm_next >> 32;
+        break;
+    case RTC_IRQ_ENABLED:
+        r = s->irq_enabled;
+        break;
+    case RTC_ALARM_STATUS:
+        r = s->alarm_running;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: offset 0x%x is UNIMP.\n", __func__, (uint32_t)offset);
+        break;
+    }
+
+    trace_goldfish_rtc_read(offset, r);
+
+    return r;
+}
+
+static void goldfish_rtc_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    GoldfishRTCState *s = opaque;
+    uint64_t current_tick, new_tick;
+
+    switch (offset) {
+    case RTC_TIME_LOW:
+        current_tick = goldfish_rtc_get_count(s);
+        new_tick = deposit64(current_tick, 0, 32, value);
+        s->tick_offset += new_tick - current_tick;
+        break;
+    case RTC_TIME_HIGH:
+        current_tick = goldfish_rtc_get_count(s);
+        new_tick = deposit64(current_tick, 32, 32, value);
+        s->tick_offset += new_tick - current_tick;
+        break;
+    case RTC_ALARM_LOW:
+        s->alarm_next = deposit64(s->alarm_next, 0, 32, value);
+        goldfish_rtc_set_alarm(s);
+        break;
+    case RTC_ALARM_HIGH:
+        s->alarm_next = deposit64(s->alarm_next, 32, 32, value);
+        break;
+    case RTC_IRQ_ENABLED:
+        s->irq_enabled = (uint32_t)(value & 0x1);
+        goldfish_rtc_update(s);
+        break;
+    case RTC_CLEAR_ALARM:
+        goldfish_rtc_clear_alarm(s);
+        break;
+    case RTC_CLEAR_INTERRUPT:
+        s->irq_pending = 0;
+        goldfish_rtc_update(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: offset 0x%x is UNIMP.\n", __func__, (uint32_t)offset);
+        break;
+    }
+
+    trace_goldfish_rtc_write(offset, value);
+}
+
+static int goldfish_rtc_pre_save(void *opaque)
+{
+    uint64_t delta;
+    GoldfishRTCState *s = opaque;
+
+    /*
+     * We want to migrate this offset, which sounds straightforward.
+     * Unfortunately, we cannot directly pass tick_offset because
+     * rtc_clock on destination Host might not be same source Host.
+     *
+     * To tackle, this we pass tick_offset relative to vm_clock from
+     * source Host and make it relative to rtc_clock at destination Host.
+     */
+    delta = qemu_clock_get_ns(rtc_clock) -
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tick_offset_vmstate = s->tick_offset + delta;
+
+    return 0;
+}
+
+static int goldfish_rtc_post_load(void *opaque, int version_id)
+{
+    uint64_t delta;
+    GoldfishRTCState *s = opaque;
+
+    /*
+     * We extract tick_offset from tick_offset_vmstate by doing
+     * reverse math compared to pre_save() function.
+     */
+    delta = qemu_clock_get_ns(rtc_clock) -
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tick_offset = s->tick_offset_vmstate - delta;
+
+    return 0;
+}
+
+static const MemoryRegionOps goldfish_rtc_ops = {
+    .read = goldfish_rtc_read,
+    .write = goldfish_rtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static const VMStateDescription goldfish_rtc_vmstate = {
+    .name = TYPE_GOLDFISH_RTC,
+    .version_id = 1,
+    .pre_save = goldfish_rtc_pre_save,
+    .post_load = goldfish_rtc_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
+        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
+        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
+        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
+        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void goldfish_rtc_reset(DeviceState *dev)
+{
+    GoldfishRTCState *s = GOLDFISH_RTC(dev);
+    struct tm tm;
+
+    timer_del(s->timer);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm);
+    s->tick_offset *= NANOSECONDS_PER_SECOND;
+    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
+    s->tick_offset_vmstate = 0;
+    s->alarm_next = 0;
+    s->alarm_running = 0;
+    s->irq_pending = 0;
+    s->irq_enabled = 0;
+}
+
+static void goldfish_rtc_realize(DeviceState *d, Error **errp)
+{
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
+    GoldfishRTCState *s = GOLDFISH_RTC(d);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
+                          "goldfish_rtc", 0x24);
+    sysbus_init_mmio(dev, &s->iomem);
+
+    sysbus_init_irq(dev, &s->irq);
+
+    s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+}
+
+static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = goldfish_rtc_realize;
+    dc->reset = goldfish_rtc_reset;
+    dc->vmsd = &goldfish_rtc_vmstate;
+}
+
+static const TypeInfo goldfish_rtc_info = {
+    .name          = TYPE_GOLDFISH_RTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(GoldfishRTCState),
+    .class_init    = goldfish_rtc_class_init,
+};
+
+static void goldfish_rtc_register_types(void)
+{
+    type_register_static(&goldfish_rtc_info);
+}
+
+type_init(goldfish_rtc_register_types)
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 52c1566198..c9894e1747 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -23,3 +23,7 @@ m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" PRIx64
 m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx64 " value:0x%02" PRIx64
 m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
 m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
+
+# goldfish_rtc.c
+goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
new file mode 100644
index 0000000000..16f9f9e29d
--- /dev/null
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -0,0 +1,46 @@
+/*
+ * Goldfish virtual platform RTC
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * For more details on Google Goldfish virtual platform refer:
+ * https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RTC_GOLDFISH_RTC_H
+#define HW_RTC_GOLDFISH_RTC_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_GOLDFISH_RTC "goldfish_rtc"
+#define GOLDFISH_RTC(obj) \
+    OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
+
+typedef struct GoldfishRTCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    qemu_irq irq;
+
+    uint64_t tick_offset;
+    uint64_t tick_offset_vmstate;
+    uint64_t alarm_next;
+    uint32_t alarm_running;
+    uint32_t irq_pending;
+    uint32_t irq_enabled;
+} GoldfishRTCState;
+
+#endif
-- 
2.25.0.225.g125e21ebc7-goog


