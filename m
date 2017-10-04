Received: from eggs.gnu.org ([2001:4830:134:3::10]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3k-00069M-PA
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3g-0003pz-RS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:50:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dzk3g-0003p1-IT
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Dnb8e085094
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:49:51 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcx4ut8cw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:49:51 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 14:49:49 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 15:49:39 +0200
In-Reply-To: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1507124979-8880-6-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 5/5] s390x/intc: AIS is now always migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Adapter Interrupt Suppression can now be emulated if the host kernel
does not support the FLIC AIS attributes in KVM.

It follows it can always be migrated.

In the case AIS is supported by the kernel at one side of the migration

1) SRC and DST AIS in KVM
All PCI devices can be created on SRC and DST
All PCI devices can migrate

2) SRC and DST AIS NOT in  KVM
Only emulated PCI devices can be used on SRC and DST
Only emulated PCI devices can migrate

3) SRC AIS in KVM DST has NOT AIS in KVM
Only emulated PCI devices can migrate
Only emulated PCI devices can be created on SRC and DST
VFIO PCI devices can be used only on SRC

4) SRC has NOT AIS in KVM DST AIS in KVM
Only emulated PCI devices can migrate
Only emulated PCI devices can be created on SRC and DST
VFIO PCI devices can be used only on DST

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index fd1aa22..6f44b1d 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -457,6 +457,12 @@ static void kvm_flic_ais_pre_save(void *opaque)
         .attr = sizeof(ais),
     };
 
+    if (!flic->parent_obj.ais_supported) {
+        tmp->simm = flic->simm;
+        tmp->nimm = flic->nimm;
+        return;
+    }
+
     if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
         error_report("Failed to retrieve kvm flic ais states");
         return;
@@ -479,14 +485,10 @@ static int kvm_flic_ais_post_load(void *opaque, int version_id)
         .addr = (uint64_t)&ais,
     };
 
-    /* This can happen when the user mis-configures its guests in an
-     * incompatible fashion or without a CPU model. For example using
-     * qemu with -cpu host (which is not migration safe) and do a
-     * migration from a host that has AIS to a host that has no AIS.
-     * In that case the target system will reject the migration here.
-     */
-    if (!ais_needed(flic)) {
-        return -ENOSYS;
+    if (!flic->parent_obj.ais_supported) {
+        flic->simm = tmp->simm;
+        flic->nimm = tmp->nimm;
+        return 0;
     }
 
     return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
-- 
2.3.0
