Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpt-0004oM-UV
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEps-0001l4-S5
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:53 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  4 Sep 2018 13:09:28 -0400
Message-Id: <20180904170930.28619-14-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-1-jsnow@redhat.com>
References: <20180904170930.28619-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/15] qapi/block-mirror: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c           | 14 ++++++++++++++
 qapi/block-core.json | 30 ++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 98b91e75a7..429cdf9901 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3597,6 +3597,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    bool has_filter_node_name,
                                    const char *filter_node_name,
                                    bool has_copy_mode, MirrorCopyMode copy_mode,
+                                   bool has_auto_finalize, bool auto_finalize,
+                                   bool has_auto_dismiss, bool auto_dismiss,
                                    Error **errp)
 {
     int job_flags = JOB_DEFAULT;
@@ -3625,6 +3627,12 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     if (!has_copy_mode) {
         copy_mode = MIRROR_COPY_MODE_BACKGROUND;
     }
+    if (has_auto_finalize && !auto_finalize) {
+        job_flags |= JOB_MANUAL_FINALIZE;
+    }
+    if (has_auto_dismiss && !auto_dismiss) {
+        job_flags |= JOB_MANUAL_DISMISS;
+    }
 
     if (granularity != 0 && (granularity < 512 || granularity > 1048576 * 64)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
@@ -3802,6 +3810,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_unmap, arg->unmap,
                            false, NULL,
                            arg->has_copy_mode, arg->copy_mode,
+                           arg->has_auto_finalize, arg->auto_finalize,
+                           arg->has_auto_dismiss, arg->auto_dismiss,
                            &local_err);
     bdrv_unref(target_bs);
     error_propagate(errp, local_err);
@@ -3823,6 +3833,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          bool has_filter_node_name,
                          const char *filter_node_name,
                          bool has_copy_mode, MirrorCopyMode copy_mode,
+                         bool has_auto_finalize, bool auto_finalize,
+                         bool has_auto_dismiss, bool auto_dismiss,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -3856,6 +3868,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            true, true,
                            has_filter_node_name, filter_node_name,
                            has_copy_mode, copy_mode,
+                           has_auto_finalize, auto_finalize,
+                           has_auto_dismiss, auto_dismiss,
                            &local_err);
     error_propagate(errp, local_err);
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d5b62e50d7..e785c2e9fe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1729,6 +1729,18 @@
 # @copy-mode: when to copy data to the destination; defaults to 'background'
 #             (Since: 3.0)
 #
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
+#                 Defaults to true. (Since 3.1)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completely ceased all work, and awaits @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true. (Since 3.1)
 # Since: 1.3
 ##
 { 'struct': 'DriveMirror',
@@ -1738,7 +1750,8 @@
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*unmap': 'bool', '*copy-mode': 'MirrorCopyMode' } }
+            '*unmap': 'bool', '*copy-mode': 'MirrorCopyMode',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @BlockDirtyBitmap:
@@ -2004,6 +2017,18 @@
 # @copy-mode: when to copy data to the destination; defaults to 'background'
 #             (Since: 3.0)
 #
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
+#                 Defaults to true. (Since 3.1)
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completely ceased all work, and awaits @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true. (Since 3.1)
 # Returns: nothing on success.
 #
 # Since: 2.6
@@ -2025,7 +2050,8 @@
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
-            '*copy-mode': 'MirrorCopyMode' } }
+            '*copy-mode': 'MirrorCopyMode',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @block_set_io_throttle:
-- 
2.14.4
