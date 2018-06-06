Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fQUnJ-0001jM-I3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fQUnI-0003k9-6S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:31:53 -0400
From: luc.michel@greensocs.com
Date: Wed,  6 Jun 2018 11:31:00 +0200
Message-Id: <20180606093101.30518-6-luc.michel@greensocs.com>
In-Reply-To: <20180606093101.30518-1-luc.michel@greensocs.com>
References: <20180606093101.30518-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 5/6] intc/arm_gic: Improve traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

From: Luc MICHEL <luc.michel@greensocs.com>

Add some traces to the ARM GIC to catch register accesses (distributor,
(v)cpu interface and virtual interface), and to take into account
virtualization extensions (print `vcpu` instead of `cpu` when needed).

Also add some virtualization extensions specific traces: LR updating
and maintenance IRQ generation.

Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c    | 31 +++++++++++++++++++++++++------
 hw/intc/trace-events | 12 ++++++++++--
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 6105f930c4..a0ffd85fdf 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -179,8 +179,10 @@ static inline void gic_update_internal(GICState *s, bool virt)
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
@@ -268,6 +270,7 @@ static void gic_update_maintenance(GICState *s)
         gic_compute_misr(s, cpu);
         maint_level = (s->h_hcr[cpu] & GICH_HCR_EN) && s->h_misr[cpu];
 
+        trace_gic_update_maintenance_irq(cpu, maint_level);
         qemu_set_irq(s->maintenance_irq[cpu], maint_level);
     }
 }
@@ -524,7 +527,8 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
      * is in the wrong group.
      */
     irq = gic_get_current_pending_irq(s, cpu, attrs);
-    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
+    trace_gic_acknowledge_irq(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                              gic_get_vcpu_real_id(cpu), irq);
 
     if (irq >= GIC_MAXIRQ) {
         DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
@@ -1002,20 +1006,23 @@ static MemTxResult gic_dist_read(void *opaque, hwaddr offset, uint64_t *data,
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
@@ -1309,6 +1316,8 @@ static void gic_dist_writel(void *opaque, hwaddr offset,
 static MemTxResult gic_dist_write(void *opaque, hwaddr offset, uint64_t data,
                                   unsigned size, MemTxAttrs attrs)
 {
+    trace_gic_dist_write(offset, size, data);
+
     switch (size) {
     case 1:
         gic_dist_writeb(opaque, offset, data, attrs);
@@ -1463,12 +1472,18 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
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
@@ -1679,6 +1694,7 @@ static void gic_set_lr_entry(GICState *s, int cpu, int lr_num, uint32_t entry)
     }
 
     s->h_lr[lr_num][cpu] = entry;
+    trace_gic_lr_entry(cpu, lr_num, entry);
     is_free = gic_lr_update(s, lr_num, cpu);
 
     if (!is_free) {
@@ -1749,6 +1765,7 @@ static MemTxResult gic_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
         return MEMTX_OK;
     }
 
+    trace_gic_hyp_read(addr, *data);
     return MEMTX_OK;
 }
 
@@ -1759,6 +1776,8 @@ static MemTxResult gic_hyp_write(void *opaque, hwaddr addr, uint64_t value,
     int cpu = gic_get_current_cpu(s);
     int vcpu = gic_get_current_vcpu(s);
 
+    trace_gic_hyp_write(addr, value);
+
     switch (addr) {
     case 0x0: /* Hypervisor Control */
         s->h_hcr[cpu] = value & 0xf80000ff;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 55e8c2570c..16d02fa8cf 100644
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
+gic_cpu_read(const char *s, int cpu, int addr, uint32_t val) "%s %d iface write at 0x%08x: 0x%08" PRIx32
+gic_hyp_read(int addr, uint32_t val) "hyp read at 0x%08x: 0x%08" PRIx32
+gic_hyp_write(int addr, uint32_t val) "hyp write at 0x%08x: 0x%08" PRIx32
+gic_dist_read(int addr, unsigned int size, uint32_t val) "dist read at 0x%08x size %u: 0x%08" PRIx32
+gic_dist_write(int addr, unsigned int size, uint32_t val) "dist write at 0x%08x size %u: 0x%08" PRIx32
+gic_lr_entry(int cpu, int entry, uint32_t val) "cpu %d: new lr entry %d: 0x%08" PRIx32
+gic_update_maintenance_irq(int cpu, int val) "cpu %d: maintenance = %d"
 
 # hw/intc/arm_gicv3_cpuif.c
 gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu 0x%x value 0x%" PRIx64
-- 
2.17.0
