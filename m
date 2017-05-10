Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcn-0002QQ-Pf
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcm-0007nL-S2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:00:56 +1000
Message-Id: <20170510070115.13063-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/22] cputlb: handle first atomic write to the
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

In case where the conditional write is the first write to the page,
TLB_NOTDIRTY will be set and stop_the_world is triggered. Handle this as
a special case and set the dirty bit. After that fall through to the
actual atomic instruction below.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
