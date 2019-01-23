Received: from eggs.gnu.org ([209.51.188.92]:34623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZY-0001WZ-82
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZT-0007J9-W1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:50 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:47 +0100
Message-Id: <20190123101458.12478-8-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 07/18] kvm: add kvm_arm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

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
index e00ccf9c98..877c588ef5 100644
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
@@ -162,6 +163,13 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features =3D arm_host_cpu_features.features;
 }
=20
+int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
+{
+    KVMState *s =3D KVM_STATE(ms->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* For ARM interrupt delivery is always asynchronous,
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6393455b1d..5969c41f83 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -207,6 +207,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeature=
s *ahcf);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
=20
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
@@ -239,6 +250,11 @@ static inline void kvm_arm_set_cpu_features_from_hos=
t(ARMCPU *cpu)
     cpu->host_cpu_probe_failed =3D true;
 }
=20
+static inline int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
+{
+    return -ENOENT;
+}
+
 static inline int kvm_arm_vgic_probe(void)
 {
     return 0;
--=20
2.20.1
