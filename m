Received: from eggs.gnu.org ([2001:4830:134:3::10]:45474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuGD-0000xV-2y
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuGB-0007er-Cn
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 12 Oct 2018 12:00:57 +0200
Message-Id: <20181012100101.29058-5-cohuck@redhat.com>
In-Reply-To: <20181012100101.29058-1-cohuck@redhat.com>
References: <20181012100101.29058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] s390x/kvm: enable AP instruction
 interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Let's use the KVM_SET_DEVICE_ATTR ioctl to enable hardware
interpretation of AP instructions executed on the guest.
If the S390_FEAT_AP feature is switched on for the guest,
AP instructions must be interpreted by default; otherwise,
they will be intercepted.

This attribute setting may be overridden by a device. For example,
a device may want to provide AP instructions to the guest (i.e.,
S390_FEAT_AP turned on), but it may want to emulate them. In this
case, the AP instructions executed on the guest must be
intercepted; so when the device is realized, it must disable
interpretation.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20181010170309.12045-4-akrowiak@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 78d39b34d0..2ebf26adfe 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2299,11 +2299,26 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         error_setg(errp, "KVM: host CPU model could not be identified");
         return;
     }
+    /* for now, we can only provide the AP feature with HW support */
+    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
+        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
+        set_bit(S390_FEAT_AP, model->features);
+    }
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
 }
 
+static void kvm_s390_configure_apie(bool interpret)
+{
+    uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
+                                KVM_S390_VM_CRYPTO_DISABLE_APIE;
+
+    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
+        kvm_s390_set_attr(attr);
+    }
+}
+
 void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
 {
     struct kvm_s390_vm_cpu_processor prop  = {
@@ -2353,6 +2368,10 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (test_bit(S390_FEAT_CMM, model->features)) {
         kvm_s390_enable_cmma();
     }
+
+    if (test_bit(S390_FEAT_AP, model->features)) {
+        kvm_s390_configure_apie(true);
+    }
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
2.14.4
