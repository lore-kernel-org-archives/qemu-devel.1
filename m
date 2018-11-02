Received: from eggs.gnu.org ([2001:4830:134:3::10]:60712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhl-00078u-AI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhj-0007MM-A0
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIZhh-0007CH-Ae
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id d17-v6so2014235wre.11
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:41:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 13:41:12 +0000
Message-Id: <20181102134112.26370-5-richard.henderson@linaro.org>
In-Reply-To: <20181102134112.26370-1-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 4/4] target/arm: Implement the
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
Cc: qemu-arm@nongnu.org

The bulk of the work here, beyond base HPD, is defining the TTBCR2 register.
In addition we must check TTBCR.T2E, which is not present (RES0) for AArch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  8 ++++++++
 target/arm/cpu.c    |  4 ++++
 target/arm/helper.c | 37 +++++++++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f12a6afddc..a253cdebde 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1517,6 +1517,14 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR4, SPECSEI, 0, 4)
+FIELD(ID_MMFR4, AC2, 4, 4)
+FIELD(ID_MMFR4, XNX, 8, 4)
+FIELD(ID_MMFR4, CNP, 12, 4)
+FIELD(ID_MMFR4, HPDS, 16, 4)
+FIELD(ID_MMFR4, LSM, 20, 4)
+FIELD(ID_MMFR4, CCIDX, 24, 4)
+
 FIELD(ID_AA64ISAR0, AES, 4, 4)
 FIELD(ID_AA64ISAR0, SHA1, 8, 4)
 FIELD(ID_AA64ISAR0, SHA2, 12, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8f16e96b6c..3fd85f21c5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1856,6 +1856,10 @@ static void arm_max_initfn(Object *obj)
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
index 312d3e6f02..85d3f4ad89 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2722,6 +2722,7 @@ static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
+    TCR *tcr = raw_ptr(env, ri);
 
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         /* With LPAE the TTBCR could result in a change of ASID
@@ -2729,6 +2730,8 @@ static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          */
         tlb_flush(CPU(cpu));
     }
+    /* Preserve the high half of TCR_EL1, set via TTBCR2.  */
+    value = deposit64(tcr->raw_tcr, 0, 32, value);
     vmsa_ttbcr_raw_write(env, ri, value);
 }
 
@@ -2831,6 +2834,16 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Note that unlike TTBCR, writing to TTBCR2 does not require flushing
+ * qemu tlbs nor adjusting cached masks.
+ */
+static const ARMCPRegInfo ttbcr2_reginfo = {
+    .name = "TTBCR2", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 3,
+    .access = PL1_RW, .type = ARM_CP_ALIAS,
+    .bank_fieldoffsets = { offsetofhigh32(CPUARMState, cp15.tcr_el[3]),
+                           offsetofhigh32(CPUARMState, cp15.tcr_el[1]) },
+};
+
 static void omap_ticonfig_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
@@ -5454,6 +5467,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -9797,12 +9814,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -9819,8 +9838,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
