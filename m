Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3bf-0002yL-UY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3bb-00023L-5S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:29:39 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 16 Jan 2017 17:27:01 +0800
Message-ID: <1484558821-15512-7-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 6/6] target-arm: cpu64: Add support for
 Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, christoffer.dall@linaro.org, kvmarm@lists.cs.columbia.edu, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

Add the ARM Cortex-A72 processor definition. It's similar to A57.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 hw/arm/virt.c      |  1 +
 target/arm/cpu64.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 49b7b65..2ba93e3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -166,6 +166,7 @@ static const char *valid_cpus[] = {
     "cortex-a15",
     "cortex-a53",
     "cortex-a57",
+    "cortex-a72",
     "generic",
     "host",
     NULL
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 223f31e..4f00ceb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -204,6 +204,61 @@ static void aarch64_a53_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
 }
 
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
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    cpu->kvm_target = QEMU_KVM_ARM_TARGET_GENERIC_V8;
+    cpu->midr = 0x410fd081;
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
+    cpu->ccsidr[2] = 0x71ffe07a; /* 4096KB L2 cache */
+    cpu->dcz_blocksize = 4; /* 64 bytes */
+    define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
+}
+
 static void aarch64_generic_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -285,6 +340,7 @@ typedef struct ARMCPUInfo {
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
+    { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "generic",            .initfn = aarch64_generic_initfn },
 #ifdef CONFIG_USER_ONLY
     { .name = "any",         .initfn = aarch64_any_initfn },
-- 
2.0.4
