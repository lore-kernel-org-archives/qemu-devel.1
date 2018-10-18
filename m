Received: from eggs.gnu.org ([2001:4830:134:3::10]:36236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9L0-0005w8-7o
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kz-0007NI-Ah
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:46 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:30 +0200
Message-Id: <20181018143042.29588-5-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 04/16] kvm: add kvm_arm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

Add the kvm_arm_get_max_vm_phys_shift() helper that returns the
log of the maximum IPA size supported by KVM. This capability
needs to be known to create the VM with a specific IPA max size
(kvm_type passed along KVM_CREATE_VM ioctl.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- s/s/ms in kvm_arm_get_max_vm_phys_shift function comment
- check KVM_CAP_ARM_VM_IPA_SIZE extension

v1 -> v2:
- put this in ARM specific code
---
 target/arm/kvm.c     |  8 ++++++++
 target/arm/kvm_arm.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 54ef5f711b..485e3291ae 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
 #include "cpu.h"
 #include "trace.h"
@@ -154,6 +155,13 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
+{
+    KVMState *s = KVM_STATE(ms->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* For ARM interrupt delivery is always asynchronous,
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 5948e8b560..749c38cb35 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -182,6 +182,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * kvm_arm_get_max_vm_phys_shift - Returns log2 of the max IPA size
+ * supported by KVM
+ *
+ * @ms: Machine state handle
+ *
+ * Return the max number of IPA bits or a negative value if
+ * the host kernel does not expose this value.
+ */
+int kvm_arm_get_max_vm_phys_shift(MachineState *ms);
+
 /**
  * kvm_arm_sync_mpstate_to_kvm
  * @cpu: ARMCPU
@@ -214,6 +225,11 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->host_cpu_probe_failed = true;
 }
 
+static inline int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
+{
+    return -ENOENT;
+}
+
 static inline int kvm_arm_vgic_probe(void)
 {
     return 0;
-- 
2.17.1
