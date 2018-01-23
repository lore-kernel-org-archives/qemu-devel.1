Received: from eggs.gnu.org ([2001:4830:134:3::10]:57631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9g-0003Pd-FZ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9f-0005oh-6a
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:40 +0100
Message-Id: <20180123140201.31163-9-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/29] blockdev: Drop BD-{remove,
 insert}-medium's @device
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

From: Max Reitz <mreitz@redhat.com>

This is an incompatible change, which is fine as the commands are
experimental.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171110224302.14424-4-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 10 ++--------
 blockdev.c           | 30 +++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a6881b2..d1df47de26 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3411,8 +3411,6 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no-op.
 #
-# @device: Block device name (deprecated, use @id instead)
-#
 # @id:     The name or QOM path of the guest device (since: 2.8)
 #
 # Note: This command is still a work in progress and is considered experimental.
@@ -3447,8 +3445,7 @@
 #
 ##
 { 'command': 'x-blockdev-remove-medium',
-  'data': { '*device': 'str',
-            '*id': 'str' } }
+  'data': { 'id': 'str' } }
 
 ##
 # @x-blockdev-insert-medium:
@@ -3457,8 +3454,6 @@
 # device's tray must currently be open (unless there is no attached guest
 # device) and there must be no medium inserted already.
 #
-# @device:    Block device name (deprecated, use @id instead)
-#
 # @id:        The name or QOM path of the guest device (since: 2.8)
 #
 # @node-name: name of a node in the block driver state graph
@@ -3486,8 +3481,7 @@
 #
 ##
 { 'command': 'x-blockdev-insert-medium',
-  'data': { '*device': 'str',
-            '*id': 'str',
+  'data': { 'id': 'str',
             'node-name': 'str'} }
 
 
diff --git a/blockdev.c b/blockdev.c
index 29d569a24e..2f9aef4167 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -60,6 +60,11 @@ static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
 
 static int do_open_tray(const char *blk_name, const char *qdev_id,
                         bool force, Error **errp);
+static void blockdev_remove_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id, Error **errp);
+static void blockdev_insert_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id,
+                                   const char *node_name, Error **errp);
 
 static const char *const if_name[IF_COUNT] = {
     [IF_NONE] = "none",
@@ -2323,7 +2328,7 @@ void qmp_eject(bool has_device, const char *device,
     }
     error_free(local_err);
 
-    qmp_x_blockdev_remove_medium(has_device, device, has_id, id, errp);
+    blockdev_remove_medium(has_device, device, has_id, id, errp);
 }
 
 void qmp_block_passwd(bool has_device, const char *device,
@@ -2446,8 +2451,8 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
     }
 }
 
-void qmp_x_blockdev_remove_medium(bool has_device, const char *device,
-                                  bool has_id, const char *id, Error **errp)
+static void blockdev_remove_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id, Error **errp)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -2503,6 +2508,11 @@ out:
     aio_context_release(aio_context);
 }
 
+void qmp_x_blockdev_remove_medium(const char *id, Error **errp)
+{
+    blockdev_remove_medium(false, NULL, true, id, errp);
+}
+
 static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
@@ -2548,9 +2558,9 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
     }
 }
 
-void qmp_x_blockdev_insert_medium(bool has_device, const char *device,
-                                  bool has_id, const char *id,
-                                  const char *node_name, Error **errp)
+static void blockdev_insert_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id,
+                                   const char *node_name, Error **errp)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -2576,6 +2586,12 @@ void qmp_x_blockdev_insert_medium(bool has_device, const char *device,
     qmp_blockdev_insert_anon_medium(blk, bs, errp);
 }
 
+void qmp_x_blockdev_insert_medium(const char *id, const char *node_name,
+                                  Error **errp)
+{
+    blockdev_insert_medium(false, NULL, true, id, node_name, errp);
+}
+
 void qmp_blockdev_change_medium(bool has_device, const char *device,
                                 bool has_id, const char *id,
                                 const char *filename,
@@ -2650,7 +2666,7 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
     error_free(err);
     err = NULL;
 
-    qmp_x_blockdev_remove_medium(has_device, device, has_id, id, &err);
+    blockdev_remove_medium(has_device, device, has_id, id, &err);
     if (err) {
         error_propagate(errp, err);
         goto fail;
-- 
2.13.6
