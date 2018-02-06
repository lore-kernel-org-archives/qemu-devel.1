Received: from eggs.gnu.org ([2001:4830:134:3::10]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8im-0005ML-RM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ig-0007yX-Gt
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59916
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ig-0007y3-Bj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJjQ126670
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:54 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1f4h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:52 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:51 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:48 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-28-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/54] s390x: fix storage attributes migration
 for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Fix storage attribute migration so that it does not fail for guests
with more than a few GB of RAM.
With such guests, the index in the buffer would go out of bounds,
usually by large amounts, thus receiving -EFAULT from the kernel.
Migration itself would be successful, but storage attributes would then
not be migrated completely.

This patch fixes the out of bounds access, and thus migration of all
storage attributes when the guest have large amounts of memory.

Cc: qemu-stable@nongnu.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
Message-Id: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 46fa893355e0bd88f3c59b886f0d75cbd5f0bbbe)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/s390-stattrib-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 41770a7dec..480551c3db 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -116,7 +116,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
         for (cx = 0; cx + len <= max; cx += len) {
             clog.start_gfn = cx;
             clog.count = len;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
@@ -126,7 +126,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
         if (cx < max) {
             clog.start_gfn = cx;
             clog.count = max - cx;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
-- 
2.11.0
