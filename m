Received: from eggs.gnu.org ([209.51.188.92]:47198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wia-0003qU-9q
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2WiX-0000NQ-4G
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WiV-0000JY-SO
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id d17so23651006wre.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:54 +0100
Message-Id: <1552117698-12355-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/25] memory: Do not update coalesced IO range
 in the case of NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jagannathan Raman <jag.raman@oracle.com>

From: Jagannathan Raman <jag.raman@oracle.com>

Do not add/del coalesced IO ranges in the case where the
same FlatRanges are present in both old and new FlatViews

Fixes: 3ac7d43a6fbb ("memory: update coalesced_range on transaction_commit")
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Message-Id: <59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
