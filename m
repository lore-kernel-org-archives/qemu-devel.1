Received: from eggs.gnu.org ([2001:4830:134:3::10]:47328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-0000sn-LX
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPm-000566-1m
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:11 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPl-0004w9-OT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPl-0003Dc-1i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:47 +0000
Message-Id: <1484834995-26826-29-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/36] hw/intc/arm_gicv3: Implement ICV_ HPPIR,
 DIR and RPR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the the ICV_ registers HPPIR, DIR and RPR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-11-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 235 +++++++++++++++++++++++++++++++++++++++++++++-
 hw/intc/trace-events      |   3 +
 2 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 40a52ce..e069082 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -44,6 +44,21 @@ static inline int icv_min_vbpr(GICv3CPUState *cs)
 }
 
 /* Simple accessor functions for LR fields */
+static uint32_t ich_lr_vintid(uint64_t lr)
+{
+    return extract64(lr, ICH_LR_EL2_VINTID_SHIFT, ICH_LR_EL2_VINTID_LENGTH);
+}
+
+static uint32_t ich_lr_pintid(uint64_t lr)
+{
+    return extract64(lr, ICH_LR_EL2_PINTID_SHIFT, ICH_LR_EL2_PINTID_LENGTH);
+}
+
+static uint32_t ich_lr_prio(uint64_t lr)
+{
+    return extract64(lr, ICH_LR_EL2_PRIORITY_SHIFT, ICH_LR_EL2_PRIORITY_LENGTH);
+}
+
 static int ich_lr_state(uint64_t lr)
 {
     return extract64(lr, ICH_LR_EL2_STATE_SHIFT, ICH_LR_EL2_STATE_LENGTH);
@@ -115,6 +130,79 @@ static uint32_t icv_fullprio_mask(GICv3CPUState *cs)
     return ~0U << (8 - cs->vpribits);
 }
 
+static int ich_highest_active_virt_prio(GICv3CPUState *cs)
+{
+    /* Calculate the current running priority based on the set bits
+     * in the ICH Active Priority Registers.
+     */
+    int i;
+    int aprmax = 1 << (cs->vprebits - 5);
+
+    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
+
+    for (i = 0; i < aprmax; i++) {
+        uint32_t apr = cs->ich_apr[GICV3_G0][i] |
+            cs->ich_apr[GICV3_G1NS][i];
+
+        if (!apr) {
+            continue;
+        }
+        return (i * 32 + ctz32(apr)) << (icv_min_vbpr(cs) + 1);
+    }
+    /* No current active interrupts: return idle priority */
+    return 0xff;
+}
+
+static int hppvi_index(GICv3CPUState *cs)
+{
+    /* Return the list register index of the highest priority pending
+     * virtual interrupt, as per the HighestPriorityVirtualInterrupt
+     * pseudocode. If no pending virtual interrupts, return -1.
+     */
+    int idx = -1;
+    int i;
+    /* Note that a list register entry with a priority of 0xff will
+     * never be reported by this function; this is the architecturally
+     * correct behaviour.
+     */
+    int prio = 0xff;
+
+    if (!(cs->ich_vmcr_el2 & (ICH_VMCR_EL2_VENG0 | ICH_VMCR_EL2_VENG1))) {
+        /* Both groups disabled, definitely nothing to do */
+        return idx;
+    }
+
+    for (i = 0; i < cs->num_list_regs; i++) {
+        uint64_t lr = cs->ich_lr_el2[i];
+        int thisprio;
+
+        if (ich_lr_state(lr) != ICH_LR_EL2_STATE_PENDING) {
+            /* Not Pending */
+            continue;
+        }
+
+        /* Ignore interrupts if relevant group enable not set */
+        if (lr & ICH_LR_EL2_GROUP) {
+            if (!(cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG1)) {
+                continue;
+            }
+        } else {
+            if (!(cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG0)) {
+                continue;
+            }
+        }
+
+        thisprio = ich_lr_prio(lr);
+
+        if (thisprio < prio) {
+            prio = thisprio;
+            idx = i;
+        }
+    }
+
+    return idx;
+}
+
 static uint32_t eoi_maintenance_interrupt_state(GICv3CPUState *cs,
                                                 uint32_t *misr)
 {
@@ -363,6 +451,35 @@ static void icv_ctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv3_cpuif_virt_update(cs);
 }
 
+static uint64_t icv_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int prio = ich_highest_active_virt_prio(cs);
+
+    trace_gicv3_icv_rpr_read(gicv3_redist_affid(cs), prio);
+    return prio;
+}
+
+static uint64_t icv_hppir_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
+    int idx = hppvi_index(cs);
+    uint64_t value = INTID_SPURIOUS;
+
+    if (idx >= 0) {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+        if (grp == thisgrp) {
+            value = ich_lr_vintid(lr);
+        }
+    }
+
+    trace_gicv3_icv_hppir_read(grp, gicv3_redist_affid(cs), value);
+    return value;
+}
+
 static int icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
@@ -781,6 +898,97 @@ static void icc_deactivate_irq(GICv3CPUState *cs, int irq)
     }
 }
 
+static bool icv_eoi_split(CPUARMState *env, GICv3CPUState *cs)
+{
+    /* Return true if we should split priority drop and interrupt
+     * deactivation, ie whether the virtual EOIMode bit is set.
+     */
+    return cs->ich_vmcr_el2 & ICH_VMCR_EL2_VEOIM;
+}
+
+static int icv_find_active(GICv3CPUState *cs, int irq)
+{
+    /* Given an interrupt number for an active interrupt, return the index
+     * of the corresponding list register, or -1 if there is no match.
+     * Corresponds to FindActiveVirtualInterrupt pseudocode.
+     */
+    int i;
+
+    for (i = 0; i < cs->num_list_regs; i++) {
+        uint64_t lr = cs->ich_lr_el2[i];
+
+        if ((lr & ICH_LR_EL2_STATE_ACTIVE_BIT) && ich_lr_vintid(lr) == irq) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+static void icv_deactivate_irq(GICv3CPUState *cs, int idx)
+{
+    /* Deactivate the interrupt in the specified list register index */
+    uint64_t lr = cs->ich_lr_el2[idx];
+
+    if (lr & ICH_LR_EL2_HW) {
+        /* Deactivate the associated physical interrupt */
+        int pirq = ich_lr_pintid(lr);
+
+        if (pirq < INTID_SECURE) {
+            icc_deactivate_irq(cs, pirq);
+        }
+    }
+
+    /* Clear the 'active' part of the state, so ActivePending->Pending
+     * and Active->Invalid.
+     */
+    lr &= ~ICH_LR_EL2_STATE_ACTIVE_BIT;
+    cs->ich_lr_el2[idx] = lr;
+}
+
+static void icv_increment_eoicount(GICv3CPUState *cs)
+{
+    /* Increment the EOICOUNT field in ICH_HCR_EL2 */
+    int eoicount = extract64(cs->ich_hcr_el2, ICH_HCR_EL2_EOICOUNT_SHIFT,
+                             ICH_HCR_EL2_EOICOUNT_LENGTH);
+
+    cs->ich_hcr_el2 = deposit64(cs->ich_hcr_el2, ICH_HCR_EL2_EOICOUNT_SHIFT,
+                                ICH_HCR_EL2_EOICOUNT_LENGTH, eoicount + 1);
+}
+
+static void icv_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    /* Deactivate interrupt */
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int idx;
+    int irq = value & 0xffffff;
+
+    trace_gicv3_icv_dir_write(gicv3_redist_affid(cs), value);
+
+    if (irq >= cs->gic->num_irq) {
+        /* Also catches special interrupt numbers and LPIs */
+        return;
+    }
+
+    if (!icv_eoi_split(env, cs)) {
+        return;
+    }
+
+    idx = icv_find_active(cs, irq);
+
+    if (idx < 0) {
+        /* No list register matching this, so increment the EOI count
+         * (might trigger a maintenance interrupt)
+         */
+        icv_increment_eoicount(cs);
+    } else {
+        icv_deactivate_irq(cs, idx);
+    }
+
+    gicv3_cpuif_virt_update(cs);
+}
+
 static void icc_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
@@ -831,8 +1039,13 @@ static void icc_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icc_hppir0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    uint64_t value = icc_hppir0_value(cs, env);
+    uint64_t value;
+
+    if (icv_access(env, HCR_FMO)) {
+        return icv_hppir_read(env, ri);
+    }
 
+    value = icc_hppir0_value(cs, env);
     trace_gicv3_icc_hppir0_read(gicv3_redist_affid(cs), value);
     return value;
 }
@@ -840,8 +1053,13 @@ static uint64_t icc_hppir0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    uint64_t value = icc_hppir1_value(cs, env);
+    uint64_t value;
+
+    if (icv_access(env, HCR_IMO)) {
+        return icv_hppir_read(env, ri);
+    }
 
+    value = icc_hppir1_value(cs, env);
     trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
     return value;
 }
@@ -986,6 +1204,11 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     bool irq_is_secure, single_sec_state, irq_is_grp0;
     bool route_fiq_to_el3, route_irq_to_el3, route_fiq_to_el2, route_irq_to_el2;
 
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        icv_dir_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_dir_write(gicv3_redist_affid(cs), value);
 
     if (irq >= cs->gic->num_irq) {
@@ -1057,7 +1280,13 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio = icc_highest_active_prio(cs);
+    int prio;
+
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        return icv_rpr_read(env, ri);
+    }
+
+    prio = icc_highest_active_prio(cs);
 
     if (arm_feature(env, ARM_FEATURE_EL3) &&
         !arm_is_secure(env) && (env->cp15.scr_el3 & SCR_FIQ)) {
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 19fe1d5..fc9ec57 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -133,6 +133,9 @@ gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d r
 gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %x value 0x%" PRIx64
 gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %x value 0x%" PRIx64
 gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x value 0x%" PRIx64
+gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %x value 0x%" PRIx64
+gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %x value 0x%" PRIx64
+gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %x value 0x%" PRIx64
 
 # hw/intc/arm_gicv3_dist.c
 gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-- 
2.7.4
