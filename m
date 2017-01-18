Received: from eggs.gnu.org ([2001:4830:134:3::10]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIx-0004ul-FC
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIv-0001jL-TN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTyIv-0001iW-LG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:05 -0500
From: Marek Vasut <marex@denx.de>
Date: Wed, 18 Jan 2017 23:01:44 +0100
Message-Id: <20170118220146.489-6-marex@denx.de>
In-Reply-To: <20170118220146.489-1-marex@denx.de>
References: <20170118220146.489-1-marex@denx.de>
Subject: [Qemu-devel] [PATCH V5 5/7] nios2: Add periodic timer emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

From: Chris Wulff <crwulff@gmail.com>

Add the Altera timer model.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
V3: Checkpatch cleanup
V4: Rebase on top of qemu/master
V5: - Rebase on top of qemu/master
    - Drop the addr &= 0x7 , which is now deemed obsolete.
---
 hw/timer/Makefile.objs  |   1 +
 hw/timer/altera_timer.c | 237 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 hw/timer/altera_timer.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 7ba8c23c75..0867a64754 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -18,6 +18,7 @@ common-obj-$(CONFIG_IMX) += imx_gpt.o
 common-obj-$(CONFIG_LM32) += lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
 
+obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
new file mode 100644
index 0000000000..6d4862661d
--- /dev/null
+++ b/hw/timer/altera_timer.c
@@ -0,0 +1,237 @@
+/*
+ * QEMU model of the Altera timer.
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+
+#include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
+#include "hw/ptimer.h"
+
+#define R_STATUS      0
+#define R_CONTROL     1
+#define R_PERIODL     2
+#define R_PERIODH     3
+#define R_SNAPL       4
+#define R_SNAPH       5
+#define R_MAX         6
+
+#define STATUS_TO     0x0001
+#define STATUS_RUN    0x0002
+
+#define CONTROL_ITO   0x0001
+#define CONTROL_CONT  0x0002
+#define CONTROL_START 0x0004
+#define CONTROL_STOP  0x0008
+
+#define TYPE_ALTERA_TIMER "ALTR.timer"
+#define ALTERA_TIMER(obj) \
+    OBJECT_CHECK(AlteraTimer, (obj), TYPE_ALTERA_TIMER)
+
+typedef struct AlteraTimer {
+    SysBusDevice  busdev;
+    MemoryRegion  mmio;
+    qemu_irq      irq;
+    uint32_t      freq_hz;
+    QEMUBH       *bh;
+    ptimer_state *ptimer;
+    uint32_t      regs[R_MAX];
+} AlteraTimer;
+
+static int timer_irq_state(AlteraTimer *t)
+{
+    bool irq = (t->regs[R_STATUS] & STATUS_TO) &&
+               (t->regs[R_CONTROL] & CONTROL_ITO);
+    return irq;
+}
+
+static uint64_t timer_read(void *opaque, hwaddr addr,
+                           unsigned int size)
+{
+    AlteraTimer *t = opaque;
+    uint64_t r = 0;
+
+    addr >>= 2;
+
+    switch (addr) {
+    case R_CONTROL:
+        r = t->regs[R_CONTROL] & (CONTROL_ITO | CONTROL_CONT);
+        break;
+
+    default:
+        if (addr < ARRAY_SIZE(t->regs)) {
+            r = t->regs[addr];
+        }
+        break;
+    }
+
+    return r;
+}
+
+static void timer_write(void *opaque, hwaddr addr,
+                        uint64_t value, unsigned int size)
+{
+    AlteraTimer *t = opaque;
+    uint64_t tvalue;
+    uint32_t count = 0;
+    int irqState = timer_irq_state(t);
+
+    addr >>= 2;
+
+    switch (addr) {
+    case R_STATUS:
+        /* The timeout bit is cleared by writing the status register. */
+        t->regs[R_STATUS] &= ~STATUS_TO;
+        break;
+
+    case R_CONTROL:
+        t->regs[R_CONTROL] = value & (CONTROL_ITO | CONTROL_CONT);
+        if ((value & CONTROL_START) &&
+            !(t->regs[R_STATUS] & STATUS_RUN)) {
+            ptimer_run(t->ptimer, 1);
+            t->regs[R_STATUS] |= STATUS_RUN;
+        }
+        if ((value & CONTROL_STOP) && (t->regs[R_STATUS] & STATUS_RUN)) {
+            ptimer_stop(t->ptimer);
+            t->regs[R_STATUS] &= ~STATUS_RUN;
+        }
+        break;
+
+    case R_PERIODL:
+    case R_PERIODH:
+        t->regs[addr] = value & 0xFFFF;
+        if (t->regs[R_STATUS] & STATUS_RUN) {
+            ptimer_stop(t->ptimer);
+            t->regs[R_STATUS] &= ~STATUS_RUN;
+        }
+        tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
+        ptimer_set_limit(t->ptimer, tvalue + 1, 1);
+        break;
+
+    case R_SNAPL:
+    case R_SNAPH:
+        count = ptimer_get_count(t->ptimer);
+        t->regs[R_SNAPL] = count & 0xFFFF;
+        t->regs[R_SNAPH] = count >> 16;
+        break;
+
+    default:
+        break;
+    }
+
+    if (irqState != timer_irq_state(t)) {
+        qemu_set_irq(t->irq, timer_irq_state(t));
+    }
+}
+
+static const MemoryRegionOps timer_ops = {
+    .read = timer_read,
+    .write = timer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4
+    }
+};
+
+static void timer_hit(void *opaque)
+{
+    AlteraTimer *t = opaque;
+    const uint64_t tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
+
+    t->regs[R_STATUS] |= STATUS_TO;
+
+    ptimer_set_limit(t->ptimer, tvalue + 1, 1);
+
+    if (!(t->regs[R_CONTROL] & CONTROL_CONT)) {
+        t->regs[R_STATUS] &= ~STATUS_RUN;
+        ptimer_set_count(t->ptimer, tvalue);
+    } else {
+        ptimer_run(t->ptimer, 1);
+    }
+
+    qemu_set_irq(t->irq, timer_irq_state(t));
+}
+
+static void altera_timer_realize(DeviceState *dev, Error **errp)
+{
+    AlteraTimer *t = ALTERA_TIMER(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (t->freq_hz == 0) {
+        error_setg(errp, "\"clock-frequency\" property must be provided.");
+        return;
+    }
+
+    t->bh = qemu_bh_new(timer_hit, t);
+    t->ptimer = ptimer_init(t->bh, PTIMER_POLICY_DEFAULT);
+    ptimer_set_freq(t->ptimer, t->freq_hz);
+
+    memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
+                          TYPE_ALTERA_TIMER, R_MAX * sizeof(uint32_t));
+    sysbus_init_mmio(sbd, &t->mmio);
+}
+
+static void altera_timer_init(Object *obj)
+{
+    AlteraTimer *t = ALTERA_TIMER(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    sysbus_init_irq(sbd, &t->irq);
+}
+
+static void altera_timer_reset(DeviceState *dev)
+{
+    AlteraTimer *t = ALTERA_TIMER(dev);
+
+    ptimer_stop(t->ptimer);
+    ptimer_set_limit(t->ptimer, 0xffffffff, 1);
+    memset(t->regs, 0, ARRAY_SIZE(t->regs));
+}
+
+static Property altera_timer_properties[] = {
+    DEFINE_PROP_UINT32("clock-frequency", AlteraTimer, freq_hz, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void altera_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = altera_timer_realize;
+    dc->props = altera_timer_properties;
+    dc->reset = altera_timer_reset;
+}
+
+static const TypeInfo altera_timer_info = {
+    .name          = TYPE_ALTERA_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AlteraTimer),
+    .instance_init = altera_timer_init,
+    .class_init    = altera_timer_class_init,
+};
+
+static void altera_timer_register(void)
+{
+    type_register_static(&altera_timer_info);
+}
+
+type_init(altera_timer_register)
-- 
2.11.0
