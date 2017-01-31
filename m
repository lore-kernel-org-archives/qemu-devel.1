Received: from eggs.gnu.org ([2001:4830:134:3::10]:57520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9w-0007ZH-A7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9v-00019M-C7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:52 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue, 31 Jan 2017 10:15:41 -0500
Message-Id: <1485875745-27741-2-git-send-email-wei@redhat.com>
In-Reply-To: <1485875745-27741-1-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V2 1/5] target-arm: Add support for PMU
 register PMSELR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

This patch adds support for AArch64 register PMSELR_EL0. The existing
PMSELR definition is revised accordingly.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39bff86..8a82c73 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -309,6 +309,7 @@ typedef struct CPUARMState {
         uint32_t c9_pmovsr; /* perf monitor overflow status */
         uint32_t c9_pmxevtyper; /* perf monitor event type */
         uint32_t c9_pmuserenr; /* perf monitor user enable */
+        uint64_t c9_pmselr; /* perf monitor counter selection register */
         uint32_t c9_pminten; /* perf monitor interrupt enables */
         union { /* Memory attribute redirection */
             struct {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c23df1b..67520ea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -975,6 +975,17 @@ static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return total_ticks - env->cp15.c15_ccnt;
 }
 
+static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    /* The value of PMSELR.SEL affects the behavior of PMXEVTYPER and
+     * PMXEVCNTR. We allow [0..31] to be written to PMSELR here; in the
+     * meanwhile, we check PMSELR.SEL when PMXEVTYPER and PMXEVCNTR are
+     * accessed.
+     */
+    env->cp15.c9_pmselr = value & 0x1f;
+}
+
 static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -1194,12 +1205,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* Unimplemented so WI. */
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
       .access = PL0_W, .accessfn = pmreg_access, .type = ARM_CP_NOP },
-    /* Since we don't implement any events, writing to PMSELR is UNPREDICTABLE.
-     * We choose to RAZ/WI.
-     */
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
-      .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
-      .accessfn = pmreg_access },
+      .access = PL0_RW, .type = ARM_CP_ALIAS,
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
+      .accessfn = pmreg_access, .writefn = pmselr_write,
+      .raw_writefn = raw_write},
+    { .name = "PMSELR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 5,
+      .access = PL0_RW, .accessfn = pmreg_access,
+      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
+      .writefn = pmselr_write, .raw_writefn = raw_write, },
 #ifndef CONFIG_USER_ONLY
     { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
       .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_IO,
-- 
1.8.3.1
