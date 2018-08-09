Received: from eggs.gnu.org ([2001:4830:134:3::10]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSp-0007tJ-8Y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSo-0002XQ-DE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:27 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:08 +0200
Message-Id: <20180809223117.7846-3-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/11] blockdev: Check @replaces in
 blockdev_mirror_common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

There is no reason why the constraints we put on @replaces should be
limited to drive-mirror.  Therefore, move the sanity checks from
qmp_drive_mirror() to blockdev_mirror_common() so they apply to
blockdev-mirror as well.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 55 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9b143d9e72..2d61588a9a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3644,6 +3644,39 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
+    if (has_replaces) {
+        BlockDriverState *to_replace_bs;
+        AioContext *replace_aio_context;
+        int64_t bs_size, replace_size;
+
+        bs_size = bdrv_getlength(bs);
+        if (bs_size < 0) {
+            error_setg_errno(errp, -bs_size, "Failed to query device's size");
+            return;
+        }
+
+        to_replace_bs = check_to_replace_node(bs, replaces, errp);
+        if (!to_replace_bs) {
+            return;
+        }
+
+        replace_aio_context = bdrv_get_aio_context(to_replace_bs);
+        aio_context_acquire(replace_aio_context);
+        replace_size = bdrv_getlength(to_replace_bs);
+        aio_context_release(replace_aio_context);
+
+        if (replace_size < 0) {
+            error_setg_errno(errp, -replace_size,
+                             "Failed to query the replacement node's size");
+            return;
+        }
+        if (bs_size != replace_size) {
+            error_setg(errp, "cannot replace image with a mirror image of "
+                             "different size");
+            return;
+        }
+    }
+
     /* pass the node name to replace to mirror start since it's loose coupling
      * and will allow to check whether the node still exist at mirror completion
      */
@@ -3704,33 +3737,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }
 
     if (arg->has_replaces) {
-        BlockDriverState *to_replace_bs;
-        AioContext *replace_aio_context;
-        int64_t replace_size;
-
         if (!arg->has_node_name) {
             error_setg(errp, "a node-name must be provided when replacing a"
                              " named node of the graph");
             goto out;
         }
-
-        to_replace_bs = check_to_replace_node(bs, arg->replaces, &local_err);
-
-        if (!to_replace_bs) {
-            error_propagate(errp, local_err);
-            goto out;
-        }
-
-        replace_aio_context = bdrv_get_aio_context(to_replace_bs);
-        aio_context_acquire(replace_aio_context);
-        replace_size = bdrv_getlength(to_replace_bs);
-        aio_context_release(replace_aio_context);
-
-        if (size != replace_size) {
-            error_setg(errp, "cannot replace image with a mirror image of "
-                             "different size");
-            goto out;
-        }
     }
 
     if (arg->mode == NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
-- 
2.17.1
