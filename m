Received: from eggs.gnu.org ([2001:4830:134:3::10]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKL-0001Qb-Mi
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXpKK-000839-LM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:47:45 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed, 19 Jul 2017 09:39:57 -0400
Message-Id: <1500471597-2517-5-git-send-email-drjones@redhat.com>
In-Reply-To: <1500471597-2517-1-git-send-email-drjones@redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] target/arm/kvm: pmu: improve error
 handling
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

If a KVM PMU init or set-irq attr call fails we just silently stop
the PMU DT node generation. The only way they could fail, though,
is if the attr's respective KVM has-attr call fails. But that should
never happen if KVM advertises the PMU capability, because both
attrs have been available since the capability was introduced. Let's
just abort if this should-never-happen stuff does happen, because,
if it does, then something is obviously horribly wrong.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c        |  9 +++------
 target/arm/kvm32.c   |  3 +--
 target/arm/kvm64.c   | 28 ++++++++++++++++++++--------
 target/arm/kvm_arm.h | 15 ++++-----------
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a215330444da..4bc50964d52b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -496,13 +496,10 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
             return;
         }
         if (kvm_enabled()) {
-            if (kvm_irqchip_in_kernel() &&
-                !kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ))) {
-                return;
-            }
-            if (!kvm_arm_pmu_init(cpu)) {
-                return;
+            if (kvm_irqchip_in_kernel()) {
+                kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
             }
+            kvm_arm_pmu_init(cpu);
         }
     }
 
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index e3aab89a1a94..717a2562670b 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -522,10 +522,9 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
     return false;
 }
 
-int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
 {
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return 0;
 }
 
 int kvm_arm_pmu_init(CPUState *cs)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ec7d85314acc..6554c30007a4 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -387,30 +387,36 @@ static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
+        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
-    if (err < 0) {
-        fprintf(stderr, "KVM_SET_DEVICE_ATTR failed: %s\n",
-                strerror(-err));
-        abort();
+    if (err != 0) {
+        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        return false;
     }
 
     return true;
 }
 
-int kvm_arm_pmu_init(CPUState *cs)
+void kvm_arm_pmu_init(CPUState *cs)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
         .attr = KVM_ARM_VCPU_PMU_V3_INIT,
     };
 
-    return kvm_arm_pmu_set_attr(cs, &attr);
+    if (!ARM_CPU(cs)->has_pmu) {
+        return;
+    }
+    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+        error_report("failed to init PMU");
+        abort();
+    }
 }
 
-int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
@@ -418,7 +424,13 @@ int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
         .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
     };
 
-    return kvm_arm_pmu_set_attr(cs, &attr);
+    if (!ARM_CPU(cs)->has_pmu) {
+        return;
+    }
+    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+        error_report("failed to set irq for PMU");
+        abort();
+    }
 }
 
 static inline void set_feature(uint64_t *features, int feature)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cab5ea9be55c..ff53e9fafb7a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -195,8 +195,8 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
 int kvm_arm_vgic_probe(void);
 
-int kvm_arm_pmu_set_irq(CPUState *cs, int irq);
-int kvm_arm_pmu_init(CPUState *cs);
+void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
+void kvm_arm_pmu_init(CPUState *cs);
 
 #else
 
@@ -205,15 +205,8 @@ static inline int kvm_arm_vgic_probe(void)
     return 0;
 }
 
-static inline int kvm_arm_pmu_set_irq(CPUState *cs, int irq)
-{
-    return 0;
-}
-
-static inline int kvm_arm_pmu_init(CPUState *cs)
-{
-    return 0;
-}
+static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
+static inline void kvm_arm_pmu_init(CPUState *cs) {}
 
 #endif
 
-- 
1.8.3.1
