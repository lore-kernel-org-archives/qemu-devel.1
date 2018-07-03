Received: from eggs.gnu.org ([208.118.235.92]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFkU-0004qG-Af
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFgp-0001d9-U9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:29:09 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  3 Jul 2018 09:19:46 +0200
Message-Id: <1530602398-16127-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 03/15] kvm: add kvm_arm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

Add the kvm_arm_get_max_vm_phys_shift() helper that returns the
log of the maximum IPA size supported by KVM. This capability
needs to be known to create the VM with a correct IPA max size
(kvm_type passed along KVM_CREATE_VM ioctl.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v1 -> v2:
- put this in ARM specific code
---
 target/arm/kvm.c     |  9 +++++++++
 target/arm/kvm_arm.h | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 65f867d..7d501ca 100644
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
+    return kvm_ioctl(s, KVM_ARM_GET_MAX_VM_PHYS_SHIFT, 0);
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* For ARM interrupt delivery is always asynchronous,
@@ -713,3 +721,4 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 863f205..ee973f6 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -183,6 +183,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 /**
+ * kvm_arm_get_max_vm_phys_shift - Returns log2 of the max IPA size
+ * supported by KVM
+ *
+ * @s: Machine state handle
+ *
+ * Return the max number of IPA bits or a negative value if
+ * the host kernel does not expose this value.
+ */
+int kvm_arm_get_max_vm_phys_shift(MachineState *ms);
+
+/**
  * kvm_arm_sync_mpstate_to_kvm
  * @cpu: ARMCPU
  *
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
2.5.5
