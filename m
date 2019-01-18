Received: from eggs.gnu.org ([209.51.188.92]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbb-0002sW-4F
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbZ-0007VH-9d
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbZ-0007UT-0b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:45 -0500
Received: by mail-wm1-x332.google.com with SMTP id d15so4767369wmb.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:48 +0000
Message-Id: <20190118145805.6852-33-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/49] target/arm: Add PAuth system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a62ce2a76e6..46648ef8b68 100644
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
+    { .name = "APDAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key.lo) },
+    { .name = "APDAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apda_key.hi) },
+    { .name = "APDBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key.lo) },
+    { .name = "APDBKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 2, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apdb_key.hi) },
+    { .name = "APGAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apga_key.lo) },
+    { .name = "APGAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 3, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apga_key.hi) },
+    { .name = "APIAKEYLO_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.lo) },
+    { .name = "APIAKEYHI_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 1, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_pauth,
+      .fieldoffset = offsetof(CPUARMState, apia_key.hi) },
+    { .name = "APIBKEYLO_EL1", .state = ARM_CP_STATE_AA64,
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
2.20.1
