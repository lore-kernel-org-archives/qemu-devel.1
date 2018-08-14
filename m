Received: from eggs.gnu.org ([2001:4830:134:3::10]:52700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvZ-0004xX-2b
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu6-0006jq-Jt
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdu5-0006iE-No
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu4-0007Iu-3m
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:57 +0100
Message-Id: <20180814181815.23348-28-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/45] intc/arm_gic: Implement gic_update_virt()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Add the gic_update_virt() function to update the vCPU interface states
and raise vIRQ and vFIQ as needed. This commit renames gic_update() to
gic_update_internal() and generalizes it to handle both cases, with a
`virt' parameter to track whether we are updating the CPU or vCPU
interfaces.

The main difference between CPU and vCPU is the way we select the best
IRQ. This part has been split into the gic_get_best_(v)irq functions.
For the virt case, the LRs are iterated to find the best candidate.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-17-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 175 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 136 insertions(+), 39 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 60631964876..6b97e197966 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -79,74 +79,149 @@ static inline bool gic_cpu_ns_access(GICState *s, int cpu, MemTxAttrs attrs)
     return !gic_is_vcpu(cpu) && s->security_extn && !attrs.secure;
 }
 
+static inline void gic_get_best_irq(GICState *s, int cpu,
+                                    int *best_irq, int *best_prio, int *group)
+{
+    int irq;
+    int cm = 1 << cpu;
+
+    *best_irq = 1023;
+    *best_prio = 0x100;
+
+    for (irq = 0; irq < s->num_irq; irq++) {
+        if (GIC_DIST_TEST_ENABLED(irq, cm) && gic_test_pending(s, irq, cm) &&
+            (!GIC_DIST_TEST_ACTIVE(irq, cm)) &&
+            (irq < GIC_INTERNAL || GIC_DIST_TARGET(irq) & cm)) {
+            if (GIC_DIST_GET_PRIORITY(irq, cpu) < *best_prio) {
+                *best_prio = GIC_DIST_GET_PRIORITY(irq, cpu);
+                *best_irq = irq;
+            }
+        }
+    }
+
+    if (*best_irq < 1023) {
+        *group = GIC_DIST_TEST_GROUP(*best_irq, cm);
+    }
+}
+
+static inline void gic_get_best_virq(GICState *s, int cpu,
+                                     int *best_irq, int *best_prio, int *group)
+{
+    int lr_idx = 0;
+
+    *best_irq = 1023;
+    *best_prio = 0x100;
+
+    for (lr_idx = 0; lr_idx < s->num_lrs; lr_idx++) {
+        uint32_t lr_entry = s->h_lr[lr_idx][cpu];
+        int state = GICH_LR_STATE(lr_entry);
+
+        if (state == GICH_LR_STATE_PENDING) {
+            int prio = GICH_LR_PRIORITY(lr_entry);
+
+            if (prio < *best_prio) {
+                *best_prio = prio;
+                *best_irq = GICH_LR_VIRT_ID(lr_entry);
+                *group = GICH_LR_GROUP(lr_entry);
+            }
+        }
+    }
+}
+
+/* Return true if IRQ signaling is enabled for the given cpu and at least one
+ * of the given groups:
+ *   - in the non-virt case, the distributor must be enabled for one of the
+ *   given groups
+ *   - in the virt case, the virtual interface must be enabled.
+ *   - in all cases, the (v)CPU interface must be enabled for one of the given
+ *   groups.
+ */
+static inline bool gic_irq_signaling_enabled(GICState *s, int cpu, bool virt,
+                                    int group_mask)
+{
+    if (!virt && !(s->ctlr & group_mask)) {
+        return false;
+    }
+
+    if (virt && !(s->h_hcr[cpu] & R_GICH_HCR_EN_MASK)) {
+        return false;
+    }
+
+    if (!(s->cpu_ctlr[cpu] & group_mask)) {
+        return false;
+    }
+
+    return true;
+}
+
 /* TODO: Many places that call this routine could be optimized.  */
 /* Update interrupt status after enabled or pending bits have been changed.  */
-static void gic_update(GICState *s)
+static inline void gic_update_internal(GICState *s, bool virt)
 {
     int best_irq;
     int best_prio;
-    int irq;
     int irq_level, fiq_level;
-    int cpu;
-    int cm;
+    int cpu, cpu_iface;
+    int group = 0;
+    qemu_irq *irq_lines = virt ? s->parent_virq : s->parent_irq;
+    qemu_irq *fiq_lines = virt ? s->parent_vfiq : s->parent_fiq;
 
     for (cpu = 0; cpu < s->num_cpu; cpu++) {
-        cm = 1 << cpu;
-        s->current_pending[cpu] = 1023;
-        if (!(s->ctlr & (GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1))
-            || !(s->cpu_ctlr[cpu] & (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {
-            qemu_irq_lower(s->parent_irq[cpu]);
-            qemu_irq_lower(s->parent_fiq[cpu]);
+        cpu_iface = virt ? (cpu + GIC_NCPU) : cpu;
+
+        s->current_pending[cpu_iface] = 1023;
+        if (!gic_irq_signaling_enabled(s, cpu, virt,
+                                       GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1)) {
+            qemu_irq_lower(irq_lines[cpu]);
+            qemu_irq_lower(fiq_lines[cpu]);
             continue;
         }
-        best_prio = 0x100;
-        best_irq = 1023;
-        for (irq = 0; irq < s->num_irq; irq++) {
-            if (GIC_DIST_TEST_ENABLED(irq, cm) &&
-                gic_test_pending(s, irq, cm) &&
-                (!GIC_DIST_TEST_ACTIVE(irq, cm)) &&
-                (irq < GIC_INTERNAL || GIC_DIST_TARGET(irq) & cm)) {
-                if (GIC_DIST_GET_PRIORITY(irq, cpu) < best_prio) {
-                    best_prio = GIC_DIST_GET_PRIORITY(irq, cpu);
-                    best_irq = irq;
-                }
-            }
+
+        if (virt) {
+            gic_get_best_virq(s, cpu, &best_irq, &best_prio, &group);
+        } else {
+            gic_get_best_irq(s, cpu, &best_irq, &best_prio, &group);
         }
 
         if (best_irq != 1023) {
             trace_gic_update_bestirq(cpu, best_irq, best_prio,
-                s->priority_mask[cpu], s->running_priority[cpu]);
+                s->priority_mask[cpu_iface], s->running_priority[cpu_iface]);
         }
 
         irq_level = fiq_level = 0;
 
-        if (best_prio < s->priority_mask[cpu]) {
-            s->current_pending[cpu] = best_irq;
-            if (best_prio < s->running_priority[cpu]) {
-                int group = GIC_DIST_TEST_GROUP(best_irq, cm);
-
-                if (extract32(s->ctlr, group, 1) &&
-                    extract32(s->cpu_ctlr[cpu], group, 1)) {
-                    if (group == 0 && s->cpu_ctlr[cpu] & GICC_CTLR_FIQ_EN) {
+        if (best_prio < s->priority_mask[cpu_iface]) {
+            s->current_pending[cpu_iface] = best_irq;
+            if (best_prio < s->running_priority[cpu_iface]) {
+                if (gic_irq_signaling_enabled(s, cpu, virt, 1 << group)) {
+                    if (group == 0 &&
+                        s->cpu_ctlr[cpu_iface] & GICC_CTLR_FIQ_EN) {
                         DPRINTF("Raised pending FIQ %d (cpu %d)\n",
-                                best_irq, cpu);
+                                best_irq, cpu_iface);
                         fiq_level = 1;
-                        trace_gic_update_set_irq(cpu, "fiq", fiq_level);
+                        trace_gic_update_set_irq(cpu, virt ? "vfiq" : "fiq",
+                                                 fiq_level);
                     } else {
                         DPRINTF("Raised pending IRQ %d (cpu %d)\n",
-                                best_irq, cpu);
+                                best_irq, cpu_iface);
                         irq_level = 1;
-                        trace_gic_update_set_irq(cpu, "irq", irq_level);
+                        trace_gic_update_set_irq(cpu, virt ? "virq" : "irq",
+                                                 irq_level);
                     }
                 }
             }
         }
 
-        qemu_set_irq(s->parent_irq[cpu], irq_level);
-        qemu_set_irq(s->parent_fiq[cpu], fiq_level);
+        qemu_set_irq(irq_lines[cpu], irq_level);
+        qemu_set_irq(fiq_lines[cpu], fiq_level);
     }
 }
 
+static void gic_update(GICState *s)
+{
+    gic_update_internal(s, false);
+}
+
 /* Return true if this LR is empty, i.e. the corresponding bit
  * in ELRSR is set.
  */
@@ -165,6 +240,11 @@ static inline bool gic_lr_entry_is_eoi(uint32_t entry)
         && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
 }
 
+static void gic_update_virt(GICState *s)
+{
+    gic_update_internal(s, true);
+}
+
 static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
                                  int cm, int target)
 {
@@ -449,7 +529,11 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
         }
     }
 
-    gic_update(s);
+    if (gic_is_vcpu(cpu)) {
+        gic_update_virt(s);
+    } else {
+        gic_update(s);
+    }
     DPRINTF("ACK %d\n", irq);
     return ret;
 }
@@ -627,6 +711,11 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
          */
         int rcpu = gic_get_vcpu_real_id(cpu);
         s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
+
+        /* Update the virtual interface in case a maintenance interrupt should
+         * be raised.
+         */
+        gic_update_virt(s);
         return;
     }
 
@@ -676,6 +765,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
             }
         }
 
+        gic_update_virt(s);
         return;
     }
 
@@ -1531,7 +1621,13 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                       "gic_cpu_write: Bad offset %x\n", (int)offset);
         return MEMTX_OK;
     }
-    gic_update(s);
+
+    if (gic_is_vcpu(cpu)) {
+        gic_update_virt(s);
+    } else {
+        gic_update(s);
+    }
+
     return MEMTX_OK;
 }
 
@@ -1742,6 +1838,7 @@ static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
         return MEMTX_OK;
     }
 
+    gic_update_virt(s);
     return MEMTX_OK;
 }
 
-- 
2.18.0
