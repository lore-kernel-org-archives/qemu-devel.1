Received: from eggs.gnu.org ([2001:4830:134:3::10]:43681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvI-0001Bp-Li
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvH-0008OH-CT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:40 +0100
Message-Id: <1487689130-30373-45-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 44/54] mirror: Add filter-node-name to
 blockdev-mirror
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

Management tools need to be able to know about every node in the graph
and need a way to address them. This new option to blockdev-mirror
allows the client to set a node-name for the automatically inserted
filter driver, and at the same time serves as a witness that this
version of qemu does automatically insert a filter driver.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c            | 14 ++++++++------
 blockdev.c                | 12 +++++++++++-
 include/block/block_int.h |  5 ++++-
 qapi/block-core.json      |  8 +++++++-
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 252107d..2e1cd16 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1046,7 +1046,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              void *opaque, Error **errp,
                              const BlockJobDriver *driver,
                              bool is_none_mode, BlockDriverState *base,
-                             bool auto_complete)
+                             bool auto_complete, const char *filter_node_name)
 {
     MirrorBlockJob *s;
     BlockDriverState *mirror_top_bs;
@@ -1071,8 +1071,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes */
-    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, NULL, BDRV_O_RDWR,
-                                         errp);
+    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
+                                         BDRV_O_RDWR, errp);
     if (mirror_top_bs == NULL) {
         return;
     }
@@ -1181,7 +1181,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
-                  bool unmap, Error **errp)
+                  bool unmap, const char *filter_node_name, Error **errp)
 {
     bool is_none_mode;
     BlockDriverState *base;
@@ -1195,7 +1195,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL, errp,
-                     &mirror_job_driver, is_none_mode, base, false);
+                     &mirror_job_driver, is_none_mode, base, false,
+                     filter_node_name);
 }
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1216,7 +1217,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque, &local_err,
-                     &commit_active_job_driver, false, base, auto_complete);
+                     &commit_active_job_driver, false, base, auto_complete,
+                     NULL);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error_restore_flags;
diff --git a/blockdev.c b/blockdev.c
index bcee23e..4314584 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3362,6 +3362,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    bool has_on_target_error,
                                    BlockdevOnError on_target_error,
                                    bool has_unmap, bool unmap,
+                                   bool has_filter_node_name,
+                                   const char *filter_node_name,
                                    Error **errp)
 {
 
@@ -3383,6 +3385,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     if (!has_unmap) {
         unmap = true;
     }
+    if (!has_filter_node_name) {
+        filter_node_name = NULL;
+    }
 
     if (granularity != 0 && (granularity < 512 || granularity > 1048576 * 64)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
@@ -3412,7 +3417,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     mirror_start(job_id, bs, target,
                  has_replaces ? replaces : NULL,
                  speed, granularity, buf_size, sync, backing_mode,
-                 on_source_error, on_target_error, unmap, errp);
+                 on_source_error, on_target_error, unmap, filter_node_name,
+                 errp);
 }
 
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
@@ -3550,6 +3556,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_on_source_error, arg->on_source_error,
                            arg->has_on_target_error, arg->on_target_error,
                            arg->has_unmap, arg->unmap,
+                           false, NULL,
                            &local_err);
     bdrv_unref(target_bs);
     error_propagate(errp, local_err);
@@ -3568,6 +3575,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          BlockdevOnError on_source_error,
                          bool has_on_target_error,
                          BlockdevOnError on_target_error,
+                         bool has_filter_node_name,
+                         const char *filter_node_name,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -3599,6 +3608,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            has_on_source_error, on_source_error,
                            has_on_target_error, on_target_error,
                            true, true,
+                           has_filter_node_name, filter_node_name,
                            &local_err);
     error_propagate(errp, local_err);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5c704b..563b30c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -824,6 +824,9 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @unmap: Whether to unmap target where source sectors only contain zeroes.
+ * @filter_node_name: The node name that should be assigned to the filter
+ * driver that the mirror job inserts into the graph above @bs. NULL means that
+ * a node name should be autogenerated.
  * @errp: Error object.
  *
  * Start a mirroring operation on @bs.  Clusters that are allocated
@@ -837,7 +840,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
-                  bool unmap, Error **errp);
+                  bool unmap, const char *filter_node_name, Error **errp);
 
 /*
  * backup_job_create:
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 932f5bb..893fa34 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1671,6 +1671,11 @@
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
+# @filter-node-name: #optional the node name that should be assigned to the
+#                    filter driver that the mirror job inserts into the graph
+#                    above @device. If this option is not given, a node name is
+#                    autogenerated. (Since: 2.9)
+#
 # Returns: nothing on success.
 #
 # Since: 2.6
@@ -1690,7 +1695,8 @@
             'sync': 'MirrorSyncMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
-            '*on-target-error': 'BlockdevOnError' } }
+            '*on-target-error': 'BlockdevOnError',
+            '*filter-node-name': 'str' } }
 
 ##
 # @block_set_io_throttle:
-- 
1.8.3.1
