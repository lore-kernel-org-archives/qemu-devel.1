Received: from eggs.gnu.org ([2001:4830:134:3::10]:39614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoWB-0001d7-Aa
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW8-0008Ek-MN
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKoW8-0008Cv-8q
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id f2-v6so2033299wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:54:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Nov 2018 18:52:46 +0100
Message-Id: <20181108175246.13416-6-richard.henderson@linaro.org>
In-Reply-To: <20181108175246.13416-1-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 5/5] target/arm: Convert t32ee from feature
 bit to isar3 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 6 +++++-
 linux-user/elfload.c | 2 +-
 target/arm/cpu.c     | 4 ----
 target/arm/helper.c  | 2 +-
 target/arm/kvm32.c   | 3 ---
 target/arm/machine.c | 3 +--
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5eff79f73..5c2c77c31d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1575,7 +1575,6 @@ enum arm_features {
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
-    ARM_FEATURE_THUMB2EE,
     ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
     ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
     ARM_FEATURE_V4T,
@@ -3172,6 +3171,11 @@ static inline bool isar_feature_jazelle(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
 }
 
+static inline bool isar_feature_t32ee(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar3, ID_ISAR3, T32EE) != 0;
+}
+
 static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5bccd2e243..a3503c83c9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -466,7 +466,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
     GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
     GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
-    GET_FEATURE(ARM_FEATURE_THUMB2EE, ARM_HWCAP_ARM_THUMBEE);
+    GET_FEATURE_ID(t32ee, ARM_HWCAP_ARM_THUMBEE);
     GET_FEATURE(ARM_FEATURE_NEON, ARM_HWCAP_ARM_NEON);
     GET_FEATURE(ARM_FEATURE_VFP3, ARM_HWCAP_ARM_VFPv3);
     GET_FEATURE(ARM_FEATURE_V6K, ARM_HWCAP_ARM_TLS);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 784a4c2dfc..d4dc0bc225 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1451,7 +1451,6 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fc080;
@@ -1520,7 +1519,6 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_VFP_FP16);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     /* Note that A9 supports the MP extensions even for
      * A9UP and single-core A9MP (which are both different
@@ -1583,7 +1581,6 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
@@ -1629,7 +1626,6 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96301930cc..e28770833a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5457,7 +5457,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+    if (cpu_isar_feature(t32ee, cpu)) {
         define_arm_cp_regs(cpu, t2ee_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 9ededa3c73..8b2c9b3075 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -115,9 +115,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     set_feature(&features, ARM_FEATURE_VFP3);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
-    if (extract32(id_pfr0, 12, 4) == 1) {
-        set_feature(&features, ARM_FEATURE_THUMB2EE);
-    }
     if (extract32(ahcf->isar.mvfr1, 20, 4) == 1) {
         set_feature(&features, ARM_FEATURE_VFP_FP16);
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 239fe4e84d..07f904709a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -321,9 +321,8 @@ static const VMStateDescription vmstate_m = {
 static bool thumb2ee_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_THUMB2EE);
+    return cpu_isar_feature(t32ee, cpu);
 }
 
 static const VMStateDescription vmstate_thumb2ee = {
-- 
2.17.2
