Received: from eggs.gnu.org ([2001:4830:134:3::10]:38653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKM-000256-KJ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKK-0003GU-GF
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:26 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33198)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-0003Fy-UG
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:24 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:13 +0200
Message-Id: <20180806100114.21410-7-contrib@steffen-goertz.de>
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] hw/timer/nrf51_timer: Add nRF51 Timer
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This patch adds the model for the nRF51 timer peripheral.
Currently, only the TIMER mode is implemented.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/timer/Makefile.objs         |   1 +
 hw/timer/nrf51_timer.c         | 382 +++++++++++++++++++++++++++++++++
 hw/timer/trace-events          |   5 +
 include/hw/timer/nrf51_timer.h |  63 ++++++
 4 files changed, 451 insertions(+)
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 include/hw/timer/nrf51_timer.h

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index e16b2b913c..18deca761e 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -23,6 +23,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
 common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
+common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
=20
 obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
 obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
new file mode 100644
index 0000000000..2119426b2c
--- /dev/null
+++ b/hw/timer/nrf51_timer.c
@@ -0,0 +1,382 @@
+/*
+ * nRF51 System-on-Chip Timer peripheral
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/timer/nrf51_timer.h"
+#include "trace.h"
+
+#define NRF51_TIMER_SIZE         0x1000
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
+#define NRF51_TIMER_EVENT_COMPARE_3 0x14C
+
+#define NRF51_TIMER_REG_SHORTS 0x200
+#define NRF51_TIMER_REG_SHORTS_MASK 0xf0f
+#define NRF51_TIMER_REG_INTENSET 0x304
+#define NRF51_TIMER_REG_INTENCLR 0x308
+#define NRF51_TIMER_REG_INTEN_MASK 0xf0000
+#define NRF51_TIMER_REG_MODE 0x504
+#define NRF51_TIMER_REG_MODE_MASK 0x01
+#define NRF51_TIMER_REG_BITMODE 0x508
+#define NRF51_TIMER_REG_BITMODE_MASK 0x03
+#define NRF51_TIMER_REG_PRESCALER 0x510
+#define NRF51_TIMER_REG_PRESCALER_MASK 0x0F
+#define NRF51_TIMER_REG_CC0 0x540
+#define NRF51_TIMER_REG_CC3 0x54C
+
+#define TIMER_CLK 16000000ULL
+
+/* Trigger */
+#define NRF51_TRIGGER_TASK 0x01
+
+/* Events */
+#define NRF51_EVENT_CLEAR  0x00
+
+static uint8_t const bitwidths[] =3D {16, 8, 24, 32};
+#define BWM(x) ((1UL << bitwidths[x]) - 1)
+
+static inline uint64_t ns_to_ticks(Nrf51TimerState *s, uint64_t ns)
+{
+    uint64_t t =3D NANOSECONDS_PER_SECOND * (1 << s->prescaler);
+    return muldiv64(ns, TIMER_CLK, t);
+}
+
+static inline uint64_t ticks_to_ns(Nrf51TimerState *s, uint64_t ticks)
+{
+    ticks *=3D (1 << s->prescaler);
+    return muldiv64(ticks, NANOSECONDS_PER_SECOND, TIMER_CLK);
+}
+
+static void update_irq(Nrf51TimerState *s)
+{
+    bool flag =3D false;
+    size_t i;
+
+    for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        flag |=3D s->events_compare[i] && extract32(s->inten, 16 + i, 1)=
;
+    }
+    qemu_set_irq(s->irq, flag);
+}
+
+static void update_events(Nrf51TimerState *s, uint64_t now)
+{
+    uint64_t strobe;
+    uint64_t tick;
+    uint64_t cc;
+    size_t i;
+    bool occured;
+
+    strobe =3D ns_to_ticks(s, now - s->last_visited);
+    tick =3D ns_to_ticks(s, s->last_visited - s->time_offset) & BWM(s->b=
itmode);
+
+    for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        cc =3D s->cc[i];
+
+        if (tick < cc) {
+            occured =3D (cc - tick) <=3D strobe;
+        } else {
+            occured =3D ((cc + (1UL << bitwidths[s->bitmode])) - tick) <=
=3D strobe;
+        }
+
+        s->events_compare[i] |=3D occured;
+    }
+
+    s->last_visited =3D now;
+}
+
+static int cmpfunc(const void *a, const void *b)
+{
+   return *(uint32_t *)a - *(uint32_t *)b;
+}
+
+static uint64_t get_next_timeout(Nrf51TimerState *s, uint64_t now)
+{
+    uint64_t r;
+    size_t idx;
+
+    uint64_t tick =3D (ns_to_ticks(s, now - s->time_offset)) & BWM(s->bi=
tmode);
+    int8_t next =3D -1;
+
+    for (idx =3D 0; idx < NRF51_TIMER_REG_COUNT; idx++) {
+        if (s->cc_sorted[idx] > tick) {
+            next =3D idx;
+            break;
+        }
+    }
+
+    if (next =3D=3D -1) {
+        r =3D s->cc_sorted[0] + (1UL << bitwidths[s->bitmode]);
+    } else {
+        r =3D s->cc_sorted[next];
+    }
+
+    return now + ticks_to_ns(s, r - tick);
+}
+
+static void update_internal_state(Nrf51TimerState *s, uint64_t now)
+{
+    if (s->runstate =3D=3D NRF51_TIMER_RUNNING) {
+        timer_mod(&s->timer, get_next_timeout(s, now));
+    } else {
+        timer_del(&s->timer);
+    }
+
+    update_irq(s);
+}
+
+static void timer_expire(void *opaque)
+{
+    Nrf51TimerState *s =3D NRF51_TIMER(opaque);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    update_events(s, now);
+    update_internal_state(s, now);
+}
+
+static uint64_t nrf51_timer_read(void *opaque, hwaddr offset, unsigned i=
nt size)
+{
+    Nrf51TimerState *s =3D NRF51_TIMER(opaque);
+    uint64_t r =3D 0;
+
+    switch (offset) {
+    case NRF51_TIMER_EVENT_COMPARE_0 ... NRF51_TIMER_EVENT_COMPARE_3:
+        r =3D s->events_compare[(offset - NRF51_TIMER_EVENT_COMPARE_0) /=
 4];
+        break;
+    case NRF51_TIMER_REG_SHORTS:
+        r =3D s->shorts;
+        break;
+    case NRF51_TIMER_REG_INTENSET:
+        r =3D s->inten;
+        break;
+    case NRF51_TIMER_REG_INTENCLR:
+        r =3D s->inten;
+        break;
+    case NRF51_TIMER_REG_MODE:
+        r =3D s->mode;
+        break;
+    case NRF51_TIMER_REG_BITMODE:
+        r =3D s->bitmode;
+        break;
+    case NRF51_TIMER_REG_PRESCALER:
+        r =3D s->prescaler;
+        break;
+    case NRF51_TIMER_REG_CC0 ... NRF51_TIMER_REG_CC3:
+        r =3D s->cc[(offset - NRF51_TIMER_REG_CC0) / 4];
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
+static inline void update_cc_sorted(Nrf51TimerState *s)
+{
+    memcpy(s->cc_sorted, s->cc, sizeof(s->cc_sorted));
+    qsort(s->cc_sorted, NRF51_TIMER_REG_COUNT, sizeof(uint32_t), cmpfunc=
);
+}
+
+static void nrf51_timer_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    Nrf51TimerState *s =3D NRF51_TIMER(opaque);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    size_t idx;
+
+    trace_nrf51_timer_write(offset, value, size);
+
+    switch (offset) {
+    case NRF51_TIMER_TASK_START:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->runstate =3D NRF51_TIMER_RUNNING;
+        }
+        break;
+    case NRF51_TIMER_TASK_STOP:
+    case NRF51_TIMER_TASK_SHUTDOWN:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->runstate =3D NRF51_TIMER_STOPPED;
+        }
+        break;
+    case NRF51_TIMER_TASK_COUNT:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            qemu_log_mask(LOG_UNIMP, "COUNTER mode not implemented\n");
+        }
+        break;
+    case NRF51_TIMER_TASK_CLEAR:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->time_offset =3D now;
+            s->last_visited =3D now;
+        }
+        break;
+    case NRF51_TIMER_TASK_CAPTURE_0 ... NRF51_TIMER_TASK_CAPTURE_3:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            idx =3D (offset - NRF51_TIMER_TASK_CAPTURE_0) / 4;
+            s->cc[idx] =3D ns_to_ticks(s, now - s->time_offset) & BWM(s-=
>bitmode);
+            update_cc_sorted(s);
+        }
+        break;
+    case NRF51_TIMER_EVENT_COMPARE_0 ... NRF51_TIMER_EVENT_COMPARE_3:
+        if (value =3D=3D NRF51_EVENT_CLEAR) {
+            s->events_compare[(offset - NRF51_TIMER_EVENT_COMPARE_0) / 4=
] =3D 0;
+        }
+        break;
+    case NRF51_TIMER_REG_SHORTS:
+        s->shorts =3D value & NRF51_TIMER_REG_SHORTS_MASK;
+        break;
+    case NRF51_TIMER_REG_INTENSET:
+        s->inten |=3D value & NRF51_TIMER_REG_INTEN_MASK;
+        break;
+    case NRF51_TIMER_REG_INTENCLR:
+        s->inten &=3D ~(value & NRF51_TIMER_REG_INTEN_MASK);
+        break;
+    case NRF51_TIMER_REG_MODE:
+        if (s->mode !=3D NRF51_TIMER_TIMER) {
+            qemu_log_mask(LOG_UNIMP, "COUNTER mode not implemented\n");
+            return;
+        }
+        s->mode =3D value;
+        break;
+    case NRF51_TIMER_REG_BITMODE:
+        if (s->mode =3D=3D NRF51_TIMER_TIMER && s->runstate !=3D NRF51_T=
IMER_STOPPED) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: erroneous change of BITMODE while timer is running\=
n",
+                __func__);
+        }
+        s->bitmode =3D value & NRF51_TIMER_REG_BITMODE_MASK;
+        s->time_offset =3D now;
+        s->last_visited =3D now;
+        break;
+    case NRF51_TIMER_REG_PRESCALER:
+        if (s->mode =3D=3D NRF51_TIMER_TIMER && s->runstate !=3D NRF51_T=
IMER_STOPPED) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: erroneous change of PRESCALER while timer is runnin=
g\n",
+                __func__);
+        }
+        s->prescaler =3D value & NRF51_TIMER_REG_PRESCALER_MASK;
+        s->time_offset =3D now;
+        s->last_visited =3D now;
+        break;
+    case NRF51_TIMER_REG_CC0 ... NRF51_TIMER_REG_CC3:
+        s->cc[(offset - NRF51_TIMER_REG_CC0) / 4] =3D value & BWM(s->bit=
mode);
+        update_cc_sorted(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    update_internal_state(s, now);
+}
+
+static const MemoryRegionOps rng_ops =3D {
+    .read =3D  nrf51_timer_read,
+    .write =3D nrf51_timer_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+};
+
+static void nrf51_timer_init(Object *obj)
+{
+    Nrf51TimerState *s =3D NRF51_TIMER(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
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
+    Nrf51TimerState *s =3D NRF51_TIMER(dev);
+
+    s->runstate =3D NRF51_TIMER_STOPPED;
+
+    memset(s->events_compare, 0x00, sizeof(s->events_compare));
+    memset(s->cc, 0x00, sizeof(s->cc));
+    memset(s->cc_sorted, 0x00, sizeof(s->cc_sorted));
+    s->shorts =3D 0x00;
+    s->inten =3D 0x00;
+    s->mode =3D 0x00;
+    s->bitmode =3D 0x00;
+    s->prescaler =3D 0x00;
+
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->time_offset =3D now;
+    s->last_visited =3D now;
+}
+
+static const VMStateDescription vmstate_nrf51_timer =3D {
+    .name =3D TYPE_NRF51_TIMER,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_TIMER(timer, Nrf51TimerState),
+        VMSTATE_UINT8(runstate, Nrf51TimerState),
+        VMSTATE_UINT64(time_offset, Nrf51TimerState),
+        VMSTATE_UINT64(last_visited, Nrf51TimerState),
+        VMSTATE_UINT8_ARRAY(events_compare, Nrf51TimerState,
+                            NRF51_TIMER_REG_COUNT),
+        VMSTATE_UINT32_ARRAY(cc, Nrf51TimerState, NRF51_TIMER_REG_COUNT)=
,
+        VMSTATE_UINT32_ARRAY(cc_sorted, Nrf51TimerState, NRF51_TIMER_REG=
_COUNT),
+        VMSTATE_UINT32(shorts, Nrf51TimerState),
+        VMSTATE_UINT32(inten, Nrf51TimerState),
+        VMSTATE_UINT32(mode, Nrf51TimerState),
+        VMSTATE_UINT32(bitmode, Nrf51TimerState),
+        VMSTATE_UINT32(prescaler, Nrf51TimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property nrf51_timer_properties[] =3D {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nrf51_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D nrf51_timer_properties;
+    dc->reset =3D nrf51_timer_reset;
+    dc->vmsd =3D &vmstate_nrf51_timer;
+}
+
+static const TypeInfo nrf51_timer_info =3D {
+    .name =3D TYPE_NRF51_TIMER,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(Nrf51TimerState),
+    .instance_init =3D nrf51_timer_init,
+    .class_init =3D nrf51_timer_class_init
+};
+
+static void nrf51_timer_register_types(void)
+{
+    type_register_static(&nrf51_timer_info);
+}
+
+type_init(nrf51_timer_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index e6e042fddb..91c20540a3 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -63,3 +63,8 @@ cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
=20
 # hw/timer/xlnx-zynqmp-rtc.c
 xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
+
+# hw/timer/nrf51_timer.c
+nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_time=
r.h
new file mode 100644
index 0000000000..a1278f17bd
--- /dev/null
+++ b/include/hw/timer/nrf51_timer.h
@@ -0,0 +1,63 @@
+/*
+* nRF51 System-on-Chip Timer peripheral
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: GPIO registers
+ * + sysbus irq
+ *
+ * Accuracy of the peripheral model:
+ * + Only TIMER mode is implemented, COUNTER mode is not implemented.
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
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
+#define NRF51_TIMER(obj) OBJECT_CHECK(Nrf51TimerState, (obj), TYPE_NRF51=
_TIMER)
+
+#define NRF51_TIMER_REG_COUNT 4
+
+typedef enum {
+    NRF51_TIMER_STOPPED =3D 0,
+    NRF51_TIMER_RUNNING
+} Nrf51TimerRunstate;
+
+typedef enum {
+    NRF51_TIMER_TIMER =3D 0,
+    NRF51_TIMER_COUNTER =3D 1
+} Nrf51TimerMode;
+
+typedef struct Nrf51TimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    QEMUTimer timer;
+
+    uint8_t runstate;
+
+    uint64_t time_offset;
+    uint64_t last_visited;
+
+    uint8_t events_compare[NRF51_TIMER_REG_COUNT];
+    uint32_t cc[NRF51_TIMER_REG_COUNT];
+    uint32_t cc_sorted[NRF51_TIMER_REG_COUNT];
+    uint32_t shorts;
+    uint32_t inten;
+    uint32_t mode;
+    uint32_t bitmode;
+    uint32_t prescaler;
+} Nrf51TimerState;
+
+
+#endif
--=20
2.18.0
