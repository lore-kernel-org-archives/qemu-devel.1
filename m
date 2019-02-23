Received: from eggs.gnu.org ([209.51.188.92]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNET-0002v3-7Q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNER-0002WT-UQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:05 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:41976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNER-0002V6-Nc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:03 -0500
Received: by mail-pf1-x433.google.com with SMTP id d25so1919002pfn.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:53 -0800
Message-Id: <20190223023957.18865-3-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
References: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] target/arm: Define cortex-a73
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

There are new field definitions, CSV2 and CSV3, that do not yet
appear in the main ARM ARM.  Define the ID_AA64PF0 versions,
since we already define the rest of those bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  2 ++
 hw/arm/virt.c      |  1 +
 target/arm/cpu64.c | 63 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c57f8e9ba8..c2899f0bed 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1694,6 +1694,8 @@ FIELD(ID_AA64PFR0, ADVSIMD, 20, 4)
 FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
+FIELD(ID_AA64PFR0, CSV2, 56, 4)
+FIELD(ID_AA64PFR0, CSV3, 60, 4)
 
 FIELD(ID_AA64PFR1, BT, 0, 4)
 FIELD(ID_AA64PFR1, SBSS, 4, 4)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99c2b6e60d..c69a734878 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -173,6 +173,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
     ARM_CPU_TYPE_NAME("cortex-a72"),
+    ARM_CPU_TYPE_NAME("cortex-a73"),
     ARM_CPU_TYPE_NAME("host"),
     ARM_CPU_TYPE_NAME("max"),
 };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index eff0f164dd..d34aa3af75 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -51,7 +51,8 @@ static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 }
 #endif
 
-static const ARMCPRegInfo cortex_a72_a57_a53_cp_reginfo[] = {
+/* These extra registers are used by (most of?) the cortex-a* series.  */
+static const ARMCPRegInfo cortex_aXX_cp_reginfo[] = {
 #ifndef CONFIG_USER_ONLY
     { .name = "L2CTLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 11, .crm = 0, .opc2 = 2,
@@ -149,7 +150,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
-    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
 }
 
 static void aarch64_a53_initfn(Object *obj)
@@ -203,7 +204,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
-    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
 }
 
 static void aarch64_a72_initfn(Object *obj)
@@ -255,7 +256,60 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
-    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
+}
+
+static void aarch64_a73_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,cortex-a73";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+    cpu->midr = 0x411fd090;
+    cpu->revidr = 0x00000000;
+    cpu->reset_fpsid = 0x41034091;
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x12111111;
+    cpu->isar.mvfr2 = 0x00000043;
+    cpu->ctr = 0x84448004;
+    cpu->reset_sctlr = 0x00c50838;
+    cpu->id_pfr0 = 0x00010131;
+    cpu->id_pfr1 = 0x00011011;
+    cpu->id_pfr2 = 0x00000001;
+    cpu->id_dfr0 = 0x03010066;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x10201105;
+    cpu->id_mmfr1 = 0x40000000;
+    cpu->id_mmfr2 = 0x01260000;
+    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_aa64pfr0 = 0x1100000000002222ull;
+    cpu->id_aa64dfr0 = 0x10305106;
+    cpu->isar.id_aa64isar0 = 0x00011120;
+    cpu->isar.id_aa64mmfr0 = 0x00101122;
+    cpu->dbgdidr = 0x3516d000;
+    cpu->clidr = 0x0a200023;
+    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
+    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
+    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+    cpu->dcz_blocksize = 4; /* 64 bytes */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
 }
 
 static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
@@ -378,6 +432,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
+    { .name = "cortex-a73",         .initfn = aarch64_a73_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
     { .name = NULL }
 };
-- 
2.17.2
