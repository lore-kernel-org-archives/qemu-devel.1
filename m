Received: from eggs.gnu.org ([2001:4830:134:3::10]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzc-00069u-QV
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzb-0005vW-PO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:39:00 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzb-0005uJ-Jc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:59 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so12216596oix.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:39 -0600
Message-Id: <20181203203839.757-11-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 10/10] target/arm: Implement the
 ARMv8.2-AA32HPD extension
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

The bulk of the work here, beyond base HPD, is defining the
TTBCR2 register.  In addition we must check TTBCR.T2E, which
is not present (RES0) for AArch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  9 +++++++++
 target/arm/cpu.c    |  4 ++++
 target/arm/helper.c | 37 +++++++++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ba0c368292..15daa2c050 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1548,6 +1548,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR4, SPECSEI, 0, 4)
+FIELD(ID_MMFR4, AC2, 4, 4)
+FIELD(ID_MMFR4, XNX, 8, 4)
+FIELD(ID_MMFR4, CNP, 12, 4)
+FIELD(ID_MMFR4, HPDS, 16, 4)
+FIELD(ID_MMFR4, LSM, 20, 4)
+FIELD(ID_MMFR4, CCIDX, 24, 4)
+FIELD(ID_MMFR4, EVT, 28, 4)
+
 FIELD(ID_AA64ISAR0, AES, 4, 4)
 FIELD(ID_AA64ISAR0, SHA1, 8, 4)
 FIELD(ID_AA64ISAR0, SHA2, 12, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..0b185f8d30 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1932,6 +1932,10 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             cpu->isar.id_isar6 = t;
+
+            t = cpu->id_mmfr4;
+            t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
+            cpu->id_mmfr4 = t;
         }
 #endif
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9bb3e364d4..5df7a9e637 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2733,6 +2733,7 @@ static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
+    TCR *tcr = raw_ptr(env, ri);
 
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         /* With LPAE the TTBCR could result in a change of ASID
@@ -2740,6 +2741,8 @@ static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         tlb_flush(CPU(cpu));
     }
+    /* Preserve the high half of TCR_EL1, set via TTBCR2.  */
+    value = deposit64(tcr->raw_tcr, 0, 32, value);
     vmsa_ttbcr_raw_write(env, ri, value);
 }
 
@@ -2842,6 +2845,16 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Note that unlike TTBCR, writing to TTBCR2 does not require flushing
+ * qemu tlbs nor adjusting cached masks.
+ */
+static const ARMCPRegInfo ttbcr2_reginfo = {
+    .name = "TTBCR2", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 3,
+    .access = PL1_RW, .type = ARM_CP_ALIAS,
+    .bank_fieldoffsets = { offsetofhigh32(CPUARMState, cp15.tcr_el[3]),
+                           offsetofhigh32(CPUARMState, cp15.tcr_el[1]) },
+};
+
 static void omap_ticonfig_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
@@ -5540,6 +5553,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     } else {
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
+        /* TTCBR2 is introduced with ARMv8.2-A32HPD.  */
+        if (FIELD_EX32(cpu->id_mmfr4, ID_MMFR4, HPDS) != 0) {
+            define_one_arm_cp_reg(cpu, &ttbcr2_reginfo);
+        }
     }
     if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
         define_arm_cp_regs(cpu, t2ee_cp_reginfo);
@@ -9891,12 +9908,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 2) { /* 16KB pages */
             stride = 11;
         }
-        if (aarch64) {
-            if (el > 1) {
-                hpd = extract64(tcr->raw_tcr, 24, 1);
-            } else {
-                hpd = extract64(tcr->raw_tcr, 41, 1);
-            }
+        if (aarch64 && el > 1) {
+            hpd = extract64(tcr->raw_tcr, 24, 1);
+        } else {
+            hpd = extract64(tcr->raw_tcr, 41, 1);
+        }
+        if (!aarch64) {
+            /* For aarch32, hpd0 is not enabled without t2e as well.  */
+            hpd &= extract64(tcr->raw_tcr, 6, 1);
         }
     } else {
         /* We should only be here if TTBR1 is valid */
@@ -9913,8 +9932,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         if (tg == 1) { /* 16KB pages */
             stride = 11;
         }
-        if (aarch64) {
-            hpd = extract64(tcr->raw_tcr, 42, 1);
+        hpd = extract64(tcr->raw_tcr, 42, 1);
+        if (!aarch64) {
+            /* For aarch32, hpd1 is not enabled without t2e as well.  */
+            hpd &= extract64(tcr->raw_tcr, 6, 1);
         }
     }
 
-- 
2.17.2
