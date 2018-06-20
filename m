Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq2-0004SK-C8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq1-0005hL-BF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Jun 2018 15:07:30 +0200
Message-Id: <1529500053-21704-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 3/6] kvm: add kvm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com

Add the kvm_get_max_vm_phys_shift() helper that returns the
log of the maximum IPA size supported by KVM. This capability
needs to be known to create the VM with a correct IPA max size
(kvm_type passed along KVM_CREATE_VM ioctl.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 accel/kvm/kvm-all.c    | 7 +++++++
 accel/stubs/kvm-stub.c | 5 +++++
 include/sysemu/kvm.h   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0590986..137c38e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -280,6 +280,13 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
     return ret;
 }
 
+int kvm_get_max_vm_phys_shift(MachineState *ms)
+{
+    KVMState *s = KVM_STATE(ms->accelerator);
+
+    return kvm_ioctl(s, KVM_ARM_GET_MAX_VM_PHYS_SHIFT, 0);
+}
+
 int kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 02d5170..7575ba7 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -161,6 +161,11 @@ bool kvm_has_free_slot(MachineState *ms)
     return false;
 }
 
+int kvm_get_max_vm_phys_shift(MachineState *ms)
+{
+    return 0;
+}
+
 void kvm_init_cpu_signals(CPUState *cpu)
 {
     abort();
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 0b64b8e..240e3d9 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -206,6 +206,7 @@ extern KVMState *kvm_state;
 /* external API */
 
 bool kvm_has_free_slot(MachineState *ms);
+int kvm_get_max_vm_phys_shift(MachineState *ms);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
-- 
2.5.5
