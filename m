Received: from eggs.gnu.org ([209.51.188.92]:55689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNEX-0002yZ-Lv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNEW-0002cW-PQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:09 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:46200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNEW-0002bo-GX
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:08 -0500
Received: by mail-pl1-x62b.google.com with SMTP id o6so1875497pls.13
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:57 -0800
Message-Id: <20190223023957.18865-7-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
References: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC 6/6] target/arm: Define cortex-a76
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c      |  1 +
 target/arm/cpu64.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 06a155724c..4495ce8918 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -175,6 +175,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("cortex-a73"),
     ARM_CPU_TYPE_NAME("cortex-a75"),
+    ARM_CPU_TYPE_NAME("cortex-a76"),
     ARM_CPU_TYPE_NAME("host"),
     ARM_CPU_TYPE_NAME("max"),
 };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 325e0ecf17..4a92d7656a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -369,6 +369,63 @@ static void aarch64_a75_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
 }
 
+static void aarch64_a76_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,cortex-a76";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /*
+     * Note that the A76 only supports AA32 at EL0, so the
+     * AA32-only EL1 id registers do not exist.
+     */
+    cpu->midr = 0x413fd0b1;
+    cpu->revidr = 0x00000000;
+    cpu->ctr = 0x8444C004;
+    cpu->reset_sctlr = 0x30d50838;
+    cpu->id_pfr0 = 0x10010131;
+    cpu->id_pfr1 = 0x10010000;
+    cpu->id_pfr2 = 0x00000011;
+    cpu->id_dfr0 = 0x04010088;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x10201105;
+    cpu->id_mmfr1 = 0x40000000;
+    cpu->id_mmfr2 = 0x01260000;
+    cpu->id_mmfr3 = 0x02122211;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00011142;
+    cpu->isar.id_isar5 = 0x00011121;
+    cpu->isar.id_isar6 = 0x00000010;
+    cpu->isar.id_aa64pfr0 = 0x1100000010111112ull;
+    cpu->id_aa64dfr0 = 0x10305408;
+    cpu->isar.id_aa64isar0 = 0x0000100010211120ull;
+    cpu->isar.id_aa64isar1 = 0x00100001;
+    cpu->isar.id_aa64mmfr0 = 0x00101122;
+    cpu->isar.id_aa64mmfr1 = 0x10212122;
+    cpu->isar.id_aa64mmfr2 = 0x00001011;
+    cpu->clidr = 0x08200023;
+    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
+    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
+    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+    cpu->dcz_blocksize = 4; /* 64 bytes */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    define_arm_cp_regs(cpu, cortex_aXX_cp_reginfo);
+}
+
 static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -491,6 +548,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a73",         .initfn = aarch64_a73_initfn },
     { .name = "cortex-a75",         .initfn = aarch64_a75_initfn },
+    { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
     { .name = NULL }
 };
-- 
2.17.2
