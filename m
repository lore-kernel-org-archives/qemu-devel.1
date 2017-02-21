Received: from eggs.gnu.org ([2001:4830:134:3::10]:36262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgD57-0004X5-04
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgD53-00066a-Ll
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:14:24 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 21 Feb 2017 18:13:54 +0200
Message-Id: <20170221161354.22204-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] block: Remove unnecessary cases of
 error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

There are several cases of local Error variables that are never used
for checking actual errors:

   ret = some_call(params, &local_err);
   if (ret < 0) {
       error_propagate(errp, local_err);
       goto fail;
   }

In these cases there's no need for local_err or error_propagate(), and
we can use errp directly instead.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c    |  4 +---
 blockdev.c | 53 +++++++++++++++--------------------------------------
 2 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/block.c b/block.c
index 743c349100..86e1023b96 100644
--- a/block.c
+++ b/block.c
@@ -2088,7 +2088,6 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
 {
     int ret = -1;
     BlockReopenQueueEntry *bs_entry, *next;
-    Error *local_err = NULL;
 
     assert(bs_queue != NULL);
 
@@ -2097,8 +2096,7 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
     aio_context_acquire(ctx);
 
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
-        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, &local_err)) {
-            error_propagate(errp, local_err);
+        if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
             goto cleanup;
         }
         bs_entry->prepared = true;
diff --git a/blockdev.c b/blockdev.c
index db82ac97e5..7db8248dad 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2221,7 +2221,6 @@ void qmp_eject(bool has_device, const char *device,
                bool has_id, const char *id,
                bool has_force, bool force, Error **errp)
 {
-    Error *local_err = NULL;
     int rc;
 
     if (!has_force) {
@@ -2230,12 +2229,10 @@ void qmp_eject(bool has_device, const char *device,
 
     rc = do_open_tray(has_device ? device : NULL,
                       has_id ? id : NULL,
-                      force, &local_err);
+                      force, errp);
     if (rc && rc != -ENOSYS) {
-        error_propagate(errp, local_err);
         return;
     }
-    error_free(local_err);
 
     qmp_x_blockdev_remove_medium(has_device, device, has_id, id, errp);
 }
@@ -2324,20 +2321,13 @@ void qmp_blockdev_open_tray(bool has_device, const char *device,
                             bool has_force, bool force,
                             Error **errp)
 {
-    Error *local_err = NULL;
-    int rc;
-
     if (!has_force) {
         force = false;
     }
-    rc = do_open_tray(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      force, &local_err);
-    if (rc && rc != -ENOSYS && rc != -EINPROGRESS) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    error_free(local_err);
+
+    do_open_tray(has_device ? device : NULL,
+                 has_id ? id : NULL,
+                 force, errp);
 }
 
 void qmp_blockdev_close_tray(bool has_device, const char *device,
@@ -2564,13 +2554,10 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
 
     rc = do_open_tray(has_device ? device : NULL,
                       has_id ? id : NULL,
-                      false, &err);
+                      false, errp);
     if (rc && rc != -ENOSYS) {
-        error_propagate(errp, err);
         goto fail;
     }
-    error_free(err);
-    err = NULL;
 
     qmp_x_blockdev_remove_medium(has_device, device, has_id, id, &err);
     if (err) {
@@ -3011,7 +2998,6 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     BlockDriverState *iter;
     BlockDriverState *base_bs, *top_bs;
     AioContext *aio_context;
-    Error *local_err = NULL;
     /* This will be part of the QMP command, if/when the
      * BlockdevOnError change for blkmirror makes it in
      */
@@ -3026,15 +3012,14 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
      *  live commit feature versions; for this to work, we must make sure to
      *  perform the device lookup before any generic errors that may occur in a
      *  scenario in which all optional arguments are omitted. */
-    bs = qmp_get_root_bs(device, &local_err);
+    bs = qmp_get_root_bs(device, errp);
     if (!bs) {
         bs = bdrv_lookup_bs(device, device, NULL);
-        if (!bs) {
-            error_free(local_err);
+        if (!bs && errp) {
+            error_free(*errp);
+            *errp = NULL;
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", device);
-        } else {
-            error_propagate(errp, local_err);
         }
         return;
     }
@@ -3095,7 +3080,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         }
         commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
                             BLOCK_JOB_DEFAULT, speed, on_error, NULL, NULL,
-                            &local_err, false);
+                            errp, false);
     } else {
         BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);
         if (bdrv_op_is_blocked(overlay_bs, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
@@ -3103,11 +3088,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         }
         commit_start(has_job_id ? job_id : NULL, bs, base_bs, top_bs, speed,
                      on_error, has_backing_file ? backing_file : NULL,
-                     &local_err);
-    }
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        goto out;
+                     errp);
     }
 
 out:
@@ -3447,10 +3428,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
             goto out;
         }
 
-        to_replace_bs = check_to_replace_node(bs, arg->replaces, &local_err);
+        to_replace_bs = check_to_replace_node(bs, arg->replaces, errp);
 
         if (!to_replace_bs) {
-            error_propagate(errp, local_err);
             goto out;
         }
 
@@ -3527,9 +3507,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_on_source_error, arg->on_source_error,
                            arg->has_on_target_error, arg->on_target_error,
                            arg->has_unmap, arg->unmap,
-                           &local_err);
+                           errp);
     bdrv_unref(target_bs);
-    error_propagate(errp, local_err);
 out:
     aio_context_release(aio_context);
 }
@@ -3551,7 +3530,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
-    Error *local_err = NULL;
 
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
@@ -3576,8 +3554,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            has_on_source_error, on_source_error,
                            has_on_target_error, on_target_error,
                            true, true,
-                           &local_err);
-    error_propagate(errp, local_err);
+                           errp);
 
     aio_context_release(aio_context);
 }
-- 
2.11.0
