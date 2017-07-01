Received: from eggs.gnu.org ([2001:4830:134:3::10]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYN-00084b-C8
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYM-0000Sc-F1
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:27 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Sat,  1 Jul 2017 12:47:17 -0400
Message-Id: <1498927637-14496-4-git-send-email-drjones@redhat.com>
In-Reply-To: <1498927637-14496-1-git-send-email-drjones@redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] hw/arm/virt: allow pmu instantiation with
 userspace irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, agraf@suse.de

Move the in-kernel-irqchip test to only guard the creation,
not the init'ing of the PMU.  Also add the PMU to the KVM
device irq line synchronization to enable its use.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c      | 2 +-
 target/arm/kvm.c   | 6 +++++-
 target/arm/kvm64.c | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0cb8b479232d..53592fd0f30c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -495,7 +495,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
         if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             return;
         }
-        if (kvm_enabled() &&
+        if (kvm_irqchip_in_kernel() &&
             !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ))) {
             return;
         }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7c17f0d629d7..211a7bf7befd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -567,7 +567,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
             switched_level &= ~KVM_ARM_DEV_EL1_PTIMER;
         }
 
-        /* XXX PMU IRQ is missing */
+        if (switched_level & KVM_ARM_DEV_PMU) {
+            qemu_set_irq(cpu->pmu_interrupt,
+                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_PMU));
+            switched_level &= ~KVM_ARM_DEV_PMU;
+        }
 
         if (switched_level) {
             qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index d94e0a04f015..54e58e407812 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -506,8 +506,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
     }
-    if (!kvm_irqchip_in_kernel() ||
-        !kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
             cpu->has_pmu = false;
     }
     if (cpu->has_pmu) {
-- 
1.8.3.1
