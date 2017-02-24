Received: from eggs.gnu.org ([2001:4830:134:3::10]:50086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQy-0006aZ-BG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQw-0002ra-05
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:36 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:17:02 +0100
Message-Id: <1487960230-18054-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/19] mirror: Resize active commit base in
 mirror_run()
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

This is more consistent with the commit block job, and it moves the code
to a place where we already have the necessary BlockBackends to resize
the base image when bdrv_truncate() is changed to require a BdrvChild.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ca8547b..3d50857 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -662,7 +662,28 @@ static void coroutine_fn mirror_run(void *opaque)
     if (s->bdev_length < 0) {
         ret = s->bdev_length;
         goto immediate_exit;
-    } else if (s->bdev_length == 0) {
+    }
+
+    /* Active commit must resize the base image if its size differs from the
+     * active layer. */
+    if (s->base == blk_bs(s->target)) {
+        int64_t base_length;
+
+        base_length = blk_getlength(s->target);
+        if (base_length < 0) {
+            ret = base_length;
+            goto immediate_exit;
+        }
+
+        if (s->bdev_length > base_length) {
+            ret = blk_truncate(s->target, s->bdev_length);
+            if (ret < 0) {
+                goto immediate_exit;
+            }
+        }
+    }
+
+    if (s->bdev_length == 0) {
         /* Report BLOCK_JOB_READY and wait for complete. */
         block_job_event_ready(&s->common);
         s->synced = true;
@@ -1063,9 +1084,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockCompletionFunc *cb, void *opaque, Error **errp,
                          bool auto_complete)
 {
-    int64_t length, base_length;
     int orig_base_flags;
-    int ret;
     Error *local_err = NULL;
 
     orig_base_flags = bdrv_get_flags(base);
@@ -1074,31 +1093,6 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    length = bdrv_getlength(bs);
-    if (length < 0) {
-        error_setg_errno(errp, -length,
-                         "Unable to determine length of %s", bs->filename);
-        goto error_restore_flags;
-    }
-
-    base_length = bdrv_getlength(base);
-    if (base_length < 0) {
-        error_setg_errno(errp, -base_length,
-                         "Unable to determine length of %s", base->filename);
-        goto error_restore_flags;
-    }
-
-    if (length > base_length) {
-        ret = bdrv_truncate(base, length);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret,
-                            "Top image %s is larger than base image %s, and "
-                             "resize of base image failed",
-                             bs->filename, base->filename);
-            goto error_restore_flags;
-        }
-    }
-
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque, &local_err,
-- 
1.8.3.1
