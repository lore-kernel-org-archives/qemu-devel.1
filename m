Received: from eggs.gnu.org ([209.51.188.92]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAsu-00025b-Vi
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAss-0003X8-A6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1goAsr-0003Uf-Rn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id g67so14840787wmd.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:39:44 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 28 Jan 2019 17:39:38 +0000
Message-Id: <20190128173940.25813-3-alex.bennee@linaro.org>
In-Reply-To: <20190128173940.25813-1-alex.bennee@linaro.org>
References: <20190128173940.25813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/4] target/arm: expose CPUID registers to
 userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

A number of CPUID registers are exposed to userspace by modern Linux
kernels thanks to the "ARM64 CPU Feature Registers" ABI. For QEMU's
user-mode emulation we don't need to emulate the kernels trap but just
return the value the trap would have done. For this we use the PL0U_R
permission mask which allows this access in CONFIG_USER mode.

Some registers only return a subset of their contents so we need
specific CONFIG_USER_ONLY logic to do this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - tweak commit message
  - use PL0U_R instead of PL1U_R to be less confusing
  - more CONFIG_USER logic for special cases
  - mask a bunch of bits for some registers
---
 target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 42c1c0b144..68808e7293 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3543,7 +3543,7 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static const ARMCPRegInfo mpidr_cp_reginfo[] = {
     { .name = "MPIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
-      .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+      .access = PL0U_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
     REGINFO_SENTINEL
 };
 
@@ -5488,6 +5488,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -5498,6 +5499,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -5799,18 +5801,26 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST for system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs. For
+             * user-mode HWCAP_CPUID emulation the GIC bits are masked
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
+              .access = PL0U_R, .type = ARM_CP_CONST,
+              .resetvalue = cpu->isar.id_aa64pfr0 & 0x000f000f0ff0000ULL
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->isar.id_aa64pfr1},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
@@ -5839,11 +5849,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_aa64dfr1 },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
@@ -5871,11 +5881,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->isar.id_aa64isar0 },
+              .access = PL0U_R, .type = ARM_CP_CONST,
+#ifdef CONFIG_USER_ONLY
+              .resetvalue = cpu->isar.id_aa64isar0 & 0x000fffffff0ffff0ULL
+#else
+              .resetvalue = cpu->isar.id_aa64isar0
+#endif
+            },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->isar.id_aa64isar1 },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
@@ -5903,11 +5918,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->isar.id_aa64mmfr0 },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST,
+              .access = PL0U_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
             { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
@@ -6211,7 +6226,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo id_v8_midr_cp_reginfo[] = {
             { .name = "MIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_NO_RAW, .resetvalue = cpu->midr,
+              .access = PL0U_R, .type = ARM_CP_NO_RAW, .resetvalue = cpu->midr,
               .fieldoffset = offsetof(CPUARMState, cp15.c0_cpuid),
               .readfn = midr_read },
             /* crn = 0 op1 = 0 crm = 0 op2 = 4,7 : AArch32 aliases of MIDR */
@@ -6223,7 +6238,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .resetvalue = cpu->midr },
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+#ifdef CONFIG_USER_ONLY
+              .access = PL0U_R, .type = ARM_CP_CONST,
+              .resetvalue = 0 /* HW_CPUID IMPDEF fields are 0 */ },
+#else
+              .access = PL1_R, .type = ARM_CP_CONST,
+              .resetvalue = cpu->revidr },
+#endif
             REGINFO_SENTINEL
         };
         ARMCPRegInfo id_cp_reginfo[] = {
-- 
2.17.1
