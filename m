Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgd-0000kU-12
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgb-00089o-Qb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cnkgb-0007v8-Ip
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgR-0002E7-Gc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:32:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:32:04 +0000
Message-Id: <1489491125-23648-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
References: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/2] target/arm: implement armv8 PMUSERENR
 (user-mode enable bits)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Baumann <Andrew.Baumann@microsoft.com>

In armv8, this register implements more than a single bit, with
fine-grained enables for read access to event counters, cycles
counters, and write access to the software increment. This change
implements those checks using custom access functions for the relevant
registers.

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Message-id: 20170228215801.10472-2-Andrew.Baumann@microsoft.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: move a couple of access functions to be only compiled
 ifndef CONFIG_USER_ONLY to avoid compiler warnings]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 76b608f..8646a7a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -885,7 +885,7 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     int el = arm_current_el(env);
 
-    if (el == 0 && !env->cp15.c9_pmuserenr) {
+    if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
         return CP_ACCESS_TRAP;
     }
     if (el < 2 && (env->cp15.mdcr_el2 & MDCR_TPM)
@@ -899,8 +899,67 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
+                                           const ARMCPRegInfo *ri,
+                                           bool isread)
+{
+    /* ER: event counter read trap control */
+    if (arm_feature(env, ARM_FEATURE_V8)
+        && arm_current_el(env) == 0
+        && (env->cp15.c9_pmuserenr & (1 << 3)) != 0
+        && isread) {
+        return CP_ACCESS_OK;
+    }
+
+    return pmreg_access(env, ri, isread);
+}
+
+static CPAccessResult pmreg_access_swinc(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool isread)
+{
+    /* SW: software increment write trap control */
+    if (arm_feature(env, ARM_FEATURE_V8)
+        && arm_current_el(env) == 0
+        && (env->cp15.c9_pmuserenr & (1 << 1)) != 0
+        && !isread) {
+        return CP_ACCESS_OK;
+    }
+
+    return pmreg_access(env, ri, isread);
+}
+
 #ifndef CONFIG_USER_ONLY
 
+static CPAccessResult pmreg_access_selr(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    /* ER: event counter read trap control */
+    if (arm_feature(env, ARM_FEATURE_V8)
+        && arm_current_el(env) == 0
+        && (env->cp15.c9_pmuserenr & (1 << 3)) != 0) {
+        return CP_ACCESS_OK;
+    }
+
+    return pmreg_access(env, ri, isread);
+}
+
+static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         bool isread)
+{
+    /* CR: cycle counter read trap control */
+    if (arm_feature(env, ARM_FEATURE_V8)
+        && arm_current_el(env) == 0
+        && (env->cp15.c9_pmuserenr & (1 << 2)) != 0
+        && isread) {
+        return CP_ACCESS_OK;
+    }
+
+    return pmreg_access(env, ri, isread);
+}
+
 static inline bool arm_ccnt_enabled(CPUARMState *env)
 {
     /* This does not support checking PMCCFILTR_EL0 register */
@@ -1068,7 +1127,11 @@ static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    env->cp15.c9_pmuserenr = value & 1;
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        env->cp15.c9_pmuserenr = value & 0xf;
+    } else {
+        env->cp15.c9_pmuserenr = value & 1;
+    }
 }
 
 static void pmintenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1212,25 +1275,25 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .raw_writefn = raw_write },
     /* Unimplemented so WI. */
     { .name = "PMSWINC", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 4,
-      .access = PL0_W, .accessfn = pmreg_access, .type = ARM_CP_NOP },
+      .access = PL0_W, .accessfn = pmreg_access_swinc, .type = ARM_CP_NOP },
 #ifndef CONFIG_USER_ONLY
     { .name = "PMSELR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 5,
       .access = PL0_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmselr),
-      .accessfn = pmreg_access, .writefn = pmselr_write,
+      .accessfn = pmreg_access_selr, .writefn = pmselr_write,
       .raw_writefn = raw_write},
     { .name = "PMSELR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 5,
-      .access = PL0_RW, .accessfn = pmreg_access,
+      .access = PL0_RW, .accessfn = pmreg_access_selr,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
       .writefn = pmselr_write, .raw_writefn = raw_write, },
     { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
       .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_IO,
       .readfn = pmccntr_read, .writefn = pmccntr_write32,
-      .accessfn = pmreg_access },
+      .accessfn = pmreg_access_ccntr },
     { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 0,
-      .access = PL0_RW, .accessfn = pmreg_access,
+      .access = PL0_RW, .accessfn = pmreg_access_ccntr,
       .type = ARM_CP_IO,
       .readfn = pmccntr_read, .writefn = pmccntr_write, },
 #endif
@@ -1251,7 +1314,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* Unimplemented, RAZ/WI. */
     { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
       .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
-      .accessfn = pmreg_access },
+      .accessfn = pmreg_access_xevcntr },
     { .name = "PMUSERENR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 0,
       .access = PL0_R | PL1_RW, .accessfn = access_tpm,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmuserenr),
-- 
2.7.4
