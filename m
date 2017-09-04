Received: from eggs.gnu.org ([2001:4830:134:3::10]:52697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSX-00056l-VL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSJ-0004qq-DA
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSJ-0004pl-5m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSI-0005YG-1F
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:52 +0100
Message-Id: <1504527967-29248-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/36] hw/arm/virt: allow pmu instantiation with
 userspace irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Move the in-kernel-irqchip test to only guard the set-irq
stage, not the init stage of the PMU.  Also add the PMU to
the KVM device irq line synchronization to enable its use.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Message-id: 1500471597-2517-4-git-send-email-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c      | 3 ++-
 target/arm/kvm.c   | 6 +++++-
 target/arm/kvm64.c | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d6e2486..999f448 100644
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
index 7c17f0d..211a7bf 100644
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
index e26638a..ec7d853 100644
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
2.7.4
