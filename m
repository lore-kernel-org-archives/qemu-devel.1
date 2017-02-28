Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWw-0006LR-6i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWt-0007y7-TI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:29 +0100
Message-Id: <1488314205-16264-31-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/46] block: Fix pending requests check in
 bdrv_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

bdrv_append() cares about isolation of the node that it modifies, but
not about activity in some subtree below it. Instead of using the
recursive bdrv_requests_pending(), directly check bs->in_flight, which
considers only the node in question.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 9e538a5..5189c7c 100644
--- a/block.c
+++ b/block.c
@@ -2897,8 +2897,8 @@ static void change_parent_backing_link(BlockDriverState *from,
  */
 void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top)
 {
-    assert(!bdrv_requests_pending(bs_top));
-    assert(!bdrv_requests_pending(bs_new));
+    assert(!atomic_read(&bs_top->in_flight));
+    assert(!atomic_read(&bs_new->in_flight));
 
     bdrv_ref(bs_top);
 
-- 
1.8.3.1
