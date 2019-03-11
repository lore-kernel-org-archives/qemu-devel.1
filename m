Received: from eggs.gnu.org ([209.51.188.92]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODF-0006j0-QT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODF-0002nb-4L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODE-0002mw-Sj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id y15so4133155wro.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:05 +0100
Message-Id: <1552323335-46779-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/31] memory: Do not update coalesced IO
 range in the case of NOP
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
