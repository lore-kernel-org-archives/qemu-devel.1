Received: from eggs.gnu.org ([2001:4830:134:3::10]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7N-0006OX-BC
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7J-0000Z1-BY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ7I-0000YY-Ni
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:09 -0500
Received: by mail-pg0-x242.google.com with SMTP id q12so1109007pgt.7
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:49:08 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:32 -0800
Message-Id: <1515628000-93285-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 13/21] SiFive RISC-V CLINT Block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

The CLINT (Core Local Interruptor) device provides real-time clock, timer
and interprocessor interrupts based on SiFive's CLINT specification.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_clint.c         | 312 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_clint.h |  56 ++++++++
 2 files changed, 368 insertions(+)
 create mode 100644 hw/riscv/sifive_clint.c
 create mode 100644 include/hw/riscv/sifive_clint.h

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
new file mode 100644
index 0000000..50d2a09
--- /dev/null
+++ b/hw/riscv/sifive_clint.c
@@ -0,0 +1,312 @@
+/*
+ * SiFive CLINT (Core Local Interruptor)
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * This provides real-time clock, timer and interprocessor interrupts.
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
+uint64_t cpu_riscv_read_instret(CPURISCVState *env)
+{
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), TIMER_FREQ,
+                    NANOSECONDS_PER_SECOND);
+}
+
+uint64_t cpu_riscv_read_rtc(void)
+{
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), TIMER_FREQ,
+                    NANOSECONDS_PER_SECOND);
+}
+
+static void sifive_clint_irq_request(void *opaque, int irq, int level)
+{
+    /* These are not the same irq numbers visible to the emulated processor. */
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    /* The CLINT currently uses irq 0 */
+
+    if (level) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        if (!env->mip && !env->mfromhost) {
+            /* no interrupts pending, no host interrupt for HTIF, reset */
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+/*
+ * Called when timecmp is written to update the QEMU timer or immediately
+ * trigger timer interrupt if mtimecmp <= current timer value.
+ */
+static void sifive_clint_timer_update(CPURISCVState *env)
+{
+    uint64_t next;
+    uint64_t diff;
+
+    uint64_t rtc_r = cpu_riscv_read_rtc();
+
+    if (env->timecmp <= rtc_r) {
+        /* if we're setting an MTIMECMP value in the "past",
+           immediately raise the timer interrupt */
+        env->mip |= MIP_MTIP;
+        qemu_irq_raise(env->irq[3]);
+        return;
+    }
+
+    /* otherwise, set up the future timer interrupt */
+    diff = env->timecmp - rtc_r;
+    /* back to ns (note args switched in muldiv64) */
+    next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+        muldiv64(diff, NANOSECONDS_PER_SECOND, TIMER_FREQ);
+    timer_mod(env->timer, next);
+}
+
+/*
+ * Called by the callback used when the timer set using timer_mod expires.
+ * Should raise the timer interrupt line
+ */
+static void sifive_clint_timer_expire(CPURISCVState *env)
+{
+    /* do not call update here */
+    env->mip |= MIP_MTIP;
+    qemu_irq_raise(env->irq[3]);
+}
+
+static void sifive_clint_write_timecmp(CPURISCVState *env, uint64_t value)
+{
+    env->timecmp = value;
+    env->mip &= ~MIP_MTIP;
+    sifive_clint_timer_update(env);
+}
+
+/*
+ * Callback used when the timer set using timer_mod expires.
+ */
+static void sifive_clint_timer_cb(void *opaque)
+{
+    CPURISCVState *env;
+    env = opaque;
+    sifive_clint_timer_expire(env);
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
+            if (value) {
+                env->mip |= MIP_MSIP;
+                qemu_irq_raise(env->irq[2]);
+            } else {
+                env->mip &= ~MIP_MSIP;
+                qemu_irq_lower(env->irq[2]);
+            }
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
+            sifive_clint_write_timecmp(env,
+                timecmp << 32 | (value & 0xFFFFFFFF));
+            return;
+        } else if ((addr & 0x7) == 4) {
+            /* timecmp_hi */
+            uint64_t timecmp = env->timecmp;
+            sifive_clint_write_timecmp(env,
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
+    int i, j;
+    for (i = 0; i < num_harts; i++) {
+        CPUState *cpu = qemu_get_cpu(i);
+        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        if (!env) {
+            continue;
+        }
+        for (j = 0; j < MAX_RISCV_IRQ; j++) {
+            env->irq[j] = qemu_allocate_irq(sifive_clint_irq_request,
+                riscv_env_get_cpu(env), 0 /* irq 0 */);
+        }
+        env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                  &sifive_clint_timer_cb, env);
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
index 0000000..cec3fbd
--- /dev/null
+++ b/include/hw/riscv/sifive_clint.h
@@ -0,0 +1,56 @@
+/*
+ * SiFive CLINT (Core Local Interruptor) interface
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017 SiFive, Inc.
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
