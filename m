Received: from eggs.gnu.org ([2001:4830:134:3::10]:51843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g0BRP-0006do-TK
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1g0BRL-00023s-IG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1g0BRJ-00022t-QV
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8CK4OU4018160
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:08:39 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mf9h0r5jf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:08:38 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 12 Sep 2018 14:08:38 -0600
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 12 Sep 2018 16:08:15 -0400
In-Reply-To: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1536782900-17656-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 1/6] linux-headers: linux header updates for
 AP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com

Updates the linux header files in preparation for introduction
of the VFIO AP device:

* Added a feature ID to indicate AP facilities are installed

* Added device attributes to the KVM_S390_VM_CRYPTO group
  to indicate whether AP instructions are to be interpreted

* Added VFIO device information for AP devices

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 linux-headers/asm-s390/kvm.h |    3 +++
 linux-headers/linux/vfio.h   |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 1ab9901..b494870 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_AP		14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
@@ -160,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
+#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
 
 /* kvm attributes for migration mode */
 #define KVM_S390_VM_MIGRATION_STOP	0
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3615a26..838919a 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -200,6 +200,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_AP (1 << 5)		/* vfio-ap device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -215,6 +216,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
+#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
1.7.1
