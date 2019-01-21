Received: from eggs.gnu.org ([209.51.188.92]:45075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRT-0006e0-8U
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRQ-0004HK-Pu
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:43 -0500
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:35851)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRK-00043c-Nk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:38 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 21 Jan 2019 22:15:58 +0900
Message-Id: <20190121131602.55003-8-ysato@users.sourceforge.jp>
In-Reply-To: <20190121131602.55003-1-ysato@users.sourceforge.jp>
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC 07/11] RX62N internal timer unit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

renesas_tmr: 8bit timer modules.
renesas_cmt: 16bit compare match timer modules.
This part use many renesas's CPU.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf?key=086621e01bd70347c18ea7f794aa9cc3

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/timer/Makefile.objs         |   2 +
 hw/timer/renesas_cmt.c         | 226 +++++++++++++++++++++++
 hw/timer/renesas_tmr.c         | 401 +++++++++++++++++++++++++++++++++++++++++
 include/hw/timer/renesas_cmt.h |  33 ++++
 include/hw/timer/renesas_tmr.h |  42 +++++
 5 files changed, 704 insertions(+)
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f8..e11aaf5bf5 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -40,6 +40,8 @@ obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 
 obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
+obj-$(CONFIG_RX) += renesas_tmr.o renesas_cmt.o
+
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
 
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
new file mode 100644
index 0000000000..fb48d315c2
--- /dev/null
+++ b/hw/timer/renesas_cmt.c
@@ -0,0 +1,226 @@
+/*
+ * Renesas Compare-match timer
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/timer.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/timer/renesas_cmt.h"
+#include "qemu/error-report.h"
+
+#define freq_to_ns(freq) (1000000000LL / freq)
+static const int clkdiv[] = {8, 32, 128, 512};
+
+static void update_events(RCMTState *cmt, int ch)
+{
+    uint16_t diff;
+
+    if ((cmt->cmstr & (1 << ch)) != 0) {
+        diff = cmt->cmcor[ch] - cmt->cmcnt[ch];
+        timer_mod(cmt->timer[ch],
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              diff * freq_to_ns(cmt->input_freq) *
+              clkdiv[cmt->cmcr[ch] & 3]);
+    }
+}
+
+static uint64_t read_cmcnt(RCMTState *cmt, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (cmt->cmstr & (1 << ch)) {
+        delta = (now - cmt->tick[ch]) / freq_to_ns(cmt->input_freq);
+        delta /= clkdiv[cmt->cmcr[ch] & 0x03];
+        return cmt->cmcnt[ch] + delta;
+    } else {
+        return cmt->cmcnt[ch];
+    }
+}
+
+static uint64_t cmt_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0x0f;
+    RCMTState *cmt = opaque;
+    int ch = offset / 0x08;
+    int error = 1;
+
+    if (offset == 0) {
+        return cmt->cmstr;
+        error = 0;
+    } else {
+        offset &= 0x07;
+        if (ch == 0) {
+            offset -= 0x02;
+        }
+        error = 0;
+        switch (offset) {
+        case 0:
+            return cmt->cmcr[ch];
+        case 2:
+            return read_cmcnt(cmt, ch);
+        case 4:
+            return cmt->cmcor[ch];
+        default:
+            error = 1;
+        }
+    }
+    if (error) {
+        error_report("rcmt: unsupported read request to %08lx", addr);
+    }
+    return 0xffffffffffffffffUL;
+}
+
+static void start_stop(RCMTState *cmt, int ch, int st)
+{
+    if (st) {
+        update_events(cmt, ch);
+    } else {
+        timer_del(cmt->timer[ch]);
+    }
+}
+
+static void cmt_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    hwaddr offset = addr & 0x0f;
+    RCMTState *cmt = opaque;
+    int ch = offset / 0x08;
+    int error = 1;
+
+    if (offset == 0) {
+        cmt->cmstr = val;
+        start_stop(cmt, 0, cmt->cmstr & 1);
+        start_stop(cmt, 1, (cmt->cmstr >> 1) & 1);
+        error = 0;
+    } else {
+        offset &= 0x07;
+        if (ch == 0) {
+            offset -= 0x02;
+        }
+        error = 0;
+        switch (offset) {
+        case 0:
+            cmt->cmcr[ch] = val;
+            break;
+        case 2:
+            cmt->cmcnt[ch] = val;
+            break;
+        case 4:
+            cmt->cmcor[ch] = val;
+            break;
+        default:
+            error = 1;
+        }
+        if (error == 0 && cmt->cmstr & (1 << ch)) {
+            update_events(cmt, ch);
+        }
+    }
+    if (error) {
+        error_report("rcmt: unsupported write request to %08lx", addr);
+    }
+}
+
+static const MemoryRegionOps cmt_ops = {
+    .write = cmt_write,
+    .read  = cmt_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+    },
+};
+
+static void timer_events(RCMTState *cmt, int ch)
+{
+    cmt->cmcnt[ch] = 0;
+    cmt->tick[ch] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    update_events(cmt, ch);
+    if (cmt->cmcr[ch] & 0x40) {
+        qemu_irq_pulse(cmt->cmi[ch]);
+    }
+}
+
+static void timer_event0(void *opaque)
+{
+    RCMTState *cmt = opaque;
+
+    timer_events(cmt, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RCMTState *cmt = opaque;
+
+    timer_events(cmt, 1);
+}
+
+static void rcmt_reset(DeviceState *dev)
+{
+    RCMTState *cmt = RCMT(dev);
+    cmt->cmstr = 0;
+    cmt->cmcr[0] = cmt->cmcr[1] = 0;
+    cmt->cmcnt[0] = cmt->cmcnt[1] = 0;
+    cmt->cmcor[0] = cmt->cmcor[1] = 0xffff;
+}
+
+static void rcmt_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RCMTState *cmt = RCMT(obj);
+    int i;
+
+    memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
+                          cmt, "renesas-cmt", 0x10);
+    sysbus_init_mmio(d, &cmt->memory);
+
+    for (i = 0; i < 2; i++) {
+        sysbus_init_irq(d, &cmt->cmi[i]);
+    }
+    cmt->timer[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, cmt);
+    cmt->timer[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1, cmt);
+}
+
+static const VMStateDescription vmstate_rcmt = {
+    .name = "rx-cmt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rcmt_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rcmt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = rcmt_properties;
+    dc->vmsd = &vmstate_rcmt;
+    dc->reset = rcmt_reset;
+}
+
+static const TypeInfo rcmt_info = {
+    .name       = TYPE_RENESAS_CMT,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RCMTState),
+    .instance_init = rcmt_init,
+    .class_init = rcmt_class_init,
+};
+
+static void rcmt_register_types(void)
+{
+    type_register_static(&rcmt_info);
+}
+
+type_init(rcmt_register_types)
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
new file mode 100644
index 0000000000..1b59c6c092
--- /dev/null
+++ b/hw/timer/renesas_tmr.c
@@ -0,0 +1,401 @@
+/*
+ * Renesas 8bit timer
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/timer.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/timer/renesas_tmr.h"
+#include "qemu/error-report.h"
+
+#define freq_to_ns(freq) (1000000000LL / freq)
+static const int clkdiv[] = {0, 1, 2, 8, 32, 64, 1024, 8192};
+
+static void update_events(RTMRState *tmr, int ch)
+{
+    uint16_t diff[3];
+    uint16_t tcnt, tcora, tcorb;
+    int i, min, event;
+
+    if (tmr->tccr[ch] == 0) {
+        return ;
+    }
+    if ((tmr->tccr[ch] & 0x08) == 0) {
+        error_report("rtmr: unsupported count mode %02x", tmr->tccr[ch]);
+        return ;
+    }
+    if ((tmr->tccr[0] & 0x18) == 0x18) {
+        if (ch == 1) {
+            tmr->next[ch] = none;
+            return ;
+        }
+        tcnt = (tmr->tcnt[0] << 8) + tmr->tcnt[1];
+        tcora = (tmr->tcora[0] << 8) | tmr->tcora[1];
+        tcorb = (tmr->tcorb[0] << 8) | tmr->tcorb[1];
+        diff[0] = tcora - tcnt;
+        diff[1] = tcorb - tcnt;
+        diff[2] = 0x10000 - tcnt;
+    } else {
+        diff[0] = tmr->tcora[ch] - tmr->tcnt[ch];
+        diff[1] = tmr->tcorb[ch] - tmr->tcnt[ch];
+        diff[2] = 0x100 - tmr->tcnt[ch];
+    }
+    for (event = 0, min = diff[0], i = 1; i < 3; i++) {
+        if (min > diff[i]) {
+            event = i;
+            min = diff[i];
+        }
+    }
+    tmr->next[ch] = event + 1;
+    timer_mod(tmr->timer[ch],
+              diff[event] * freq_to_ns(tmr->input_freq) *
+              clkdiv[tmr->tccr[ch] & 7]);
+}
+
+#define UPDATE_TIME(tmr, ch, upd, delta)                                \
+    do {                                                                \
+        tmr->div_round[ch] += delta;                                    \
+        if (clkdiv[tmr->tccr[ch] & 0x07] > 0) {                         \
+            upd = tmr->div_round[ch] / clkdiv[tmr->tccr[ch] & 0x07];    \
+            tmr->div_round[ch] %= clkdiv[tmr->tccr[ch] & 0x07];         \
+        } else                                                          \
+            upd = 0;                                                    \
+    } while (0)
+
+static uint64_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int upd, ovf = 0;
+    uint16_t tcnt[2];
+
+    delta = (now - tmr->tick) / freq_to_ns(tmr->input_freq);
+    if (delta > 0) {
+        tmr->tick = now;
+
+        if ((tmr->tccr[1] & 0x18) == 0x08) {
+            UPDATE_TIME(tmr, 1, upd, delta);
+            if (upd >= 0x100) {
+                ovf = upd >> 8;
+                upd -= ovf;
+            }
+            tcnt[1] = tmr->tcnt[1] + upd;
+        }
+        switch (tmr->tccr[0] & 0x18) {
+        case 0x08:
+            UPDATE_TIME(tmr, 0, upd, delta);
+            tcnt[0] = tmr->tcnt[0] + upd;
+            break;
+        case 0x18:
+            if (ovf > 0) {
+                tcnt[0] = tmr->tcnt[0] + ovf;
+            }
+            break;
+        }
+    } else {
+        tcnt[0] = tmr->tcnt[0];
+        tcnt[1] = tmr->tcnt[1];
+    }
+    if (size == 1) {
+        return tcnt[ch];
+    } else {
+        return (tmr->tcnt[0] << 8) | (tmr->tcnt[1] & 0xff);
+    }
+}
+
+static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0x1f;
+    RTMRState *tmr = opaque;
+    int ch = offset & 1;
+    int error = 0;
+
+    if (size == 1) {
+        switch (offset & 0x0e) {
+        case 0x00:
+            return tmr->tcr[ch] & 0xf8;
+        case 0x02:
+            return tmr->tcsr[ch] & 0xf8;
+        case 0x04:
+            return tmr->tcora[ch];
+        case 0x06:
+            return tmr->tcorb[ch];
+        case 0x08:
+            return read_tcnt(tmr, size, ch);
+        case 0x0a:
+            return tmr->tccr[ch];
+        default:
+            error = 1;
+        }
+    } else if (ch == 0) {
+        switch (offset & 0x0e) {
+        case 0x04:
+            return tmr->tcora[0] << 8 | tmr->tcora[1];
+        case 0x06:
+            return tmr->tcorb[0] << 8 | tmr->tcorb[1];;
+        case 0x08:
+            return read_tcnt(tmr, size, 0) & 0xff;
+        case 0x0a:
+            return tmr->tccr[0] << 8 | tmr->tccr[1];
+        default:
+            error = 1;
+        }
+    } else {
+        error = 1;
+    }
+    if (error) {
+        error_report("rtmr: unsupported read request to %08lx", addr);
+    }
+    return 0xffffffffffffffffULL;
+}
+
+static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    hwaddr offset = addr & 0x1f;
+    RTMRState *tmr = opaque;
+    int ch = offset & 1;
+    int error = 0;
+
+    if (size == 1) {
+        switch (offset & 0x0e) {
+        case 0x00:
+            tmr->tcr[ch] = val;
+            break;
+        case 0x02:
+            tmr->tcsr[ch] = val;
+            break;
+        case 0x04:
+            tmr->tcora[ch] = val;
+            update_events(tmr, ch);
+            break;
+        case 0x06:
+            tmr->tcora[ch] = val;
+            update_events(tmr, ch);
+            break;
+        case 0x08:
+            tmr->tcnt[ch] = val;
+            update_events(tmr, ch);
+            break;
+        case 0x0a:
+            tmr->tccr[ch] = val;
+            update_events(tmr, ch);
+            break;
+        default:
+            error = 1;
+        }
+    } else if (ch == 0) {
+        switch (offset & 0x0e) {
+        case 0x04:
+            tmr->tcora[0] = (val >> 8) & 0xff;
+            tmr->tcora[1] = val & 0xff;
+            update_events(tmr, 0);
+            update_events(tmr, 1);
+        case 0x06:
+            tmr->tcorb[0] = (val >> 8) & 0xff;
+            tmr->tcorb[1] = val & 0xff;
+            update_events(tmr, 0);
+            update_events(tmr, 1);
+            break;
+        case 0x08:
+            tmr->tcnt[0] = (val >> 8) & 0xff;
+            tmr->tcnt[1] = val & 0xff;
+            update_events(tmr, 0);
+            update_events(tmr, 1);
+            break;
+        case 0x0a:
+            tmr->tccr[0] = (val >> 8) & 0xff;
+            tmr->tccr[1] = val & 0xff;
+            update_events(tmr, 0);
+            update_events(tmr, 1);
+            break;
+        default:
+            error = 1;
+        }
+    } else {
+        error = 1;
+    }
+    if (error) {
+        error_report("rtmr: unsupported write request to %08lx", addr);
+    }
+}
+
+static const MemoryRegionOps tmr_ops = {
+    .write = tmr_write,
+    .read  = tmr_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void timer_events(RTMRState *tmr, int ch)
+{
+    tmr->tcnt[ch] = read_tcnt(tmr, 1, ch);
+    if ((tmr->tccr[0] & 0x18) != 0x18) {
+        switch (tmr->next[ch]) {
+        case none:
+            break;
+        case cmia:
+            if (tmr->tcnt[ch] >= tmr->tcora[ch]) {
+                if ((tmr->tcr[ch] & 0x18) == 0x08) {
+                    tmr->tcnt[ch] = 0;
+                }
+                if ((tmr->tcr[ch] & 0x40)) {
+                    qemu_irq_pulse(tmr->cmia[ch]);
+                }
+                if (ch == 0 && (tmr->tccr[1] & 0x18) == 0x18) {
+                    tmr->tcnt[1]++;
+                    timer_events(tmr, 1);
+                }
+            }
+            break;
+        case cmib:
+            if (tmr->tcnt[ch] >= tmr->tcorb[ch]) {
+                if ((tmr->tcr[ch] & 0x18) == 0x10) {
+                    tmr->tcnt[ch] = 0;
+                }
+                if ((tmr->tcr[ch] & 0x80)) {
+                    qemu_irq_pulse(tmr->cmib[ch]);
+                }
+            }
+            break;
+        case ovi:
+            if ((tmr->tcnt[ch] >= 0x100) &&
+                (tmr->tcr[ch] & 0x20)) {
+                qemu_irq_pulse(tmr->ovi[ch]);
+            }
+            break;
+        }
+        tmr->tcnt[ch] &= 0xff;
+    } else {
+        uint32_t tcnt, tcora, tcorb;
+        if (ch == 1) {
+            return ;
+        }
+        tcnt = (tmr->tcnt[0] << 8) + tmr->tcnt[1];
+        tcora = (tmr->tcora[0] << 8) | tmr->tcora[1];
+        tcorb = (tmr->tcorb[0] << 8) | tmr->tcorb[1];
+        switch (tmr->next[ch]) {
+        case none:
+            break;
+        case cmia:
+            if (tcnt >= tcora) {
+                if ((tmr->tcr[ch] & 0x18) == 0x08) {
+                    tcnt = 0;
+                }
+                if ((tmr->tcr[ch] & 0x40)) {
+                    qemu_irq_pulse(tmr->cmia[ch]);
+                }
+            }
+            break;
+        case cmib:
+            if (tcnt >= tcorb) {
+                if ((tmr->tcr[ch] & 0x18) == 0x10) {
+                    tcnt = 0;
+                }
+                if ((tmr->tcr[ch] & 0x80)) {
+                    qemu_irq_pulse(tmr->cmib[ch]);
+                }
+            }
+            break;
+        case ovi:
+            if ((tcnt >= 0x10000) &&
+                (tmr->tcr[ch] & 0x20)) {
+                qemu_irq_pulse(tmr->ovi[ch]);
+            }
+            break;
+        }
+        tmr->tcnt[0] = (tcnt >> 8) & 0xff;
+        tmr->tcnt[1] = tcnt & 0xff;
+    }
+    update_events(tmr, ch);
+}
+
+static void timer_event0(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 1);
+}
+
+static void rtmr_reset(DeviceState *dev)
+{
+    RTMRState *tmr = RTMR(dev);
+    tmr->tcora[0] = tmr->tcora[1] = 0xff;
+    tmr->tcorb[0] = tmr->tcorb[1] = 0xff;
+    tmr->tcsr[0] = 0x00;
+    tmr->tcsr[1] = 0x10;
+    tmr->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void rtmr_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RTMRState *tmr = RTMR(obj);
+    int i;
+
+    memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                          tmr, "rx-tmr", 0x10);
+    sysbus_init_mmio(d, &tmr->memory);
+
+    for (i = 0; i < 2; i++) {
+        sysbus_init_irq(d, &tmr->cmia[i]);
+        sysbus_init_irq(d, &tmr->cmib[i]);
+        sysbus_init_irq(d, &tmr->ovi[i]);
+    }
+    tmr->timer[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, tmr);
+    tmr->timer[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1, tmr);
+}
+
+static const VMStateDescription vmstate_rtmr = {
+    .name = "rx-cmt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rtmr_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rtmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = rtmr_properties;
+    dc->vmsd = &vmstate_rtmr;
+    dc->reset = rtmr_reset;
+}
+
+static const TypeInfo rtmr_info = {
+    .name       = TYPE_RENESAS_TMR,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RTMRState),
+    .instance_init = rtmr_init,
+    .class_init = rtmr_class_init,
+};
+
+static void rtmr_register_types(void)
+{
+    type_register_static(&rtmr_info);
+}
+
+type_init(rtmr_register_types)
diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
new file mode 100644
index 0000000000..764759d4ad
--- /dev/null
+++ b/include/hw/timer/renesas_cmt.h
@@ -0,0 +1,33 @@
+/*
+ * Renesas Compare-match timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_CMT_H
+#define HW_RENESAS_CMT_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_CMT "renesas-cmt"
+#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
+
+typedef struct RCMTState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint16_t cmstr;
+    uint16_t cmcr[2];
+    uint16_t cmcnt[2];
+    uint16_t cmcor[2];
+    int64_t tick[2];
+    qemu_irq cmi[2];
+    QEMUTimer *timer[2];
+} RCMTState;
+
+#endif
diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
new file mode 100644
index 0000000000..09333c86fc
--- /dev/null
+++ b/include/hw/timer/renesas_tmr.h
@@ -0,0 +1,42 @@
+/*
+ * Renesas 8bit timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#ifndef HW_RENESAS_TMR_H
+#define HW_RENESAS_TMR_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TMR "renesas-tmr"
+#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
+
+enum timer_event {none, cmia, cmib, ovi};
+
+typedef struct RTMRState {
+    SysBusDevice parent_obj;
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint16_t tcnt[2];
+    uint8_t tcora[2];
+    uint8_t tcorb[2];
+    uint8_t tcr[2];
+    uint8_t tccr[2];
+    uint8_t tcor[2];
+    uint8_t tcsr[2];
+    int64_t tick;
+    int64_t div_round[2];
+    enum timer_event next[2];
+    qemu_irq cmia[2];
+    qemu_irq cmib[2];
+    qemu_irq ovi[2];
+    QEMUTimer *timer[2];
+} RTMRState;
+
+#endif
-- 
2.11.0
