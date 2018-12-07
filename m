Received: from eggs.gnu.org ([2001:4830:134:3::10]:59325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVQ-0008Pg-UJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVP-00080p-7Q
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:12 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVP-00080C-15
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:11 -0500
Received: by mail-ot1-x342.google.com with SMTP id i20so3387094otl.0
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:28 -0600
Message-Id: <20181207103631.28193-24-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/26] target/arm: Add PAuth system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c73525f813..f466c174e6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5071,6 +5071,66 @@ static CPAccessResult access_lor_other(CPUARMState *env,
     return access_lor_ns(env);
 }
 
+#ifdef TARGET_AARCH64
+static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 && (arm_hcr_el2_eff(env) & HCR_APK)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el < 3 && (env->cp15.scr_el3 & SCR_APK)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo pauth_reginfo[] = {
+    { .name = "APDAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key[0]) },
+    { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key[1]) },
+    { .name = "APDBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key[0]) },
+    { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key[1]) },
+    { .name = "APGAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key[0]) },
+    { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key[1]) },
+    { .name = "APIAKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key[0]) },
+    { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key[1]) },
+    { .name = "APIBKEYLOW_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apib_key[0]) },
+    { .name = "APIBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apib_key[1]) },
+    REGINFO_SENTINEL
+};
+#endif
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -5855,6 +5915,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
