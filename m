Received: from eggs.gnu.org ([2001:4830:134:3::10]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mX-5n
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxq-0005VI-Fj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxq-0005UJ-72
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:42 -0500
Received: by mail-oi1-x241.google.com with SMTP id y23so3631746oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:07 -0600
Message-Id: <20181214052410.11863-25-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 24/27] target/arm: Add PAuth system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b9ffc07fbc..f1e9254c9a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5061,6 +5061,70 @@ static CPAccessResult access_lor_other(CPUARMState *env,
     return access_lor_ns(env);
 }
 
+#ifdef TARGET_AARCH64
+static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 &&
+        arm_feature(env, ARM_FEATURE_EL2) &&
+        !(arm_hcr_el2_eff(env) & HCR_APK)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el < 3 &&
+        arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_APK)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo pauth_reginfo[] = {
+    { .name = "APDAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key.lo) },
+    { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key.hi) },
+    { .name = "APDBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key.lo) },
+    { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key.hi) },
+    { .name = "APGAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
+    { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
+    { .name = "APIAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
+    { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
+    { .name = "APIBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apib_key.lo) },
+    { .name = "APIBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
+    REGINFO_SENTINEL
+};
+#endif
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -5845,6 +5909,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, &zcr_el3_reginfo);
         }
     }
+
+#ifdef TARGET_AARCH64
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        define_arm_cp_regs(cpu, pauth_reginfo);
+    }
+#endif
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.17.2
