Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdva-0004yp-GD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu8-0006kr-5g
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdu7-0006iE-Pi
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu6-0007Jq-4M
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:59 +0100
Message-Id: <20180814181815.23348-30-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/45] intc/arm_gic: Improve traces
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

Add some traces to the ARM GIC to catch register accesses (distributor,
(v)cpu interface and virtual interface), and to take into account
virtualization extensions (print `vcpu` instead of `cpu` when needed).

Also add some virtualization extensions specific traces: LR updating
and maintenance IRQ generation.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-19-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c    | 31 +++++++++++++++++++++++++------
 hw/intc/trace-events | 12 ++++++++++--
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 6ff7da3e5d3..c1b35fc1ee2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -184,8 +184,10 @@ static inline void gic_update_internal(GICState *s, bool virt)
         }
 
         if (best_irq != 1023) {
-            trace_gic_update_bestirq(cpu, best_irq, best_prio,
-                s->priority_mask[cpu_iface], s->running_priority[cpu_iface]);
+            trace_gic_update_bestirq(virt ? "vcpu" : "cpu", cpu,
+                                     best_irq, best_prio,
+                                     s->priority_mask[cpu_iface],
+                                     s->running_priority[cpu_iface]);
         }
 
         irq_level = fiq_level = 0;
@@ -332,6 +334,7 @@ static void gic_update_maintenance(GICState *s)
         gic_compute_misr(s, cpu);
         maint_level = (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK) && s->h_misr[cpu];
 
+        trace_gic_update_maintenance_irq(cpu, maint_level);
         qemu_set_irq(s->maintenance_irq[cpu], maint_level);
     }
 }
@@ -597,7 +600,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
      * is in the wrong group.
      */
     irq = gic_get_current_pending_irq(s, cpu, attrs);
-    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
+    trace_gic_acknowledge_irq(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                              gic_get_vcpu_real_id(cpu), irq);
 
     if (irq >= GIC_MAXIRQ) {
         DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
@@ -1130,20 +1134,23 @@ static MemTxResult gic_dist_read(void *opaque, hwaddr offset, uint64_t *data,
     switch (size) {
     case 1:
         *data = gic_dist_readb(opaque, offset, attrs);
-        return MEMTX_OK;
+        break;
     case 2:
         *data = gic_dist_readb(opaque, offset, attrs);
         *data |= gic_dist_readb(opaque, offset + 1, attrs) << 8;
-        return MEMTX_OK;
+        break;
     case 4:
         *data = gic_dist_readb(opaque, offset, attrs);
         *data |= gic_dist_readb(opaque, offset + 1, attrs) << 8;
         *data |= gic_dist_readb(opaque, offset + 2, attrs) << 16;
         *data |= gic_dist_readb(opaque, offset + 3, attrs) << 24;
-        return MEMTX_OK;
+        break;
     default:
         return MEMTX_ERROR;
     }
+
+    trace_gic_dist_read(offset, size, *data);
+    return MEMTX_OK;
 }
 
 static void gic_dist_writeb(void *opaque, hwaddr offset,
@@ -1482,6 +1489,8 @@ static void gic_dist_writel(void *opaque, hwaddr offset,
 static MemTxResult gic_dist_write(void *opaque, hwaddr offset, uint64_t data,
                                   unsigned size, MemTxAttrs attrs)
 {
+    trace_gic_dist_write(offset, size, data);
+
     switch (size) {
     case 1:
         gic_dist_writeb(opaque, offset, data, attrs);
@@ -1638,12 +1647,18 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         *data = 0;
         break;
     }
+
+    trace_gic_cpu_read(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                       gic_get_vcpu_real_id(cpu), offset, *data);
     return MEMTX_OK;
 }
 
 static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                                  uint32_t value, MemTxAttrs attrs)
 {
+    trace_gic_cpu_write(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                        gic_get_vcpu_real_id(cpu), offset, value);
+
     switch (offset) {
     case 0x00: /* Control */
         gic_set_cpu_control(s, cpu, value, attrs);
@@ -1894,6 +1909,7 @@ static MemTxResult gic_hyp_read(void *opaque, int cpu, hwaddr addr,
         return MEMTX_OK;
     }
 
+    trace_gic_hyp_read(addr, *data);
     return MEMTX_OK;
 }
 
@@ -1903,6 +1919,8 @@ static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
     GICState *s = ARM_GIC(opaque);
     int vcpu = cpu + GIC_NCPU;
 
+    trace_gic_hyp_write(addr, value);
+
     switch (addr) {
     case A_GICH_HCR: /* Hypervisor Control */
         s->h_hcr[cpu] = value & GICH_HCR_MASK;
@@ -1926,6 +1944,7 @@ static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
         }
 
         s->h_lr[lr_idx][cpu] = value & GICH_LR_MASK;
+        trace_gic_lr_entry(cpu, lr_idx, s->h_lr[lr_idx][cpu]);
         break;
     }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 5fb18e65c97..81c7c399f7d 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -92,9 +92,17 @@ aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
 gic_enable_irq(int irq) "irq %d enabled"
 gic_disable_irq(int irq) "irq %d disabled"
 gic_set_irq(int irq, int level, int cpumask, int target) "irq %d level %d cpumask 0x%x target 0x%x"
-gic_update_bestirq(int cpu, int irq, int prio, int priority_mask, int running_priority) "cpu %d irq %d priority %d cpu priority mask %d cpu running priority %d"
+gic_update_bestirq(const char *s, int cpu, int irq, int prio, int priority_mask, int running_priority) "%s %d irq %d priority %d cpu priority mask %d cpu running priority %d"
 gic_update_set_irq(int cpu, const char *name, int level) "cpu[%d]: %s = %d"
-gic_acknowledge_irq(int cpu, int irq) "cpu %d acknowledged irq %d"
+gic_acknowledge_irq(const char *s, int cpu, int irq) "%s %d acknowledged irq %d"
+gic_cpu_write(const char *s, int cpu, int addr, uint32_t val) "%s %d iface write at 0x%08x 0x%08" PRIx32
+gic_cpu_read(const char *s, int cpu, int addr, uint32_t val) "%s %d iface read at 0x%08x: 0x%08" PRIx32
+gic_hyp_read(int addr, uint32_t val) "hyp read at 0x%08x: 0x%08" PRIx32
+gic_hyp_write(int addr, uint32_t val) "hyp write at 0x%08x: 0x%08" PRIx32
+gic_dist_read(int addr, unsigned int size, uint32_t val) "dist read at 0x%08x size %u: 0x%08" PRIx32
+gic_dist_write(int addr, unsigned int size, uint32_t val) "dist write at 0x%08x size %u: 0x%08" PRIx32
+gic_lr_entry(int cpu, int entry, uint32_t val) "cpu %d: new lr entry %d: 0x%08" PRIx32
+gic_update_maintenance_irq(int cpu, int val) "cpu %d: maintenance = %d"
 
 # hw/intc/arm_gicv3_cpuif.c
 gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu 0x%x value 0x%" PRIx64
-- 
2.18.0
