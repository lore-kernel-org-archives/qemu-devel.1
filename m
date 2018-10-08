Received: from eggs.gnu.org ([2001:4830:134:3::10]:58268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4P-00055T-RQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyw-0008C1-Pb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyt-0008AE-Iz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id v133-v6so8400074pgb.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:22:03 -0700
Message-Id: <20181008212205.17752-9-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/10] target/arm: Convert t32ee from
 feature bit to isar3 test
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
index 557ef8daf9..d8cb9633d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1552,7 +1552,6 @@ enum arm_features {
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
-    ARM_FEATURE_THUMB2EE,
     ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
     ARM_FEATURE_V7VE, /* v7 Virtualization Extensions (non-EL2 parts) */
     ARM_FEATURE_V4T,
@@ -3151,6 +3150,11 @@ static inline bool aa32_feature_jazelle(ARMCPU *cpu)
     return FIELD_EX32(cpu->id_isar1, ID_ISAR1, JAZELLE) != 0;
 }
 
+static inline bool aa32_feature_t32ee(ARMCPU *cpu)
+{
+    return FIELD_EX32(cpu->id_isar3, ID_ISAR3, T32EE) != 0;
+}
+
 static inline bool aa32_feature_aes(ARMCPU *cpu)
 {
     return FIELD_EX32(cpu->id_isar5, ID_ISAR5, AES) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9b00e977d8..3061d703b2 100644
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
index 4e2609aa7e..f8faea7933 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1436,7 +1436,6 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fc080;
@@ -1505,7 +1504,6 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_VFP_FP16);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     /* Note that A9 supports the MP extensions even for
      * A9UP and single-core A9MP (which are both different
@@ -1568,7 +1566,6 @@ static void cortex_a7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
@@ -1614,7 +1611,6 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
     set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0efbb5c76c..0da13175be 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5356,7 +5356,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
     }
-    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+    if (aa32_feature_t32ee(cpu)) {
         define_arm_cp_regs(cpu, t2ee_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index ff4ec22bf7..d44e891533 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -301,9 +301,8 @@ static const VMStateDescription vmstate_m = {
 static bool thumb2ee_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_THUMB2EE);
+    return aa32_feature_t32ee(cpu);
 }
 
 static const VMStateDescription vmstate_thumb2ee = {
-- 
2.17.1
