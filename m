Received: from eggs.gnu.org ([2001:4830:134:3::10]:54715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g9wBa-0007kh-9v
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g9wBX-00036v-UE
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1g9wBX-00036P-I5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:52:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w99HiYUg069474
	for <qemu-devel@nongnu.org>; Tue, 9 Oct 2018 13:52:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n0x6q05xm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 13:52:42 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 9 Oct 2018 13:52:41 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue,  9 Oct 2018 13:52:23 -0400
In-Reply-To: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181009175226.22138-4-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v10 3/6] s390x/kvm: enable AP instruction
 interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

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
Tested-by: Pierre Morel<pmorel@linux.ibm.com>
---
 target/s390x/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 348e8cc5467a..d042deed1af3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2291,11 +2291,26 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
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
@@ -2345,6 +2360,10 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
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
2.19.0.221.g150f307
