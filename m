Received: from eggs.gnu.org ([2001:4830:134:3::10]:58430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSn-0003wf-KF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSl-0006QL-28
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:09 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:16 +0200
Message-Id: <20180727095421.386-16-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 15/20] intc/arm_gic: Implement the virtual
 interface registers
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

Implement the read and write functions for the virtual interface of the
virtualization extensions in the GICv2.

One mirror region per CPU is also created, which maps to that specific
CPU id. This is required by the GIC architecture specification.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 235 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7ee2e6bcbb..6063196487 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -145,10 +145,28 @@ static void gic_update(GICState *s)
         qemu_set_irq(s->parent_irq[cpu], irq_level);
         qemu_set_irq(s->parent_fiq[cpu], fiq_level);
     }
 }
 
+/* Return true if this LR is empty, i.e. the corresponding bit
+ * in ELRSR is set.
+ */
+static inline bool gic_lr_entry_is_free(uint32_t entry)
+{
+    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
+        && (GICH_LR_HW(entry) || !GICH_LR_EOI(entry));
+}
+
+/* Return true if this LR should trigger an EOI maintenance interrupt, i.e. the
+ * corrsponding bit in EISR is set.
+ */
+static inline bool gic_lr_entry_is_eoi(uint32_t entry)
+{
+    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
+        && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
+}
+
 static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
                                  int cm, int target)
 {
     if (level) {
         GIC_DIST_SET_LEVEL(irq, cm);
@@ -1570,10 +1588,204 @@ static MemTxResult gic_thisvcpu_write(void *opaque, hwaddr addr,
     GICState *s = (GICState *)opaque;
 
     return gic_cpu_write(s, gic_get_current_vcpu(s), addr, value, attrs);
 }
 
+static uint32_t gic_compute_eisr(GICState *s, int cpu, int lr_start)
+{
+    int lr_idx;
+    uint32_t ret = 0;
+
+    for (lr_idx = lr_start; lr_idx < s->num_lrs; lr_idx++) {
+        uint32_t *entry = &s->h_lr[lr_idx][cpu];
+        ret = deposit32(ret, lr_idx - lr_start, 1,
+                        gic_lr_entry_is_eoi(*entry));
+    }
+
+    return ret;
+}
+
+static uint32_t gic_compute_elrsr(GICState *s, int cpu, int lr_start)
+{
+    int lr_idx;
+    uint32_t ret = 0;
+
+    for (lr_idx = lr_start; lr_idx < s->num_lrs; lr_idx++) {
+        uint32_t *entry = &s->h_lr[lr_idx][cpu];
+        ret = deposit32(ret, lr_idx - lr_start, 1,
+                        gic_lr_entry_is_free(*entry));
+    }
+
+    return ret;
+}
+
+static void gic_vmcr_write(GICState *s, uint32_t value, MemTxAttrs attrs)
+{
+    int vcpu = gic_get_current_vcpu(s);
+    uint32_t ctlr;
+    uint32_t abpr;
+    uint32_t bpr;
+    uint32_t prio_mask;
+
+    ctlr = FIELD_EX32(value, GICH_VMCR, VMCCtlr);
+    abpr = FIELD_EX32(value, GICH_VMCR, VMABP);
+    bpr = FIELD_EX32(value, GICH_VMCR, VMBP);
+    prio_mask = FIELD_EX32(value, GICH_VMCR, VMPriMask) << 3;
+
+    gic_set_cpu_control(s, vcpu, ctlr, attrs);
+    s->abpr[vcpu] = MAX(abpr, GIC_VIRT_MIN_ABPR);
+    s->bpr[vcpu] = MAX(bpr, GIC_VIRT_MIN_BPR);
+    gic_set_priority_mask(s, vcpu, prio_mask, attrs);
+}
+
+static MemTxResult gic_hyp_read(void *opaque, int cpu, hwaddr addr,
+                                uint64_t *data, MemTxAttrs attrs)
+{
+    GICState *s = ARM_GIC(opaque);
+    int vcpu = cpu + GIC_NCPU;
+
+    switch (addr) {
+    case A_GICH_HCR: /* Hypervisor Control */
+        *data = s->h_hcr[cpu];
+        break;
+
+    case A_GICH_VTR: /* VGIC Type */
+        *data = FIELD_DP32(0, GICH_VTR, ListRegs, s->num_lrs - 1);
+        *data = FIELD_DP32(*data, GICH_VTR, PREbits,
+                           GIC_VIRT_MAX_GROUP_PRIO_BITS - 1);
+        *data = FIELD_DP32(*data, GICH_VTR, PRIbits,
+                           (7 - GIC_VIRT_MIN_BPR) - 1);
+        break;
+
+    case A_GICH_VMCR: /* Virtual Machine Control */
+        *data = FIELD_DP32(0, GICH_VMCR, VMCCtlr,
+                           extract32(s->cpu_ctlr[vcpu], 0, 10));
+        *data = FIELD_DP32(*data, GICH_VMCR, VMABP, s->abpr[vcpu]);
+        *data = FIELD_DP32(*data, GICH_VMCR, VMBP, s->bpr[vcpu]);
+        *data = FIELD_DP32(*data, GICH_VMCR, VMPriMask,
+                           extract32(s->priority_mask[vcpu], 3, 5));
+        break;
+
+    case A_GICH_MISR: /* Maintenance Interrupt Status */
+        *data = s->h_misr[cpu];
+        break;
+
+    case A_GICH_EISR0: /* End of Interrupt Status 0 and 1 */
+    case A_GICH_EISR1:
+        *data = gic_compute_eisr(s, cpu, (addr - A_GICH_EISR0) * 8);
+        break;
+
+    case A_GICH_ELRSR0: /* Empty List Status 0 and 1 */
+    case A_GICH_ELRSR1:
+        *data = gic_compute_elrsr(s, cpu, (addr - A_GICH_ELRSR0) * 8);
+        break;
+
+    case A_GICH_APR: /* Active Priorities */
+        *data = s->h_apr[cpu];
+        break;
+
+    case A_GICH_LR0 ... A_GICH_LR63: /* List Registers */
+    {
+        int lr_idx = (addr - A_GICH_LR0) / 4;
+
+        if (lr_idx > s->num_lrs) {
+            *data = 0;
+        } else {
+            *data = s->h_lr[lr_idx][cpu];
+        }
+        break;
+    }
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gic_hyp_read: Bad offset %" HWADDR_PRIx "\n", addr);
+        return MEMTX_OK;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
+                                 uint64_t value, MemTxAttrs attrs)
+{
+    GICState *s = ARM_GIC(opaque);
+    int vcpu = cpu + GIC_NCPU;
+
+    switch (addr) {
+    case A_GICH_HCR: /* Hypervisor Control */
+        s->h_hcr[cpu] = value & GICH_HCR_MASK;
+        break;
+
+    case A_GICH_VMCR: /* Virtual Machine Control */
+        gic_vmcr_write(s, value, attrs);
+        break;
+
+    case A_GICH_APR: /* Active Priorities */
+        s->h_apr[cpu] = value;
+        s->running_priority[vcpu] = gic_get_prio_from_apr_bits(s, vcpu);
+        break;
+
+    case A_GICH_LR0 ... A_GICH_LR63: /* List Registers */
+    {
+        int lr_idx = (addr - A_GICH_LR0) / 4;
+
+        if (lr_idx > s->num_lrs) {
+            return MEMTX_OK;
+        }
+
+        s->h_lr[lr_idx][cpu] = value & GICH_LR_MASK;
+        break;
+    }
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gic_hyp_write: Bad offset %" HWADDR_PRIx "\n", addr);
+        return MEMTX_OK;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult gic_thiscpu_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    GICState *s = (GICState *)opaque;
+
+    return gic_hyp_read(s, gic_get_current_cpu(s), addr, data, attrs);
+}
+
+static MemTxResult gic_thiscpu_hyp_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    GICState *s = (GICState *)opaque;
+
+    return gic_hyp_write(s, gic_get_current_cpu(s), addr, value, attrs);
+}
+
+static MemTxResult gic_do_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    GICState **backref = (GICState **)opaque;
+    GICState *s = *backref;
+    int id = (backref - s->backref);
+
+    return gic_hyp_read(s, id, addr, data, attrs);
+}
+
+static MemTxResult gic_do_hyp_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    GICState **backref = (GICState **)opaque;
+    GICState *s = *backref;
+    int id = (backref - s->backref);
+
+    return gic_hyp_write(s, id + GIC_NCPU, addr, value, attrs);
+
+}
+
 static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
         .write_with_attrs = gic_dist_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
@@ -1591,21 +1803,27 @@ static const MemoryRegionOps gic_cpu_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
 static const MemoryRegionOps gic_virt_ops[2] = {
     {
-        .read_with_attrs = NULL,
-        .write_with_attrs = NULL,
+        .read_with_attrs = gic_thiscpu_hyp_read,
+        .write_with_attrs = gic_thiscpu_hyp_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
     },
     {
         .read_with_attrs = gic_thisvcpu_read,
         .write_with_attrs = gic_thisvcpu_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
     }
 };
 
+static const MemoryRegionOps gic_viface_ops = {
+    .read_with_attrs = gic_do_hyp_read,
+    .write_with_attrs = gic_do_hyp_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
     int i;
     GICState *s = ARM_GIC(dev);
@@ -1643,10 +1861,23 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         s->backref[i] = s;
         memory_region_init_io(&s->cpuiomem[i+1], OBJECT(s), &gic_cpu_ops,
                               &s->backref[i], "gic_cpu", 0x100);
         sysbus_init_mmio(sbd, &s->cpuiomem[i+1]);
     }
+
+    /* Extra core-specific regions for virtual interfaces. This is required by
+     * the GICv2 specification.
+     */
+    if (s->virt_extn) {
+        for (i = 0; i < s->num_cpu; i++) {
+            memory_region_init_io(&s->vifaceiomem[i + 1], OBJECT(s),
+                                  &gic_viface_ops, &s->backref[i],
+                                  "gic_viface", 0x1000);
+            sysbus_init_mmio(sbd, &s->vifaceiomem[i + 1]);
+        }
+    }
+
 }
 
 static void arm_gic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.18.0
