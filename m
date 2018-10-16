Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRD2-0001Su-CA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRD1-0000o7-CX
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCx-0007xg-GF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCD-0003pp-6q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:21 +0100
Message-Id: <20181016152325.31367-16-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/19] target/arm: Add the Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the ARM Cortex-A72.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-11-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 66 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index db71504cb5c..44fdf0f6fa2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -51,7 +51,7 @@ static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 }
 #endif
 
-static const ARMCPRegInfo cortex_a57_a53_cp_reginfo[] = {
+static const ARMCPRegInfo cortex_a72_a57_a53_cp_reginfo[] = {
 #ifndef CONFIG_USER_ONLY
     { .name = "L2CTLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 11, .crm = 0, .opc2 = 2,
@@ -156,7 +156,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
-    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
+    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
 
 static void aarch64_a53_initfn(Object *obj)
@@ -215,7 +215,66 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
-    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
+    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+}
+
+static void aarch64_a72_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,cortex-a72";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
+    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
+    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
+    set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+    cpu->midr = 0x410fd083;
+    cpu->revidr = 0x00000000;
+    cpu->reset_fpsid = 0x41034080;
+    cpu->mvfr0 = 0x10110222;
+    cpu->mvfr1 = 0x12111111;
+    cpu->mvfr2 = 0x00000043;
+    cpu->ctr = 0x8444c004;
+    cpu->reset_sctlr = 0x00c50838;
+    cpu->id_pfr0 = 0x00000131;
+    cpu->id_pfr1 = 0x00011011;
+    cpu->id_dfr0 = 0x03010066;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x10201105;
+    cpu->id_mmfr1 = 0x40000000;
+    cpu->id_mmfr2 = 0x01260000;
+    cpu->id_mmfr3 = 0x02102211;
+    cpu->id_isar0 = 0x02101110;
+    cpu->id_isar1 = 0x13112111;
+    cpu->id_isar2 = 0x21232042;
+    cpu->id_isar3 = 0x01112131;
+    cpu->id_isar4 = 0x00011142;
+    cpu->id_isar5 = 0x00011121;
+    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->id_aa64dfr0 = 0x10305106;
+    cpu->pmceid0 = 0x00000000;
+    cpu->pmceid1 = 0x00000000;
+    cpu->id_aa64isar0 = 0x00011120;
+    cpu->id_aa64mmfr0 = 0x00001124;
+    cpu->dbgdidr = 0x3516d000;
+    cpu->clidr = 0x0a200023;
+    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
+    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
+    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+    cpu->dcz_blocksize = 4; /* 64 bytes */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
 }
 
 static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
@@ -293,6 +352,7 @@ typedef struct ARMCPUInfo {
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
+    { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
     { .name = NULL }
 };
-- 
2.19.0
