Received: from eggs.gnu.org ([2001:4830:134:3::10]:58112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aM-0002vu-Rf
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cw4aH-0004GN-Su
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cw4aH-0004G1-I0
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36ANqsb138749
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 06:24:08 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29n1byvg61-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 06:24:08 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 6 Apr 2017 20:24:05 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  6 Apr 2017 15:52:48 +0530
In-Reply-To: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170406102249.20383-3-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v1 2/3] cputlb: handle first atomic write
 to the page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

In case where the conditional write is the first write to the page,
TLB_NOTDIRTY will be set and stop_the_world is triggered. Handle this as
a special case and set the dirty bit. After that fall through to the
actual atomic instruction below.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 cputlb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/cputlb.c b/cputlb.c
index f5d056c..743776a 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -930,7 +930,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         tlb_addr = tlbe->addr_write;
     }
 
-    /* Notice an IO access, or a notdirty page.  */
+    /* Check notdirty */
+    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
+        tlb_set_dirty(ENV_GET_CPU(env), addr);
+        tlb_addr = tlb_addr & ~TLB_NOTDIRTY;
+    }
+
+    /* Notice an IO access  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
-- 
2.9.3
