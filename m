Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSY-00056w-4v
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSI-0004qN-GL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSI-0004pl-5Q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSH-0005Xq-7C
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:51 +0100
Message-Id: <1504527967-29248-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/36] target/arm/kvm: pmu: split init and
 set-irq stages
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

When adding a PMU with a userspace irqchip we skip the set-irq
stage of device creation. Split the 'create' function into two
functions 'init' and 'set-irq' so they may be called separately.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Message-id: 1500471597-2517-3-git-send-email-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 10 ++++++++--
 hw/arm/virt.c        | 11 +++++++++--
 target/arm/kvm32.c   |  8 +++++++-
 target/arm/kvm64.c   | 52 +++++++++++++++++++++++++---------------------------
 4 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 633d088..cab5ea9 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -195,7 +195,8 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
 int kvm_arm_vgic_probe(void);
 
-int kvm_arm_pmu_create(CPUState *cs, int irq);
+int kvm_arm_pmu_set_irq(CPUState *cs, int irq);
+int kvm_arm_pmu_init(CPUState *cs);
 
 #else
 
@@ -204,7 +205,12 @@ static inline int kvm_arm_vgic_probe(void)
     return 0;
 }
 
-static inline int kvm_arm_pmu_create(CPUState *cs, int irq)
+static inline int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+{
+    return 0;
+}
+
+static inline int kvm_arm_pmu_init(CPUState *cs)
 {
     return 0;
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a06ec13..d6e2486 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -492,10 +492,17 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 
     CPU_FOREACH(cpu) {
         armcpu = ARM_CPU(cpu);
-        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU) ||
-            (kvm_enabled() && !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ)))) {
+        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             return;
         }
+        if (kvm_enabled()) {
+            if (!kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
+                return;
+            }
+            if (!kvm_arm_pmu_init(cpu)) {
+                return;
+            }
+        }
     }
 
     if (vms->gic_version == 2) {
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 069da0c..e3aab89 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -522,7 +522,13 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
     return false;
 }
 
-int kvm_arm_pmu_create(CPUState *cs, int irq)
+int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+    return 0;
+}
+
+int kvm_arm_pmu_init(CPUState *cs)
 {
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
     return 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a16abc8..e26638a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -381,46 +381,44 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_support_ctrl(CPUState *cs, struct kvm_device_attr *attr)
-{
-    return kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr) == 0;
-}
-
-int kvm_arm_pmu_create(CPUState *cs, int irq)
+static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
 {
     int err;
 
-    struct kvm_device_attr attr = {
-        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
-        .addr = (intptr_t)&irq,
-        .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
-        .flags = 0,
-    };
-
-    if (!kvm_arm_pmu_support_ctrl(cs, &attr)) {
-        return 0;
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        return false;
     }
 
-    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err < 0) {
         fprintf(stderr, "KVM_SET_DEVICE_ATTR failed: %s\n",
                 strerror(-err));
         abort();
     }
 
-    attr.group = KVM_ARM_VCPU_PMU_V3_CTRL;
-    attr.attr = KVM_ARM_VCPU_PMU_V3_INIT;
-    attr.addr = 0;
-    attr.flags = 0;
+    return true;
+}
 
-    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
-    if (err < 0) {
-        fprintf(stderr, "KVM_SET_DEVICE_ATTR failed: %s\n",
-                strerror(-err));
-        abort();
-    }
+int kvm_arm_pmu_init(CPUState *cs)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+        .attr = KVM_ARM_VCPU_PMU_V3_INIT,
+    };
+
+    return kvm_arm_pmu_set_attr(cs, &attr);
+}
+
+int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+        .addr = (intptr_t)&irq,
+        .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
+    };
 
-    return 1;
+    return kvm_arm_pmu_set_attr(cs, &attr);
 }
 
 static inline void set_feature(uint64_t *features, int feature)
-- 
2.7.4
