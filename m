Received: from eggs.gnu.org ([2001:4830:134:3::10]:50526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNT-0002rs-NE
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f8XNR-00059L-9e
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:38:59 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Tue, 17 Apr 2018 16:37:48 -0400
Message-Id: <1523997485-1905-5-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v4 04/21] target/arm: Mask PMU register writes
 based on PMCR_EL0.N
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

This is in preparation for enabling counters other than PMCCNTR

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f6269a2..8bec07e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -52,11 +52,6 @@ typedef struct V8M_SAttributes {
 static void v8m_security_lookup(CPUARMState *env, uint32_t address,
                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                 V8M_SAttributes *sattrs);
-
-/* Definitions for the PMCCNTR and PMCR registers */
-#define PMCRD   0x8
-#define PMCRC   0x4
-#define PMCRE   0x1
 #endif
 
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
@@ -906,6 +901,24 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Definitions for the PMU registers */
+#define PMCRN_MASK  0xf800
+#define PMCRN_SHIFT 11
+#define PMCRD   0x8
+#define PMCRC   0x4
+#define PMCRE   0x1
+
+static inline uint32_t pmu_num_counters(CPUARMState *env)
+{
+  return (env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT;
+}
+
+/* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
+static inline uint64_t pmu_counter_mask(CPUARMState *env)
+{
+  return (1 << 31) | ((1 << pmu_num_counters(env)) - 1);
+}
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -1119,14 +1132,14 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    value &= (1 << 31);
+    value &= pmu_counter_mask(env);
     env->cp15.c9_pmcnten |= value;
 }
 
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    value &= (1 << 31);
+    value &= pmu_counter_mask(env);
     env->cp15.c9_pmcnten &= ~value;
 }
 
@@ -1174,14 +1187,14 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
     /* We have no event counters so only the C bit can be changed */
-    value &= (1 << 31);
+    value &= pmu_counter_mask(env);
     env->cp15.c9_pminten |= value;
 }
 
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    value &= (1 << 31);
+    value &= pmu_counter_mask(env);
     env->cp15.c9_pminten &= ~value;
 }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
