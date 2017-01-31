Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9z-0007dF-BV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9v-00019R-DT
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:55 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue, 31 Jan 2017 10:15:45 -0500
Message-Id: <1485875745-27741-6-git-send-email-wei@redhat.com>
In-Reply-To: <1485875745-27741-1-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V2 5/5] target-arm: Enable vPMU support under
 TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

This patch contains several fixes to enable vPMU under TCG mode. It
first removes the checking of kvm_enabled() while unsetting
ARM_FEATURE_PMU. With it, the .pmu option can be used to turn on/off vPMU
under TCG mode. Secondly the PMU node of DT table is now created under TCG.
The last fix is to disable the masking of PMUver field of ID_AA64DFR0_EL1.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 hw/arm/virt.c       | 2 +-
 target/arm/cpu.c    | 2 +-
 target/arm/helper.c | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6c9e898..5687d49 100644
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
index e9f10f7..9a2bc8a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -745,7 +745,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         unset_feature(env, ARM_FEATURE_EL2);
     }
 
-    if (!cpu->has_pmu || !kvm_enabled()) {
+    if (!cpu->has_pmu) {
         cpu->has_pmu = false;
         unset_feature(env, ARM_FEATURE_PMU);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b028042..6cf0f4f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4630,12 +4630,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
1.8.3.1
