Received: from eggs.gnu.org ([2001:4830:134:3::10]:44036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1O-0005ox-7y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1N-0003Hd-6d
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:14 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:04 -0400
Message-Id: <1521232280-13089-7-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 06/22] target/arm: Mask PMU register writes
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
---
 target/arm/helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6480b80..5d5c738 100644
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
@@ -906,6 +901,17 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Definitions for the PMU registers */
+#define PMCRN_MASK  0xf800
+#define PMCRN_SHIFT 11
+#define PMCRD   0x8
+#define PMCRC   0x4
+#define PMCRE   0x1
+
+#define PMU_NUM_COUNTERS(env) ((env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT)
+/* Bits allowed to be set/cleared for PMCNTEN* and PMINTEN* */
+#define PMU_COUNTER_MASK(env) ((1 << 31) | ((1 << PMU_NUM_COUNTERS(env)) - 1))
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -1124,14 +1130,14 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    value &= (1 << 31);
+    value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmcnten |= value;
 }
 
 static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    value &= (1 << 31);
+    value &= PMU_COUNTER_MASK(env);
     env->cp15.c9_pmcnten &= ~value;
 }
 
@@ -1179,14 +1185,14 @@ static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
