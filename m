Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR7t-0006cP-Cp
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR7r-0005KM-FI
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:20:05 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqR7r-0005IU-7H
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:20:03 -0500
Received: by mail-pl0-x244.google.com with SMTP id s13so10120842plq.6
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:20:03 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Feb 2018 11:17:51 +1300
Message-Id: <1519683480-33201-15-git-send-email-mjc@sifive.com>
In-Reply-To: <1519683480-33201-1-git-send-email-mjc@sifive.com>
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v7 14/23] SiFive RISC-V CLINT Block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

The CLINT (Core Local Interruptor) device provides real-time clock, timer
and interprocessor interrupts based on SiFive's CLINT specification.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_clint.c         | 254 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_clint.h |  50 ++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 hw/riscv/sifive_clint.c
 create mode 100644 include/hw/riscv/sifive_clint.h

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
new file mode 100644
index 0000000..4893453
--- /dev/null
+++ b/hw/riscv/sifive_clint.c
@@ -0,0 +1,254 @@
+/*
+ * SiFive CLINT (Core Local Interruptor)
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * This provides real-time clock, timer and interprocessor interrupts.
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
+#include "qemu/error-report.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/sifive_clint.h"
+#include "qemu/timer.h"
+
+/* See: riscv-pk/machine/sbi_entry.S and arch/riscv/kernel/time.c */
+#define TIMER_FREQ (10 * 1000 * 1000)
+
+static uint64_t cpu_riscv_read_rtc(void)
+{
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), TIMER_FREQ,
+                    NANOSECONDS_PER_SECOND);
+}
+
+/*
+ * Called when timecmp is written to update the QEMU timer or immediately
+ * trigger timer interrupt if mtimecmp <= current timer value.
+ */
+static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
+{
+    uint64_t next;
+    uint64_t diff;
+
+    uint64_t rtc_r = cpu_riscv_read_rtc();
+
+    cpu->env.timecmp = value;
+    if (cpu->env.timecmp <= rtc_r) {
+        /* if we're setting an MTIMECMP value in the "past",
+           immediately raise the timer interrupt */
+        riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+        return;
+    }
+
+    /* otherwise, set up the future timer interrupt */
+    riscv_set_local_interrupt(cpu, MIP_MTIP, 0);
+    diff = cpu->env.timecmp - rtc_r;
+    /* back to ns (note args switched in muldiv64) */
+    next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+        muldiv64(diff, NANOSECONDS_PER_SECOND, TIMER_FREQ);
+    timer_mod(cpu->env.timer, next);
+}
+
+/*
+ * Callback used when the timer set using timer_mod expires.
+ * Should raise the timer interrupt line
+ */
+static void sifive_clint_timer_cb(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+}
+
+/* CPU wants to read rtc or timecmp register */
+static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
+{
+    SiFiveCLINTState *clint = opaque;
+    if (addr >= clint->sip_base &&
+        addr < clint->sip_base + (clint->num_harts << 2)) {
+        size_t hartid = (addr - clint->sip_base) >> 2;
+        CPUState *cpu = qemu_get_cpu(hartid);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            error_report("clint: invalid timecmp hartid: %zu", hartid);
+        } else if ((addr & 0x3) == 0) {
+            return (env->mip & MIP_MSIP) > 0;
+        } else {
+            error_report("clint: invalid read: %08x", (uint32_t)addr);
+            return 0;
+        }
+    } else if (addr >= clint->timecmp_base &&
+        addr < clint->timecmp_base + (clint->num_harts << 3)) {
+        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        CPUState *cpu = qemu_get_cpu(hartid);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            error_report("clint: invalid timecmp hartid: %zu", hartid);
+        } else if ((addr & 0x7) == 0) {
+            /* timecmp_lo */
+            uint64_t timecmp = env->timecmp;
+            return timecmp & 0xFFFFFFFF;
+        } else if ((addr & 0x7) == 4) {
+            /* timecmp_hi */
+            uint64_t timecmp = env->timecmp;
+            return (timecmp >> 32) & 0xFFFFFFFF;
+        } else {
+            error_report("clint: invalid read: %08x", (uint32_t)addr);
+            return 0;
+        }
+    } else if (addr == clint->time_base) {
+        /* time_lo */
+        return cpu_riscv_read_rtc() & 0xFFFFFFFF;
+    } else if (addr == clint->time_base + 4) {
+        /* time_hi */
+        return (cpu_riscv_read_rtc() >> 32) & 0xFFFFFFFF;
+    }
+
+    error_report("clint: invalid read: %08x", (uint32_t)addr);
+    return 0;
+}
+
+/* CPU wrote to rtc or timecmp register */
+static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
+        unsigned size)
+{
+    SiFiveCLINTState *clint = opaque;
+
+    if (addr >= clint->sip_base &&
+        addr < clint->sip_base + (clint->num_harts << 2)) {
+        size_t hartid = (addr - clint->sip_base) >> 2;
+        CPUState *cpu = qemu_get_cpu(hartid);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            error_report("clint: invalid timecmp hartid: %zu", hartid);
+        } else if ((addr & 0x3) == 0) {
+            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MSIP, value != 0);
+        } else {
+            error_report("clint: invalid sip write: %08x", (uint32_t)addr);
+        }
+        return;
+    } else if (addr >= clint->timecmp_base &&
+        addr < clint->timecmp_base + (clint->num_harts << 3)) {
+        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        CPUState *cpu = qemu_get_cpu(hartid);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            error_report("clint: invalid timecmp hartid: %zu", hartid);
+        } else if ((addr & 0x7) == 0) {
+            /* timecmp_lo */
+            uint64_t timecmp = env->timecmp;
+            sifive_clint_write_timecmp(RISCV_CPU(cpu),
+                timecmp << 32 | (value & 0xFFFFFFFF));
+            return;
+        } else if ((addr & 0x7) == 4) {
+            /* timecmp_hi */
+            uint64_t timecmp = env->timecmp;
+            sifive_clint_write_timecmp(RISCV_CPU(cpu),
+                value << 32 | (timecmp & 0xFFFFFFFF));
+        } else {
+            error_report("clint: invalid timecmp write: %08x", (uint32_t)addr);
+        }
+        return;
+    } else if (addr == clint->time_base) {
+        /* time_lo */
+        error_report("clint: time_lo write not implemented");
+        return;
+    } else if (addr == clint->time_base + 4) {
+        /* time_hi */
+        error_report("clint: time_hi write not implemented");
+        return;
+    }
+
+    error_report("clint: invalid write: %08x", (uint32_t)addr);
+}
+
+static const MemoryRegionOps sifive_clint_ops = {
+    .read = sifive_clint_read,
+    .write = sifive_clint_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static Property sifive_clint_properties[] = {
+    DEFINE_PROP_UINT32("num-harts", SiFiveCLINTState, num_harts, 0),
+    DEFINE_PROP_UINT32("sip-base", SiFiveCLINTState, sip_base, 0),
+    DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
+    DEFINE_PROP_UINT32("time-base", SiFiveCLINTState, time_base, 0),
+    DEFINE_PROP_UINT32("aperture-size", SiFiveCLINTState, aperture_size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sifive_clint_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveCLINTState *s = SIFIVE_CLINT(dev);
+    memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_clint_ops, s,
+                          TYPE_SIFIVE_CLINT, s->aperture_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void sifive_clint_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = sifive_clint_realize;
+    dc->props = sifive_clint_properties;
+}
+
+static const TypeInfo sifive_clint_info = {
+    .name          = TYPE_SIFIVE_CLINT,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveCLINTState),
+    .class_init    = sifive_clint_class_init,
+};
+
+static void sifive_clint_register_types(void)
+{
+    type_register_static(&sifive_clint_info);
+}
+
+type_init(sifive_clint_register_types)
+
+
+/*
+ * Create CLINT device.
+ */
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base)
+{
+    int i;
+    for (i = 0; i < num_harts; i++) {
+        CPUState *cpu = qemu_get_cpu(i);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            continue;
+        }
+        env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                  &sifive_clint_timer_cb, cpu);
+        env->timecmp = 0;
+    }
+
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
+    qdev_prop_set_uint32(dev, "num-harts", num_harts);
+    qdev_prop_set_uint32(dev, "sip-base", sip_base);
+    qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
+    qdev_prop_set_uint32(dev, "time-base", time_base);
+    qdev_prop_set_uint32(dev, "aperture-size", size);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    return dev;
+}
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
new file mode 100644
index 0000000..aaa2a58
--- /dev/null
+++ b/include/hw/riscv/sifive_clint.h
@@ -0,0 +1,50 @@
+/*
+ * SiFive CLINT (Core Local Interruptor) interface
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017 SiFive, Inc.
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
+#ifndef HW_SIFIVE_CLINT_H
+#define HW_SIFIVE_CLINT_H
+
+#define TYPE_SIFIVE_CLINT "riscv.sifive.clint"
+
+#define SIFIVE_CLINT(obj) \
+    OBJECT_CHECK(SiFiveCLINTState, (obj), TYPE_SIFIVE_CLINT)
+
+typedef struct SiFiveCLINTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t num_harts;
+    uint32_t sip_base;
+    uint32_t timecmp_base;
+    uint32_t time_base;
+    uint32_t aperture_size;
+} SiFiveCLINTState;
+
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base);
+
+enum {
+    SIFIVE_SIP_BASE     = 0x0,
+    SIFIVE_TIMECMP_BASE = 0x4000,
+    SIFIVE_TIME_BASE    = 0xBFF8
+};
+
+#endif
-- 
2.7.0
