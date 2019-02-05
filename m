Received: from eggs.gnu.org ([209.51.188.92]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gr9YF-0004mN-V7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gr9YF-00046A-6T
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gr9YE-0003zj-As
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:50:47 -0500
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Tue,  5 Feb 2019 17:50:19 -0500
Message-Id: <59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
In-Reply-To: <cover.1549406119.git.jag.raman@oracle.com>
References: <cover.1549406119.git.jag.raman@oracle.com>
In-Reply-To: <cover.1549406119.git.jag.raman@oracle.com>
References: <cover.1549406119.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [PATCH] memory: Do not update coalesced IO range in
 the case of NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Do not add/del coalesced IO ranges in the case where the
same FlatRanges are present in both old and new FlatViews

Fixes: 3ac7d43a6fbb ("memory: update coalesced_range on transaction_commit")
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 61d66e4..e49369d 100644
--- a/memory.c
+++ b/memory.c
@@ -932,9 +932,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
         } else if (frold && frnew && flatrange_equal(frold, frnew)) {
             /* In both and unchanged (except logging may have changed) */
 
-            if (!adding) {
-                flat_range_coalesced_io_del(frold, as);
-            } else {
+            if (adding) {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,
@@ -946,7 +944,6 @@ static void address_space_update_topology_pass(AddressSpace *as,
                                                   frold->dirty_log_mask,
                                                   frnew->dirty_log_mask);
                 }
-                flat_range_coalesced_io_add(frnew, as);
             }
 
             ++iold;
-- 
1.8.3.1
