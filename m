Received: from eggs.gnu.org ([2001:4830:134:3::10]:50012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d5kTv-0007NK-22
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1d5kTs-00042r-CZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:57:35 -0400
Date: Tue, 2 May 2017 19:57:22 -0700
From: Aaron Larson <alarson@ddci.com>
Message-Id: <201705030257.v432vMO2008047@linux03a.ddci.com>
Subject: [Qemu-devel] [PATCH v2] target-ppc: Enable open-pic timers to count
 and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: agraf@suse.de, alarson@ddci.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


Previous QEMU open-pic implemented the 4 open-pic timers including all
timer registers, but the timers did not "count" or generate any
interrupts.  The patch makes the timers both count and generate
interrupts.  The timer clock frequency is fixed at 100MHZ.

Signed-off-by: Aaron Larson <alarson@ddci.com>
---
 hw/intc/openpic.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 18 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4349e45..e0556f1 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -45,6 +45,7 @@
 #include "qemu/bitops.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/log.h"
+#include "qemu/timer.h"
 
 //#define DEBUG_OPENPIC
 
@@ -54,8 +55,10 @@ static const int debug_openpic = 1;
 static const int debug_openpic = 0;
 #endif
 
+static int get_current_cpu(void);
 #define DPRINTF(fmt, ...) do { \
         if (debug_openpic) { \
+            printf("Core%d: ", get_current_cpu()); \
             printf(fmt , ## __VA_ARGS__); \
         } \
     } while (0)
@@ -246,9 +249,25 @@ typedef struct IRQSource {
 #define IDR_EP      0x80000000  /* external pin */
 #define IDR_CI      0x40000000  /* critical interrupt */
 
+/* Conversion between openpic clock ticks and nanosecs.  Ideally this clock
+   frequency would follow the openpic spec, for now hard code to 100mz.
+   A 100mhz clock, divided by 8, or 25mhz
+   25,000,000 ticks/sec, 25,000/ms, 25/us, 1 tick/40ns
+*/
+#define CONV_FACTOR 40LL
+static inline uint64_t ns_to_ticks(uint64_t ns)   { return ns   / CONV_FACTOR; }
+static inline uint64_t ticks_to_ns(uint64_t tick) { return tick * CONV_FACTOR; }
+
 typedef struct OpenPICTimer {
     uint32_t tccr;  /* Global timer current count register */
     uint32_t tbcr;  /* Global timer base count register */
+    int                   n_IRQ;
+    bool                  qemu_timer_active; /* Is the qemu_timer is running? */
+    struct QEMUTimer     *qemu_timer;   /* May be NULL if not created. */
+    struct OpenPICState  *opp;          /* Device timer is part of. */
+    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
+       current_count written or read, only defined if qemu_timer_active. */
+    uint64_t              originTime;
 } OpenPICTimer;
 
 typedef struct OpenPICMSI {
@@ -795,37 +814,102 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr addr, unsigned len)
     return retval;
 }
 
+static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, bool enabled);
+
+static void qemu_timer_cb(void *opaque)
+{
+    OpenPICTimer *tmr = opaque;
+    OpenPICState *opp = tmr->opp;
+    uint32_t    n_IRQ = tmr->n_IRQ;
+    uint32_t val =   tmr->tbcr & ~TBCR_CI;
+    uint32_t tog = ((tmr->tccr & TCCR_TOG) ^ TCCR_TOG);  /* invert toggle. */
+
+    DPRINTF("%s n_IRQ=%d\n", __func__, n_IRQ);
+    /* Reload current count from base count and setup timer. */
+    tmr->tccr = val | tog;
+    openpic_tmr_set_tmr(tmr, val, /*enabled=*/true);
+    /* Raise the interrupt. */
+    opp->src[n_IRQ].destmask = read_IRQreg_idr(opp, n_IRQ);
+    openpic_set_irq(opp, n_IRQ, 1);
+    openpic_set_irq(opp, n_IRQ, 0);
+}
+
+/* If enabled is true, arranges for an interrupt to be raised val clocks into
+   the future, if enabled is false cancels the timer. */
+static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, bool enabled)
+{
+    /* If timer doesn't exist, create it. */
+    if (tmr->qemu_timer == NULL) {
+        tmr->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &qemu_timer_cb, tmr);
+        DPRINTF("Created timer for n_IRQ %d\n", tmr->n_IRQ);
+    }
+    uint64_t ns = ticks_to_ns(val & ~TCCR_TOG);
+    /* A count of zero causes a timer to be set to expire immediately.  This
+       effectively stops the simulation so we don't honor that configuration.
+       On real hardware, this would generate an interrupt on every clock cycle
+       if the interrupt was unmasked. */
+    if ((ns == 0) || !enabled) {
+        tmr->qemu_timer_active = false;
+        tmr->tccr = tmr->tccr & TCCR_TOG;
+        timer_del(tmr->qemu_timer); /* set timer to never expire. */
+    } else {
+        tmr->qemu_timer_active = true;
+        uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        tmr->originTime = now;
+        timer_mod(tmr->qemu_timer, now + ns);     /* set timer expiration. */
+    }
+}
+
+/* Returns the currrent tccr value, i.e., timer value (in clocks) with
+   appropriate TOG. */
+static uint64_t openpic_tmr_get_timer(OpenPICTimer *tmr)
+{
+    uint64_t retval;
+    if (!tmr->qemu_timer_active) {
+        retval = tmr->tccr;
+    } else {
+        uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        uint64_t used = now - tmr->originTime;  /* nsecs */
+        uint32_t used_ticks = (uint32_t)ns_to_ticks(used);
+        uint32_t count = (tmr->tccr & ~TCCR_TOG) - used_ticks;
+        retval = (uint32_t)((tmr->tccr & TCCR_TOG) | (count & ~TCCR_TOG));
+    }
+    return retval;
+}
+
 static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
-                                unsigned len)
+                              unsigned len)
 {
     OpenPICState *opp = opaque;
     int idx;
 
-    addr += 0x10f0;
-
     DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
-            __func__, addr, val);
+            __func__, (addr + 0x10f0), val);
     if (addr & 0xF) {
         return;
     }
 
-    if (addr == 0x10f0) {
+    if (addr == 0) {
         /* TFRR */
         opp->tfrr = val;
         return;
     }
-
+    addr -= 0x10;  /* correct for TFRR */
     idx = (addr >> 6) & 0x3;
-    addr = addr & 0x30;
 
     switch (addr & 0x30) {
     case 0x00: /* TCCR */
         break;
     case 0x10: /* TBCR */
-        if ((opp->timers[idx].tccr & TCCR_TOG) != 0 &&
-            (val & TBCR_CI) == 0 &&
-            (opp->timers[idx].tbcr & TBCR_CI) != 0) {
-            opp->timers[idx].tccr &= ~TCCR_TOG;
+        /* Did the enable status change? */
+        if ((opp->timers[idx].tbcr & TBCR_CI) != (val & TBCR_CI)) {
+            /* Did "Count Inhibit" transition from 1 to 0? */
+            if ((val & TBCR_CI) == 0) {
+                opp->timers[idx].tccr = val & ~TCCR_TOG;
+            }
+            openpic_tmr_set_tmr(&opp->timers[idx],
+                                (val & ~TBCR_CI),
+                                /*enabled=*/((val & TBCR_CI) == 0));
         }
         opp->timers[idx].tbcr = val;
         break;
@@ -844,27 +928,28 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     uint32_t retval = -1;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
     if (addr & 0xF) {
         goto out;
     }
-    idx = (addr >> 6) & 0x3;
-    if (addr == 0x0) {
+    if (addr == 0) {
         /* TFRR */
         retval = opp->tfrr;
         goto out;
     }
+    addr -= 0x10;  /* correct for TFRR */
+    idx = (addr >> 6) & 0x3;
     switch (addr & 0x30) {
     case 0x00: /* TCCR */
-        retval = opp->timers[idx].tccr;
+        retval = openpic_tmr_get_timer(&opp->timers[idx]);
         break;
     case 0x10: /* TBCR */
         retval = opp->timers[idx].tbcr;
         break;
-    case 0x20: /* TIPV */
+    case 0x20: /* TVPR */
         retval = read_IRQreg_ivpr(opp, opp->irq_tim0 + idx);
         break;
-    case 0x30: /* TIDE (TIDR) */
+    case 0x30: /* TDR */
         retval = read_IRQreg_idr(opp, opp->irq_tim0 + idx);
         break;
     }
@@ -1138,7 +1223,10 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
         IRQ_resetbit(&dst->raised, irq);
     }
 
-    if ((irq >= opp->irq_ipi0) &&  (irq < (opp->irq_ipi0 + OPENPIC_MAX_IPI))) {
+    /* Timers and IPIs support multicast. */
+    if (((irq >= opp->irq_ipi0) && (irq < (opp->irq_ipi0 + OPENPIC_MAX_IPI))) ||
+        ((irq >= opp->irq_tim0) && (irq < (opp->irq_tim0 + OPENPIC_MAX_TMR)))) {
+        DPRINTF("irq is IPI or TMR\n");
         src->destmask &= ~(1 << cpu);
         if (src->destmask && !src->level) {
             /* trigger on CPUs that didn't know about it yet */
@@ -1343,6 +1431,10 @@ static void openpic_reset(DeviceState *d)
     for (i = 0; i < OPENPIC_MAX_TMR; i++) {
         opp->timers[i].tccr = 0;
         opp->timers[i].tbcr = TBCR_CI;
+        if (opp->timers[i].qemu_timer_active) {
+            timer_del(opp->timers[i].qemu_timer);  /* Inhibit timer */
+            opp->timers[i].qemu_timer_active = false;
+        }
     }
     /* Go out of RESET state */
     opp->gcr = 0;
@@ -1393,6 +1485,13 @@ static void fsl_common_init(OpenPICState *opp)
         opp->src[i].type = IRQ_TYPE_FSLSPECIAL;
         opp->src[i].level = false;
     }
+
+    for (i = 0; i < OPENPIC_MAX_TMR; i++) {
+        opp->timers[i].n_IRQ = opp->irq_tim0 + i;
+        opp->timers[i].qemu_timer_active = false;
+        opp->timers[i].qemu_timer = NULL;
+        opp->timers[i].opp = opp;
+    }
 }
 
 static void map_list(OpenPICState *opp, const MemReg *list, int *count)
-- 
2.7.4
