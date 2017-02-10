Received: from eggs.gnu.org ([2001:4830:134:3::10]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-00021d-R3
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc7-0003xC-Lv
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc7-0003sU-E1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:07 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc5-0007bu-Uz
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:54 +0000
Message-Id: <1486750082-12324-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/12] target-arm: Enable vPMU support under TCG
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Wei Huang <wei@redhat.com>

This patch contains several fixes to enable vPMU under TCG mode. It
first removes the checking of kvm_enabled() while unsetting
ARM_FEATURE_PMU. With it, the .pmu option can be used to turn on/off vPMU
under TCG mode. Secondly the PMU node of DT table is now created under TCG.
The last fix is to disable the masking of PMUver field of ID_AA64DFR0_EL1.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1486504171-26807-5-git-send-email-wei@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c       | 2 +-
 target/arm/cpu.c    | 2 +-
 target/arm/helper.c | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1f216cf..8eef143 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -471,7 +471,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     CPU_FOREACH(cpu) {
         armcpu = ARM_CPU(cpu);
         if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU) ||
-            !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ))) {
+            (kvm_enabled() && !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ)))) {
             return;
         }
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4ee250c..4a069f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -781,7 +781,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         unset_feature(env, ARM_FEATURE_EL2);
     }
 
-    if (!cpu->has_pmu || !kvm_enabled()) {
+    if (!cpu->has_pmu) {
         cpu->has_pmu = false;
         unset_feature(env, ARM_FEATURE_PMU);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5358ac6..47250bc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4633,12 +4633,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              /* We mask out the PMUVer field, because we don't currently
-               * implement the PMU. Not advertising it prevents the guest
-               * from trying to use it and getting UNDEFs on registers we
-               * don't implement.
-               */
-              .resetvalue = cpu->id_aa64dfr0 & ~0xf00 },
+              .resetvalue = cpu->id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.7.4
