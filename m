Received: from eggs.gnu.org ([2001:4830:134:3::10]:42411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzb-000688-6C
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzY-0005rJ-Pi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:59 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzY-0005qE-Kg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id 81so12996442otj.2
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:37 -0600
Message-Id: <20181203203839.757-9-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/10] target/arm: Implement the ARMv8.1-LOR
 extension
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

Provide a trivial implementation with zero limited ordering regions,
which causes the LDLAR and STLLR instructions to devolve into the
LDAR and STLR instructions from the base ARMv8.0 instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v2: Mark LORID_EL1 read-only.
    Add TLOR access checks.
    Conditionally unmask TLOR in hcr/scr_write.
---
 target/arm/cpu.h           |  5 +++
 target/arm/cpu64.c         |  4 ++
 target/arm/helper.c        | 91 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 12 +++++
 4 files changed, 112 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a84101efa9..ba0c368292 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3285,6 +3285,11 @@ static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
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
index faf7f922bf..a0ee1fbc5a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1281,6 +1281,7 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     /* Begin with base v8.0 state.  */
     uint32_t valid_mask = 0x3fff;
+    ARMCPU *cpu = arm_env_get_cpu(env);
 
     if (arm_el_is_aa64(env, 3)) {
         value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
@@ -1303,6 +1304,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             valid_mask &= ~SCR_SMD;
         }
     }
+    if (cpu_isar_feature(aa64_lor, cpu)) {
+        valid_mask |= SCR_TLOR;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -3950,6 +3954,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
+    if (cpu_isar_feature(aa64_lor, cpu)) {
+        valid_mask |= HCR_TLOR;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
@@ -5004,6 +5011,58 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr0;
 }
 
+static CPAccessResult access_lorid(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (arm_is_secure_below_el3(env)) {
+        /* Access ok in secure mode.  */
+        return CP_ACCESS_OK;
+    }
+    if (el < 2 && arm_el_is_aa64(env, 2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            hcr &= HCR_TLOR;
+        } else {
+            hcr &= HCR_TGE | HCR_TLOR;
+        }
+        if (hcr == HCR_TLOR) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    if (el < 3 && (env->cp15.scr_el3 & SCR_TLOR)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_lor_other(CPUARMState *env,
+                                       const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (arm_is_secure_below_el3(env)) {
+        /* Access denied in secure mode.  */
+        return CP_ACCESS_TRAP;
+    }
+    if (el < 2 && arm_el_is_aa64(env, 2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            hcr &= HCR_TLOR;
+        } else {
+            hcr &= HCR_TGE | HCR_TLOR;
+        }
+        if (hcr == HCR_TLOR) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    if (el < 3 && (env->cp15.scr_el3 & SCR_TLOR)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -5741,6 +5800,38 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
+              .access = PL1_RW, .accessfn = access_lor_other,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
+              .access = PL1_RW, .accessfn = access_lor_other,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
+              .access = PL1_RW, .accessfn = access_lor_other,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
+              .access = PL1_RW, .accessfn = access_lor_other,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
+            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
+              .access = PL1_R, .accessfn = access_lorid,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, lor_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fd36425f1a..5952a9d1cc 100644
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
