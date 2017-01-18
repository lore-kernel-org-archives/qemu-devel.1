Received: from eggs.gnu.org ([2001:4830:134:3::10]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyth-000761-Vu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytd-00036m-4i
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:40:06 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytc-00035y-P0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:40:01 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so7559600wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:40:00 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:42 +0100
Message-Id: <1484779123-18968-30-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 29/30] target-sparc: move common cpu
 initialisation routines to sparc64.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 hw/sparc64/Makefile.objs   |   1 +
 hw/sparc64/sparc64.c       | 378 +++++++++++++++++++++++++++++++++++++++++++++
 hw/sparc64/sun4u.c         | 348 +----------------------------------------
 hw/timer/sun4v-rtc.c       |   2 +-
 include/hw/sparc/sparc64.h |   5 +
 5 files changed, 389 insertions(+), 345 deletions(-)
 create mode 100644 hw/sparc64/sparc64.c
 create mode 100644 include/hw/sparc/sparc64.h

diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
index a84cfe3..a96b1f8 100644
--- a/hw/sparc64/Makefile.objs
+++ b/hw/sparc64/Makefile.objs
@@ -1 +1,2 @@
+obj-y += sparc64.o
 obj-y += sun4u.o
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
new file mode 100644
index 0000000..b3d219c
--- /dev/null
+++ b/hw/sparc64/sparc64.c
@@ -0,0 +1,378 @@
+/*
+ * QEMU Sun4u/Sun4v System Emulator common routines
+ *
+ * Copyright (c) 2005 Fabrice Bellard
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
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/char/serial.h"
+#include "hw/sparc/sparc64.h"
+#include "qemu/timer.h"
+
+
+//#define DEBUG_IRQ
+//#define DEBUG_TIMER
+
+#ifdef DEBUG_IRQ
+#define CPUIRQ_DPRINTF(fmt, ...)                                \
+    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define CPUIRQ_DPRINTF(fmt, ...)
+#endif
+
+#ifdef DEBUG_TIMER
+#define TIMER_DPRINTF(fmt, ...)                                  \
+    do { printf("TIMER: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define TIMER_DPRINTF(fmt, ...)
+#endif
+
+#define TICK_MAX             0x7fffffffffffffffULL
+
+void cpu_check_irqs(CPUSPARCState *env)
+{
+    CPUState *cs;
+    uint32_t pil = env->pil_in |
+                  (env->softint & ~(SOFTINT_TIMER | SOFTINT_STIMER));
+
+    /* TT_IVEC has a higher priority (16) than TT_EXTINT (31..17) */
+    if (env->ivec_status & 0x20) {
+        return;
+    }
+    cs = CPU(sparc_env_get_cpu(env));
+    /* check if TM or SM in SOFTINT are set
+       setting these also causes interrupt 14 */
+    if (env->softint & (SOFTINT_TIMER | SOFTINT_STIMER)) {
+        pil |= 1 << 14;
+    }
+
+    /* The bit corresponding to psrpil is (1<< psrpil), the next bit
+       is (2 << psrpil). */
+    if (pil < (2 << env->psrpil)) {
+        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+            CPUIRQ_DPRINTF("Reset CPU IRQ (current interrupt %x)\n",
+                           env->interrupt_index);
+            env->interrupt_index = 0;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+        return;
+    }
+
+    if (cpu_interrupts_enabled(env)) {
+
+        unsigned int i;
+
+        for (i = 15; i > env->psrpil; i--) {
+            if (pil & (1 << i)) {
+                int old_interrupt = env->interrupt_index;
+                int new_interrupt = TT_EXTINT | i;
+
+                if (unlikely(env->tl > 0 && cpu_tsptr(env)->tt > new_interrupt
+                  && ((cpu_tsptr(env)->tt & 0x1f0) == TT_EXTINT))) {
+                    CPUIRQ_DPRINTF("Not setting CPU IRQ: TL=%d "
+                                   "current %x >= pending %x\n",
+                                   env->tl, cpu_tsptr(env)->tt, new_interrupt);
+                } else if (old_interrupt != new_interrupt) {
+                    env->interrupt_index = new_interrupt;
+                    CPUIRQ_DPRINTF("Set CPU IRQ %d old=%x new=%x\n", i,
+                                   old_interrupt, new_interrupt);
+                    cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+                }
+                break;
+            }
+        }
+    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        CPUIRQ_DPRINTF("Interrupts disabled, pil=%08x pil_in=%08x softint=%08x "
+                       "current interrupt %x\n",
+                       pil, env->pil_in, env->softint, env->interrupt_index);
+        env->interrupt_index = 0;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+static void cpu_kick_irq(SPARCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    CPUSPARCState *env = &cpu->env;
+
+    cs->halted = 0;
+    cpu_check_irqs(env);
+    qemu_cpu_kick(cs);
+}
+
+void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    CPUState *cs;
+
+    if (level) {
+        if (!(env->ivec_status & 0x20)) {
+            CPUIRQ_DPRINTF("Raise IVEC IRQ %d\n", irq);
+            cs = CPU(cpu);
+            cs->halted = 0;
+            env->interrupt_index = TT_IVEC;
+            env->ivec_status |= 0x20;
+            env->ivec_data[0] = (0x1f << 6) | irq;
+            env->ivec_data[1] = 0;
+            env->ivec_data[2] = 0;
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    } else {
+        if (env->ivec_status & 0x20) {
+            CPUIRQ_DPRINTF("Lower IVEC IRQ %d\n", irq);
+            cs = CPU(cpu);
+            env->ivec_status &= ~0x20;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+typedef struct ResetData {
+    SPARCCPU *cpu;
+    uint64_t prom_addr;
+} ResetData;
+
+static CPUTimer *cpu_timer_create(const char *name, SPARCCPU *cpu,
+                                  QEMUBHFunc *cb, uint32_t frequency,
+                                  uint64_t disabled_mask, uint64_t npt_mask)
+{
+    CPUTimer *timer = g_malloc0(sizeof(CPUTimer));
+
+    timer->name = name;
+    timer->frequency = frequency;
+    timer->disabled_mask = disabled_mask;
+    timer->npt_mask = npt_mask;
+
+    timer->disabled = 1;
+    timer->npt = 1;
+    timer->clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    timer->qtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cb, cpu);
+
+    return timer;
+}
+
+static void cpu_timer_reset(CPUTimer *timer)
+{
+    timer->disabled = 1;
+    timer->clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    timer_del(timer->qtimer);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    ResetData *s = (ResetData *)opaque;
+    CPUSPARCState *env = &s->cpu->env;
+    static unsigned int nr_resets;
+
+    cpu_reset(CPU(s->cpu));
+
+    cpu_timer_reset(env->tick);
+    cpu_timer_reset(env->stick);
+    cpu_timer_reset(env->hstick);
+
+    env->gregs[1] = 0; /* Memory start */
+    env->gregs[2] = ram_size; /* Memory size */
+    env->gregs[3] = 0; /* Machine description XXX */
+    if (nr_resets++ == 0) {
+        /* Power on reset */
+        env->pc = s->prom_addr + 0x20ULL;
+    } else {
+        env->pc = s->prom_addr + 0x40ULL;
+    }
+    env->npc = env->pc + 4;
+}
+
+static void tick_irq(void *opaque)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+
+    CPUTimer *timer = env->tick;
+
+    if (timer->disabled) {
+        CPUIRQ_DPRINTF("tick_irq: softint disabled\n");
+        return;
+    } else {
+        CPUIRQ_DPRINTF("tick: fire\n");
+    }
+
+    env->softint |= SOFTINT_TIMER;
+    cpu_kick_irq(cpu);
+}
+
+static void stick_irq(void *opaque)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+
+    CPUTimer *timer = env->stick;
+
+    if (timer->disabled) {
+        CPUIRQ_DPRINTF("stick_irq: softint disabled\n");
+        return;
+    } else {
+        CPUIRQ_DPRINTF("stick: fire\n");
+    }
+
+    env->softint |= SOFTINT_STIMER;
+    cpu_kick_irq(cpu);
+}
+
+static void hstick_irq(void *opaque)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+
+    CPUTimer *timer = env->hstick;
+
+    if (timer->disabled) {
+        CPUIRQ_DPRINTF("hstick_irq: softint disabled\n");
+        return;
+    } else {
+        CPUIRQ_DPRINTF("hstick: fire\n");
+    }
+
+    env->softint |= SOFTINT_STIMER;
+    cpu_kick_irq(cpu);
+}
+
+static int64_t cpu_to_timer_ticks(int64_t cpu_ticks, uint32_t frequency)
+{
+    return muldiv64(cpu_ticks, NANOSECONDS_PER_SECOND, frequency);
+}
+
+static uint64_t timer_to_cpu_ticks(int64_t timer_ticks, uint32_t frequency)
+{
+    return muldiv64(timer_ticks, frequency, NANOSECONDS_PER_SECOND);
+}
+
+void cpu_tick_set_count(CPUTimer *timer, uint64_t count)
+{
+    uint64_t real_count = count & ~timer->npt_mask;
+    uint64_t npt_bit = count & timer->npt_mask;
+
+    int64_t vm_clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
+                    cpu_to_timer_ticks(real_count, timer->frequency);
+
+    TIMER_DPRINTF("%s set_count count=0x%016lx (npt %s) p=%p\n",
+                  timer->name, real_count,
+                  timer->npt ? "disabled" : "enabled", timer);
+
+    timer->npt = npt_bit ? 1 : 0;
+    timer->clock_offset = vm_clock_offset;
+}
+
+uint64_t cpu_tick_get_count(CPUTimer *timer)
+{
+    uint64_t real_count = timer_to_cpu_ticks(
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - timer->clock_offset,
+                    timer->frequency);
+
+    TIMER_DPRINTF("%s get_count count=0x%016lx (npt %s) p=%p\n",
+           timer->name, real_count,
+           timer->npt ? "disabled" : "enabled", timer);
+
+    if (timer->npt) {
+        real_count |= timer->npt_mask;
+    }
+
+    return real_count;
+}
+
+void cpu_tick_set_limit(CPUTimer *timer, uint64_t limit)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    uint64_t real_limit = limit & ~timer->disabled_mask;
+    timer->disabled = (limit & timer->disabled_mask) ? 1 : 0;
+
+    int64_t expires = cpu_to_timer_ticks(real_limit, timer->frequency) +
+                    timer->clock_offset;
+
+    if (expires < now) {
+        expires = now + 1;
+    }
+
+    TIMER_DPRINTF("%s set_limit limit=0x%016lx (%s) p=%p "
+                  "called with limit=0x%016lx at 0x%016lx (delta=0x%016lx)\n",
+                  timer->name, real_limit,
+                  timer->disabled ? "disabled" : "enabled",
+                  timer, limit,
+                  timer_to_cpu_ticks(now - timer->clock_offset,
+                                     timer->frequency),
+                  timer_to_cpu_ticks(expires - now, timer->frequency));
+
+    if (!real_limit) {
+        TIMER_DPRINTF("%s set_limit limit=ZERO - not starting timer\n",
+                timer->name);
+        timer_del(timer->qtimer);
+    } else if (timer->disabled) {
+        timer_del(timer->qtimer);
+    } else {
+        timer_mod(timer->qtimer, expires);
+    }
+}
+
+SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
+                              const char *default_cpu_model, uint64_t prom_addr)
+{
+    SPARCCPU *cpu;
+    CPUSPARCState *env;
+    ResetData *reset_info;
+
+    uint32_t   tick_frequency = 100 * 1000000;
+    uint32_t  stick_frequency = 100 * 1000000;
+    uint32_t hstick_frequency = 100 * 1000000;
+
+    if (cpu_model == NULL) {
+        cpu_model = default_cpu_model;
+    }
+    cpu = cpu_sparc_init(cpu_model);
+    if (cpu == NULL) {
+        fprintf(stderr, "Unable to find Sparc CPU definition\n");
+        exit(1);
+    }
+    env = &cpu->env;
+
+    env->tick = cpu_timer_create("tick", cpu, tick_irq,
+                                  tick_frequency, TICK_INT_DIS,
+                                  TICK_NPT_MASK);
+
+    env->stick = cpu_timer_create("stick", cpu, stick_irq,
+                                   stick_frequency, TICK_INT_DIS,
+                                   TICK_NPT_MASK);
+
+    env->hstick = cpu_timer_create("hstick", cpu, hstick_irq,
+                                    hstick_frequency, TICK_INT_DIS,
+                                    TICK_NPT_MASK);
+
+    reset_info = g_malloc0(sizeof(ResetData));
+    reset_info->cpu = cpu;
+    reset_info->prom_addr = prom_addr;
+    qemu_register_reset(main_cpu_reset, reset_info);
+
+    return cpu;
+}
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4663315..232d4a6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -38,25 +38,15 @@
 #include "hw/boards.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/nvram/chrp_nvram.h"
+#include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "sysemu/block-backend.h"
-#include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 
-//#define DEBUG_IRQ
 //#define DEBUG_EBUS
-//#define DEBUG_TIMER
-
-#ifdef DEBUG_IRQ
-#define CPUIRQ_DPRINTF(fmt, ...)                                \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CPUIRQ_DPRINTF(fmt, ...)
-#endif
 
 #ifdef DEBUG_EBUS
 #define EBUS_DPRINTF(fmt, ...)                                  \
@@ -65,13 +55,6 @@
 #define EBUS_DPRINTF(fmt, ...)
 #endif
 
-#ifdef DEBUG_TIMER
-#define TIMER_DPRINTF(fmt, ...)                                  \
-    do { printf("TIMER: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define TIMER_DPRINTF(fmt, ...)
-#endif
-
 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
 #define PROM_SIZE_MAX        (4 * 1024 * 1024)
@@ -89,8 +72,6 @@
 
 #define IVEC_MAX             0x40
 
-#define TICK_MAX             0x7fffffffffffffffULL
-
 struct hwdef {
     const char * const default_cpu_model;
     uint16_t machine_id;
@@ -216,293 +197,11 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
     return kernel_size;
 }
 
-void cpu_check_irqs(CPUSPARCState *env)
-{
-    CPUState *cs;
-    uint32_t pil = env->pil_in |
-                  (env->softint & ~(SOFTINT_TIMER | SOFTINT_STIMER));
-
-    /* TT_IVEC has a higher priority (16) than TT_EXTINT (31..17) */
-    if (env->ivec_status & 0x20) {
-        return;
-    }
-    cs = CPU(sparc_env_get_cpu(env));
-    /* check if TM or SM in SOFTINT are set
-       setting these also causes interrupt 14 */
-    if (env->softint & (SOFTINT_TIMER | SOFTINT_STIMER)) {
-        pil |= 1 << 14;
-    }
-
-    /* The bit corresponding to psrpil is (1<< psrpil), the next bit
-       is (2 << psrpil). */
-    if (pil < (2 << env->psrpil)){
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-            CPUIRQ_DPRINTF("Reset CPU IRQ (current interrupt %x)\n",
-                           env->interrupt_index);
-            env->interrupt_index = 0;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-        return;
-    }
-
-    if (cpu_interrupts_enabled(env)) {
-
-        unsigned int i;
-
-        for (i = 15; i > env->psrpil; i--) {
-            if (pil & (1 << i)) {
-                int old_interrupt = env->interrupt_index;
-                int new_interrupt = TT_EXTINT | i;
-
-                if (unlikely(env->tl > 0 && cpu_tsptr(env)->tt > new_interrupt
-                  && ((cpu_tsptr(env)->tt & 0x1f0) == TT_EXTINT))) {
-                    CPUIRQ_DPRINTF("Not setting CPU IRQ: TL=%d "
-                                   "current %x >= pending %x\n",
-                                   env->tl, cpu_tsptr(env)->tt, new_interrupt);
-                } else if (old_interrupt != new_interrupt) {
-                    env->interrupt_index = new_interrupt;
-                    CPUIRQ_DPRINTF("Set CPU IRQ %d old=%x new=%x\n", i,
-                                   old_interrupt, new_interrupt);
-                    cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-                }
-                break;
-            }
-        }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-        CPUIRQ_DPRINTF("Interrupts disabled, pil=%08x pil_in=%08x softint=%08x "
-                       "current interrupt %x\n",
-                       pil, env->pil_in, env->softint, env->interrupt_index);
-        env->interrupt_index = 0;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
-}
-
-static void cpu_kick_irq(SPARCCPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-    CPUSPARCState *env = &cpu->env;
-
-    cs->halted = 0;
-    cpu_check_irqs(env);
-    qemu_cpu_kick(cs);
-}
-
-static void cpu_set_ivec_irq(void *opaque, int irq, int level)
-{
-    SPARCCPU *cpu = opaque;
-    CPUSPARCState *env = &cpu->env;
-    CPUState *cs;
-
-    if (level) {
-        if (!(env->ivec_status & 0x20)) {
-            CPUIRQ_DPRINTF("Raise IVEC IRQ %d\n", irq);
-            cs = CPU(cpu);
-            cs->halted = 0;
-            env->interrupt_index = TT_IVEC;
-            env->ivec_status |= 0x20;
-            env->ivec_data[0] = (0x1f << 6) | irq;
-            env->ivec_data[1] = 0;
-            env->ivec_data[2] = 0;
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    } else {
-        if (env->ivec_status & 0x20) {
-            CPUIRQ_DPRINTF("Lower IVEC IRQ %d\n", irq);
-            cs = CPU(cpu);
-            env->ivec_status &= ~0x20;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    }
-}
-
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint64_t prom_addr;
 } ResetData;
 
-static CPUTimer *cpu_timer_create(const char *name, SPARCCPU *cpu,
-                                  QEMUBHFunc *cb, uint32_t frequency,
-                                  uint64_t disabled_mask, uint64_t npt_mask)
-{
-    CPUTimer *timer = g_malloc0(sizeof (CPUTimer));
-
-    timer->name = name;
-    timer->frequency = frequency;
-    timer->disabled_mask = disabled_mask;
-    timer->npt_mask = npt_mask;
-
-    timer->disabled = 1;
-    timer->npt = 1;
-    timer->clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-    timer->qtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cb, cpu);
-
-    return timer;
-}
-
-static void cpu_timer_reset(CPUTimer *timer)
-{
-    timer->disabled = 1;
-    timer->clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-    timer_del(timer->qtimer);
-}
-
-static void main_cpu_reset(void *opaque)
-{
-    ResetData *s = (ResetData *)opaque;
-    CPUSPARCState *env = &s->cpu->env;
-    static unsigned int nr_resets;
-
-    cpu_reset(CPU(s->cpu));
-
-    cpu_timer_reset(env->tick);
-    cpu_timer_reset(env->stick);
-    cpu_timer_reset(env->hstick);
-
-    env->gregs[1] = 0; // Memory start
-    env->gregs[2] = ram_size; // Memory size
-    env->gregs[3] = 0; // Machine description XXX
-    if (nr_resets++ == 0) {
-        /* Power on reset */
-        env->pc = s->prom_addr + 0x20ULL;
-    } else {
-        env->pc = s->prom_addr + 0x40ULL;
-    }
-    env->npc = env->pc + 4;
-}
-
-static void tick_irq(void *opaque)
-{
-    SPARCCPU *cpu = opaque;
-    CPUSPARCState *env = &cpu->env;
-
-    CPUTimer* timer = env->tick;
-
-    if (timer->disabled) {
-        CPUIRQ_DPRINTF("tick_irq: softint disabled\n");
-        return;
-    } else {
-        CPUIRQ_DPRINTF("tick: fire\n");
-    }
-
-    env->softint |= SOFTINT_TIMER;
-    cpu_kick_irq(cpu);
-}
-
-static void stick_irq(void *opaque)
-{
-    SPARCCPU *cpu = opaque;
-    CPUSPARCState *env = &cpu->env;
-
-    CPUTimer* timer = env->stick;
-
-    if (timer->disabled) {
-        CPUIRQ_DPRINTF("stick_irq: softint disabled\n");
-        return;
-    } else {
-        CPUIRQ_DPRINTF("stick: fire\n");
-    }
-
-    env->softint |= SOFTINT_STIMER;
-    cpu_kick_irq(cpu);
-}
-
-static void hstick_irq(void *opaque)
-{
-    SPARCCPU *cpu = opaque;
-    CPUSPARCState *env = &cpu->env;
-
-    CPUTimer* timer = env->hstick;
-
-    if (timer->disabled) {
-        CPUIRQ_DPRINTF("hstick_irq: softint disabled\n");
-        return;
-    } else {
-        CPUIRQ_DPRINTF("hstick: fire\n");
-    }
-
-    env->softint |= SOFTINT_STIMER;
-    cpu_kick_irq(cpu);
-}
-
-static int64_t cpu_to_timer_ticks(int64_t cpu_ticks, uint32_t frequency)
-{
-    return muldiv64(cpu_ticks, NANOSECONDS_PER_SECOND, frequency);
-}
-
-static uint64_t timer_to_cpu_ticks(int64_t timer_ticks, uint32_t frequency)
-{
-    return muldiv64(timer_ticks, frequency, NANOSECONDS_PER_SECOND);
-}
-
-void cpu_tick_set_count(CPUTimer *timer, uint64_t count)
-{
-    uint64_t real_count = count & ~timer->npt_mask;
-    uint64_t npt_bit = count & timer->npt_mask;
-
-    int64_t vm_clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
-                    cpu_to_timer_ticks(real_count, timer->frequency);
-
-    TIMER_DPRINTF("%s set_count count=0x%016lx (npt %s) p=%p\n",
-                  timer->name, real_count,
-                  timer->npt ? "disabled" : "enabled", timer);
-
-    timer->npt = npt_bit ? 1 : 0;
-    timer->clock_offset = vm_clock_offset;
-}
-
-uint64_t cpu_tick_get_count(CPUTimer *timer)
-{
-    uint64_t real_count = timer_to_cpu_ticks(
-                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - timer->clock_offset,
-                    timer->frequency);
-
-    TIMER_DPRINTF("%s get_count count=0x%016lx (npt %s) p=%p\n",
-           timer->name, real_count,
-           timer->npt ? "disabled" : "enabled", timer);
-
-    if (timer->npt) {
-        real_count |= timer->npt_mask;
-    }
-
-    return real_count;
-}
-
-void cpu_tick_set_limit(CPUTimer *timer, uint64_t limit)
-{
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-    uint64_t real_limit = limit & ~timer->disabled_mask;
-    timer->disabled = (limit & timer->disabled_mask) ? 1 : 0;
-
-    int64_t expires = cpu_to_timer_ticks(real_limit, timer->frequency) +
-                    timer->clock_offset;
-
-    if (expires < now) {
-        expires = now + 1;
-    }
-
-    TIMER_DPRINTF("%s set_limit limit=0x%016lx (%s) p=%p "
-                  "called with limit=0x%016lx at 0x%016lx (delta=0x%016lx)\n",
-                  timer->name, real_limit,
-                  timer->disabled?"disabled":"enabled",
-                  timer, limit,
-                  timer_to_cpu_ticks(now - timer->clock_offset,
-                                     timer->frequency),
-                  timer_to_cpu_ticks(expires - now, timer->frequency));
-
-    if (!real_limit) {
-        TIMER_DPRINTF("%s set_limit limit=ZERO - not starting timer\n",
-                timer->name);
-        timer_del(timer->qtimer);
-    } else if (timer->disabled) {
-        timer_del(timer->qtimer);
-    } else {
-        timer_mod(timer->qtimer, expires);
-    }
-}
-
 static void isa_irq_handler(void *opaque, int n, int level)
 {
     static const int isa_irq_to_ivec[16] = {
@@ -723,46 +422,6 @@ static const TypeInfo ram_info = {
     .class_init    = ram_class_init,
 };
 
-static SPARCCPU *cpu_devinit(const char *cpu_model, const struct hwdef *hwdef)
-{
-    SPARCCPU *cpu;
-    CPUSPARCState *env;
-    ResetData *reset_info;
-
-    uint32_t   tick_frequency = 100*1000000;
-    uint32_t  stick_frequency = 100*1000000;
-    uint32_t hstick_frequency = 100*1000000;
-
-    if (cpu_model == NULL) {
-        cpu_model = hwdef->default_cpu_model;
-    }
-    cpu = cpu_sparc_init(cpu_model);
-    if (cpu == NULL) {
-        fprintf(stderr, "Unable to find Sparc CPU definition\n");
-        exit(1);
-    }
-    env = &cpu->env;
-
-    env->tick = cpu_timer_create("tick", cpu, tick_irq,
-                                  tick_frequency, TICK_INT_DIS,
-                                  TICK_NPT_MASK);
-
-    env->stick = cpu_timer_create("stick", cpu, stick_irq,
-                                   stick_frequency, TICK_INT_DIS,
-                                   TICK_NPT_MASK);
-
-    env->hstick = cpu_timer_create("hstick", cpu, hstick_irq,
-                                    hstick_frequency, TICK_INT_DIS,
-                                    TICK_NPT_MASK);
-
-    reset_info = g_malloc0(sizeof(ResetData));
-    reset_info->cpu = cpu;
-    reset_info->prom_addr = hwdef->prom_addr;
-    qemu_register_reset(main_cpu_reset, reset_info);
-
-    return cpu;
-}
-
 static void sun4uv_init(MemoryRegion *address_space_mem,
                         MachineState *machine,
                         const struct hwdef *hwdef)
@@ -781,14 +440,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     FWCfgState *fw_cfg;
 
     /* init CPUs */
-    cpu = cpu_devinit(machine->cpu_model, hwdef);
+    cpu = sparc64_cpu_devinit(machine->cpu_model, hwdef->default_cpu_model,
+                              hwdef->prom_addr);
 
     /* set up devices */
     ram_init(0, machine->ram_size);
 
     prom_init(hwdef->prom_addr, bios_name);
 
-    ivec_irqs = qemu_allocate_irqs(cpu_set_ivec_irq, cpu, IVEC_MAX);
+    ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
     pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_bus2,
                            &pci_bus3, &pbm_irqs);
     pci_vga_init(pci_bus);
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 82e9e14..31052322 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -36,7 +36,7 @@ typedef struct Sun4vRtc {
 static uint64_t sun4v_rtc_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    uint64_t val = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    uint64_t val = get_clock_realtime() / NANOSECONDS_PER_SECOND;
     if (!(addr & 4ULL)) {
         /* accessing the high 32 bits */
         val >>= 32;
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
new file mode 100644
index 0000000..7748939
--- /dev/null
+++ b/include/hw/sparc/sparc64.h
@@ -0,0 +1,5 @@
+
+SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
+                              const char *dflt_cpu_model, uint64_t prom_addr);
+
+void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level);
-- 
2.7.2
