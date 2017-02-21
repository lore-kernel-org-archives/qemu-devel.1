Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvL-0001Fs-6K
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvH-0008OC-Br
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:39 +0100
Message-Id: <1487689130-30373-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 43/54] stream: Use real permissions in
 streaming block job
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

The correct permissions are relatively obvious here (and explained in
code comments). For intermediate streaming, we need to reopen the top
node read-write before creating the job now because the permissions
system catches attempts to get the BLK_PERM_WRITE_UNCHANGED permission
on a read-only node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index ba8650f..0c30d41 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -229,28 +229,35 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
@@ -260,4 +267,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
