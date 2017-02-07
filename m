Received: from eggs.gnu.org ([2001:4830:134:3::10]:48934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cbDdq-0002zO-7P
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cbDdp-0007cZ-1S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:49:38 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue,  7 Feb 2017 16:49:29 -0500
Message-Id: <1486504171-26807-3-git-send-email-wei@redhat.com>
In-Reply-To: <1486504171-26807-1-git-send-email-wei@redhat.com>
References: <1486504171-26807-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V3 2/4] target-arm: Add support for AArch64 PMU
 register PMXEVTYPER_EL0
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

In order to support Linux perf, which uses PMXEVTYPER register,
this patch adds read/write access support for PMXEVTYPER. The access
is CONSTRAINED UNPREDICTABLE when PMSELR is not 0x1f. Additionally
this patch adds support for PMXEVTYPER_EL0.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/cpu.h    |  1 -
 target/arm/helper.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8a82c73..f46607e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -307,7 +307,6 @@ typedef struct CPUARMState {
         uint64_t c9_pmcr; /* performance monitor control register */
         uint64_t c9_pmcnten; /* perf monitor counter enables */
         uint32_t c9_pmovsr; /* perf monitor overflow status */
-        uint32_t c9_pmxevtyper; /* perf monitor event type */
         uint32_t c9_pmuserenr; /* perf monitor user enable */
         uint64_t c9_pmselr; /* perf monitor counter selection register */
         uint32_t c9_pminten; /* perf monitor interrupt enables */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 67520ea..ec5cf1f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1054,7 +1054,25 @@ static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    env->cp15.c9_pmxevtyper = value & 0xff;
+    /* Attempts to access PMXEVTYPER are CONSTRAINED UNPREDICTABLE when
+     * PMSELR value is equal to or greater than the number of implemented
+     * counters, but not equal to 0x1f. We opt to behave as a RAZ/WI.
+     */
+    if (env->cp15.c9_pmselr == 0x1f) {
+        pmccfiltr_write(env, ri, value);
+    }
+}
+
+static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* We opt to behave as a RAZ/WI when attempts to access PMXEVTYPER
+     * are CONSTRAINED UNPREDICTABLE. See comments in pmxevtyper_write().
+     */
+    if (env->cp15.c9_pmselr == 0x1f) {
+        return env->cp15.pmccfiltr_el0;
+    } else {
+        return 0;
+    }
 }
 
 static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1234,10 +1252,12 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
       .resetvalue = 0, },
     { .name = "PMXEVTYPER", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 1,
-      .access = PL0_RW,
-      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmxevtyper),
-      .accessfn = pmreg_access, .writefn = pmxevtyper_write,
-      .raw_writefn = raw_write },
+      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
+      .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
+    { .name = "PMXEVTYPER_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 1,
+      .access = PL0_RW, .type = ARM_CP_NO_RAW, .accessfn = pmreg_access,
+      .writefn = pmxevtyper_write, .readfn = pmxevtyper_read },
     /* Unimplemented, RAZ/WI. */
     { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
       .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
-- 
1.8.3.1
