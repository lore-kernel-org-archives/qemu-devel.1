Received: from eggs.gnu.org ([2001:4830:134:3::10]:47393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0000wb-HC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-00058b-UN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPn-0004w9-NH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPj-0003CV-LM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:44 +0000
Message-Id: <1484834995-26826-26-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/36] hw/intc/gicv3: Add data fields for
 virtualization support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As the first step in adding support for the virtualization
extensions to the GICv3 emulation:
 * add the necessary data fields to the state structures
 * add the fields to the migration state, as a subsection
   which is only present if virtualization is enabled

The use of a subsection means we retain migration
compatibility as EL2 is not enabled on any CPUs currently.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1483977924-14522-8-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/arm_gicv3_common.h | 18 ++++++++++++++++++
 hw/intc/arm_gicv3_common.c         | 25 +++++++++++++++++++++++++
 hw/intc/arm_gicv3_cpuif.c          | 13 +++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index beb2c77..665d3f8 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -38,6 +38,9 @@
 /* Number of SGI target-list bits */
 #define GICV3_TARGETLIST_BITS 16
 
+/* Maximum number of list registers (architectural limit) */
+#define GICV3_LR_MAX 16
+
 /* Minimum BPR for Secure, or when security not enabled */
 #define GIC_MIN_BPR 0
 /* Minimum BPR for Nonsecure when security is enabled */
@@ -175,6 +178,21 @@ struct GICv3CPUState {
     uint64_t icc_igrpen[3];
     uint64_t icc_ctlr_el3;
 
+    /* Virtualization control interface */
+    uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
+    uint64_t ich_hcr_el2;
+    uint64_t ich_lr_el2[GICV3_LR_MAX];
+    uint64_t ich_vmcr_el2;
+
+    /* Properties of the CPU interface. These are initialized from
+     * the settings in the CPU proper.
+     * If the number of implemented list registers is 0 then the
+     * virtualization support is not implemented.
+     */
+    int num_list_regs;
+    int vpribits; /* number of virtual priority bits */
+    int vprebits; /* number of virtual preemption bits */
+
     /* Current highest priority pending interrupt for this CPU.
      * This is cached information that can be recalculated from the
      * real state above; it doesn't need to be migrated.
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0ee67a4..16b9b0f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -49,6 +49,27 @@ static int gicv3_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static bool virt_state_needed(void *opaque)
+{
+    GICv3CPUState *cs = opaque;
+
+    return cs->num_list_regs != 0;
+}
+
+static const VMStateDescription vmstate_gicv3_cpu_virt = {
+    .name = "arm_gicv3_cpu/virt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virt_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_2DARRAY(ich_apr, GICv3CPUState, 3, 4),
+        VMSTATE_UINT64(ich_hcr_el2, GICv3CPUState),
+        VMSTATE_UINT64_ARRAY(ich_lr_el2, GICv3CPUState, GICV3_LR_MAX),
+        VMSTATE_UINT64(ich_vmcr_el2, GICv3CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3_cpu = {
     .name = "arm_gicv3_cpu",
     .version_id = 1,
@@ -75,6 +96,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         VMSTATE_UINT64_ARRAY(icc_igrpen, GICv3CPUState, 3),
         VMSTATE_UINT64(icc_ctlr_el3, GICv3CPUState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gicv3_cpu_virt,
+        NULL
     }
 };
 
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 35e8eb3..d2f859c 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -36,6 +36,12 @@ static bool gicv3_use_ns_bank(CPUARMState *env)
     return !arm_is_secure_below_el3(env);
 }
 
+/* The minimum BPR for the virtual interface is a configurable property */
+static inline int icv_min_vbpr(GICv3CPUState *cs)
+{
+    return 7 - cs->vprebits;
+}
+
 static int icc_highest_active_prio(GICv3CPUState *cs)
 {
     /* Calculate the current running priority based on the set bits
@@ -1081,6 +1087,13 @@ static void icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     cs->icc_ctlr_el3 = ICC_CTLR_EL3_NDS | ICC_CTLR_EL3_A3V |
         (1 << ICC_CTLR_EL3_IDBITS_SHIFT) |
         (7 << ICC_CTLR_EL3_PRIBITS_SHIFT);
+
+    memset(cs->ich_apr, 0, sizeof(cs->ich_apr));
+    cs->ich_hcr_el2 = 0;
+    memset(cs->ich_lr_el2, 0, sizeof(cs->ich_lr_el2));
+    cs->ich_vmcr_el2 = ICH_VMCR_EL2_VFIQEN |
+        (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR1_SHIFT) |
+        (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR0_SHIFT);
 }
 
 static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
-- 
2.7.4
