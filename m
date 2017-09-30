Received: from eggs.gnu.org ([2001:4830:134:3::10]:49503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7De-0002U9-33
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7Dc-0005Cb-VI
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:30 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 29 Sep 2017 22:08:21 -0400
Message-Id: <1506737310-21880-5-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 04/13] target/arm: Mask PMU register writes
 based on PMCR_EL0.N
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Digant Desai <digantd@codeaurora.org>
List-ID: <qemu-devel.nongnu.org>

This is in preparation for enabling counters other than PMCCNTR

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ecf8c55..54070a3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,11 +30,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
                                target_ulong *page_size_ptr, uint32_t *fsr,
                                ARMMMUFaultInfo *fi);
-
-/* Definitions for the PMCCNTR and PMCR registers */
-#define PMCRD   0x8
-#define PMCRC   0x4
-#define PMCRE   0x1
 #endif
 
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
@@ -876,6 +871,17 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Definitions for the PMU registers */
+#define PMCRN   0xf800
+#define PMCRN_SHIFT 11
+#define PMCRD   0x8
+#define PMCRC   0x4
+#define PMCRE   0x1
+
+#define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN) >> PMCRN_SHIFT)
+/* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
+#define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -1060,14 +1066,14 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    value &= (1 << 31);
+    value &= (PMU_COUNTER_MASK(env) | (1 << 31));
     env->cp15.c9_pmcnten |= value;
 }
 
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    value &= (1 << 31);
+    value &= (PMU_COUNTER_MASK(env) | (1 << 31));
     env->cp15.c9_pmcnten &= ~value;
 }
 
@@ -1115,14 +1121,14 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
     /* We have no event counters so only the C bit can be changed */
-    value &= (1 << 31);
+    value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pminten |= value;
 }
 
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    value &= (1 << 31);
+    value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pminten &= ~value;
 }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.\nQualcomm Technologies, Inc. is a member of the\nCode Aurora Forum, a Linux Foundation Collaborative Project.
