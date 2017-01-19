Received: from eggs.gnu.org ([2001:4830:134:3::10]:47356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-0000uJ-HA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPm-00056u-CP
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPm-00051T-1j
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPk-0003DF-J3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:46 +0000
Message-Id: <1484834995-26826-28-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/36] hw/intc/arm_gicv3: Implement ICV_
 registers which are just accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the HCR_EL2.IMO or FMO bits are set, accesses to ICC_
system registers are redirected to be accesses to ICV_
registers (the guest-visible interface to the virtual
interrupt controller). Implement this behaviour for the
ICV_ registers which are simple accessors to the underlying
register state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-10-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events      |  10 ++
 2 files changed, 249 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 585c91c..40a52ce 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "trace.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
@@ -48,6 +49,26 @@ static int ich_lr_state(uint64_t lr)
     return extract64(lr, ICH_LR_EL2_STATE_SHIFT, ICH_LR_EL2_STATE_LENGTH);
 }
 
+static bool icv_access(CPUARMState *env, int hcr_flags)
+{
+    /* Return true if this ICC_ register access should really be
+     * directed to an ICV_ access. hcr_flags is a mask of
+     * HCR_EL2 bits to check: we treat this as an ICV_ access
+     * if we are in NS EL1 and at least one of the specified
+     * HCR_EL2 bits is set.
+     *
+     * ICV registers fall into four categories:
+     *  * access if NS EL1 and HCR_EL2.FMO == 1:
+     *    all ICV regs with '0' in their name
+     *  * access if NS EL1 and HCR_EL2.IMO == 1:
+     *    all ICV regs with '1' in their name
+     *  * access if NS EL1 and either IMO or FMO == 1:
+     *    CTLR, DIR, PMR, RPR
+     */
+    return (env->cp15.hcr_el2 & hcr_flags) && arm_current_el(env) == 1
+        && !arm_is_secure_below_el3(env);
+}
+
 static int read_vbpr(GICv3CPUState *cs, int grp)
 {
     /* Read VBPR value out of the VMCR field (caller must handle
@@ -84,6 +105,16 @@ static void write_vbpr(GICv3CPUState *cs, int grp, int value)
     }
 }
 
+static uint32_t icv_fullprio_mask(GICv3CPUState *cs)
+{
+    /* Return a mask word which clears the unimplemented priority bits
+     * from a priority value for a virtual interrupt. (Not to be confused
+     * with the group priority, whose mask depends on the value of VBPR
+     * for the interrupt group.)
+     */
+    return ~0U << (8 - cs->vpribits);
+}
+
 static uint32_t eoi_maintenance_interrupt_state(GICv3CPUState *cs,
                                                 uint32_t *misr)
 {
@@ -168,6 +199,170 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
 {
 }
 
+static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 & 3;
+    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    uint64_t value = cs->ich_apr[grp][regno];
+
+    trace_gicv3_icv_ap_read(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int regno = ri->opc2 & 3;
+    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+
+    trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
+
+    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+
+    gicv3_cpuif_virt_update(cs);
+    return;
+}
+
+static uint64_t icv_bpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int grp = (ri->crm == 8) ? GICV3_G0 : GICV3_G1NS;
+    uint64_t bpr;
+    bool satinc = false;
+
+    if (grp == GICV3_G1NS && (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VCBPR)) {
+        /* reads return bpr0 + 1 saturated to 7, writes ignored */
+        grp = GICV3_G0;
+        satinc = true;
+    }
+
+    bpr = read_vbpr(cs, grp);
+
+    if (satinc) {
+        bpr++;
+        bpr = MIN(bpr, 7);
+    }
+
+    trace_gicv3_icv_bpr_read(ri->crm == 8 ? 0 : 1, gicv3_redist_affid(cs), bpr);
+
+    return bpr;
+}
+
+static void icv_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int grp = (ri->crm == 8) ? GICV3_G0 : GICV3_G1NS;
+
+    trace_gicv3_icv_bpr_write(ri->crm == 8 ? 0 : 1,
+                              gicv3_redist_affid(cs), value);
+
+    if (grp == GICV3_G1NS && (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VCBPR)) {
+        /* reads return bpr0 + 1 saturated to 7, writes ignored */
+        return;
+    }
+
+    write_vbpr(cs, grp, value);
+
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t icv_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value;
+
+    value = extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VPMR_SHIFT,
+                      ICH_VMCR_EL2_VPMR_LENGTH);
+
+    trace_gicv3_icv_pmr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void icv_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+
+    trace_gicv3_icv_pmr_write(gicv3_redist_affid(cs), value);
+
+    value &= icv_fullprio_mask(cs);
+
+    cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VPMR_SHIFT,
+                                 ICH_VMCR_EL2_VPMR_LENGTH, value);
+
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t icv_igrpen_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int enbit;
+    uint64_t value;
+
+    enbit = ri->opc2 & 1 ? ICH_VMCR_EL2_VENG1_SHIFT : ICH_VMCR_EL2_VENG0_SHIFT;
+    value = extract64(cs->ich_vmcr_el2, enbit, 1);
+
+    trace_gicv3_icv_igrpen_read(ri->opc2 & 1 ? 1 : 0,
+                                gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void icv_igrpen_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int enbit;
+
+    trace_gicv3_icv_igrpen_write(ri->opc2 & 1 ? 1 : 0,
+                                 gicv3_redist_affid(cs), value);
+
+    enbit = ri->opc2 & 1 ? ICH_VMCR_EL2_VENG1_SHIFT : ICH_VMCR_EL2_VENG0_SHIFT;
+
+    cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, enbit, 1, value);
+    gicv3_cpuif_virt_update(cs);
+}
+
+static uint64_t icv_ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t value;
+
+    /* Note that the fixed fields here (A3V, SEIS, IDbits, PRIbits)
+     * should match the ones reported in ich_vtr_read().
+     */
+    value = ICC_CTLR_EL1_A3V | (1 << ICC_CTLR_EL1_IDBITS_SHIFT) |
+        (7 << ICC_CTLR_EL1_PRIBITS_SHIFT);
+
+    if (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VEOIM) {
+        value |= ICC_CTLR_EL1_EOIMODE;
+    }
+
+    if (cs->ich_vmcr_el2 & ICH_VMCR_EL2_VCBPR) {
+        value |= ICC_CTLR_EL1_CBPR;
+    }
+
+    trace_gicv3_icv_ctlr_read(gicv3_redist_affid(cs), value);
+    return value;
+}
+
+static void icv_ctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+
+    trace_gicv3_icv_ctlr_write(gicv3_redist_affid(cs), value);
+
+    cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VCBPR_SHIFT,
+                                 1, value & ICC_CTLR_EL1_CBPR ? 1 : 0);
+    cs->ich_vmcr_el2 = deposit64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VEOIM_SHIFT,
+                                 1, value & ICC_CTLR_EL1_EOIMODE ? 1 : 0);
+
+    gicv3_cpuif_virt_update(cs);
+}
+
 static int icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
@@ -309,6 +504,10 @@ static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     GICv3CPUState *cs = icc_cs_from_env(env);
     uint32_t value = cs->icc_pmr_el1;
 
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        return icv_pmr_read(env, ri);
+    }
+
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env) &&
         (env->cp15.scr_el3 & SCR_FIQ)) {
         /* NS access and Group 0 is inaccessible to NS: return the
@@ -332,6 +531,10 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
 
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        return icv_pmr_write(env, ri, value);
+    }
+
     trace_gicv3_icc_pmr_write(gicv3_redist_affid(cs), value);
 
     value &= 0xff;
@@ -650,6 +853,10 @@ static uint64_t icc_bpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     bool satinc = false;
     uint64_t bpr;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        return icv_bpr_read(env, ri);
+    }
+
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
         grp = GICV3_G1NS;
     }
@@ -686,6 +893,11 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv3CPUState *cs = icc_cs_from_env(env);
     int grp = (ri->crm == 8) ? GICV3_G0 : GICV3_G1;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        icv_bpr_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_bpr_write(ri->crm == 8 ? 0 : 1,
                               gicv3_redist_affid(cs), value);
 
@@ -719,6 +931,10 @@ static uint64_t icc_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
     int regno = ri->opc2 & 3;
     int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        return icv_ap_read(env, ri);
+    }
+
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
         grp = GICV3_G1NS;
     }
@@ -737,6 +953,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int regno = ri->opc2 & 3;
     int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        icv_ap_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
@@ -949,6 +1170,10 @@ static uint64_t icc_igrpen_read(CPUARMState *env, const ARMCPRegInfo *ri)
     int grp = ri->opc2 & 1 ? GICV3_G1 : GICV3_G0;
     uint64_t value;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        return icv_igrpen_read(env, ri);
+    }
+
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
         grp = GICV3_G1NS;
     }
@@ -965,6 +1190,11 @@ static void icc_igrpen_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv3CPUState *cs = icc_cs_from_env(env);
     int grp = ri->opc2 & 1 ? GICV3_G1 : GICV3_G0;
 
+    if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
+        icv_igrpen_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_igrpen_write(ri->opc2 & 1 ? 1 : 0,
                                  gicv3_redist_affid(cs), value);
 
@@ -1006,6 +1236,10 @@ static uint64_t icc_ctlr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     int bank = gicv3_use_ns_bank(env) ? GICV3_NS : GICV3_S;
     uint64_t value;
 
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        return icv_ctlr_read(env, ri);
+    }
+
     value = cs->icc_ctlr_el1[bank];
     trace_gicv3_icc_ctlr_read(gicv3_redist_affid(cs), value);
     return value;
@@ -1018,6 +1252,11 @@ static void icc_ctlr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int bank = gicv3_use_ns_bank(env) ? GICV3_NS : GICV3_S;
     uint64_t mask;
 
+    if (icv_access(env, HCR_FMO | HCR_IMO)) {
+        icv_ctlr_write(env, ri, value);
+        return;
+    }
+
     trace_gicv3_icc_ctlr_write(gicv3_redist_affid(cs), value);
 
     /* Only CBPR and EOIMODE can be RW;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4ac1ea2..19fe1d5 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -123,6 +123,16 @@ gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %x value
 gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %x value 0x%" PRIx64
 gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %x value 0x%" PRIx64
 gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu %x value 0x%" PRIx64
+gicv3_icv_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d read cpu %x value 0x%" PRIx64
+gicv3_icv_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d write cpu %x value 0x%" PRIx64
+gicv3_icv_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d read cpu %x value 0x%" PRIx64
+gicv3_icv_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d write cpu %x value 0x%" PRIx64
+gicv3_icv_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR read cpu %x value 0x%" PRIx64
+gicv3_icv_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR write cpu %x value 0x%" PRIx64
+gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d read cpu %x value 0x%" PRIx64
+gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %x value 0x%" PRIx64
+gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %x value 0x%" PRIx64
+gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x value 0x%" PRIx64
 
 # hw/intc/arm_gicv3_dist.c
 gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-- 
2.7.4
