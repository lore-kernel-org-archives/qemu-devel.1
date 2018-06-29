Received: from eggs.gnu.org ([2001:4830:134:3::10]:38185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUJ-0007jh-QK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUG-0007Su-Aw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:59 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:49 +0200
Message-Id: <20180629132954.24269-16-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 15/20] intc/arm_gic: Implement the virtual
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

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 161 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 9bbd544a5c..a29042f291 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1530,6 +1530,163 @@ static MemTxResult gic_do_vcpu_write(void *opaque, hwaddr addr,
 
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
+static MemTxResult gic_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
+                                unsigned size, MemTxAttrs attrs)
+{
+    GICState *s = ARM_GIC(opaque);
+    int cpu = gic_get_current_cpu(s);
+    int vcpu = gic_get_current_vcpu(s);
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
+static MemTxResult gic_hyp_write(void *opaque, hwaddr addr, uint64_t value,
+                                 unsigned size, MemTxAttrs attrs)
+{
+    GICState *s = ARM_GIC(opaque);
+    int cpu = gic_get_current_cpu(s);
+    int vcpu = gic_get_current_vcpu(s);
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
 static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
@@ -1551,8 +1708,8 @@ static const MemoryRegionOps gic_cpu_ops = {
 
 static const MemoryRegionOps gic_virt_ops[2] = {
     {
-        .read_with_attrs = NULL,
-        .write_with_attrs = NULL,
+        .read_with_attrs = gic_hyp_read,
+        .write_with_attrs = gic_hyp_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
     },
     {
-- 
2.17.1
