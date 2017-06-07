Received: from eggs.gnu.org ([2001:4830:134:3::10]:53687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6K-0001ya-Kg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6J-0005wL-PW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Jun 2017 19:50:16 +0200
Message-Id: <1496857819-12466-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] commit: Fix use after free in completion
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

The final bdrv_set_backing_hd() could be working on already freed nodes
because the commit job drops its references (through BlockBackends) to
both overlay_bs and top already a bit earlier.

One way to trigger the bug is hot unplugging a disk for which
blockdev_mark_auto_del() cancels the block job.

Fix this by taking BDS-level references while we're still using the
nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index a3028b2..af6fa68 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -89,6 +89,10 @@ static void commit_complete(BlockJob *job, void *opaque)
     int ret = data->ret;
     bool remove_commit_top_bs = false;
 
+    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
+    bdrv_ref(top);
+    bdrv_ref(overlay_bs);
+
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
     blk_unref(s->base);
@@ -124,6 +128,9 @@ static void commit_complete(BlockJob *job, void *opaque)
     if (remove_commit_top_bs) {
         bdrv_set_backing_hd(overlay_bs, top, &error_abort);
     }
+
+    bdrv_unref(overlay_bs);
+    bdrv_unref(top);
 }
 
 static void coroutine_fn commit_run(void *opaque)
-- 
1.8.3.1
