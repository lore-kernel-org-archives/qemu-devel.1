Received: from eggs.gnu.org ([2001:4830:134:3::10]:59809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqQWi-0004Hr-P6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 16:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqQWe-0000v5-AD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 16:37:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqQWe-0000ua-1A
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 16:37:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LKSc3G110322
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 16:37:01 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vhuuwv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 16:37:01 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 16:36:59 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:19 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-56-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 55/81] s390x/kvm: fix cmma reset for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We must reset the CMMA states for normal memory (when not on mem path),
but the current code does the opposite. This was unnoticed for some time
as the kernel since 4.6 also had a bug which mostly disabled the paging
optimizations.

Fixes: 07059effd14e ("s390x/kvm: let the CPU model control CMM(A)")
Cc: qemu-stable@nongnu.org # v2.8
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit 0cf4d747cb8d053e6a6161aadfd3531fa1a62be1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target-s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 97afe02..5fc4ed1 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -197,7 +197,7 @@ void kvm_s390_cmma_reset(void)
         .attr = KVM_S390_VM_MEM_CLR_CMMA,
     };
 
-    if (!mem_path || !kvm_s390_cmma_available()) {
+    if (mem_path || !kvm_s390_cmma_available()) {
         return;
     }
 
-- 
2.7.4
