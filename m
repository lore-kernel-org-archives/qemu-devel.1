Received: from eggs.gnu.org ([2001:4830:134:3::10]:44828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKn-0001iL-7L
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKm-00089j-A2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:48:13 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed, 19 Jul 2017 09:39:56 -0400
Message-Id: <1500471597-2517-4-git-send-email-drjones@redhat.com>
In-Reply-To: <1500471597-2517-1-git-send-email-drjones@redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] hw/arm/virt: allow pmu instantiation
 with userspace irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, agraf@suse.de, cdall@linaro.org

Move the in-kernel-irqchip test to only guard the set-irq
stage, not the init stage of the PMU.  Also add the PMU to
the KVM device irq line synchronization to enable its use.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c      | 3 ++-
 target/arm/kvm.c   | 6 +++++-
 target/arm/kvm64.c | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7157a028adce..a215330444da 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -496,7 +496,8 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
             return;
         }
         if (kvm_enabled()) {
-            if (!kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
+            if (kvm_irqchip_in_kernel() &&
+                !kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
                 return;
             }
             if (!kvm_arm_pmu_init(cpu)) {
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
index e26638a6fac1..ec7d85314acc 100644
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
