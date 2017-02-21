Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBv8-0000xN-JF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBv7-0008EL-Tr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:35 +0100
Message-Id: <1487689130-30373-40-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 39/54] block: Fix pending requests check in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

bdrv_append() cares about isolation of the node that it modifies, but
not about activity in some subtree below it. Instead of using the
recursive bdrv_requests_pending(), directly check bs->in_flight, which
considers only the node in question.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index c7c0a8b..a800e81 100644
--- a/block.c
+++ b/block.c
@@ -2874,8 +2874,8 @@ static void change_parent_backing_link(BlockDriverState *from,
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
