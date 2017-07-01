Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYN-00084c-D3
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dRLYM-0000SV-Dq
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 12:47:27 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Sat,  1 Jul 2017 12:47:16 -0400
Message-Id: <1498927637-14496-3-git-send-email-drjones@redhat.com>
In-Reply-To: <1498927637-14496-1-git-send-email-drjones@redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] target/arm/kvm: split pmu init from
 creation
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

When adding a PMU with a userspace irqchip we only do the INIT
stage of the device creation.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c        | 10 ++++++++--
 target/arm/kvm32.c   |  6 ++++++
 target/arm/kvm64.c   | 52 +++++++++++++++++++++++++---------------------------
 target/arm/kvm_arm.h |  6 ++++++
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9781e1cc5ed7..0cb8b479232d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -492,8 +492,14 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 
     CPU_FOREACH(cpu) {
         armcpu = ARM_CPU(cpu);
-        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU) ||
-            (kvm_enabled() && !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ)))) {
+        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
+            return;
+        }
+        if (kvm_enabled() &&
+            !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ))) {
+            return;
+        }
+        if (kvm_enabled() && !kvm_arm_pmu_init(cpu)) {
             return;
         }
     }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 069da0c5fd10..a51695f25911 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -527,3 +527,9 @@ int kvm_arm_pmu_create(CPUState *cs, int irq)
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
     return 0;
 }
+
+int kvm_arm_pmu_init(CPUState *cs)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+    return 0;
+}
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a16abc8d129e..d94e0a04f015 100644
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
+int kvm_arm_pmu_create(CPUState *cs, int irq)
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
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 633d08828a5d..3382762aa023 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -196,6 +196,7 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 int kvm_arm_vgic_probe(void);
 
 int kvm_arm_pmu_create(CPUState *cs, int irq);
+int kvm_arm_pmu_init(CPUState *cs);
 
 #else
 
@@ -209,6 +210,11 @@ static inline int kvm_arm_pmu_create(CPUState *cs, int irq)
     return 0;
 }
 
+static inline int kvm_arm_pmu_init(CPUState *cs)
+{
+    return 0;
+}
+
 #endif
 
 static inline const char *gic_class_name(void)
-- 
1.8.3.1
