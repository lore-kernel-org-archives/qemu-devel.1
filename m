Received: from eggs.gnu.org ([2001:4830:134:3::10]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth7-0004kt-7P
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth4-0001M4-WD
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:48 -0400
Message-Id: <20180807043349.27196-21-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 20/21] qapi/block-mirror: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 14 ++++++++++++++
 qapi/block-core.json |  6 ++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 8efc47e178..bbb3279020 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3707,6 +3707,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    bool has_filter_node_name,
                                    const char *filter_node_name,
                                    bool has_copy_mode, MirrorCopyMode copy_mode,
+                                   bool has_auto_finalize, bool auto_finalize,
+                                   bool has_auto_dismiss, bool auto_dismiss,
                                    Error **errp)
 {
     int job_flags = JOB_DEFAULT;
@@ -3735,6 +3737,12 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
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
@@ -3912,6 +3920,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
                            arg->has_unmap, arg->unmap,
                            false, NULL,
                            arg->has_copy_mode, arg->copy_mode,
+                           arg->has_auto_finalize, arg->auto_finalize,
+                           arg->has_auto_dismiss, arg->auto_dismiss,
                            &local_err);
     bdrv_unref(target_bs);
     error_propagate(errp, local_err);
@@ -3933,6 +3943,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          bool has_filter_node_name,
                          const char *filter_node_name,
                          bool has_copy_mode, MirrorCopyMode copy_mode,
+                         bool has_auto_finalize, bool auto_finalize,
+                         bool has_auto_dismiss, bool auto_dismiss,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -3966,6 +3978,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            true, true,
                            has_filter_node_name, filter_node_name,
                            has_copy_mode, copy_mode,
+                           has_auto_finalize, auto_finalize,
+                           has_auto_dismiss, auto_dismiss,
                            &local_err);
     error_propagate(errp, local_err);
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4ee58cfb28..bc53eaf2c0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1728,7 +1728,8 @@
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-            '*unmap': 'bool', '*copy-mode': 'MirrorCopyMode' } }
+            '*unmap': 'bool', '*copy-mode': 'MirrorCopyMode',
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
 
 ##
 # @BlockDirtyBitmap:
@@ -2015,7 +2016,8 @@
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
