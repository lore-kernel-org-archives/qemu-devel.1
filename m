Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-0000uT-Ic
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPm-00057I-Ph
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPm-00055o-Ej
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPl-0003E3-GF
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:48 +0000
Message-Id: <1484834995-26826-30-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 29/36] hw/intc/arm_gicv3: Implement ICV_
 registers EOIR and IAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the two remaining ICV_ registers: EOIR and IAR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-12-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events      |   2 +
 2 files changed, 222 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e069082..f3845a6 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -203,6 +203,73 @@ static int hppvi_index(GICv3CPUState *cs)
     return idx;
 }
 
+static uint32_t icv_gprio_mask(GICv3CPUState *cs, int group)
+{
+    /* Return a mask word which clears the subpriority bits from
+     * a priority value for a virtual interrupt in the specified group.
+     * This depends on the VBPR value:
+     *  a BPR of 0 means the group priority bits are [7:1];
+     *  a BPR of 1 means they are [7:2], and so on down to
+     *  a BPR of 7 meaning no group priority bits at all.
+     * Which BPR to use depends on the group of the interrupt and
+     * the current ICH_VMCR_EL2.VCBPR settings.
+     */
+    if (group == GICV3_G1NS && cs->ich_vmcr_el2 & ICH_VMCR_EL2_VCBPR) {
+        group = GICV3_G0;
+    }
+
+    return ~0U << (read_vbpr(cs, group) + 1);
+}
+
+static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
+{
+    /* Return true if we can signal this virtual interrupt defined by
+     * the given list register value; see the pseudocode functions
+     * CanSignalVirtualInterrupt and CanSignalVirtualInt.
+     * Compare also icc_hppi_can_preempt() which is the non-virtual
+     * equivalent of these checks.
+     */
+    int grp;
+    uint32_t mask, prio, rprio, vpmr;
+
+    if (!(cs->ich_hcr_el2 & ICH_HCR_EL2_EN)) {
+        /* Virtual interface disabled */
+        return false;
+    }
+
+    /* We don't need to check that this LR is in Pending state because
+     * that has already been done in hppvi_index().
+     */
+
+    prio = ich_lr_prio(lr);
+    vpmr = extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VPMR_SHIFT,
+                     ICH_VMCR_EL2_VPMR_LENGTH);
+
+    if (prio >= vpmr) {
+        /* Priority mask masks this interrupt */
+        return false;
+    }
+
+    rprio = ich_highest_active_virt_prio(cs);
+    if (rprio == 0xff) {
+        /* No running interrupt so we can preempt */
+        return true;
+    }
+
+    grp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+    mask = icv_gprio_mask(cs, grp);
+
+    /* We only preempt a running interrupt if the pending interrupt's
+     * group priority is sufficient (the subpriorities are not considered).
+     */
+    if ((prio & mask) < (rprio & mask)) {
+        return true;
+    }
+
+    return false;
+}
+
 static uint32_t eoi_maintenance_interrupt_state(GICv3CPUState *cs,
                                                 uint32_t *misr)
 {
@@ -480,6 +547,53 @@ static uint64_t icv_hppir_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return value;
 }
 
+static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
+{
+    /* Activate the interrupt in the specified list register
+     * by moving it from Pending to Active state, and update the
+     * Active Priority Registers.
+     */
+    uint32_t mask = icv_gprio_mask(cs, grp);
+    int prio = ich_lr_prio(cs->ich_lr_el2[idx]) & mask;
+    int aprbit = prio >> (8 - cs->vprebits);
+    int regno = aprbit / 32;
+    int regbit = aprbit % 32;
+
+    cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
+    cs->ich_lr_el2[idx] |= ICH_LR_EL2_STATE_ACTIVE_BIT;
+    cs->ich_apr[grp][regno] |= (1 << regbit);
+}
+
+static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
+    int idx = hppvi_index(cs);
+    uint64_t intid = INTID_SPURIOUS;
+
+    if (idx >= 0) {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+        if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
+            intid = ich_lr_vintid(lr);
+            if (intid < INTID_SECURE) {
+                icv_activate_irq(cs, idx, grp);
+            } else {
+                /* Interrupt goes from Pending to Invalid */
+                cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
+                /* We will now return the (bogus) ID from the list register,
+                 * as per the pseudocode.
+                 */
+            }
+        }
+    }
+
+    trace_gicv3_icv_iar_read(ri->crm == 8 ? 0 : 1,
+                             gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
 static int icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
@@ -773,6 +887,10 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     GICv3CPUState *cs = icc_cs_from_env(env);
     uint64_t intid;
 
+    if (icv_access(env, HCR_FMO)) {
+        return icv_iar_read(env, ri);
+    }
+
     if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
@@ -792,6 +910,10 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     GICv3CPUState *cs = icc_cs_from_env(env);
     uint64_t intid;
 
+    if (icv_access(env, HCR_IMO)) {
+        return icv_iar_read(env, ri);
+    }
+
     if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
@@ -956,6 +1078,48 @@ static void icv_increment_eoicount(GICv3CPUState *cs)
                                 ICH_HCR_EL2_EOICOUNT_LENGTH, eoicount + 1);
 }
 
+static int icv_drop_prio(GICv3CPUState *cs)
+{
+    /* Drop the priority of the currently active virtual interrupt
+     * (favouring group 0 if there is a set active bit at
+     * the same priority for both group 0 and group 1).
+     * Return the priority value for the bit we just cleared,
+     * or 0xff if no bits were set in the AP registers at all.
+     * Note that though the ich_apr[] are uint64_t only the low
+     * 32 bits are actually relevant.
+     */
+    int i;
+    int aprmax = 1 << (cs->vprebits - 5);
+
+    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
+
+    for (i = 0; i < aprmax; i++) {
+        uint64_t *papr0 = &cs->ich_apr[GICV3_G0][i];
+        uint64_t *papr1 = &cs->ich_apr[GICV3_G1NS][i];
+        int apr0count, apr1count;
+
+        if (!*papr0 && !*papr1) {
+            continue;
+        }
+
+        /* We can't just use the bit-twiddling hack icc_drop_prio() does
+         * because we need to return the bit number we cleared so
+         * it can be compared against the list register's priority field.
+         */
+        apr0count = ctz32(*papr0);
+        apr1count = ctz32(*papr1);
+
+        if (apr0count <= apr1count) {
+            *papr0 &= *papr0 - 1;
+            return (apr0count + i * 32) << (icv_min_vbpr(cs) + 1);
+        } else {
+            *papr1 &= *papr1 - 1;
+            return (apr1count + i * 32) << (icv_min_vbpr(cs) + 1);
+        }
+    }
+    return 0xff;
+}
+
 static void icv_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
@@ -989,6 +1153,57 @@ static void icv_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv3_cpuif_virt_update(cs);
 }
 
+static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /* End of Interrupt */
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int irq = value & 0xffffff;
+    int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
+    int idx, dropprio;
+
+    trace_gicv3_icv_eoir_write(ri->crm == 8 ? 0 : 1,
+                               gicv3_redist_affid(cs), value);
+
+    if (irq >= cs->gic->num_irq) {
+        /* Also catches special interrupt numbers and LPIs */
+        return;
+    }
+
+    /* We implement the IMPDEF choice of "drop priority before doing
+     * error checks" (because that lets us avoid scanning the AP
+     * registers twice).
+     */
+    dropprio = icv_drop_prio(cs);
+    if (dropprio == 0xff) {
+        /* No active interrupt. It is CONSTRAINED UNPREDICTABLE
+         * whether the list registers are checked in this
+         * situation; we choose not to.
+         */
+        return;
+    }
+
+    idx = icv_find_active(cs, irq);
+
+    if (idx < 0) {
+        /* No valid list register corresponding to EOI ID */
+        icv_increment_eoicount(cs);
+    } else {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+        int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
+
+        if (thisgrp == grp && lr_gprio == dropprio) {
+            if (!icv_eoi_split(env, cs)) {
+                /* Priority drop and deactivate not split: deactivate irq now */
+                icv_deactivate_irq(cs, idx);
+            }
+        }
+    }
+
+    gicv3_cpuif_virt_update(cs);
+}
+
 static void icc_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
@@ -997,6 +1212,11 @@ static void icc_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int irq = value & 0xffffff;
     int grp;
 
+    if (icv_access(env, ri->crm == 8 ? HCR_FMO : HCR_IMO)) {
+        icv_eoir_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_eoir_write(ri->crm == 8 ? 0 : 1,
                                gicv3_redist_affid(cs), value);
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index fc9ec57..1dcc830 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -136,6 +136,8 @@ gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x va
 gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %x value 0x%" PRIx64
 gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %x value 0x%" PRIx64
 gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %x value 0x%" PRIx64
+gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu %x value 0x%" PRIx64
+gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu %x value 0x%" PRIx64
 
 # hw/intc/arm_gicv3_dist.c
 gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-- 
2.7.4
