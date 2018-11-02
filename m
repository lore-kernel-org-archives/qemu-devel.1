Received: from eggs.gnu.org ([2001:4830:134:3::10]:60713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhl-00078v-AL
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhj-0007Mc-Dp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIZhj-0007BJ-48
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id p2-v6so1946947wmc.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 13:41:10 +0000
Message-Id: <20181102134112.26370-3-richard.henderson@linaro.org>
In-Reply-To: <20181102134112.26370-1-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 2/4] target/arm: Implement the
 ARMv8.1-LOR extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Provide a trivial implementation with zero limited ordering regions,
which causes the LDLAR and STLLR instructions to devolve into the
LDAR and STLR instructions from the base ARMv8.0 instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 +++++
 target/arm/cpu64.c         |  4 ++++
 target/arm/helper.c        | 26 ++++++++++++++++++++++++++
 target/arm/translate-a64.c | 12 ++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2ce5e80dfc..f12a6afddc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3278,6 +3278,11 @@ static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
 }
 
+static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR1, LO) != 0;
+}
+
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0babe483ac..aac6283018 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -324,6 +324,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
         cpu->isar.id_aa64pfr0 = t;
 
+        t = cpu->isar.id_aa64mmfr1;
+        t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        cpu->isar.id_aa64mmfr1 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 70376764cb..758ddac5e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5714,6 +5714,32 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &sctlr);
     }
 
+    if (cpu_isar_feature(aa64_lor, cpu)) {
+        /*
+         * A trivial implementation of ARMv8.1-LOR leaves all of these
+         * registers fixed at 0, which indicates that there are zero
+         * supported Limited Ordering regions.
+         */
+        static const ARMCPRegInfo lor_reginfo[] = {
+            { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
+              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
+              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
+              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
+              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
+              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+        };
+        define_arm_cp_regs(cpu, lor_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88195ab949..2307a18d5a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2290,6 +2290,12 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         }
         return;
 
+    case 0x8: /* STLLR */
+        if (!dc_isar_feature(aa64_lor, s)) {
+            break;
+        }
+        /* StoreLORelease is the same as Store-Release for QEMU.  */
+        /* fallthru */
     case 0x9: /* STLR */
         /* Generate ISS for non-exclusive accesses including LASR.  */
         if (rn == 31) {
@@ -2301,6 +2307,12 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
 
+    case 0xc: /* LDLAR */
+        if (!dc_isar_feature(aa64_lor, s)) {
+            break;
+        }
+        /* LoadLOAcquire is the same as Load-Acquire for QEMU.  */
+        /* fallthru */
     case 0xd: /* LDAR */
         /* Generate ISS for non-exclusive accesses including LASR.  */
         if (rn == 31) {
-- 
2.17.2
