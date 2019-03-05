Received: from eggs.gnu.org ([209.51.188.92]:54679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHe-0001fw-Li
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHd-0000zT-Rc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHd-0000yU-Jq
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id f65so3252558wma.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.11
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:45 +0000
Message-Id: <20190305165051.26860-17-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/22] kvm: add kvm_arm_get_max_vm_ipa_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Add the kvm_arm_get_max_vm_ipa_size() helper that returns the
number of bits in the IPA address space supported by KVM.

This capability needs to be known to create the VM with a
specific IPA max size (kvm_type passed along KVM_CREATE_VM ioctl.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 13 +++++++++++++
 target/arm/kvm.c     | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6393455b1d0..2a07333c615 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -207,6 +207,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
  */
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/**
+ * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
+ * IPA address space supported by KVM
+ *
+ * @ms: Machine state handle
+ */
+int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
+
 /**
  * kvm_arm_sync_mpstate_to_kvm
  * @cpu: ARMCPU
@@ -239,6 +247,11 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     cpu->host_cpu_probe_failed = true;
 }
 
+static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
+{
+    return -ENOENT;
+}
+
 static inline int kvm_arm_vgic_probe(void)
 {
     return 0;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e00ccf9c987..79a79f01905 100644
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
@@ -162,6 +163,15 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
+{
+    KVMState *s = KVM_STATE(ms->accelerator);
+    int ret;
+
+    ret = kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
+    return ret > 0 ? ret : 40;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* For ARM interrupt delivery is always asynchronous,
-- 
2.20.1
