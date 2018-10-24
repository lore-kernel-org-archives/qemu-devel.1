Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTm-0003HY-F2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTk-0005HU-TV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHTk-0005DS-KO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id y144-v6so5013872wmd.4
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:37:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Oct 2018 12:37:09 +0100
Message-Id: <20181024113709.16599-6-richard.henderson@linaro.org>
In-Reply-To: <20181024113709.16599-1-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] target/arm: Convert t32ee from feature bit
 to isar3 test
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
 target/arm/cpu.h     | 6 +++++-
 linux-user/elfload.c | 2 +-
 target/arm/cpu.c     | 4 ----
 target/arm/helper.c  | 2 +-
 target/arm/kvm32.c   | 3 ---
 target/arm/machine.c | 3 +--
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8e6779936e..895f9909d8 100644
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
index 055f6a95ab..45d6836bb9 100644
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
index 8f16e96b6c..e08a2d2d79 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1440,7 +1440,6 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fc080;
@@ -1509,7 +1508,6 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_VFP_FP16);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     /* Note that A9 supports the MP extensions even for
      * A9UP and single-core A9MP (which are both different
@@ -1572,7 +1570,6 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
@@ -1618,7 +1615,6 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ea95b0815..bea4d5350d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5455,7 +5455,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+    if (cpu_isar_feature(t32ee, cpu)) {
         define_arm_cp_regs(cpu, t2ee_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f23cc77d9e..bf39937a08 100644
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
