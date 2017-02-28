Received: from eggs.gnu.org ([2001:4830:134:3::10]:45554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioX6-0006XD-Jl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioX5-00083h-Ag
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:34 +0100
Message-Id: <1488314205-16264-36-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 35/46] stream: Use real permissions in streaming
 block job
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

The correct permissions are relatively obvious here (and explained in
code comments). For intermediate streaming, we need to reopen the top
node read-write before creating the job now because the permissions
system catches attempts to get the BLK_PERM_WRITE_UNCHANGED permission
on a read-only node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block/stream.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index ba8650f..b9c2f43 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -84,6 +84,8 @@ static void stream_complete(BlockJob *job, void *opaque)
 
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_flags != bdrv_get_flags(bs)) {
+        /* Give up write permissions before making it read-only */
+        blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
         bdrv_reopen(bs, s->bs_flags, NULL);
     }
 
@@ -229,28 +231,35 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     int orig_bs_flags;
 
-    /* FIXME Use real permissions */
-    s = block_job_create(job_id, &stream_job_driver, bs, 0, BLK_PERM_ALL,
-                         speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
-    if (!s) {
-        return;
-    }
-
     /* Make sure that the image is opened in read-write mode */
     orig_bs_flags = bdrv_get_flags(bs);
     if (!(orig_bs_flags & BDRV_O_RDWR)) {
         if (bdrv_reopen(bs, orig_bs_flags | BDRV_O_RDWR, errp) != 0) {
-            block_job_unref(&s->common);
             return;
         }
     }
 
-    /* Block all intermediate nodes between bs and base, because they
-     * will disappear from the chain after this operation */
+    /* Prevent concurrent jobs trying to modify the graph structure here, we
+     * already have our own plans. Also don't allow resize as the image size is
+     * queried only at the job start and then cached. */
+    s = block_job_create(job_id, &stream_job_driver, bs,
+                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                         BLK_PERM_GRAPH_MOD,
+                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                         BLK_PERM_WRITE,
+                         speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
+    if (!s) {
+        goto fail;
+    }
+
+    /* Block all intermediate nodes between bs and base, because they will
+     * disappear from the chain after this operation. The streaming job reads
+     * every block only once, assuming that it doesn't change, so block writes
+     * and resizes. */
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
-        /* FIXME Use real permissions */
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_ALL, &error_abort);
+                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
+                           &error_abort);
     }
 
     s->base = base;
@@ -260,4 +269,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
     block_job_start(&s->common);
+    return;
+
+fail:
+    if (orig_bs_flags != bdrv_get_flags(bs)) {
+        bdrv_reopen(bs, s->bs_flags, NULL);
+    }
 }
-- 
1.8.3.1
