Received: from eggs.gnu.org ([2001:4830:134:3::10]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1le-0003ZB-Ib
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lb-0002X7-Tp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:24:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:50 +0100
Message-Id: <20171221142251.18366-19-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/19] commit: Simplify reopen of base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Since commit bde70715, base is the only node that is reopened in
commit_start(). This means that the code, which still involves an
explicit BlockReopenQueue, can now be simplified by using bdrv_reopen().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index c5327551ce..bb6c904704 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -277,7 +277,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                   const char *filter_node_name, Error **errp)
 {
     CommitBlockJob *s;
-    BlockReopenQueue *reopen_queue = NULL;
     int orig_base_flags;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs = NULL;
@@ -299,12 +298,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     /* convert base to r/w, if necessary */
     orig_base_flags = bdrv_get_flags(base);
     if (!(orig_base_flags & BDRV_O_RDWR)) {
-        reopen_queue = bdrv_reopen_queue(reopen_queue, base, NULL,
-                                         orig_base_flags | BDRV_O_RDWR);
-    }
-
-    if (reopen_queue) {
-        bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
+        bdrv_reopen(base, orig_base_flags | BDRV_O_RDWR, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             goto fail;
-- 
2.13.6
