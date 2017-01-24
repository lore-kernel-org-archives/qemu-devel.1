Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2iB-0001xh-VF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2i1-0002rs-Ku
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47189
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cW2i1-0002rF-FJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OEnRsF056400
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2865sjamus-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:32 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 24 Jan 2017 15:08:31 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 24 Jan 2017 16:08:23 +0100
In-Reply-To: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
References: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
Message-Id: <20170124150823.30162-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/2] s390x/kvm: fix cmma reset for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We must reset the CMMA states for normal memory (when not on mem path),
but the current code does the opposite. This was unnoticed for some time
as the kernel since 4.6 also had a bug which mostly disabled the paging
optimizations.

Fixes: 07059effd14e ("s390x/kvm: let the CPU model control CMM(A)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 5ad0acbc82..6ed387671e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -197,7 +197,7 @@ void kvm_s390_cmma_reset(void)
         .attr = KVM_S390_VM_MEM_CLR_CMMA,
     };
 
-    if (!mem_path || !kvm_s390_cmma_available()) {
+    if (mem_path || !kvm_s390_cmma_available()) {
         return;
     }
 
-- 
2.11.0
