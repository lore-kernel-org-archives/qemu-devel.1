Received: from eggs.gnu.org ([2001:4830:134:3::10]:53362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixQ-0003i7-JC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0004gg-0b
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:52 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:19 +1100
Message-Id: <20171215055435.24204-9-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/24] openpic: debug w/ info_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Davidsaver <mdavidsaver@gmail.com>

Replace *printf() with *_report().
Remove trailing new lines.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/openpic.c | 102 +++++++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 10d6e871fb..9159a06f07 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -46,6 +46,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 
 //#define DEBUG_OPENPIC
 
@@ -58,8 +59,7 @@ static const int debug_openpic = 0;
 static int get_current_cpu(void);
 #define DPRINTF(fmt, ...) do { \
         if (debug_openpic) { \
-            printf("Core%d: ", get_current_cpu()); \
-            printf(fmt , ## __VA_ARGS__); \
+            info_report("Core%d: " fmt, get_current_cpu(), ## __VA_ARGS__); \
         } \
     } while (0)
 
@@ -173,7 +173,7 @@ static int inttgt_to_output(int inttgt)
         }
     }
 
-    fprintf(stderr, "%s: unsupported inttgt %d\n", __func__, inttgt);
+    error_report("%s: unsupported inttgt %d", __func__, inttgt);
     return OPENPIC_OUTPUT_INT;
 }
 
@@ -372,7 +372,7 @@ static void IRQ_check(OpenPICState *opp, IRQQueue *q)
             break;
         }
 
-        DPRINTF("IRQ_check: irq %d set ivpr_pr=%d pr=%d\n",
+        DPRINTF("IRQ_check: irq %d set ivpr_pr=%d pr=%d",
                 irq, IVPR_PRIORITY(opp->src[irq].ivpr), priority);
 
         if (IVPR_PRIORITY(opp->src[irq].ivpr) > priority) {
@@ -403,11 +403,11 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_CPU, int n_IRQ,
     dst = &opp->dst[n_CPU];
     src = &opp->src[n_IRQ];
 
-    DPRINTF("%s: IRQ %d active %d was %d\n",
+    DPRINTF("%s: IRQ %d active %d was %d",
             __func__, n_IRQ, active, was_active);
 
     if (src->output != OPENPIC_OUTPUT_INT) {
-        DPRINTF("%s: output %d irq %d active %d was %d count %d\n",
+        DPRINTF("%s: output %d irq %d active %d was %d count %d",
                 __func__, src->output, n_IRQ, active, was_active,
                 dst->outputs_active[src->output]);
 
@@ -417,13 +417,13 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_CPU, int n_IRQ,
          */
         if (active) {
             if (!was_active && dst->outputs_active[src->output]++ == 0) {
-                DPRINTF("%s: Raise OpenPIC output %d cpu %d irq %d\n",
+                DPRINTF("%s: Raise OpenPIC output %d cpu %d irq %d",
                         __func__, src->output, n_CPU, n_IRQ);
                 qemu_irq_raise(dst->irqs[src->output]);
             }
         } else {
             if (was_active && --dst->outputs_active[src->output] == 0) {
-                DPRINTF("%s: Lower OpenPIC output %d cpu %d irq %d\n",
+                DPRINTF("%s: Lower OpenPIC output %d cpu %d irq %d",
                         __func__, src->output, n_CPU, n_IRQ);
                 qemu_irq_lower(dst->irqs[src->output]);
             }
@@ -446,7 +446,7 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_CPU, int n_IRQ,
     IRQ_check(opp, &dst->raised);
 
     if (active && priority <= dst->ctpr) {
-        DPRINTF("%s: IRQ %d priority %d too low for ctpr %d on CPU %d\n",
+        DPRINTF("%s: IRQ %d priority %d too low for ctpr %d on CPU %d",
                 __func__, n_IRQ, priority, dst->ctpr, n_CPU);
         active = 0;
     }
@@ -454,10 +454,10 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_CPU, int n_IRQ,
     if (active) {
         if (IRQ_get_next(opp, &dst->servicing) >= 0 &&
                 priority <= dst->servicing.priority) {
-            DPRINTF("%s: IRQ %d is hidden by servicing IRQ %d on CPU %d\n",
+            DPRINTF("%s: IRQ %d is hidden by servicing IRQ %d on CPU %d",
                     __func__, n_IRQ, dst->servicing.next, n_CPU);
         } else {
-            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d/%d\n",
+            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d/%d",
                     __func__, n_CPU, n_IRQ, dst->raised.next);
             qemu_irq_raise(opp->dst[n_CPU].irqs[OPENPIC_OUTPUT_INT]);
         }
@@ -465,12 +465,12 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_CPU, int n_IRQ,
         IRQ_get_next(opp, &dst->servicing);
         if (dst->raised.priority > dst->ctpr &&
                 dst->raised.priority > dst->servicing.priority) {
-            DPRINTF("%s: IRQ %d inactive, IRQ %d prio %d above %d/%d, CPU %d\n",
+            DPRINTF("%s: IRQ %d inactive, IRQ %d prio %d above %d/%d, CPU %d",
                     __func__, n_IRQ, dst->raised.next, dst->raised.priority,
                     dst->ctpr, dst->servicing.priority, n_CPU);
             /* IRQ line stays asserted */
         } else {
-            DPRINTF("%s: IRQ %d inactive, current prio %d/%d, CPU %d\n",
+            DPRINTF("%s: IRQ %d inactive, current prio %d/%d, CPU %d",
                     __func__, n_IRQ, dst->ctpr, dst->servicing.priority, n_CPU);
             qemu_irq_lower(opp->dst[n_CPU].irqs[OPENPIC_OUTPUT_INT]);
         }
@@ -489,7 +489,7 @@ static void openpic_update_irq(OpenPICState *opp, int n_IRQ)
 
     if ((src->ivpr & IVPR_MASK_MASK) && !src->nomask) {
         /* Interrupt source is disabled */
-        DPRINTF("%s: IRQ %d is disabled\n", __func__, n_IRQ);
+        DPRINTF("%s: IRQ %d is disabled", __func__, n_IRQ);
         active = false;
     }
 
@@ -500,7 +500,7 @@ static void openpic_update_irq(OpenPICState *opp, int n_IRQ)
      * ctpr may have changed and we need to withdraw the interrupt.
      */
     if (!active && !was_active) {
-        DPRINTF("%s: IRQ %d is already inactive\n", __func__, n_IRQ);
+        DPRINTF("%s: IRQ %d is already inactive", __func__, n_IRQ);
         return;
     }
 
@@ -512,7 +512,7 @@ static void openpic_update_irq(OpenPICState *opp, int n_IRQ)
 
     if (src->destmask == 0) {
         /* No target */
-        DPRINTF("%s: IRQ %d has no target\n", __func__, n_IRQ);
+        DPRINTF("%s: IRQ %d has no target", __func__, n_IRQ);
         return;
     }
 
@@ -547,12 +547,12 @@ static void openpic_set_irq(void *opaque, int n_IRQ, int level)
     IRQSource *src;
 
     if (n_IRQ >= OPENPIC_MAX_IRQ) {
-        fprintf(stderr, "%s: IRQ %d out of range\n", __func__, n_IRQ);
+        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
         abort();
     }
 
     src = &opp->src[n_IRQ];
-    DPRINTF("openpic: set irq %d = %d ivpr=0x%08x\n",
+    DPRINTF("openpic: set irq %d = %d ivpr=0x%08x",
             n_IRQ, level, src->ivpr);
     if (src->level) {
         /* level-sensitive irq */
@@ -612,13 +612,13 @@ static inline void write_IRQreg_idr(OpenPICState *opp, int n_IRQ, uint32_t val)
     }
 
     src->idr = val & mask;
-    DPRINTF("Set IDR %d to 0x%08x\n", n_IRQ, src->idr);
+    DPRINTF("Set IDR %d to 0x%08x", n_IRQ, src->idr);
 
     if (opp->flags & OPENPIC_FLAG_IDR_CRIT) {
         if (src->idr & crit_mask) {
             if (src->idr & normal_mask) {
                 DPRINTF("%s: IRQ configured for multiple output types, using "
-                        "critical\n", __func__);
+                        "critical", __func__);
             }
 
             src->output = OPENPIC_OUTPUT_CINT;
@@ -648,7 +648,7 @@ static inline void write_IRQreg_ilr(OpenPICState *opp, int n_IRQ, uint32_t val)
         IRQSource *src = &opp->src[n_IRQ];
 
         src->output = inttgt_to_output(val & ILR_INTTGT_MASK);
-        DPRINTF("Set ILR %d to 0x%08x, output %d\n", n_IRQ, src->idr,
+        DPRINTF("Set ILR %d to 0x%08x, output %d", n_IRQ, src->idr,
                 src->output);
 
         /* TODO: on MPIC v4.0 only, set nomask for non-INT */
@@ -688,7 +688,7 @@ static inline void write_IRQreg_ivpr(OpenPICState *opp, int n_IRQ, uint32_t val)
     }
 
     openpic_update_irq(opp, n_IRQ);
-    DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x\n", n_IRQ, val,
+    DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x", n_IRQ, val,
             opp->src[n_IRQ].ivpr);
 }
 
@@ -719,7 +719,7 @@ static void openpic_gbl_write(void *opaque, hwaddr addr, uint64_t val,
     IRQDest *dst;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
+    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64,
             __func__, addr, val);
     if (addr & 0xF) {
         return;
@@ -747,11 +747,11 @@ static void openpic_gbl_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x1090: /* PIR */
         for (idx = 0; idx < opp->nb_cpus; idx++) {
             if ((val & (1 << idx)) && !(opp->pir & (1 << idx))) {
-                DPRINTF("Raise OpenPIC RESET output for CPU %d\n", idx);
+                DPRINTF("Raise OpenPIC RESET output for CPU %d", idx);
                 dst = &opp->dst[idx];
                 qemu_irq_raise(dst->irqs[OPENPIC_OUTPUT_RESET]);
             } else if (!(val & (1 << idx)) && (opp->pir & (1 << idx))) {
-                DPRINTF("Lower OpenPIC RESET output for CPU %d\n", idx);
+                DPRINTF("Lower OpenPIC RESET output for CPU %d", idx);
                 dst = &opp->dst[idx];
                 qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_RESET]);
             }
@@ -781,7 +781,7 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr addr, unsigned len)
     OpenPICState *opp = opaque;
     uint32_t retval;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
     retval = 0xFFFFFFFF;
     if (addr & 0xF) {
         return retval;
@@ -828,7 +828,7 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr addr, unsigned len)
     default:
         break;
     }
-    DPRINTF("%s: => 0x%08x\n", __func__, retval);
+    DPRINTF("%s: => 0x%08x", __func__, retval);
 
     return retval;
 }
@@ -843,7 +843,7 @@ static void qemu_timer_cb(void *opaque)
     uint32_t val =   tmr->tbcr & ~TBCR_CI;
     uint32_t tog = ((tmr->tccr & TCCR_TOG) ^ TCCR_TOG);  /* invert toggle. */
 
-    DPRINTF("%s n_IRQ=%d\n", __func__, n_IRQ);
+    DPRINTF("%s n_IRQ=%d", __func__, n_IRQ);
     /* Reload current count from base count and setup timer. */
     tmr->tccr = val | tog;
     openpic_tmr_set_tmr(tmr, val, /*enabled=*/true);
@@ -898,7 +898,7 @@ static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
     OpenPICState *opp = opaque;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
+    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64,
             __func__, (addr + 0x10f0), val);
     if (addr & 0xF) {
         return;
@@ -943,7 +943,7 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     uint32_t retval = -1;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
+    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr + 0x10f0);
     if (addr & 0xF) {
         goto out;
     }
@@ -970,7 +970,7 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr addr, unsigned len)
     }
 
 out:
-    DPRINTF("%s: => 0x%08x\n", __func__, retval);
+    DPRINTF("%s: => 0x%08x", __func__, retval);
 
     return retval;
 }
@@ -981,7 +981,7 @@ static void openpic_src_write(void *opaque, hwaddr addr, uint64_t val,
     OpenPICState *opp = opaque;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64 "\n",
+    DPRINTF("%s: addr %#" HWADDR_PRIx " <= %08" PRIx64,
             __func__, addr, val);
 
     addr = addr & 0xffff;
@@ -1006,7 +1006,7 @@ static uint64_t openpic_src_read(void *opaque, uint64_t addr, unsigned len)
     uint32_t retval;
     int idx;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
     retval = 0xFFFFFFFF;
 
     addr = addr & 0xffff;
@@ -1024,7 +1024,7 @@ static uint64_t openpic_src_read(void *opaque, uint64_t addr, unsigned len)
         break;
     }
 
-    DPRINTF("%s: => 0x%08x\n", __func__, retval);
+    DPRINTF("%s: => 0x%08x", __func__, retval);
     return retval;
 }
 
@@ -1035,7 +1035,7 @@ static void openpic_msi_write(void *opaque, hwaddr addr, uint64_t val,
     int idx = opp->irq_msi;
     int srs, ibs;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx " <= 0x%08" PRIx64 "\n",
+    DPRINTF("%s: addr %#" HWADDR_PRIx " <= 0x%08" PRIx64,
             __func__, addr, val);
     if (addr & 0xF) {
         return;
@@ -1061,7 +1061,7 @@ static uint64_t openpic_msi_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t r = 0;
     int i, srs;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
     if (addr & 0xF) {
         return -1;
     }
@@ -1096,7 +1096,7 @@ static uint64_t openpic_summary_read(void *opaque, hwaddr addr, unsigned size)
 {
     uint64_t r = 0;
 
-    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
+    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
 
     /* TODO: EISR/EIMR */
 
@@ -1106,7 +1106,7 @@ static uint64_t openpic_summary_read(void *opaque, hwaddr addr, unsigned size)
 static void openpic_summary_write(void *opaque, hwaddr addr, uint64_t val,
                                   unsigned size)
 {
-    DPRINTF("%s: addr %#" HWADDR_PRIx " <= 0x%08" PRIx64 "\n",
+    DPRINTF("%s: addr %#" HWADDR_PRIx " <= 0x%08" PRIx64,
             __func__, addr, val);
 
     /* TODO: EISR/EIMR */
@@ -1120,7 +1120,7 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
     IRQDest *dst;
     int s_IRQ, n_IRQ;
 
-    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx " <= 0x%08x\n", __func__, idx,
+    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx " <= 0x%08x", __func__, idx,
             addr, val);
 
     if (idx < 0 || idx >= opp->nb_cpus) {
@@ -1146,16 +1146,16 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
     case 0x80: /* CTPR */
         dst->ctpr = val & 0x0000000F;
 
-        DPRINTF("%s: set CPU %d ctpr to %d, raised %d servicing %d\n",
+        DPRINTF("%s: set CPU %d ctpr to %d, raised %d servicing %d",
                 __func__, idx, dst->ctpr, dst->raised.priority,
                 dst->servicing.priority);
 
         if (dst->raised.priority <= dst->ctpr) {
-            DPRINTF("%s: Lower OpenPIC INT output cpu %d due to ctpr\n",
+            DPRINTF("%s: Lower OpenPIC INT output cpu %d due to ctpr",
                     __func__, idx);
             qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_INT]);
         } else if (dst->raised.priority > dst->servicing.priority) {
-            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d\n",
+            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d",
                     __func__, idx, dst->raised.next);
             qemu_irq_raise(dst->irqs[OPENPIC_OUTPUT_INT]);
         }
@@ -1168,11 +1168,11 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         /* Read-only register */
         break;
     case 0xB0: /* EOI */
-        DPRINTF("EOI\n");
+        DPRINTF("EOI");
         s_IRQ = IRQ_get_next(opp, &dst->servicing);
 
         if (s_IRQ < 0) {
-            DPRINTF("%s: EOI with no interrupt in service\n", __func__);
+            DPRINTF("%s: EOI with no interrupt in service", __func__);
             break;
         }
 
@@ -1185,7 +1185,7 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         if (n_IRQ != -1 &&
             (s_IRQ == -1 ||
              IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
-            DPRINTF("Raise OpenPIC INT output cpu %d irq %d\n",
+            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
                     idx, n_IRQ);
             qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
         }
@@ -1207,11 +1207,11 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     IRQSource *src;
     int retval, irq;
 
-    DPRINTF("Lower OpenPIC INT output\n");
+    DPRINTF("Lower OpenPIC INT output");
     qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_INT]);
 
     irq = IRQ_get_next(opp, &dst->raised);
-    DPRINTF("IACK: irq=%d\n", irq);
+    DPRINTF("IACK: irq=%d", irq);
 
     if (irq == -1) {
         /* No more interrupt pending */
@@ -1221,7 +1221,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     src = &opp->src[irq];
     if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
             !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
-        fprintf(stderr, "%s: bad raised IRQ %d ctpr %d ivpr 0x%08x\n",
+        error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
                 __func__, irq, dst->ctpr, src->ivpr);
         openpic_update_irq(opp, irq);
         retval = opp->spve;
@@ -1241,7 +1241,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     /* Timers and IPIs support multicast. */
     if (((irq >= opp->irq_ipi0) && (irq < (opp->irq_ipi0 + OPENPIC_MAX_IPI))) ||
         ((irq >= opp->irq_tim0) && (irq < (opp->irq_tim0 + OPENPIC_MAX_TMR)))) {
-        DPRINTF("irq is IPI or TMR\n");
+        DPRINTF("irq is IPI or TMR");
         src->destmask &= ~(1 << cpu);
         if (src->destmask && !src->level) {
             /* trigger on CPUs that didn't know about it yet */
@@ -1262,7 +1262,7 @@ static uint32_t openpic_cpu_read_internal(void *opaque, hwaddr addr,
     IRQDest *dst;
     uint32_t retval;
 
-    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx "\n", __func__, idx, addr);
+    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx, __func__, idx, addr);
     retval = 0xFFFFFFFF;
 
     if (idx < 0 || idx >= opp->nb_cpus) {
@@ -1290,7 +1290,7 @@ static uint32_t openpic_cpu_read_internal(void *opaque, hwaddr addr,
     default:
         break;
     }
-    DPRINTF("%s: => 0x%08x\n", __func__, retval);
+    DPRINTF("%s: => 0x%08x", __func__, retval);
 
     return retval;
 }
-- 
2.14.3
