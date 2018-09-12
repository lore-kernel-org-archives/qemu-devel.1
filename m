Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g0BRV-0006jO-OO
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g0BRR-00025i-9C
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1g0BRP-00024X-Tl
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8CJwmMA117383
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:08:47 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mf68egda4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:08:46 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 12 Sep 2018 14:08:46 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 12 Sep 2018 16:08:17 -0400
In-Reply-To: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1536782900-17656-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 3/6] s390x/kvm: enable/disable AP
 instruction interpretation for guest
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

Let's use the KVM_SET_DEVICE_ATTR ioctl to enable or disable
hardware interpretation of AP instructions executed on the guest.
If the S390_FEAT_AP feature is installed, AP instructions will
be interpreted by default; otherwise, they will be intercepted.
This attribute setting may be overridden by a device. For example,
a device may want to provide AP instructions to the guest (i.e.,
S390_FEAT_AP turned on), but it may want to emulate them. In this
case, the AP instructions executed on the guest must be
intercepted; so when the device is realized, it must disable
interpretation.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 target/s390x/kvm.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c4bd84d..28a3900 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2297,6 +2297,19 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
                S390_FEAT_MAX);
 }
 
+static void kvm_s390_configure_apie(int interpret)
+{
+    uint64_t attr = KVM_S390_VM_CRYPTO_DISABLE_APIE;
+
+    if (interpret) {
+        attr = KVM_S390_VM_CRYPTO_ENABLE_APIE;
+    }
+
+    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
+            kvm_s390_set_attr(attr);
+    }
+}
+
 void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
 {
     struct kvm_s390_vm_cpu_processor prop  = {
@@ -2346,6 +2359,9 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (test_bit(S390_FEAT_CMM, model->features)) {
         kvm_s390_enable_cmma();
     }
+
+    /* configure hardware interpretation of AP instructions */
+    kvm_s390_configure_apie(test_bit(S390_FEAT_AP, model->features));
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
1.7.1
