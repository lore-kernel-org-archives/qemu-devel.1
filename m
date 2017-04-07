Received: from eggs.gnu.org ([2001:4830:134:3::10]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN4w-0005eR-Q4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwN4u-0000zT-Fl
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51591
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwN4u-0000zD-9x
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:09:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3763xdM016699
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 02:08:59 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29p0sybyde-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 02:08:59 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 16:08:56 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  7 Apr 2017 11:37:51 +0530
In-Reply-To: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
Message-Id: <20170407060752.31313-3-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/3] cputlb: handle first atomic write to
 the page
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
