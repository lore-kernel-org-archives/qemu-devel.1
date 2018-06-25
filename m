Received: from eggs.gnu.org ([2001:4830:134:3::10]:52904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTue-000594-Me
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuY-00052w-Bs
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:20 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTuY-00051r-2X
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id l15-v6so12870413wmc.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:07 +0100
Message-Id: <20180625160009.17437-4-alex.bennee@linaro.org>
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/5] target/arm: expose CPUID registers to
 userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A number of CPUID registers are exposed to userspace by modern Linux
kernels thanks to the "ARM64 CPU Feature Registers" ABI. For
CONFIG_USER_ONLY we don't emulate the kernels trap and emulate but
instead just lower the read permission to PL0_R (hidden behind the
PL1U_R macro).

The ID_AA64PFR0_EL1 is a little special as the GIC version is hidden
from userspace so we can define a ARM_CP_CONST version of the register
for usermode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

squash! target/arm: expose CPUID registers to userspace
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 39 +++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a4507a2d6f..156c811654 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1924,6 +1924,13 @@ static inline bool cptype_valid(int cptype)
 #define PL0_R (0x02 | PL1_R)
 #define PL0_W (0x01 | PL1_W)
 
+/* for AArch64 HWCAP_CPUID to userspace */
+#ifdef CONFIG_USER_ONLY
+#define PL1U_R PL0_R
+#else
+#define PL1U_R PL1_R
+#endif
+
 #define PL3_RW (PL3_R | PL3_W)
 #define PL2_RW (PL2_R | PL2_W)
 #define PL1_RW (PL1_R | PL1_W)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9d81feb124..1ea0dc4593 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2987,7 +2987,7 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static const ARMCPRegInfo mpidr_cp_reginfo[] = {
     { .name = "MPIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
-      .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+      .access = PL1U_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
     REGINFO_SENTINEL
 };
 
@@ -4776,6 +4776,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -4786,6 +4787,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
@@ -4934,18 +4936,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST for system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs. For
+             * user-mode HWCAP_CPUID emulation the gic bits are masked
+             * anyway.
              */
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
+#ifndef CONFIG_USER_ONLY
               .access = PL1_R, .type = ARM_CP_NO_RAW,
               .readfn = id_aa64pfr0_read,
-              .writefn = arm_cp_write_ignore },
+              .writefn = arm_cp_write_ignore
+#else
+              .access = PL0_R, .type = ARM_CP_CONST,
+              .resetvalue = cpu->id_aa64pfr0
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64pfr1},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
@@ -4973,11 +4983,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64dfr1 },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
@@ -5005,11 +5015,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64isar0 },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64isar1 },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
@@ -5037,11 +5047,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64mmfr0 },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL1U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64mmfr1 },
             { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
@@ -5335,7 +5345,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo id_v8_midr_cp_reginfo[] = {
             { .name = "MIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_NO_RAW, .resetvalue = cpu->midr,
+              .access = PL1U_R, .type = ARM_CP_NO_RAW, .resetvalue = cpu->midr,
               .fieldoffset = offsetof(CPUARMState, cp15.c0_cpuid),
               .readfn = midr_read },
             /* crn = 0 op1 = 0 crm = 0 op2 = 4,7 : AArch32 aliases of MIDR */
@@ -5347,7 +5357,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .resetvalue = cpu->midr },
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+              .access = PL1U_R, .type = ARM_CP_CONST,
+              .resetvalue = cpu->revidr },
             REGINFO_SENTINEL
         };
         ARMCPRegInfo id_cp_reginfo[] = {
-- 
2.17.1
