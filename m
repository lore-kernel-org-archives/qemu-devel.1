Received: from eggs.gnu.org ([2001:4830:134:3::10]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz6-0006ko-QR
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz2-0002kk-MY
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:04 -0500
Received: from steffen-goertz.de ([88.198.119.201]:35606)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJz2-0002dh-9R
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:00 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:21 -0500
Message-Id: <20181112214224.31560-12-contrib@steffen-goertz.de>
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 11/14] hw/timer/nrf51_timer: Add nRF51 Timer
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This patch adds the model for the nRF51 timer peripheral.
Currently, only the TIMER mode is implemented.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/timer/Makefile.objs         |   1 +
 hw/timer/nrf51_timer.c         | 337 +++++++++++++++++++++++++++++++++
 hw/timer/trace-events          |   5 +
 include/hw/timer/nrf51_timer.h |  81 ++++++++
 4 files changed, 424 insertions(+)
 create mode 100644 hw/timer/nrf51_timer.c
 create mode 100644 include/hw/timer/nrf51_timer.h

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index b32194d153..0e9a4530f8 100644
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
index 0000000000..40a41ab22c
--- /dev/null
+++ b/hw/timer/nrf51_timer.c
@@ -0,0 +1,337 @@
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
+#include "hw/arm/nrf51.h"
+#include "hw/timer/nrf51_timer.h"
+#include "trace.h"
+
+#define MINIMUM_PERIOD 10000UL
+#define TIMER_TICK_PS 62500UL
+
+static uint32_t const bitwidths[] =3D {16, 8, 24, 32};
+
+static void set_prescaler(NRF51TimerState *s, uint32_t prescaler)
+{
+    uint64_t period;
+    s->prescaler =3D prescaler;
+
+    period =3D ((1UL << s->prescaler) * TIMER_TICK_PS) / 1000;
+    /* Limit minimum timeout period to 10us to allow some progress */
+    if (period < MINIMUM_PERIOD) {
+        s->tick_period =3D MINIMUM_PERIOD;
+        s->counter_inc =3D MINIMUM_PERIOD / period;
+    } else {
+        s->tick_period =3D period;
+        s->counter_inc =3D 1;
+    }
+}
+
+static void update_irq(NRF51TimerState *s)
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
+static void timer_expire(void *opaque)
+{
+    NRF51TimerState *s =3D NRF51_TIMER(opaque);
+    bool should_stop =3D false;
+    uint32_t counter =3D s->counter;
+    size_t i;
+    uint64_t diff;
+
+    if (s->running) {
+        for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
+            if (counter < s->cc[i]) {
+                diff =3D s->cc[i] - counter;
+            } else {
+                diff =3D (s->cc[i] + BIT(bitwidths[s->bitmode])) - count=
er;
+            }
+
+            if (diff <=3D s->counter_inc) {
+                s->events_compare[i] =3D true;
+
+                if (s->shorts & BIT(i)) {
+                    s->counter =3D 0;
+                }
+
+                should_stop |=3D s->shorts & BIT(i + 8);
+            }
+        }
+
+        s->counter +=3D s->counter_inc;
+        s->counter &=3D (BIT(bitwidths[s->bitmode]) - 1);
+
+        update_irq(s);
+
+        if (should_stop) {
+            s->running =3D false;
+            timer_del(&s->timer);
+        } else {
+            s->time_offset +=3D s->tick_period;
+            timer_mod_ns(&s->timer, s->time_offset);
+        }
+    } else {
+        timer_del(&s->timer);
+    }
+}
+
+static void counter_compare(NRF51TimerState *s)
+{
+    uint32_t counter =3D s->counter;
+    size_t i;
+    for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
+        if (counter =3D=3D s->cc[i]) {
+            s->events_compare[i] =3D true;
+
+            if (s->shorts & BIT(i)) {
+                s->counter =3D 0;
+            }
+        }
+    }
+}
+
+static uint64_t nrf51_timer_read(void *opaque, hwaddr offset, unsigned i=
nt size)
+{
+    NRF51TimerState *s =3D NRF51_TIMER(opaque);
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
+static void nrf51_timer_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    NRF51TimerState *s =3D NRF51_TIMER(opaque);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    size_t idx;
+
+    trace_nrf51_timer_write(offset, value, size);
+
+    switch (offset) {
+    case NRF51_TIMER_TASK_START:
+        if (value =3D=3D NRF51_TRIGGER_TASK && s->mode =3D=3D NRF51_TIME=
R_TIMER) {
+            s->running =3D true;
+            s->time_offset =3D now + s->tick_period;
+            timer_mod_ns(&s->timer, s->time_offset);
+        }
+        break;
+    case NRF51_TIMER_TASK_STOP:
+    case NRF51_TIMER_TASK_SHUTDOWN:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->running =3D false;
+            timer_del(&s->timer);
+        }
+        break;
+    case NRF51_TIMER_TASK_COUNT:
+        if (value =3D=3D NRF51_TRIGGER_TASK && s->mode =3D=3D NRF51_TIME=
R_COUNTER) {
+            s->counter =3D (s->counter + 1) & (BIT(bitwidths[s->bitmode]=
) - 1);
+            counter_compare(s);
+        }
+        break;
+    case NRF51_TIMER_TASK_CLEAR:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->counter =3D 0;
+        }
+        break;
+    case NRF51_TIMER_TASK_CAPTURE_0 ... NRF51_TIMER_TASK_CAPTURE_3:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            idx =3D (offset - NRF51_TIMER_TASK_CAPTURE_0) / 4;
+            s->cc[idx] =3D s->counter;
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
+        s->mode =3D value;
+        break;
+    case NRF51_TIMER_REG_BITMODE:
+        if (s->mode =3D=3D NRF51_TIMER_TIMER && s->running) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: erroneous change of BITMODE while timer is runn=
ing\n",
+                    __func__);
+        }
+        s->bitmode =3D value & NRF51_TIMER_REG_BITMODE_MASK;
+        break;
+    case NRF51_TIMER_REG_PRESCALER:
+        if (s->mode =3D=3D NRF51_TIMER_TIMER && s->running) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: erroneous change of PRESCALER while timer is runnin=
g\n",
+                __func__);
+        }
+        set_prescaler(s, value & NRF51_TIMER_REG_PRESCALER_MASK);
+        break;
+    case NRF51_TIMER_REG_CC0 ... NRF51_TIMER_REG_CC3:
+        idx =3D (offset - NRF51_TIMER_REG_CC0) / 4;
+        s->cc[idx] =3D value & (BIT(bitwidths[s->bitmode]) - 1);
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
+    NRF51TimerState *s =3D NRF51_TIMER(obj);
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
+    NRF51TimerState *s =3D NRF51_TIMER(dev);
+
+    timer_del(&s->timer);
+    s->time_offset =3D 0x00;
+    s->counter =3D 0x00;
+    s->counter_inc =3D 0x00;
+    s->tick_period =3D 0x00;
+    s->running =3D false;
+
+    memset(s->events_compare, 0x00, sizeof(s->events_compare));
+    memset(s->cc, 0x00, sizeof(s->cc));
+
+    s->shorts =3D 0x00;
+    s->inten =3D 0x00;
+    s->mode =3D 0x00;
+    s->bitmode =3D 0x00;
+    set_prescaler(s, 0x00);
+}
+
+static int nrf51_timer_post_load(void *opaque, int version_id)
+{
+    NRF51TimerState *s =3D NRF51_TIMER(opaque);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (s->running && s->mode =3D=3D NRF51_TIMER_TIMER) {
+        s->time_offset =3D now;
+        timer_mod_ns(&s->timer, s->time_offset);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_nrf51_timer =3D {
+    .name =3D TYPE_NRF51_TIMER,
+    .version_id =3D 1,
+    .post_load =3D nrf51_timer_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_TIMER(timer, NRF51TimerState),
+        VMSTATE_INT64(time_offset, NRF51TimerState),
+        VMSTATE_UINT32(counter, NRF51TimerState),
+        VMSTATE_UINT32(counter_inc, NRF51TimerState),
+        VMSTATE_UINT64(tick_period, NRF51TimerState),
+        VMSTATE_BOOL(running, NRF51TimerState),
+        VMSTATE_UINT8_ARRAY(events_compare, NRF51TimerState,
+                            NRF51_TIMER_REG_COUNT),
+        VMSTATE_UINT32_ARRAY(cc, NRF51TimerState, NRF51_TIMER_REG_COUNT)=
,
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
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D nrf51_timer_reset;
+    dc->vmsd =3D &vmstate_nrf51_timer;
+}
+
+static const TypeInfo nrf51_timer_info =3D {
+    .name =3D TYPE_NRF51_TIMER,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(NRF51TimerState),
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
index 75bd3b1042..0144a68951 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -72,3 +72,8 @@ sun4v_rtc_write(uint64_t addr, uint64_t value) "write: =
addr 0x%" PRIx64 " value
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
index 0000000000..3b8cd6c6f3
--- /dev/null
+++ b/include/hw/timer/nrf51_timer.h
@@ -0,0 +1,81 @@
+/*
+ * nRF51 System-on-Chip Timer peripheral
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: GPIO registers
+ * + sysbus irq
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
+#define NRF51_TIMER(obj) OBJECT_CHECK(NRF51TimerState, (obj), TYPE_NRF51=
_TIMER)
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
+    int64_t time_offset;
+    uint32_t counter;
+    uint32_t counter_inc;
+    uint64_t tick_period;
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
--=20
2.19.1
