Received: from eggs.gnu.org ([209.51.188.92]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXou-0005Jj-Ev
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoq-0002Xp-PN
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXon-0002Qj-QE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:04 -0500
Received: by mail-wm1-x336.google.com with SMTP id g67so1520003wmd.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:11 +0000
Message-Id: <20190107163117.16269-32-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/37] hw/timer/nrf51_timer: Add nRF51 Timer
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

This patch adds the model for the nRF51 timer peripheral.
Currently, only the TIMER mode is implemented.

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-9-stefanha@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/Makefile.objs         |   1 +
 include/hw/timer/nrf51_timer.h |  80 +++++++
 hw/timer/nrf51_timer.c         | 393 +++++++++++++++++++++++++++++++++
 hw/timer/trace-events          |   5 +
 4 files changed, 479 insertions(+)
 create mode 100644 include/hw/timer/nrf51_timer.h
 create mode 100644 hw/timer/nrf51_timer.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index b32194d153d..0e9a4530f84 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -23,6 +23,7 @@ common-obj-$(CONFIG_IMX) += imx_gpt.o
 common-obj-$(CONFIG_LM32) += lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
+common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 
 obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_timer.h
new file mode 100644
index 00000000000..85cad2300df
--- /dev/null
+++ b/include/hw/timer/nrf51_timer.h
@@ -0,0 +1,80 @@
+/*
+ * nRF51 System-on-Chip Timer peripheral
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: GPIO registers
+ * + sysbus irq
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef NRF51_TIMER_H
+#define NRF51_TIMER_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#define TYPE_NRF51_TIMER "nrf51_soc.timer"
+#define NRF51_TIMER(obj) OBJECT_CHECK(NRF51TimerState, (obj), TYPE_NRF51_TIMER)
+
+#define NRF51_TIMER_REG_COUNT 4
+
+#define NRF51_TIMER_TASK_START 0x000
+#define NRF51_TIMER_TASK_STOP 0x004
+#define NRF51_TIMER_TASK_COUNT 0x008
+#define NRF51_TIMER_TASK_CLEAR 0x00C
+#define NRF51_TIMER_TASK_SHUTDOWN 0x010
+#define NRF51_TIMER_TASK_CAPTURE_0 0x040
+#define NRF51_TIMER_TASK_CAPTURE_3 0x04C
+
+#define NRF51_TIMER_EVENT_COMPARE_0 0x140
+#define NRF51_TIMER_EVENT_COMPARE_1 0x144
+#define NRF51_TIMER_EVENT_COMPARE_2 0x148
+#define NRF51_TIMER_EVENT_COMPARE_3 0x14C
+
+#define NRF51_TIMER_REG_SHORTS 0x200
+#define NRF51_TIMER_REG_SHORTS_MASK 0xf0f
+#define NRF51_TIMER_REG_INTENSET 0x304
+#define NRF51_TIMER_REG_INTENCLR 0x308
+#define NRF51_TIMER_REG_INTEN_MASK 0xf0000
+#define NRF51_TIMER_REG_MODE 0x504
+#define NRF51_TIMER_REG_MODE_MASK 0x01
+#define NRF51_TIMER_TIMER 0
+#define NRF51_TIMER_COUNTER 1
+#define NRF51_TIMER_REG_BITMODE 0x508
+#define NRF51_TIMER_REG_BITMODE_MASK 0x03
+#define NRF51_TIMER_WIDTH_16 0
+#define NRF51_TIMER_WIDTH_8 1
+#define NRF51_TIMER_WIDTH_24 2
+#define NRF51_TIMER_WIDTH_32 3
+#define NRF51_TIMER_REG_PRESCALER 0x510
+#define NRF51_TIMER_REG_PRESCALER_MASK 0x0F
+#define NRF51_TIMER_REG_CC0 0x540
+#define NRF51_TIMER_REG_CC3 0x54C
+
+typedef struct NRF51TimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    QEMUTimer timer;
+    int64_t timer_start_ns;
+    int64_t update_counter_ns;
+    uint32_t counter;
+
+    bool running;
+
+    uint8_t events_compare[NRF51_TIMER_REG_COUNT];
+    uint32_t cc[NRF51_TIMER_REG_COUNT];
+    uint32_t shorts;
+    uint32_t inten;
+    uint32_t mode;
+    uint32_t bitmode;
+    uint32_t prescaler;
+
+} NRF51TimerState;
+
+
+#endif
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
new file mode 100644
index 00000000000..0c90662896e
--- /dev/null
+++ b/hw/timer/nrf51_timer.c
@@ -0,0 +1,393 @@
+/*
+ * nRF51 System-on-Chip Timer peripheral
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.pdf
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/arm/nrf51.h"
+#include "hw/timer/nrf51_timer.h"
+#include "trace.h"
+
+#define TIMER_CLK_FREQ 16000000UL
+
+static uint32_t const bitwidths[] = {16, 8, 24, 32};
+
+static uint32_t ns_to_ticks(NRF51TimerState *s, int64_t ns)
+{
+    uint32_t freq = TIMER_CLK_FREQ >> s->prescaler;
+
+    return muldiv64(ns, freq, NANOSECONDS_PER_SECOND);
+}
+
+static int64_t ticks_to_ns(NRF51TimerState *s, uint32_t ticks)
+{
+    uint32_t freq = TIMER_CLK_FREQ >> s->prescaler;
+
+    return muldiv64(ticks, NANOSECONDS_PER_SECOND, freq);
+}
+
+/* Returns number of ticks since last call */
+static uint32_t update_counter(NRF51TimerState *s, int64_t now)
+{
+    uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
+
+    s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
+    s->update_counter_ns = now;
+    return ticks;
+}
+
+/* Assumes s->counter is up-to-date */
+static void rearm_timer(NRF51TimerState *s, int64_t now)
+{
+    int64_t min_ns = INT64_MAX;
+    size_t i;
+
+    for (i = 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        int64_t delta_ns;
+
+        if (s->events_compare[i]) {
+            continue; /* already expired, ignore it for now */
+        }
+
+        if (s->cc[i] <= s->counter) {
+            delta_ns = ticks_to_ns(s, BIT(bitwidths[s->bitmode]) -
+                                      s->counter + s->cc[i]);
+        } else {
+            delta_ns = ticks_to_ns(s, s->cc[i] - s->counter);
+        }
+
+        if (delta_ns < min_ns) {
+            min_ns = delta_ns;
+        }
+    }
+
+    if (min_ns != INT64_MAX) {
+        timer_mod_ns(&s->timer, now + min_ns);
+    }
+}
+
+static void update_irq(NRF51TimerState *s)
+{
+    bool flag = false;
+    size_t i;
+
+    for (i = 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        flag |= s->events_compare[i] && extract32(s->inten, 16 + i, 1);
+    }
+    qemu_set_irq(s->irq, flag);
+}
+
+static void timer_expire(void *opaque)
+{
+    NRF51TimerState *s = NRF51_TIMER(opaque);
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint32_t cc_remaining[NRF51_TIMER_REG_COUNT];
+    bool should_stop = false;
+    uint32_t ticks;
+    size_t i;
+
+    for (i = 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        if (s->cc[i] > s->counter) {
+            cc_remaining[i] = s->cc[i] - s->counter;
+        } else {
+            cc_remaining[i] = BIT(bitwidths[s->bitmode]) -
+                              s->counter + s->cc[i];
+        }
+    }
+
+    ticks = update_counter(s, now);
+
+    for (i = 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        if (cc_remaining[i] <= ticks) {
+            s->events_compare[i] = 1;
+
+            if (s->shorts & BIT(i)) {
+                s->timer_start_ns = now;
+                s->update_counter_ns = s->timer_start_ns;
+                s->counter = 0;
+            }
+
+            should_stop |= s->shorts & BIT(i + 8);
+        }
+    }
+
+    update_irq(s);
+
+    if (should_stop) {
+        s->running = false;
+        timer_del(&s->timer);
+    } else {
+        rearm_timer(s, now);
+    }
+}
+
+static void counter_compare(NRF51TimerState *s)
+{
+    uint32_t counter = s->counter;
+    size_t i;
+
+    for (i = 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        if (counter == s->cc[i]) {
+            s->events_compare[i] = 1;
+
+            if (s->shorts & BIT(i)) {
+                s->counter = 0;
+            }
+        }
+    }
+}
+
+static uint64_t nrf51_timer_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    NRF51TimerState *s = NRF51_TIMER(opaque);
+    uint64_t r = 0;
+
+    switch (offset) {
+    case NRF51_TIMER_EVENT_COMPARE_0 ... NRF51_TIMER_EVENT_COMPARE_3:
+        r = s->events_compare[(offset - NRF51_TIMER_EVENT_COMPARE_0) / 4];
+        break;
+    case NRF51_TIMER_REG_SHORTS:
+        r = s->shorts;
+        break;
+    case NRF51_TIMER_REG_INTENSET:
+        r = s->inten;
+        break;
+    case NRF51_TIMER_REG_INTENCLR:
+        r = s->inten;
+        break;
+    case NRF51_TIMER_REG_MODE:
+        r = s->mode;
+        break;
+    case NRF51_TIMER_REG_BITMODE:
+        r = s->bitmode;
+        break;
+    case NRF51_TIMER_REG_PRESCALER:
+        r = s->prescaler;
+        break;
+    case NRF51_TIMER_REG_CC0 ... NRF51_TIMER_REG_CC3:
+        r = s->cc[(offset - NRF51_TIMER_REG_CC0) / 4];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    trace_nrf51_timer_read(offset, r, size);
+
+    return r;
+}
+
+static void nrf51_timer_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    NRF51TimerState *s = NRF51_TIMER(opaque);
+    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    size_t idx;
+
+    trace_nrf51_timer_write(offset, value, size);
+
+    switch (offset) {
+    case NRF51_TIMER_TASK_START:
+        if (value == NRF51_TRIGGER_TASK && s->mode == NRF51_TIMER_TIMER) {
+            s->running = true;
+            s->timer_start_ns = now - ticks_to_ns(s, s->counter);
+            s->update_counter_ns = s->timer_start_ns;
+            rearm_timer(s, now);
+        }
+        break;
+    case NRF51_TIMER_TASK_STOP:
+    case NRF51_TIMER_TASK_SHUTDOWN:
+        if (value == NRF51_TRIGGER_TASK) {
+            s->running = false;
+            timer_del(&s->timer);
+        }
+        break;
+    case NRF51_TIMER_TASK_COUNT:
+        if (value == NRF51_TRIGGER_TASK && s->mode == NRF51_TIMER_COUNTER) {
+            s->counter = (s->counter + 1) % BIT(bitwidths[s->bitmode]);
+            counter_compare(s);
+        }
+        break;
+    case NRF51_TIMER_TASK_CLEAR:
+        if (value == NRF51_TRIGGER_TASK) {
+            s->timer_start_ns = now;
+            s->update_counter_ns = s->timer_start_ns;
+            s->counter = 0;
+            if (s->running) {
+                rearm_timer(s, now);
+            }
+        }
+        break;
+    case NRF51_TIMER_TASK_CAPTURE_0 ... NRF51_TIMER_TASK_CAPTURE_3:
+        if (value == NRF51_TRIGGER_TASK) {
+            if (s->running) {
+                timer_expire(s); /* update counter and all state */
+            }
+
+            idx = (offset - NRF51_TIMER_TASK_CAPTURE_0) / 4;
+            s->cc[idx] = s->counter;
+        }
+        break;
+    case NRF51_TIMER_EVENT_COMPARE_0 ... NRF51_TIMER_EVENT_COMPARE_3:
+        if (value == NRF51_EVENT_CLEAR) {
+            s->events_compare[(offset - NRF51_TIMER_EVENT_COMPARE_0) / 4] = 0;
+
+            if (s->running) {
+                timer_expire(s); /* update counter and all state */
+            }
+        }
+        break;
+    case NRF51_TIMER_REG_SHORTS:
+        s->shorts = value & NRF51_TIMER_REG_SHORTS_MASK;
+        break;
+    case NRF51_TIMER_REG_INTENSET:
+        s->inten |= value & NRF51_TIMER_REG_INTEN_MASK;
+        break;
+    case NRF51_TIMER_REG_INTENCLR:
+        s->inten &= ~(value & NRF51_TIMER_REG_INTEN_MASK);
+        break;
+    case NRF51_TIMER_REG_MODE:
+        s->mode = value;
+        break;
+    case NRF51_TIMER_REG_BITMODE:
+        if (s->mode == NRF51_TIMER_TIMER && s->running) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: erroneous change of BITMODE while timer is running\n",
+                    __func__);
+        }
+        s->bitmode = value & NRF51_TIMER_REG_BITMODE_MASK;
+        break;
+    case NRF51_TIMER_REG_PRESCALER:
+        if (s->mode == NRF51_TIMER_TIMER && s->running) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: erroneous change of PRESCALER while timer is running\n",
+                __func__);
+        }
+        s->prescaler = value & NRF51_TIMER_REG_PRESCALER_MASK;
+        break;
+    case NRF51_TIMER_REG_CC0 ... NRF51_TIMER_REG_CC3:
+        if (s->running) {
+            timer_expire(s); /* update counter */
+        }
+
+        idx = (offset - NRF51_TIMER_REG_CC0) / 4;
+        s->cc[idx] = value % BIT(bitwidths[s->bitmode]);
+
+        if (s->running) {
+            rearm_timer(s, now);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    update_irq(s);
+}
+
+static const MemoryRegionOps rng_ops = {
+    .read =  nrf51_timer_read,
+    .write = nrf51_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static void nrf51_timer_init(Object *obj)
+{
+    NRF51TimerState *s = NRF51_TIMER(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rng_ops, s,
+            TYPE_NRF51_TIMER, NRF51_TIMER_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    timer_init_ns(&s->timer, QEMU_CLOCK_VIRTUAL, timer_expire, s);
+}
+
+static void nrf51_timer_reset(DeviceState *dev)
+{
+    NRF51TimerState *s = NRF51_TIMER(dev);
+
+    timer_del(&s->timer);
+    s->timer_start_ns = 0x00;
+    s->update_counter_ns = 0x00;
+    s->counter = 0x00;
+    s->running = false;
+
+    memset(s->events_compare, 0x00, sizeof(s->events_compare));
+    memset(s->cc, 0x00, sizeof(s->cc));
+
+    s->shorts = 0x00;
+    s->inten = 0x00;
+    s->mode = 0x00;
+    s->bitmode = 0x00;
+    s->prescaler = 0x00;
+}
+
+static int nrf51_timer_post_load(void *opaque, int version_id)
+{
+    NRF51TimerState *s = NRF51_TIMER(opaque);
+
+    if (s->running && s->mode == NRF51_TIMER_TIMER) {
+        timer_expire(s);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_nrf51_timer = {
+    .name = TYPE_NRF51_TIMER,
+    .version_id = 1,
+    .post_load = nrf51_timer_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER(timer, NRF51TimerState),
+        VMSTATE_INT64(timer_start_ns, NRF51TimerState),
+        VMSTATE_INT64(update_counter_ns, NRF51TimerState),
+        VMSTATE_UINT32(counter, NRF51TimerState),
+        VMSTATE_BOOL(running, NRF51TimerState),
+        VMSTATE_UINT8_ARRAY(events_compare, NRF51TimerState,
+                            NRF51_TIMER_REG_COUNT),
+        VMSTATE_UINT32_ARRAY(cc, NRF51TimerState, NRF51_TIMER_REG_COUNT),
+        VMSTATE_UINT32(shorts, NRF51TimerState),
+        VMSTATE_UINT32(inten, NRF51TimerState),
+        VMSTATE_UINT32(mode, NRF51TimerState),
+        VMSTATE_UINT32(bitmode, NRF51TimerState),
+        VMSTATE_UINT32(prescaler, NRF51TimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void nrf51_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = nrf51_timer_reset;
+    dc->vmsd = &vmstate_nrf51_timer;
+}
+
+static const TypeInfo nrf51_timer_info = {
+    .name = TYPE_NRF51_TIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NRF51TimerState),
+    .instance_init = nrf51_timer_init,
+    .class_init = nrf51_timer_class_init
+};
+
+static void nrf51_timer_register_types(void)
+{
+    type_register_static(&nrf51_timer_info);
+}
+
+type_init(nrf51_timer_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 75bd3b1042a..0144a68951c 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -72,3 +72,8 @@ sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value
 
 # hw/timer/xlnx-zynqmp-rtc.c
 xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
+
+# hw/timer/nrf51_timer.c
+nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
-- 
2.19.2
