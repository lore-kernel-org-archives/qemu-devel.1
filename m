Received: from eggs.gnu.org ([2001:4830:134:3::10]:58407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSm-0003w5-GJ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSk-0006PZ-0A
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:19 +0200
Message-Id: <20180727095421.386-19-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 18/20] intc/arm_gic: Improve traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Add some traces to the ARM GIC to catch register accesses (distributor,
(v)cpu interface and virtual interface), and to take into account
virtualization extensions (print `vcpu` instead of `cpu` when needed).

Also add some virtualization extensions specific traces: LR updating
and maintenance IRQ generation.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c    | 31 +++++++++++++++++++++++++------
 hw/intc/trace-events | 12 ++++++++++--
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 6ff7da3e5d..c1b35fc1ee 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -182,12 +182,14 @@ static inline void gic_update_internal(GICState *s,=
 bool virt)
         } else {
             gic_get_best_irq(s, cpu, &best_irq, &best_prio, &group);
         }
=20
         if (best_irq !=3D 1023) {
-            trace_gic_update_bestirq(cpu, best_irq, best_prio,
-                s->priority_mask[cpu_iface], s->running_priority[cpu_ifa=
ce]);
+            trace_gic_update_bestirq(virt ? "vcpu" : "cpu", cpu,
+                                     best_irq, best_prio,
+                                     s->priority_mask[cpu_iface],
+                                     s->running_priority[cpu_iface]);
         }
=20
         irq_level =3D fiq_level =3D 0;
=20
         if (best_prio < s->priority_mask[cpu_iface]) {
@@ -330,10 +332,11 @@ static void gic_update_maintenance(GICState *s)
=20
     for (cpu =3D 0; cpu < s->num_cpu; cpu++) {
         gic_compute_misr(s, cpu);
         maint_level =3D (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK) && s->h_mis=
r[cpu];
=20
+        trace_gic_update_maintenance_irq(cpu, maint_level);
         qemu_set_irq(s->maintenance_irq[cpu], maint_level);
     }
 }
=20
 static void gic_update_virt(GICState *s)
@@ -595,11 +598,12 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, =
MemTxAttrs attrs)
     /* gic_get_current_pending_irq() will return 1022 or 1023 appropriat=
ely
      * for the case where this GIC supports grouping and the pending int=
errupt
      * is in the wrong group.
      */
     irq =3D gic_get_current_pending_irq(s, cpu, attrs);
-    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
+    trace_gic_acknowledge_irq(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                              gic_get_vcpu_real_id(cpu), irq);
=20
     if (irq >=3D GIC_MAXIRQ) {
         DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
         return irq;
     }
@@ -1128,24 +1132,27 @@ static MemTxResult gic_dist_read(void *opaque, hw=
addr offset, uint64_t *data,
                                  unsigned size, MemTxAttrs attrs)
 {
     switch (size) {
     case 1:
         *data =3D gic_dist_readb(opaque, offset, attrs);
-        return MEMTX_OK;
+        break;
     case 2:
         *data =3D gic_dist_readb(opaque, offset, attrs);
         *data |=3D gic_dist_readb(opaque, offset + 1, attrs) << 8;
-        return MEMTX_OK;
+        break;
     case 4:
         *data =3D gic_dist_readb(opaque, offset, attrs);
         *data |=3D gic_dist_readb(opaque, offset + 1, attrs) << 8;
         *data |=3D gic_dist_readb(opaque, offset + 2, attrs) << 16;
         *data |=3D gic_dist_readb(opaque, offset + 3, attrs) << 24;
-        return MEMTX_OK;
+        break;
     default:
         return MEMTX_ERROR;
     }
+
+    trace_gic_dist_read(offset, size, *data);
+    return MEMTX_OK;
 }
=20
 static void gic_dist_writeb(void *opaque, hwaddr offset,
                             uint32_t value, MemTxAttrs attrs)
 {
@@ -1480,10 +1487,12 @@ static void gic_dist_writel(void *opaque, hwaddr =
offset,
 }
=20
 static MemTxResult gic_dist_write(void *opaque, hwaddr offset, uint64_t =
data,
                                   unsigned size, MemTxAttrs attrs)
 {
+    trace_gic_dist_write(offset, size, data);
+
     switch (size) {
     case 1:
         gic_dist_writeb(opaque, offset, data, attrs);
         return MEMTX_OK;
     case 2:
@@ -1636,16 +1645,22 @@ static MemTxResult gic_cpu_read(GICState *s, int =
cpu, int offset,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_cpu_read: Bad offset %x\n", (int)offset);
         *data =3D 0;
         break;
     }
+
+    trace_gic_cpu_read(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                       gic_get_vcpu_real_id(cpu), offset, *data);
     return MEMTX_OK;
 }
=20
 static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                                  uint32_t value, MemTxAttrs attrs)
 {
+    trace_gic_cpu_write(gic_is_vcpu(cpu) ? "vcpu" : "cpu",
+                        gic_get_vcpu_real_id(cpu), offset, value);
+
     switch (offset) {
     case 0x00: /* Control */
         gic_set_cpu_control(s, cpu, value, attrs);
         break;
     case 0x04: /* Priority mask */
@@ -1892,19 +1907,22 @@ static MemTxResult gic_hyp_read(void *opaque, int=
 cpu, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "gic_hyp_read: Bad offset %" HWADDR_PRIx "\n", add=
r);
         return MEMTX_OK;
     }
=20
+    trace_gic_hyp_read(addr, *data);
     return MEMTX_OK;
 }
=20
 static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
                                  uint64_t value, MemTxAttrs attrs)
 {
     GICState *s =3D ARM_GIC(opaque);
     int vcpu =3D cpu + GIC_NCPU;
=20
+    trace_gic_hyp_write(addr, value);
+
     switch (addr) {
     case A_GICH_HCR: /* Hypervisor Control */
         s->h_hcr[cpu] =3D value & GICH_HCR_MASK;
         break;
=20
@@ -1924,10 +1942,11 @@ static MemTxResult gic_hyp_write(void *opaque, in=
t cpu, hwaddr addr,
         if (lr_idx > s->num_lrs) {
             return MEMTX_OK;
         }
=20
         s->h_lr[lr_idx][cpu] =3D value & GICH_LR_MASK;
+        trace_gic_lr_entry(cpu, lr_idx, s->h_lr[lr_idx][cpu]);
         break;
     }
=20
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 5fb18e65c9..81c7c399f7 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -90,13 +90,21 @@ aspeed_vic_write(uint64_t offset, unsigned size, uint=
32_t data) "To 0x%" PRIx64
=20
 # hw/intc/arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
 gic_disable_irq(int irq) "irq %d disabled"
 gic_set_irq(int irq, int level, int cpumask, int target) "irq %d level %=
d cpumask 0x%x target 0x%x"
-gic_update_bestirq(int cpu, int irq, int prio, int priority_mask, int ru=
nning_priority) "cpu %d irq %d priority %d cpu priority mask %d cpu runni=
ng priority %d"
+gic_update_bestirq(const char *s, int cpu, int irq, int prio, int priori=
ty_mask, int running_priority) "%s %d irq %d priority %d cpu priority mas=
k %d cpu running priority %d"
 gic_update_set_irq(int cpu, const char *name, int level) "cpu[%d]: %s =3D=
 %d"
-gic_acknowledge_irq(int cpu, int irq) "cpu %d acknowledged irq %d"
+gic_acknowledge_irq(const char *s, int cpu, int irq) "%s %d acknowledged=
 irq %d"
+gic_cpu_write(const char *s, int cpu, int addr, uint32_t val) "%s %d ifa=
ce write at 0x%08x 0x%08" PRIx32
+gic_cpu_read(const char *s, int cpu, int addr, uint32_t val) "%s %d ifac=
e read at 0x%08x: 0x%08" PRIx32
+gic_hyp_read(int addr, uint32_t val) "hyp read at 0x%08x: 0x%08" PRIx32
+gic_hyp_write(int addr, uint32_t val) "hyp write at 0x%08x: 0x%08" PRIx3=
2
+gic_dist_read(int addr, unsigned int size, uint32_t val) "dist read at 0=
x%08x size %u: 0x%08" PRIx32
+gic_dist_write(int addr, unsigned int size, uint32_t val) "dist write at=
 0x%08x size %u: 0x%08" PRIx32
+gic_lr_entry(int cpu, int entry, uint32_t val) "cpu %d: new lr entry %d:=
 0x%08" PRIx32
+gic_update_maintenance_irq(int cpu, int val) "cpu %d: maintenance =3D %d=
"
=20
 # hw/intc/arm_gicv3_cpuif.c
 gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu 0=
x%x value 0x%" PRIx64
 gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu=
 0x%x value 0x%" PRIx64
 gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d=
 read cpu 0x%x value 0x%" PRIx64
--=20
2.18.0
