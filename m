Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000xn-Jy
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-00057U-2d
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPm-0004w9-NN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPk-0003Cs-3r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:45 +0000
Message-Id: <1484834995-26826-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/36] hw/intc/arm_gicv3: Add accessors for ICH_
 system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The GICv3 virtualization interface includes system registers
accessible only to the hypervisor which form the control
interface for interrupt virtualization. Implement these
registers.

The function gicv3_cpuif_virt_update() which determines
whether it needs to signal vIRQ, vFIQ or a maintenance
interrupt is introduced here as a stub function -- its
implementation will be added in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-9-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 477 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events      |  16 ++
 2 files changed, 493 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d2f859c..585c91c 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -42,6 +42,132 @@ static inline int icv_min_vbpr(GICv3CPUState *cs)
     return 7 - cs->vprebits;
 }
 
+/* Simple accessor functions for LR fields */
+static int ich_lr_state(uint64_t lr)
+{
+    return extract64(lr, ICH_LR_EL2_STATE_SHIFT, ICH_LR_EL2_STATE_LENGTH);
+}
+
+static int read_vbpr(GICv3CPUState *cs, int grp)
+{
+    /* Read VBPR value out of the VMCR field (caller must handle
+     * VCBPR effects if required)
+     */
+    if (grp == GICV3_G0) {
+        return extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VBPR0_SHIFT,
+                     ICH_VMCR_EL2_VBPR0_LENGTH);
+    } else {
+        return extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VBPR1_SHIFT,
+                         ICH_VMCR_EL2_VBPR1_LENGTH);
+    }
+}
+
+static void write_vbpr(GICv3CPUState *cs, int grp, int value)
+{
+    /* Write new VBPR1 value, handling the "writing a value less than
+     * the minimum sets it to the minimum" semantics.
+     */
+    int min = icv_min_vbpr(cs);
+
+    if (grp != GICV3_G0) {
+        min++;
+    }
+
+    value = MAX(value, min);
+
+    if (grp == GICV3_G0) {
+        cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VBPR0_SHIFT,
+                                     ICH_VMCR_EL2_VBPR0_LENGTH, value);
+    } else {
+        cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VBPR1_SHIFT,
+                                     ICH_VMCR_EL2_VBPR1_LENGTH, value);
+    }
+}
+
+static uint32_t eoi_maintenance_interrupt_state(GICv3CPUState *cs,
+                                                uint32_t *misr)
+{
+    /* Return a set of bits indicating the EOI maintenance interrupt status
+     * for each list register. The EOI maintenance interrupt status is
+     * 1 if LR.State == 0 && LR.HW == 0 && LR.EOI == 1
+     * (see the GICv3 spec for the ICH_EISR_EL2 register).
+     * If misr is not NULL then we should also collect the information
+     * about the MISR.EOI, MISR.NP and MISR.U bits.
+     */
+    uint32_t value = 0;
+    int validcount = 0;
+    bool seenpending = false;
+    int i;
+
+    for (i = 0; i < cs->num_list_regs; i++) {
+        uint64_t lr = cs->ich_lr_el2[i];
+
+        if ((lr & (ICH_LR_EL2_STATE_MASK | ICH_LR_EL2_HW | ICH_LR_EL2_EOI))
+            == ICH_LR_EL2_EOI) {
+            value |= (1 << i);
+        }
+        if ((lr & ICH_LR_EL2_STATE_MASK)) {
+            validcount++;
+        }
+        if (ich_lr_state(lr) == ICH_LR_EL2_STATE_PENDING) {
+            seenpending = true;
+        }
+    }
+
+    if (misr) {
+        if (validcount < 2 && (cs->ich_hcr_el2 & ICH_HCR_EL2_UIE)) {
+            *misr |= ICH_MISR_EL2_U;
+        }
+        if (!seenpending && (cs->ich_hcr_el2 & ICH_HCR_EL2_NPIE)) {
+            *misr |= ICH_MISR_EL2_NP;
+        }
+        if (value) {
+            *misr |= ICH_MISR_EL2_EOI;
+        }
+    }
+    return value;
+}
+
+static uint32_t maintenance_interrupt_state(GICv3CPUState *cs)
+{
+    /* Return a set of bits indicating the maintenance interrupt status
+     * (as seen in the ICH_MISR_EL2 register).
+     */
+    uint32_t value = 0;
+
+    /* Scan list registers and fill in the U, NP and EOI bits */
+    eoi_maintenance_interrupt_state(cs, &value);
+
+    if (cs->ich_hcr_el2 & (ICH_HCR_EL2_LRENPIE | ICH_HCR_EL2_EOICOUNT_MASK)) {
+        value |= ICH_MISR_EL2_LRENP;
+    }
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_VGRP0EIE) &&
+        (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG0)) {
+        value |= ICH_MISR_EL2_VGRP0E;
+    }
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_VGRP0DIE) &&
+        !(cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG1)) {
+        value |= ICH_MISR_EL2_VGRP0D;
+    }
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_VGRP1EIE) &&
+        (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG1)) {
+        value |= ICH_MISR_EL2_VGRP1E;
+    }
+
+    if ((cs->ich_hcr_el2 & ICH_HCR_EL2_VGRP1DIE) &&
+        !(cs->ich_vmcr_el2 & ICH_VMCR_EL2_VENG1)) {
+        value |= ICH_MISR_EL2_VGRP1D;
+    }
+
+    return value;
+}
+
+static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
+{
+}
+
 static int icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
@@ -1334,6 +1460,306 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 & 3;
+    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    uint64_t value;
+
+    value = cs->ich_apr[grp][regno];
+    trace_gicv3_ich_ap_read(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 & 3;
+    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+
+    trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
+
+    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t ich_hcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value = cs->ich_hcr_el2;
+
+    trace_gicv3_ich_hcr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void ich_hcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+
+    trace_gicv3_ich_hcr_write(gicv3_redist_affid(cs), value);
+
+    value &= ICH_HCR_EL2_EN | ICH_HCR_EL2_UIE | ICH_HCR_EL2_LRENPIE |
+        ICH_HCR_EL2_NPIE | ICH_HCR_EL2_VGRP0EIE | ICH_HCR_EL2_VGRP0DIE |
+        ICH_HCR_EL2_VGRP1EIE | ICH_HCR_EL2_VGRP1DIE | ICH_HCR_EL2_TC |
+        ICH_HCR_EL2_TALL0 | ICH_HCR_EL2_TALL1 | ICH_HCR_EL2_TSEI |
+        ICH_HCR_EL2_TDIR | ICH_HCR_EL2_EOICOUNT_MASK;
+
+    cs->ich_hcr_el2 = value;
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t ich_vmcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value = cs->ich_vmcr_el2;
+
+    trace_gicv3_ich_vmcr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+
+    trace_gicv3_ich_vmcr_write(gicv3_redist_affid(cs), value);
+
+    value &= ICH_VMCR_EL2_VENG0 | ICH_VMCR_EL2_VENG1 | ICH_VMCR_EL2_VCBPR |
+        ICH_VMCR_EL2_VEOIM | ICH_VMCR_EL2_VBPR1_MASK |
+        ICH_VMCR_EL2_VBPR0_MASK | ICH_VMCR_EL2_VPMR_MASK;
+    value |= ICH_VMCR_EL2_VFIQEN;
+
+    cs->ich_vmcr_el2 = value;
+    /* Enforce "writing BPRs to less than minimum sets them to the minimum"
+     * by reading and writing back the fields.
+     */
+    write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G0));
+    write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G1));
+
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t ich_lr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 | ((ri->crm & 1) << 3);
+    uint64_t value;
+
+    /* This read function handles all of:
+     * 64-bit reads of the whole LR
+     * 32-bit reads of the low half of the LR
+     * 32-bit reads of the high half of the LR
+     */
+    if (ri->state == ARM_CP_STATE_AA32) {
+        if (ri->crm >= 14) {
+            value = extract64(cs->ich_lr_el2[regno], 32, 32);
+            trace_gicv3_ich_lrc_read(regno, gicv3_redist_affid(cs), value);
+        } else {
+            value = extract64(cs->ich_lr_el2[regno], 0, 32);
+            trace_gicv3_ich_lr32_read(regno, gicv3_redist_affid(cs), value);
+        }
+    } else {
+        value = cs->ich_lr_el2[regno];
+        trace_gicv3_ich_lr_read(regno, gicv3_redist_affid(cs), value);
+    }
+
+    return value;
+}
+
+static void ich_lr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 | ((ri->crm & 1) << 3);
+
+    /* This write function handles all of:
+     * 64-bit writes to the whole LR
+     * 32-bit writes to the low half of the LR
+     * 32-bit writes to the high half of the LR
+     */
+    if (ri->state == ARM_CP_STATE_AA32) {
+        if (ri->crm >= 14) {
+            trace_gicv3_ich_lrc_write(regno, gicv3_redist_affid(cs), value);
+            value = deposit64(cs->ich_lr_el2[regno], 32, 32, value);
+        } else {
+            trace_gicv3_ich_lr32_write(regno, gicv3_redist_affid(cs), value);
+            value = deposit64(cs->ich_lr_el2[regno], 0, 32, value);
+        }
+    } else {
+        trace_gicv3_ich_lr_write(regno, gicv3_redist_affid(cs), value);
+    }
+
+    /* Enforce RES0 bits in priority field */
+    if (cs->vpribits < 8) {
+        value = deposit64(value, ICH_LR_EL2_PRIORITY_SHIFT,
+                          8 - cs->vpribits, 0);
+    }
+
+    cs->ich_lr_el2[regno] = value;
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t ich_vtr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value;
+
+    value = ((cs->num_list_regs - 1) << ICH_VTR_EL2_LISTREGS_SHIFT)
+        | ICH_VTR_EL2_TDS | ICH_VTR_EL2_NV4 | ICH_VTR_EL2_A3V
+        | (1 << ICH_VTR_EL2_IDBITS_SHIFT)
+        | ((cs->vprebits - 1) << ICH_VTR_EL2_PREBITS_SHIFT)
+        | ((cs->vpribits - 1) << ICH_VTR_EL2_PRIBITS_SHIFT);
+
+    trace_gicv3_ich_vtr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static uint64_t ich_misr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value = maintenance_interrupt_state(cs);
+
+    trace_gicv3_ich_misr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static uint64_t ich_eisr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value = eoi_maintenance_interrupt_state(cs, NULL);
+
+    trace_gicv3_ich_eisr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static uint64_t ich_elrsr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value = 0;
+    int i;
+
+    for (i = 0; i < cs->num_list_regs; i++) {
+        uint64_t lr = cs->ich_lr_el2[i];
+
+        if ((lr & ICH_LR_EL2_STATE_MASK) == 0 &&
+            ((lr & ICH_LR_EL2_HW) == 1 || (lr & ICH_LR_EL2_EOI) == 0)) {
+            value |= (1 << i);
+        }
+    }
+
+    trace_gicv3_ich_elrsr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static const ARMCPRegInfo gicv3_cpuif_hcr_reginfo[] = {
+    { .name = "ICH_AP0R0_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 0,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_AP1R0_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 0,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_HCR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 0,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_hcr_read,
+      .writefn = ich_hcr_write,
+    },
+    { .name = "ICH_VTR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 1,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_R,
+      .readfn = ich_vtr_read,
+    },
+    { .name = "ICH_MISR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 2,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_R,
+      .readfn = ich_misr_read,
+    },
+    { .name = "ICH_EISR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 3,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_R,
+      .readfn = ich_eisr_read,
+    },
+    { .name = "ICH_ELRSR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 5,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_R,
+      .readfn = ich_elrsr_read,
+    },
+    { .name = "ICH_VMCR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 7,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_vmcr_read,
+      .writefn = ich_vmcr_write,
+    },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo gicv3_cpuif_ich_apxr1_reginfo[] = {
+    { .name = "ICH_AP0R1_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 1,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_AP1R1_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 1,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo gicv3_cpuif_ich_apxr23_reginfo[] = {
+    { .name = "ICH_AP0R2_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 2,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_AP0R3_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 3,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_AP1R2_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 2,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    { .name = "ICH_AP1R3_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 9, .opc2 = 3,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL2_RW,
+      .readfn = ich_ap_read,
+      .writefn = ich_ap_write,
+    },
+    REGINFO_SENTINEL
+};
+
 static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
 {
     GICv3CPUState *cs = opaque;
@@ -1362,6 +1788,57 @@ void gicv3_init_cpuif(GICv3State *s)
          * to need to register anyway.
          */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)
+            && cpu->gic_num_lrs) {
+            int j;
+
+            cs->num_list_regs = cpu->gic_num_lrs;
+            cs->vpribits = cpu->gic_vpribits;
+            cs->vprebits = cpu->gic_vprebits;
+
+            /* Check against architectural constraints: getting these
+             * wrong would be a bug in the CPU code defining these,
+             * and the implementation relies on them holding.
+             */
+            g_assert(cs->vprebits <= cs->vpribits);
+            g_assert(cs->vprebits >= 5 && cs->vprebits <= 7);
+            g_assert(cs->vpribits >= 5 && cs->vpribits <= 8);
+
+            define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
+
+            for (j = 0; j < cs->num_list_regs; j++) {
+                /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
+                 * are split into two cp15 regs, LR (the low part, with the
+                 * same encoding as the AArch64 LR) and LRC (the high part).
+                 */
+                ARMCPRegInfo lr_regset[] = {
+                    { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
+                      .opc0 = 3, .opc1 = 4, .crn = 12,
+                      .crm = 12 + (j >> 3), .opc2 = j & 7,
+                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                      .access = PL2_RW,
+                      .readfn = ich_lr_read,
+                      .writefn = ich_lr_write,
+                    },
+                    { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
+                      .cp = 15, .opc1 = 4, .crn = 12,
+                      .crm = 14 + (j >> 3), .opc2 = j & 7,
+                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                      .access = PL2_RW,
+                      .readfn = ich_lr_read,
+                      .writefn = ich_lr_write,
+                    },
+                    REGINFO_SENTINEL
+                };
+                define_arm_cp_regs(cpu, lr_regset);
+            }
+            if (cs->vprebits >= 6) {
+                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
+            }
+            if (cs->vprebits == 7) {
+                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
+            }
+        }
         arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
     }
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 340f617..4ac1ea2 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -107,6 +107,22 @@ gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu %x
 gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu %x value 0x%" PRIx64
 gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu %x value 0x%" PRIx64
 gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu %x value 0x%" PRIx64
+gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu %x value 0x%" PRIx64
+gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu %x value 0x%" PRIx64
+gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu %x value 0x%" PRIx64
+gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu %x value 0x%" PRIx64
+gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu %x value 0x%" PRIx64
+gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu %x value 0x%" PRIx64
+gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu %x value 0x%" PRIx64
+gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu %x value 0x%" PRIx32
+gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu %x value 0x%" PRIx32
+gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu %x value 0x%" PRIx64
+gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu %x value 0x%" PRIx32
+gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu %x value 0x%" PRIx32
+gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %x value 0x%" PRIx64
+gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %x value 0x%" PRIx64
+gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %x value 0x%" PRIx64
+gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu %x value 0x%" PRIx64
 
 # hw/intc/arm_gicv3_dist.c
 gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-- 
2.7.4
