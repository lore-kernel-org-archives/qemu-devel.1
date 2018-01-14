Received: from eggs.gnu.org ([2001:4830:134:3::10]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafxm-0005hU-HV
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafxi-0006Us-Vf
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:56:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41944
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eafxi-0006UK-Lx
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:56:26 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 14 Jan 2018 10:47:51 +0000
Message-Id: <20180114104751.21965-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 11/11] sparc64: convert hw/sparc64/sparc64.c
 from DPRINTF macros to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sparc64.c    | 85 ++++++++++++++++++++-----------------------------
 hw/sparc64/trace-events | 18 +++++++++++
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 95a06f00b2..408388945e 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -28,25 +28,9 @@
 #include "hw/char/serial.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
+#include "trace.h"
 
 
-//#define DEBUG_IRQ
-//#define DEBUG_TIMER
-
-#ifdef DEBUG_IRQ
-#define CPUIRQ_DPRINTF(fmt, ...)                                \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CPUIRQ_DPRINTF(fmt, ...)
-#endif
-
-#ifdef DEBUG_TIMER
-#define TIMER_DPRINTF(fmt, ...)                                  \
-    do { printf("TIMER: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define TIMER_DPRINTF(fmt, ...)
-#endif
-
 #define TICK_MAX             0x7fffffffffffffffULL
 
 void cpu_check_irqs(CPUSPARCState *env)
@@ -73,8 +57,7 @@ void cpu_check_irqs(CPUSPARCState *env)
        is (2 << psrpil). */
     if (pil < (2 << env->psrpil)) {
         if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-            CPUIRQ_DPRINTF("Reset CPU IRQ (current interrupt %x)\n",
-                           env->interrupt_index);
+            trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         }
@@ -92,22 +75,21 @@ void cpu_check_irqs(CPUSPARCState *env)
 
                 if (unlikely(env->tl > 0 && cpu_tsptr(env)->tt > new_interrupt
                   && ((cpu_tsptr(env)->tt & 0x1f0) == TT_EXTINT))) {
-                    CPUIRQ_DPRINTF("Not setting CPU IRQ: TL=%d "
-                                   "current %x >= pending %x\n",
-                                   env->tl, cpu_tsptr(env)->tt, new_interrupt);
+                    trace_sparc64_cpu_check_irqs_noset_irq(env->tl,
+                                                      cpu_tsptr(env)->tt,
+                                                      new_interrupt);
                 } else if (old_interrupt != new_interrupt) {
                     env->interrupt_index = new_interrupt;
-                    CPUIRQ_DPRINTF("Set CPU IRQ %d old=%x new=%x\n", i,
-                                   old_interrupt, new_interrupt);
+                    trace_sparc64_cpu_check_irqs_set_irq(i, old_interrupt,
+                                                         new_interrupt);
                     cpu_interrupt(cs, CPU_INTERRUPT_HARD);
                 }
                 break;
             }
         }
     } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-        CPUIRQ_DPRINTF("Interrupts disabled, pil=%08x pil_in=%08x softint=%08x "
-                       "current interrupt %x\n",
-                       pil, env->pil_in, env->softint, env->interrupt_index);
+        trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
+                                              env->interrupt_index);
         env->interrupt_index = 0;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
@@ -131,7 +113,7 @@ void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
 
     if (level) {
         if (!(env->ivec_status & 0x20)) {
-            CPUIRQ_DPRINTF("Raise IVEC IRQ %d\n", irq);
+            trace_sparc64_cpu_ivec_raise_irq(irq);
             cs = CPU(cpu);
             cs->halted = 0;
             env->interrupt_index = TT_IVEC;
@@ -143,7 +125,7 @@ void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
         }
     } else {
         if (env->ivec_status & 0x20) {
-            CPUIRQ_DPRINTF("Lower IVEC IRQ %d\n", irq);
+            trace_sparc64_cpu_ivec_lower_irq(irq);
             cs = CPU(cpu);
             env->ivec_status &= ~0x20;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -216,10 +198,10 @@ static void tick_irq(void *opaque)
     CPUTimer *timer = env->tick;
 
     if (timer->disabled) {
-        CPUIRQ_DPRINTF("tick_irq: softint disabled\n");
+        trace_sparc64_cpu_tick_irq_disabled();
         return;
     } else {
-        CPUIRQ_DPRINTF("tick: fire\n");
+        trace_sparc64_cpu_tick_irq_fire();
     }
 
     env->softint |= SOFTINT_TIMER;
@@ -234,10 +216,10 @@ static void stick_irq(void *opaque)
     CPUTimer *timer = env->stick;
 
     if (timer->disabled) {
-        CPUIRQ_DPRINTF("stick_irq: softint disabled\n");
+        trace_sparc64_cpu_stick_irq_disabled();
         return;
     } else {
-        CPUIRQ_DPRINTF("stick: fire\n");
+        trace_sparc64_cpu_stick_irq_fire();
     }
 
     env->softint |= SOFTINT_STIMER;
@@ -252,10 +234,10 @@ static void hstick_irq(void *opaque)
     CPUTimer *timer = env->hstick;
 
     if (timer->disabled) {
-        CPUIRQ_DPRINTF("hstick_irq: softint disabled\n");
+        trace_sparc64_cpu_hstick_irq_disabled();
         return;
     } else {
-        CPUIRQ_DPRINTF("hstick: fire\n");
+        trace_sparc64_cpu_hstick_irq_fire();
     }
 
     env->softint |= SOFTINT_STIMER;
@@ -280,9 +262,9 @@ void cpu_tick_set_count(CPUTimer *timer, uint64_t count)
     int64_t vm_clock_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                     cpu_to_timer_ticks(real_count, timer->frequency);
 
-    TIMER_DPRINTF("%s set_count count=0x%016lx (npt %s) p=%p\n",
-                  timer->name, real_count,
-                  timer->npt ? "disabled" : "enabled", timer);
+    trace_sparc64_cpu_tick_set_count(timer->name, real_count,
+                                     timer->npt ? "disabled" : "enabled",
+                                     timer);
 
     timer->npt = npt_bit ? 1 : 0;
     timer->clock_offset = vm_clock_offset;
@@ -294,9 +276,9 @@ uint64_t cpu_tick_get_count(CPUTimer *timer)
                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - timer->clock_offset,
                     timer->frequency);
 
-    TIMER_DPRINTF("%s get_count count=0x%016lx (npt %s) p=%p\n",
-           timer->name, real_count,
-           timer->npt ? "disabled" : "enabled", timer);
+    trace_sparc64_cpu_tick_get_count(timer->name, real_count,
+                                     timer->npt ? "disabled" : "enabled",
+                                     timer);
 
     if (timer->npt) {
         real_count |= timer->npt_mask;
@@ -319,18 +301,19 @@ void cpu_tick_set_limit(CPUTimer *timer, uint64_t limit)
         expires = now + 1;
     }
 
-    TIMER_DPRINTF("%s set_limit limit=0x%016lx (%s) p=%p "
-                  "called with limit=0x%016lx at 0x%016lx (delta=0x%016lx)\n",
-                  timer->name, real_limit,
-                  timer->disabled ? "disabled" : "enabled",
-                  timer, limit,
-                  timer_to_cpu_ticks(now - timer->clock_offset,
-                                     timer->frequency),
-                  timer_to_cpu_ticks(expires - now, timer->frequency));
+    trace_sparc64_cpu_tick_set_limit(timer->name, real_limit,
+                                     timer->disabled ? "disabled" : "enabled",
+                                     timer, limit,
+                                     timer_to_cpu_ticks(
+                                         now - timer->clock_offset,
+                                         timer->frequency
+                                     ),
+                                     timer_to_cpu_ticks(
+                                         expires - now, timer->frequency
+                                     ));
 
     if (!real_limit) {
-        TIMER_DPRINTF("%s set_limit limit=ZERO - not starting timer\n",
-                timer->name);
+        trace_sparc64_cpu_tick_set_limit_zero(timer->name);
         timer_del(timer->qtimer);
     } else if (timer->disabled) {
         timer_del(timer->qtimer);
diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
index 2ee2d75f70..cf0888581d 100644
--- a/hw/sparc64/trace-events
+++ b/hw/sparc64/trace-events
@@ -7,3 +7,21 @@ ebus_isa_irq_handler(int n, int level) "Set ISA IRQ %d level %d"
 sun4u_iommu_mem_read(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
 sun4u_iommu_mem_write(uint64_t addr, uint64_t val, int size) "addr: 0x%"PRIx64" val: 0x%"PRIx64" size: %d"
 sun4u_iommu_translate(uint64_t addr, uint64_t trans_addr, uint64_t tte) "xlate 0x%"PRIx64" => pa 0x%"PRIx64" tte: 0x%"PRIx64
+
+# hw/sparc64/sparc64.c
+sparc64_cpu_check_irqs_reset_irq(int intno) "Reset CPU IRQ (current interrupt 0x%x)"
+sparc64_cpu_check_irqs_noset_irq(uint32_t tl, uint32_t tt, int intno) "Not setting CPU IRQ: TL=%d current 0x%x >= pending 0x%x"
+sparc64_cpu_check_irqs_set_irq(unsigned int i, int old, int new) "Set CPU IRQ %d old=0x%x new=0x%x"
+sparc64_cpu_check_irqs_disabled(uint32_t pil, uint32_t pil_in, uint32_t softint, int intno) "Interrupts disabled, pil=0x%08x pil_in=0x%08x softint=0x%08x current interrupt 0x%x"
+sparc64_cpu_ivec_raise_irq(int irq) "Raise IVEC IRQ %d"
+sparc64_cpu_ivec_lower_irq(int irq) "Lower IVEC IRQ %d"
+sparc64_cpu_tick_irq_disabled(void) "tick_irq: softint disabled"
+sparc64_cpu_tick_irq_fire(void) "tick_irq: fire"
+sparc64_cpu_stick_irq_disabled(void) "stick_irq: softint disabled"
+sparc64_cpu_stick_irq_fire(void) "stick_irq: fire"
+sparc64_cpu_hstick_irq_disabled(void) "hstick_irq: softint disabled"
+sparc64_cpu_hstick_irq_fire(void) "hstick_irq: fire"
+sparc64_cpu_tick_set_count(const char *name, uint64_t real_count, const char *npt, void *p) "%s set_count count=0x%016lx (npt %s) p=%p"
+sparc64_cpu_tick_get_count(const char *name, uint64_t real_count, const char *npt, void *p) "%s get_count count=0x%016lx (npt %s) p=%p"
+sparc64_cpu_tick_set_limit(const char *name, uint64_t real_limit, const char *dis, void *p, uint64_t limit, uint64_t t, uint64_t dt) "%s set_limit limit=0x%016lx (%s) p=%p called with limit=0x%016lx at 0x%016lx (delta=0x%016lx)"
+sparc64_cpu_tick_set_limit_zero(const char *name) "%s set_limit limit=ZERO - not starting timer"
-- 
2.11.0
