Received: from eggs.gnu.org ([2001:4830:134:3::10]:45617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioXA-0006bA-07
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioX8-00085M-AN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:36 +0100
Message-Id: <1488314205-16264-38-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 37/46] commit: Add filter-node-name to
 block-commit
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

Management tools need to be able to know about every node in the graph
and need a way to address them. Changing the graph structure was okay
because libvirt doesn't really manage the node level yet, but future
libvirt versions need to deal with both new and old version of qemu.

This new option to blockdev-commit allows the client to set a node-name
for the automatically inserted filter driver, and at the same time
serves as a witness for a future libvirt that this version of qemu does
automatically insert a filter driver.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c            |  5 +++--
 block/mirror.c            |  3 ++-
 block/replication.c       |  2 +-
 blockdev.c                | 10 +++++++---
 include/block/block_int.h | 13 ++++++++++---
 qapi/block-core.json      |  8 +++++++-
 qemu-img.c                |  4 ++--
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index f18026b..1e0f531 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -257,7 +257,7 @@ static BlockDriver bdrv_commit_top = {
 void commit_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, BlockDriverState *top, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
-                  Error **errp)
+                  const char *filter_node_name, Error **errp)
 {
     CommitBlockJob *s;
     BlockReopenQueue *reopen_queue = NULL;
@@ -310,7 +310,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     /* Insert commit_top block node above top, so we can block consistent read
      * on the backing chain below it */
-    commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, 0, errp);
+    commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, filter_node_name, 0,
+                                         errp);
     if (commit_top_bs == NULL) {
         goto fail;
     }
diff --git a/block/mirror.c b/block/mirror.c
index f6d988d..869212d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1246,6 +1246,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
 void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockDriverState *base, int creation_flags,
                          int64_t speed, BlockdevOnError on_error,
+                         const char *filter_node_name,
                          BlockCompletionFunc *cb, void *opaque, Error **errp,
                          bool auto_complete)
 {
@@ -1262,7 +1263,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque, &local_err,
                      &commit_active_job_driver, false, base, auto_complete,
-                     NULL);
+                     filter_node_name);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
diff --git a/block/replication.c b/block/replication.c
index 91465cb..22f170f 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -644,7 +644,7 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
         s->replication_state = BLOCK_REPLICATION_FAILOVER;
         commit_active_start(NULL, s->active_disk->bs, s->secondary_disk->bs,
                             BLOCK_JOB_INTERNAL, 0, BLOCKDEV_ON_ERROR_REPORT,
-                            replication_done, bs, errp, true);
+                            NULL, replication_done, bs, errp, true);
         break;
     default:
         aio_context_release(aio_context);
diff --git a/blockdev.c b/blockdev.c
index e592180..ff781d9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3032,6 +3032,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
                       bool has_top, const char *top,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
+                      bool has_filter_node_name, const char *filter_node_name,
                       Error **errp)
 {
     BlockDriverState *bs;
@@ -3047,6 +3048,9 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     if (!has_speed) {
         speed = 0;
     }
+    if (!has_filter_node_name) {
+        filter_node_name = NULL;
+    }
 
     /* Important Note:
      *  libvirt relies on the DeviceNotFound error class in order to probe for
@@ -3121,8 +3125,8 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
             goto out;
         }
         commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
-                            BLOCK_JOB_DEFAULT, speed, on_error, NULL, NULL,
-                            &local_err, false);
+                            BLOCK_JOB_DEFAULT, speed, on_error,
+                            filter_node_name, NULL, NULL, &local_err, false);
     } else {
         BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);
         if (bdrv_op_is_blocked(overlay_bs, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
@@ -3130,7 +3134,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         }
         commit_start(has_job_id ? job_id : NULL, bs, base_bs, top_bs, speed,
                      on_error, has_backing_file ? backing_file : NULL,
-                     &local_err);
+                     filter_node_name, &local_err);
     }
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 563b30c..a57c0bf 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -780,13 +780,16 @@ void stream_start(const char *job_id, BlockDriverState *bs,
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
  * @backing_file_str: String to use as the backing file in @top's overlay
+ * @filter_node_name: The node name that should be assigned to the filter
+ * driver that the commit job inserts into the graph above @top. NULL means
+ * that a node name should be autogenerated.
  * @errp: Error object.
  *
  */
 void commit_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, BlockDriverState *top, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
-                  Error **errp);
+                  const char *filter_node_name, Error **errp);
 /**
  * commit_active_start:
  * @job_id: The id of the newly-created job, or %NULL to use the
@@ -797,6 +800,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
  *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
+ * @filter_node_name: The node name that should be assigned to the filter
+ * driver that the commit job inserts into the graph above @bs. NULL means that
+ * a node name should be autogenerated.
  * @cb: Completion function for the job.
  * @opaque: Opaque pointer value passed to @cb.
  * @errp: Error object.
@@ -806,8 +812,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 void commit_active_start(const char *job_id, BlockDriverState *bs,
                          BlockDriverState *base, int creation_flags,
                          int64_t speed, BlockdevOnError on_error,
-                         BlockCompletionFunc *cb,
-                         void *opaque, Error **errp, bool auto_complete);
+                         const char *filter_node_name,
+                         BlockCompletionFunc *cb, void *opaque, Error **errp,
+                         bool auto_complete);
 /*
  * mirror_start:
  * @job_id: The id of the newly-created job, or %NULL to use the
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f0fa34c..5cc992f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1304,6 +1304,11 @@
 #
 # @speed:  #optional the maximum speed, in bytes per second
 #
+# @filter-node-name: #optional the node name that should be assigned to the
+#                    filter driver that the commit job inserts into the graph
+#                    above @top. If this option is not given, a node name is
+#                    autogenerated. (Since: 2.9)
+#
 # Returns: Nothing on success
 #          If commit or stream is already active on this device, DeviceInUse
 #          If @device does not exist, DeviceNotFound
@@ -1323,7 +1328,8 @@
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
-            '*backing-file': 'str', '*speed': 'int' } }
+            '*backing-file': 'str', '*speed': 'int',
+            '*filter-node-name': 'str' } }
 
 ##
 # @drive-backup:
diff --git a/qemu-img.c b/qemu-img.c
index 0c76d4c..98b836b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -958,8 +958,8 @@ static int img_commit(int argc, char **argv)
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
     commit_active_start("commit", bs, base_bs, BLOCK_JOB_DEFAULT, 0,
-                        BLOCKDEV_ON_ERROR_REPORT, common_block_job_cb, &cbi,
-                        &local_err, false);
+                        BLOCKDEV_ON_ERROR_REPORT, NULL, common_block_job_cb,
+                        &cbi, &local_err, false);
     aio_context_release(aio_context);
     if (local_err) {
         goto done;
-- 
1.8.3.1
