Received: from eggs.gnu.org ([2001:4830:134:3::10]:50555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCt-0002Ad-8s
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCl-0008WA-HS
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:38:03 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36262
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCk-0008Vf-W4
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:55 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:26 +0000
Message-Id: <20180203103727.26457-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 09/10] misc: introduce new mos6522 VIA device
 and enable it for ppc builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

The MOS6522 VIA forms the bridge part of several Mac devices, including the
Mac via-cuda and via-pmu devices. Introduce a standard mos6522 device that
can be shared amongst multiple implementations.

This is effectively taking the 6522 parts out of cuda.c and turning them
into a separate device whilst also applying some style tidy-ups and including
a conversion to trace-events.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/Makefile.objs           |   3 +
 hw/misc/mos6522.c               | 505 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events            |   7 +
 include/hw/misc/mos6522.h       | 149 ++++++++++++
 5 files changed, 665 insertions(+)
 create mode 100644 hw/misc/mos6522.c
 create mode 100644 include/hw/misc/mos6522.h

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 3baed6a8fd..8aeb221be4 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -29,6 +29,7 @@ CONFIG_MAC=y
 CONFIG_ESCC=y
 CONFIG_MACIO=y
 CONFIG_SUNGEM=y
+CONFIG_MOS6522=y
 CONFIG_CUDA=y
 CONFIG_ADB=y
 CONFIG_MAC_NVRAM=y
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index d517f83e81..1cd7989ea7 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -17,6 +17,9 @@ common-obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o
 common-obj-$(CONFIG_A9SCU) += a9scu.o
 common-obj-$(CONFIG_ARM11SCU) += arm11scu.o
 
+# Mac devices
+common-obj-$(CONFIG_MOS6522) += mos6522.o
+
 # PKUnity SoC devices
 common-obj-$(CONFIG_PUV3) += puv3_pm.o
 
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
new file mode 100644
index 0000000000..bc69d0e053
--- /dev/null
+++ b/hw/misc/mos6522.c
@@ -0,0 +1,505 @@
+/*
+ * QEMU MOS6522 VIA emulation
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2018 Mark Cave-Ayland
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/input/adb.h"
+#include "hw/misc/mos6522.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+/* XXX: implement all timer modes */
+
+static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
+                                 int64_t current_time);
+
+static void mos6522_update_irq(MOS6522State *s)
+{
+    if (s->ifr & s->ier & (SR_INT | T1_INT | T2_INT)) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint64_t get_counter_value(MOS6522State *s, MOS6522Timer *ti)
+{
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+
+    if (ti->index == 0) {
+        return mdc->get_timer1_counter_value(s, ti);
+    } else {
+        return mdc->get_timer2_counter_value(s, ti);
+    }
+}
+
+static uint64_t get_load_time(MOS6522State *s, MOS6522Timer *ti)
+{
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+
+    if (ti->index == 0) {
+        return mdc->get_timer1_load_time(s, ti);
+    } else {
+        return mdc->get_timer2_load_time(s, ti);
+    }
+}
+
+static unsigned int get_counter(MOS6522State *s, MOS6522Timer *ti)
+{
+    int64_t d;
+    unsigned int counter;
+
+    d = get_counter_value(s, ti);
+
+    if (ti->index == 0) {
+        /* the timer goes down from latch to -1 (period of latch + 2) */
+        if (d <= (ti->counter_value + 1)) {
+            counter = (ti->counter_value - d) & 0xffff;
+        } else {
+            counter = (d - (ti->counter_value + 1)) % (ti->latch + 2);
+            counter = (ti->latch - counter) & 0xffff;
+        }
+    } else {
+        counter = (ti->counter_value - d) & 0xffff;
+    }
+    return counter;
+}
+
+static void set_counter(MOS6522State *s, MOS6522Timer *ti, unsigned int val)
+{
+    trace_mos6522_set_counter(1 + ti->index, val);
+    ti->load_time = get_load_time(s, ti);
+    ti->counter_value = val;
+    mos6522_timer_update(s, ti, ti->load_time);
+}
+
+static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
+                                 int64_t current_time)
+{
+    int64_t d, next_time;
+    unsigned int counter;
+
+    /* current counter value */
+    d = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
+                 ti->frequency, NANOSECONDS_PER_SECOND);
+
+    /* the timer goes down from latch to -1 (period of latch + 2) */
+    if (d <= (ti->counter_value + 1)) {
+        counter = (ti->counter_value - d) & 0xffff;
+    } else {
+        counter = (d - (ti->counter_value + 1)) % (ti->latch + 2);
+        counter = (ti->latch - counter) & 0xffff;
+    }
+
+    /* Note: we consider the irq is raised on 0 */
+    if (counter == 0xffff) {
+        next_time = d + ti->latch + 1;
+    } else if (counter == 0) {
+        next_time = d + ti->latch + 2;
+    } else {
+        next_time = d + counter;
+    }
+    trace_mos6522_get_next_irq_time(ti->latch, d, next_time - d);
+    next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->frequency) +
+                         ti->load_time;
+    if (next_time <= current_time) {
+        next_time = current_time + 1;
+    }
+    return next_time;
+}
+
+static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
+                                 int64_t current_time)
+{
+    if (!ti->timer) {
+        return;
+    }
+    if (ti->index == 0 && (s->acr & T1MODE) != T1MODE_CONT) {
+        timer_del(ti->timer);
+    } else {
+        ti->next_irq_time = get_next_irq_time(s, ti, current_time);
+        timer_mod(ti->timer, ti->next_irq_time);
+    }
+}
+
+static void mos6522_timer1(void *opaque)
+{
+    MOS6522State *s = opaque;
+    MOS6522Timer *ti = &s->timers[0];
+
+    mos6522_timer_update(s, ti, ti->next_irq_time);
+    s->ifr |= T1_INT;
+    mos6522_update_irq(s);
+}
+
+static void mos6522_timer2(void *opaque)
+{
+    MOS6522State *s = opaque;
+    MOS6522Timer *ti = &s->timers[1];
+
+    mos6522_timer_update(s, ti, ti->next_irq_time);
+    s->ifr |= T2_INT;
+    mos6522_update_irq(s);
+}
+
+static void mos6522_set_sr_int(MOS6522State *s)
+{
+    trace_mos6522_set_sr_int();
+    s->ifr |= SR_INT;
+    mos6522_update_irq(s);
+}
+
+static uint64_t mos6522_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
+{
+    uint64_t d;
+
+    d = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
+                 ti->frequency, NANOSECONDS_PER_SECOND);
+
+    return d;
+}
+
+static uint64_t mos6522_get_load_time(MOS6522State *s, MOS6522Timer *ti)
+{
+    uint64_t load_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    return load_time;
+}
+
+static void mos6522_portA_write(MOS6522State *s)
+{
+    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented");
+}
+
+static void mos6522_portB_write(MOS6522State *s)
+{
+    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented");
+}
+
+uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MOS6522State *s = opaque;
+    uint32_t val;
+
+    switch (addr) {
+    case VIA_REG_B:
+        val = s->b;
+        break;
+    case VIA_REG_A:
+        val = s->a;
+        break;
+    case VIA_REG_DIRB:
+        val = s->dirb;
+        break;
+    case VIA_REG_DIRA:
+        val = s->dira;
+        break;
+    case VIA_REG_T1CL:
+        val = get_counter(s, &s->timers[0]) & 0xff;
+        s->ifr &= ~T1_INT;
+        mos6522_update_irq(s);
+        break;
+    case VIA_REG_T1CH:
+        val = get_counter(s, &s->timers[0]) >> 8;
+        mos6522_update_irq(s);
+        break;
+    case VIA_REG_T1LL:
+        val = s->timers[0].latch & 0xff;
+        break;
+    case VIA_REG_T1LH:
+        /* XXX: check this */
+        val = (s->timers[0].latch >> 8) & 0xff;
+        break;
+    case VIA_REG_T2CL:
+        val = get_counter(s, &s->timers[1]) & 0xff;
+        s->ifr &= ~T2_INT;
+        mos6522_update_irq(s);
+        break;
+    case VIA_REG_T2CH:
+        val = get_counter(s, &s->timers[1]) >> 8;
+        break;
+    case VIA_REG_SR:
+        val = s->sr;
+        s->ifr &= ~(SR_INT | SR_CLOCK_INT | SR_DATA_INT);
+        mos6522_update_irq(s);
+        break;
+    case VIA_REG_ACR:
+        val = s->acr;
+        break;
+    case VIA_REG_PCR:
+        val = s->pcr;
+        break;
+    case VIA_REG_IFR:
+        val = s->ifr;
+        if (s->ifr & s->ier) {
+            val |= 0x80;
+        }
+        break;
+    case VIA_REG_IER:
+        val = s->ier | 0x80;
+        break;
+    default:
+    case VIA_REG_ANH:
+        val = s->anh;
+        break;
+    }
+
+    if (addr != VIA_REG_IFR || val != 0) {
+        trace_mos6522_read(addr, val);
+    }
+
+    return val;
+}
+
+void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    MOS6522State *s = opaque;
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+
+    trace_mos6522_write(addr, val);
+
+    switch (addr) {
+    case VIA_REG_B:
+        s->b = (s->b & ~s->dirb) | (val & s->dirb);
+        mdc->portB_write(s);
+        break;
+    case VIA_REG_A:
+        s->a = (s->a & ~s->dira) | (val & s->dira);
+        mdc->portA_write(s);
+        break;
+    case VIA_REG_DIRB:
+        s->dirb = val;
+        break;
+    case VIA_REG_DIRA:
+        s->dira = val;
+        break;
+    case VIA_REG_T1CL:
+        s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
+        mos6522_timer_update(s, &s->timers[0],
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        break;
+    case VIA_REG_T1CH:
+        s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
+        s->ifr &= ~T1_INT;
+        set_counter(s, &s->timers[0], s->timers[0].latch);
+        break;
+    case VIA_REG_T1LL:
+        s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
+        mos6522_timer_update(s, &s->timers[0],
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        break;
+    case VIA_REG_T1LH:
+        s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
+        s->ifr &= ~T1_INT;
+        mos6522_timer_update(s, &s->timers[0],
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        break;
+    case VIA_REG_T2CL:
+        s->timers[1].latch = (s->timers[1].latch & 0xff00) | val;
+        break;
+    case VIA_REG_T2CH:
+        /* To ensure T2 generates an interrupt on zero crossing with the
+           common timer code, write the value directly from the latch to
+           the counter */
+        s->timers[1].latch = (s->timers[1].latch & 0xff) | (val << 8);
+        s->ifr &= ~T2_INT;
+        set_counter(s, &s->timers[1], s->timers[1].latch);
+        break;
+    case VIA_REG_SR:
+        s->sr = val;
+        break;
+    case VIA_REG_ACR:
+        s->acr = val;
+        mos6522_timer_update(s, &s->timers[0],
+                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        break;
+    case VIA_REG_PCR:
+        s->pcr = val;
+        break;
+    case VIA_REG_IFR:
+        /* reset bits */
+        s->ifr &= ~val;
+        mos6522_update_irq(s);
+        break;
+    case VIA_REG_IER:
+        if (val & IER_SET) {
+            /* set bits */
+            s->ier |= val & 0x7f;
+        } else {
+            /* reset bits */
+            s->ier &= ~val;
+        }
+        mos6522_update_irq(s);
+        break;
+    default:
+    case VIA_REG_ANH:
+        s->anh = val;
+        break;
+    }
+}
+
+static const MemoryRegionOps mos6522_ops = {
+    .read = mos6522_read,
+    .write = mos6522_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static bool mos6522_timer_exist(void *opaque, int version_id)
+{
+    MOS6522Timer *s = opaque;
+
+    return s->timer != NULL;
+}
+
+static const VMStateDescription vmstate_mos6522_timer = {
+    .name = "mos6522_timer",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(latch, MOS6522Timer),
+        VMSTATE_UINT16(counter_value, MOS6522Timer),
+        VMSTATE_INT64(load_time, MOS6522Timer),
+        VMSTATE_INT64(next_irq_time, MOS6522Timer),
+        VMSTATE_TIMER_PTR_TEST(timer, MOS6522Timer, mos6522_timer_exist),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_mos6522 = {
+    .name = "mos6522",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(a, MOS6522State),
+        VMSTATE_UINT8(b, MOS6522State),
+        VMSTATE_UINT8(dira, MOS6522State),
+        VMSTATE_UINT8(dirb, MOS6522State),
+        VMSTATE_UINT8(sr, MOS6522State),
+        VMSTATE_UINT8(acr, MOS6522State),
+        VMSTATE_UINT8(pcr, MOS6522State),
+        VMSTATE_UINT8(ifr, MOS6522State),
+        VMSTATE_UINT8(ier, MOS6522State),
+        VMSTATE_UINT8(anh, MOS6522State),
+        VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 1,
+                             vmstate_mos6522_timer, MOS6522Timer),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void mos6522_reset(DeviceState *dev)
+{
+    MOS6522State *s = MOS6522(dev);
+
+    s->b = 0;
+    s->a = 0;
+    s->dirb = 0xff;
+    s->dira = 0;
+    s->sr = 0;
+    s->acr = 0;
+    s->pcr = 0;
+    s->ifr = 0;
+    s->ier = 0;
+    /* s->ier = T1_INT | SR_INT; */
+    s->anh = 0;
+
+    s->timers[0].latch = 0xffff;
+    set_counter(s, &s->timers[0], 0xffff);
+
+    s->timers[1].latch = 0xffff;
+}
+
+static void mos6522_realize(DeviceState *dev, Error **errp)
+{
+    MOS6522State *s = MOS6522(dev);
+
+    s->timers[0].frequency = s->frequency;
+    s->timers[1].frequency = s->frequency;
+}
+
+static void mos6522_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    MOS6522State *s = MOS6522(obj);
+    int i;
+
+    memory_region_init_io(&s->mem, obj, &mos6522_ops, s, "mos6522", 0x10);
+    sysbus_init_mmio(sbd, &s->mem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
+        s->timers[i].index = i;
+    }
+
+    s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
+    s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
+}
+
+static Property mos6522_properties[] = {
+    DEFINE_PROP_UINT64("frequency", MOS6522State, frequency, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void mos6522_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+
+    dc->realize = mos6522_realize;
+    dc->reset = mos6522_reset;
+    dc->vmsd = &vmstate_mos6522;
+    dc->props = mos6522_properties;
+    mdc->parent_realize = dc->realize;
+    mdc->set_sr_int = mos6522_set_sr_int;
+    mdc->portB_write = mos6522_portB_write;
+    mdc->portA_write = mos6522_portA_write;
+    mdc->get_timer1_counter_value = mos6522_get_counter_value;
+    mdc->get_timer2_counter_value = mos6522_get_counter_value;
+    mdc->get_timer1_load_time = mos6522_get_load_time;
+    mdc->get_timer2_load_time = mos6522_get_load_time;
+}
+
+static const TypeInfo mos6522_type_info = {
+    .name = TYPE_MOS6522,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MOS6522State),
+    .instance_init = mos6522_init,
+    .abstract = true,
+    .class_size = sizeof(MOS6522DeviceClass),
+    .class_init = mos6522_class_init,
+};
+
+static void mos6522_register_types(void)
+{
+    type_register_static(&mos6522_type_info);
+}
+
+type_init(mos6522_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 616579a403..108ca46d16 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -66,3 +66,10 @@ mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC
 msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" HWADDR_PRIx " data 0x%" PRIx32 " prev 0x%" PRIx32
 msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr 0x%08" HWADDR_PRIx " data 0x%08" PRIx32
 msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL status register"
+
+# hw/misc/mos6522.c
+mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
+mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "latch=%d counter=0x%"PRId64 " delta_next=0x%"PRId64
+mos6522_set_sr_int(void) "set sr_int"
+mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
+mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
new file mode 100644
index 0000000000..db78b0a81c
--- /dev/null
+++ b/include/hw/misc/mos6522.h
@@ -0,0 +1,149 @@
+/*
+ * QEMU MOS6522 VIA emulation
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2018 Mark Cave-Ayland
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MOS6522_H
+#define MOS6522_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+#include "hw/ide/internal.h"
+#include "hw/input/adb.h"
+
+/* Bits in ACR */
+#define SR_CTRL            0x1c    /* Shift register control bits */
+#define SR_EXT             0x0c    /* Shift on external clock */
+#define SR_OUT             0x10    /* Shift out if 1 */
+
+/* Bits in IFR and IER */
+#define IER_SET            0x80    /* set bits in IER */
+#define IER_CLR            0       /* clear bits in IER */
+#define SR_INT             0x04    /* Shift register full/empty */
+#define SR_DATA_INT        0x08
+#define SR_CLOCK_INT       0x10
+#define T1_INT             0x40    /* Timer 1 interrupt */
+#define T2_INT             0x20    /* Timer 2 interrupt */
+
+/* Bits in ACR */
+#define T1MODE             0xc0    /* Timer 1 mode */
+#define T1MODE_CONT        0x40    /*  continuous interrupts */
+
+/* VIA registers */
+#define VIA_REG_B       0x00
+#define VIA_REG_A       0x01
+#define VIA_REG_DIRB    0x02
+#define VIA_REG_DIRA    0x03
+#define VIA_REG_T1CL    0x04
+#define VIA_REG_T1CH    0x05
+#define VIA_REG_T1LL    0x06
+#define VIA_REG_T1LH    0x07
+#define VIA_REG_T2CL    0x08
+#define VIA_REG_T2CH    0x09
+#define VIA_REG_SR      0x0a
+#define VIA_REG_ACR     0x0b
+#define VIA_REG_PCR     0x0c
+#define VIA_REG_IFR     0x0d
+#define VIA_REG_IER     0x0e
+#define VIA_REG_ANH     0x0f
+
+/**
+ * MOS6522Timer:
+ * @counter_value: counter value at load time
+ */
+typedef struct MOS6522Timer {
+    int index;
+    uint16_t latch;
+    uint16_t counter_value;
+    int64_t load_time;
+    int64_t next_irq_time;
+    uint64_t frequency;
+    QEMUTimer *timer;
+} MOS6522Timer;
+
+/**
+ * MOS6522State:
+ * @b: B-side data
+ * @a: A-side data
+ * @dirb: B-side direction (1=output)
+ * @dira: A-side direction (1=output)
+ * @sr: Shift register
+ * @acr: Auxiliary control register
+ * @pcr: Peripheral control register
+ * @ifr: Interrupt flag register
+ * @ier: Interrupt enable register
+ * @anh: A-side data, no handshake
+ * @last_b: last value of B register
+ * @last_acr: last value of ACR register
+ */
+typedef struct MOS6522State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mem;
+    /* VIA registers */
+    uint8_t b;
+    uint8_t a;
+    uint8_t dirb;
+    uint8_t dira;
+    uint8_t sr;
+    uint8_t acr;
+    uint8_t pcr;
+    uint8_t ifr;
+    uint8_t ier;
+    uint8_t anh;
+
+    MOS6522Timer timers[2];
+    uint64_t frequency;
+
+    qemu_irq irq;
+} MOS6522State;
+
+#define TYPE_MOS6522 "mos6522"
+#define MOS6522(obj) OBJECT_CHECK(MOS6522State, (obj), TYPE_MOS6522)
+
+typedef struct MOS6522DeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    void (*set_sr_int)(MOS6522State *dev);
+    void (*portB_write)(MOS6522State *dev);
+    void (*portA_write)(MOS6522State *dev);
+    /* These are used to influence the CUDA MacOS timebase calibration */
+    uint64_t (*get_timer1_counter_value)(MOS6522State *dev, MOS6522Timer *ti);
+    uint64_t (*get_timer2_counter_value)(MOS6522State *dev, MOS6522Timer *ti);
+    uint64_t (*get_timer1_load_time)(MOS6522State *dev, MOS6522Timer *ti);
+    uint64_t (*get_timer2_load_time)(MOS6522State *dev, MOS6522Timer *ti);
+} MOS6522DeviceClass;
+
+#define MOS6522_DEVICE_CLASS(cls) \
+    OBJECT_CLASS_CHECK(MOS6522DeviceClass, (cls), TYPE_MOS6522)
+#define MOS6522_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
+
+uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
+void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
+
+#endif /* MOS6522_H */
-- 
2.11.0
