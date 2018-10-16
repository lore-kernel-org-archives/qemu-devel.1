Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsD-0001Y2-Uj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsA-0005WG-Mx
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXsA-0005Sz-DL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id 23-v6so11511561pgc.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:13 -0700
Message-Id: <20181016223115.24100-7-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 6/8] target/arm: Convert t32ee from feature
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
Cc: peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 6 +++++-
 linux-user/elfload.c | 2 +-
 target/arm/cpu.c     | 4 ----
 target/arm/helper.c  | 2 +-
 target/arm/machine.c | 3 +--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4fdace5de1..af68932946 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1558,7 +1558,6 @@ enum arm_features {
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
-    ARM_FEATURE_THUMB2EE,
     ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
     ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
     ARM_FEATURE_V4T,
@@ -3157,6 +3156,11 @@ static inline bool isar_feature_jazelle(const ARMISARegisters *id)
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
index 1e0f22d812..c6edc545ac 100644
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
index 342c802a95..b7d9a3392e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5359,7 +5359,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+    if (cpu_isar_feature(t32ee, cpu)) {
         define_arm_cp_regs(cpu, t2ee_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index ff4ec22bf7..5402ff8ae5 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -301,9 +301,8 @@ static const VMStateDescription vmstate_m = {
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
