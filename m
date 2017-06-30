Received: from eggs.gnu.org ([2001:4830:134:3::10]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRp-00006L-2a
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRl-0007y5-VY
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:26 +1000
Message-Id: <20170630104632.27942-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/21] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Aaron Larson <alarson@ddci.com>, David Gibson <david@gibson.dropbear.id.au>

From: Aaron Larson <alarson@ddci.com>

Previously QEMU open-pic implemented the 4 open-pic timers including
all timer registers, but the timers did not "count" or generate any
interrupts.  The patch makes the timers both count and generate
interrupts.  The timer clock frequency is fixed at 25MHZ.

--

Responding to V2 patch comments.
- Simplify clock frequency logic and commentary.
- Remove camelCase variables.
- Timer objects now created at init rather than lazily.

Signed-off-by: Aaron Larson <alarson@ddci.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 6 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 5595bb2..9dd285b 100644
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
@@ -246,9 +249,31 @@ typedef struct IRQSource {
 #define IDR_EP      0x80000000  /* external pin */
 #define IDR_CI      0x40000000  /* critical interrupt */
 
+/* Convert between openpic clock ticks and nanosecs.  In the hardware the clock
+   frequency is driven by board inputs to the PIC which the PIC would then
+   divide by 4 or 8.  For now hard code to 25MZ.
+*/
+#define OPENPIC_TIMER_FREQ_MHZ 25
+#define OPENPIC_TIMER_NS_PER_TICK (1000 / OPENPIC_TIMER_FREQ_MHZ)
+static inline uint64_t ns_to_ticks(uint64_t ns)
+{
+    return ns    / OPENPIC_TIMER_NS_PER_TICK;
+}
+static inline uint64_t ticks_to_ns(uint64_t ticks)
+{
+    return ticks * OPENPIC_TIMER_NS_PER_TICK;
+}
+
 typedef struct OpenPICTimer {
     uint32_t tccr;  /* Global timer current count register */
     uint32_t tbcr;  /* Global timer base count register */
+    int                   n_IRQ;
+    bool                  qemu_timer_active; /* Is the qemu_timer is running? */
+    struct QEMUTimer     *qemu_timer;
+    struct OpenPICState  *opp;          /* Device timer is part of. */
+    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
+       current_count written or read, only defined if qemu_timer_active. */
+    uint64_t              origin_time;
 } OpenPICTimer;
 
 typedef struct OpenPICMSI {
@@ -795,6 +820,65 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr addr, unsigned len)
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
+    uint64_t ns = ticks_to_ns(val & ~TCCR_TOG);
+    /* A count of zero causes a timer to be set to expire immediately.  This
+       effectively stops the simulation since the timer is constantly expiring
+       which prevents guest code execution, so we don't honor that
+       configuration.  On real hardware, this situation would generate an
+       interrupt on every clock cycle if the interrupt was unmasked. */
+    if ((ns == 0) || !enabled) {
+        tmr->qemu_timer_active = false;
+        tmr->tccr = tmr->tccr & TCCR_TOG;
+        timer_del(tmr->qemu_timer); /* set timer to never expire. */
+    } else {
+        tmr->qemu_timer_active = true;
+        uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        tmr->origin_time = now;
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
+        uint64_t used = now - tmr->origin_time;  /* nsecs */
+        uint32_t used_ticks = (uint32_t)ns_to_ticks(used);
+        uint32_t count = (tmr->tccr & ~TCCR_TOG) - used_ticks;
+        retval = (uint32_t)((tmr->tccr & TCCR_TOG) | (count & ~TCCR_TOG));
+    }
+    return retval;
+}
+
 static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned len)
 {
@@ -819,10 +903,15 @@ static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
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
@@ -854,7 +943,7 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     idx = (addr >> 6) & 0x3;
     switch (addr & 0x30) {
     case 0x00: /* TCCR */
-        retval = opp->timers[idx].tccr;
+        retval = openpic_tmr_get_timer(&opp->timers[idx]);
         break;
     case 0x10: /* TBCR */
         retval = opp->timers[idx].tbcr;
@@ -1136,7 +1225,10 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
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
@@ -1341,6 +1433,10 @@ static void openpic_reset(DeviceState *d)
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
@@ -1391,6 +1487,15 @@ static void fsl_common_init(OpenPICState *opp)
         opp->src[i].type = IRQ_TYPE_FSLSPECIAL;
         opp->src[i].level = false;
     }
+
+    for (i = 0; i < OPENPIC_MAX_TMR; i++) {
+        opp->timers[i].n_IRQ = opp->irq_tim0 + i;
+        opp->timers[i].qemu_timer_active = false;
+        opp->timers[i].qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                 &qemu_timer_cb,
+                                                 &opp->timers[i]);
+        opp->timers[i].opp = opp;
+    }
 }
 
 static void map_list(OpenPICState *opp, const MemReg *list, int *count)
-- 
2.9.4
