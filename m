Received: from eggs.gnu.org ([2001:4830:134:3::10]:48688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcGc-0002DG-Qw
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewcGY-0000qY-Rl
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:26:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ewcGY-0000lq-Jv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 19:26:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2FNLt5Q060338
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:26:18 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153] (may be
	forged)) by mx0a-001b2d01.pphosted.com with ESMTP id 2gr05pvwvs-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 19:26:17 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 15 Mar 2018 17:25:25 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 19:24:57 -0400
In-Reply-To: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1521156300-19296-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 4/7] s390x/kvm: interface to interpret AP
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

The VFIO AP device exploits interpretive execution of AP
instructions (APIE). APIE is enabled by setting a device attribute
via the KVM_SET_DEVICE_ATTR ioctl.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 target/s390x/kvm.c       |   16 ++++++++++++++++
 target/s390x/kvm_s390x.h |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 33e5ec3..2812e28 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -277,6 +277,22 @@ static void kvm_s390_init_dea_kw(void)
     }
 }
 
+int kvm_s390_set_interpret_ap(uint8_t enable)
+{
+    struct kvm_device_attr attribute = {
+        .group = KVM_S390_VM_CRYPTO,
+        .attr  = KVM_S390_VM_CRYPTO_INTERPRET_AP,
+        .addr = 1,
+    };
+
+    if (!kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
+                           KVM_S390_VM_CRYPTO_INTERPRET_AP)) {
+        return -EOPNOTSUPP;
+    }
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
+}
+
 void kvm_s390_crypto_reset(void)
 {
     if (s390_has_feat(S390_FEAT_MSA_EXT_3)) {
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 34ee7e7..0d6c6e7 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -40,4 +40,6 @@ void kvm_s390_crypto_reset(void);
 void kvm_s390_restart_interrupt(S390CPU *cpu);
 void kvm_s390_stop_interrupt(S390CPU *cpu);
 
+int kvm_s390_set_interpret_ap(uint8_t enable);
+
 #endif /* KVM_S390X_H */
-- 
1.7.1
