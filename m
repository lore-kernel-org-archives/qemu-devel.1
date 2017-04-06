Received: from eggs.gnu.org ([2001:4830:134:3::10]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwCVS-00005w-S0
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwCVO-0000Fi-0Y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:51:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwCVN-0000FV-NW
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:51:37 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Thu,  6 Apr 2017 11:57:35 -0700
Message-Id: <1491505055-31845-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel]  [PATCH v2] kvmvapic: Enable kvmvapic when necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sferdjao@redhat.com, pbonzini@redhat.com, stefanha@gmail.com, Anthony Xu <anthony.xu@intel.com>

If KVM provides VAPIC, don't set up kvmvapic.

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/intc/apic_common.c | 5 ++++-
 include/sysemu/kvm.h  | 1 +
 kvm-all.c             | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index c3829e3..bf72107 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -317,8 +317,11 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     info = APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
 
-    /* Note: We need at least 1M to map the VAPIC option ROM */
+    /* Note: We need at least 1M to map the VAPIC option ROM,
+       if it is KVM, enable kvmvapic only when KVM doesn't have
+       VAPIC capability                */
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
+        (!kvm_enabled() || (kvm_enabled() && !kvm_has_vapic())) &&
         !hax_enabled() && ram_size >= 1024 * 1024) {
         vapic = sysbus_create_simple("kvmvapic", -1, NULL);
     }
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 24281fc..43e0e4c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -215,6 +215,7 @@ extern KVMState *kvm_state;
 
 bool kvm_has_free_slot(MachineState *ms);
 int kvm_has_sync_mmu(void);
+int kvm_has_vapic(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..c331c8c 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2232,6 +2232,11 @@ int kvm_has_sync_mmu(void)
     return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
 }
 
+int kvm_has_vapic(void)
+{
+    return !kvm_check_extension(kvm_state, KVM_CAP_VAPIC);
+}
+
 int kvm_has_vcpu_events(void)
 {
     return kvm_state->vcpu_events;
-- 
1.8.3.1
