Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvJ-0004lQ-HS
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtx-0006fi-W2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtx-0006eo-Gs
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtw-0007Fp-0Y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:50 +0100
Message-Id: <20180814181815.23348-21-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/45] intc/arm_gic: Add virtualization enabled
 IRQ helper functions
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

Add some helper functions to gic_internal.h to get or change the state
of an IRQ. When the current CPU is not a vCPU, the call is forwarded to
the GIC distributor. Otherwise, it acts on the list register matching
the IRQ in the current CPU virtual interface.

gic_clear_active can have a side effect on the distributor, even in the
vCPU case, when the correponding LR has the HW field set.

Use those functions in the CPU interface code path to prepare for the
vCPU interface implementation.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180727095421.386-10-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gic_internal.h | 83 ++++++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gic.c      | 32 +++++++---------
 2 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index cc5acc5d419..45c2af0bf59 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -143,6 +143,13 @@ REG32(GICH_LR63, 0x1fc)
 #define GICH_LR_GROUP(entry) (FIELD_EX32(entry, GICH_LR0, Grp1))
 #define GICH_LR_HW(entry) (FIELD_EX32(entry, GICH_LR0, HW))
 
+#define GICH_LR_CLEAR_PENDING(entry) \
+        ((entry) &= ~(GICH_LR_STATE_PENDING << R_GICH_LR0_State_SHIFT))
+#define GICH_LR_SET_ACTIVE(entry) \
+        ((entry) |= (GICH_LR_STATE_ACTIVE << R_GICH_LR0_State_SHIFT))
+#define GICH_LR_CLEAR_ACTIVE(entry) \
+        ((entry) &= ~(GICH_LR_STATE_ACTIVE << R_GICH_LR0_State_SHIFT))
+
 /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
  * GICv2 and GICv2 with security extensions:
  */
@@ -238,4 +245,80 @@ static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vcpu)
     g_assert_not_reached();
 }
 
+static inline bool gic_test_group(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
+        return GICH_LR_GROUP(*entry);
+    } else {
+        return GIC_DIST_TEST_GROUP(irq, 1 << cpu);
+    }
+}
+
+static inline void gic_clear_pending(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
+        GICH_LR_CLEAR_PENDING(*entry);
+    } else {
+        /* Clear pending state for both level and edge triggered
+         * interrupts. (level triggered interrupts with an active line
+         * remain pending, see gic_test_pending)
+         */
+        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
+                                                             : (1 << cpu));
+    }
+}
+
+static inline void gic_set_active(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
+        GICH_LR_SET_ACTIVE(*entry);
+    } else {
+        GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
+    }
+}
+
+static inline void gic_clear_active(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
+        GICH_LR_CLEAR_ACTIVE(*entry);
+
+        if (GICH_LR_HW(*entry)) {
+            /* Hardware interrupt. We must forward the deactivation request to
+             * the distributor.
+             */
+            int phys_irq = GICH_LR_PHYS_ID(*entry);
+            int rcpu = gic_get_vcpu_real_id(cpu);
+
+            if (phys_irq < GIC_NR_SGIS || phys_irq >= GIC_MAXIRQ) {
+                /* UNPREDICTABLE behaviour, we choose to ignore the request */
+                return;
+            }
+
+            /* This is equivalent to a NS write to DIR on the physical CPU
+             * interface. Hence group0 interrupt deactivation is ignored if
+             * the GIC is secure.
+             */
+            if (!s->security_extn || GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
+                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
+            }
+        }
+    } else {
+        GIC_DIST_CLEAR_ACTIVE(irq, 1 << cpu);
+    }
+}
+
+static inline int gic_get_priority(GICState *s, int irq, int cpu)
+{
+    if (gic_is_vcpu(cpu)) {
+        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
+        return GICH_LR_PRIORITY(*entry);
+    } else {
+        return GIC_DIST_GET_PRIORITY(irq, cpu);
+    }
+}
+
 #endif /* QEMU_ARM_GIC_INTERNAL_H */
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 94d5982e2ac..26ed7ea58ab 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -222,7 +222,8 @@ static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
     uint16_t pending_irq = s->current_pending[cpu];
 
     if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
-        int group = GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
+        int group = gic_test_group(s, pending_irq, cpu);
+
         /* On a GIC without the security extensions, reading this register
          * behaves in the same way as a secure access to a GIC with them.
          */
@@ -253,7 +254,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
 
     if (gic_has_groups(s) &&
         !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
-        GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
+        gic_test_group(s, irq, cpu)) {
         bpr = s->abpr[cpu] - 1;
         assert(bpr >= 0);
     } else {
@@ -266,7 +267,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
      */
     mask = ~0U << ((bpr & 7) + 1);
 
-    return GIC_DIST_GET_PRIORITY(irq, cpu) & mask;
+    return gic_get_priority(s, irq, cpu) & mask;
 }
 
 static void gic_activate_irq(GICState *s, int cpu, int irq)
@@ -279,14 +280,14 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
     int regno = preemption_level / 32;
     int bitno = preemption_level % 32;
 
-    if (gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
+    if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
         s->nsapr[regno][cpu] |= (1 << bitno);
     } else {
         s->apr[regno][cpu] |= (1 << bitno);
     }
 
     s->running_priority[cpu] = prio;
-    GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
+    gic_set_active(s, irq, cpu);
 }
 
 static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
@@ -355,7 +356,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
         return irq;
     }
 
-    if (GIC_DIST_GET_PRIORITY(irq, cpu) >= s->running_priority[cpu]) {
+    if (gic_get_priority(s, irq, cpu) >= s->running_priority[cpu]) {
         DPRINTF("ACK, pending interrupt (%d) has insufficient priority\n", irq);
         return 1023;
     }
@@ -364,8 +365,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
         /* Clear pending flags for both level and edge triggered interrupts.
          * Level triggered IRQs will be reasserted once they become inactive.
          */
-        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
-                                                             : cm);
+        gic_clear_pending(s, irq, cpu);
         ret = irq;
     } else {
         if (irq < GIC_NR_SGIS) {
@@ -377,9 +377,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
             src = ctz32(s->sgi_pending[irq][cpu]);
             s->sgi_pending[irq][cpu] &= ~(1 << src);
             if (s->sgi_pending[irq][cpu] == 0) {
-                GIC_DIST_CLEAR_PENDING(irq,
-                                       GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
-                                                                : cm);
+                gic_clear_pending(s, irq, cpu);
             }
             ret = irq | ((src & 0x7) << 10);
         } else {
@@ -387,8 +385,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
              * interrupts. (level triggered interrupts with an active line
              * remain pending, see gic_test_pending)
              */
-            GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
-                                                                 : cm);
+            gic_clear_pending(s, irq, cpu);
             ret = irq;
         }
     }
@@ -544,7 +541,6 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
 
 static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 {
-    int cm = 1 << cpu;
     int group;
 
     if (irq >= s->num_irq) {
@@ -559,7 +555,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
         return;
     }
 
-    group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
+    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
 
     if (!gic_eoi_split(s, cpu, attrs)) {
         /* This is UNPREDICTABLE; we choose to ignore it */
@@ -573,7 +569,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
         return;
     }
 
-    GIC_DIST_CLEAR_ACTIVE(irq, cm);
+    gic_clear_active(s, irq, cpu);
 }
 
 static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
@@ -608,7 +604,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
         }
     }
 
-    group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
+    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
 
     if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
         DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
@@ -624,7 +620,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 
     /* In GICv2 the guest can choose to split priority-drop and deactivate */
     if (!gic_eoi_split(s, cpu, attrs)) {
-        GIC_DIST_CLEAR_ACTIVE(irq, cm);
+        gic_clear_active(s, irq, cpu);
     }
     gic_update(s);
 }
-- 
2.18.0
