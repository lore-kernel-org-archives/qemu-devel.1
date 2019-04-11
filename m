Received: from eggs.gnu.org ([209.51.188.92]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbnn-0001Iv-QA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbnm-0008Ef-Gv
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbnm-0008E2-5w
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:39:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so7932348wra.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 16:39:42 +0100
Message-Id: <20190411153942.4533-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of floating
 point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

The NSACR register allows secure code to configure the FPU
to be inaccessible to non-secure code. If the NSACR.CP10
bit is set then:
 * NS accesses to the FPU trap as UNDEF (ie to NS EL1 or EL2)
 * CPACR.{CP10,CP11} behave as if RAZ/WI
 * HCPTR.{TCP11,TCP10} behave as if RAO/WI

Note that we do not implement the NSACR.NSASEDIS bit which
gates only access to Advanced SIMD, in the same way that
we don't implement the equivalent CPACR.ASEDIS and HCPTR.TASE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed we were missing NSACR handling here while looking at
M profile floating point, but it turns out that M profile NSACR
isn't really the same, so the two don't share code. This patch
fixes the A-profile NSACR handling. Note that this only affects
CPUs with an AArch32 EL3.

 target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0dd1f99974..26105f13e70 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -903,9 +903,36 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         value &= mask;
     }
+
+    /*
+     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
+     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0xf << 20);
+        value |= env->cp15.cpacr_el1 & (0xf << 20);
+    }
+
     env->cp15.cpacr_el1 = value;
 }
 
+static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
+     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     */
+    uint64_t value = env->cp15.cpacr_el1;
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0xf << 20);
+    }
+    return value;
+}
+
+
 static void cpacr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Call cpacr_write() so that we reset with the correct RAO bits set
@@ -971,7 +998,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
-      .resetfn = cpacr_reset, .writefn = cpacr_write },
+      .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
     REGINFO_SENTINEL
 };
 
@@ -4656,6 +4683,36 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return ret;
 }
 
+static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /*
+     * For A-profile AArch32 EL3, if NSACR.CP10
+     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0x3 << 10);
+        value |= env->cp15.cptr_el[2] & (0x3 << 10);
+    }
+    env->cp15.cptr_el[2] = value;
+}
+
+static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * For A-profile AArch32 EL3, if NSACR.CP10
+     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     */
+    uint64_t value = env->cp15.cptr_el[2];
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        value &= ~(0x3 << 10);
+    }
+    return value;
+}
+
 static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_IO,
@@ -4703,7 +4760,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
       .access = PL2_RW, .accessfn = cptr_access, .resetvalue = 0,
-      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]) },
+      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]),
+      .readfn = cptr_el2_read, .writefn = cptr_el2_write },
     { .name = "MAIR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
@@ -12804,6 +12862,19 @@ int fp_exception_el(CPUARMState *env, int cur_el)
         break;
     }
 
+    /*
+     * The NSACR allows A-profile AArch32 EL3 and M-profile secure mode
+     * to control non-secure access to the FPU. It doesn't have any
+     * effect if EL3 is AArch64 or if EL3 doesn't exist at all.
+     */
+    if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
+         cur_el <= 2 && !arm_is_secure_below_el3(env))) {
+        if (!extract32(env->cp15.nsacr, 10, 1)) {
+            /* FP insns act as UNDEF */
+            return cur_el == 2 ? 2 : 1;
+        }
+    }
+
     /* For the CPTR registers we don't need to guard with an ARM_FEATURE
      * check because zero bits in the registers mean "don't trap".
      */
-- 
2.20.1
