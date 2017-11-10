Received: from eggs.gnu.org ([2001:4830:134:3::10]:52814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI1F-0006mt-Vx
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI1E-0000pV-Ti
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:26 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:43:01 +0100
Message-Id: <20171110224302.14424-4-mreitz@redhat.com>
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
References: <20171110224302.14424-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 3/4] blockdev: Drop BD-{remove,
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

This is an incompatible change, which is fine as the commands are
experimental.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 10 ++--------
 blockdev.c           | 30 +++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 76bf50f813..cf3f941999 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3405,8 +3405,6 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no-op.
 #
-# @device: Block device name (deprecated, use @id instead)
-#
 # @id:     The name or QOM path of the guest device (since: 2.8)
 #
 # Note: This command is still a work in progress and is considered experimental.
@@ -3441,8 +3439,7 @@
 #
 ##
 { 'command': 'x-blockdev-remove-medium',
-  'data': { '*device': 'str',
-            '*id': 'str' } }
+  'data': { 'id': 'str' } }
 
 ##
 # @x-blockdev-insert-medium:
@@ -3451,8 +3448,6 @@
 # device's tray must currently be open (unless there is no attached guest
 # device) and there must be no medium inserted already.
 #
-# @device:    Block device name (deprecated, use @id instead)
-#
 # @id:        The name or QOM path of the guest device (since: 2.8)
 #
 # @node-name: name of a node in the block driver state graph
@@ -3480,8 +3475,7 @@
 #
 ##
 { 'command': 'x-blockdev-insert-medium',
-  'data': { '*device': 'str',
-            '*id': 'str',
+  'data': { 'id': 'str',
             'node-name': 'str'} }
 
 
diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..a74224e8f8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -59,6 +59,11 @@ static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
 
 static int do_open_tray(const char *blk_name, const char *qdev_id,
                         bool force, Error **errp);
+static void blockdev_remove_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id, Error **errp);
+static void blockdev_insert_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id,
+                                   const char *node_name, Error **errp);
 
 static const char *const if_name[IF_COUNT] = {
     [IF_NONE] = "none",
@@ -2256,7 +2261,7 @@ void qmp_eject(bool has_device, const char *device,
     }
     error_free(local_err);
 
-    qmp_x_blockdev_remove_medium(has_device, device, has_id, id, errp);
+    blockdev_remove_medium(has_device, device, has_id, id, errp);
 }
 
 void qmp_block_passwd(bool has_device, const char *device,
@@ -2379,8 +2384,8 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
     }
 }
 
-void qmp_x_blockdev_remove_medium(bool has_device, const char *device,
-                                  bool has_id, const char *id, Error **errp)
+static void blockdev_remove_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id, Error **errp)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -2436,6 +2441,11 @@ out:
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
@@ -2481,9 +2491,9 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
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
@@ -2509,6 +2519,12 @@ void qmp_x_blockdev_insert_medium(bool has_device, const char *device,
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
@@ -2583,7 +2599,7 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
     error_free(err);
     err = NULL;
 
-    qmp_x_blockdev_remove_medium(has_device, device, has_id, id, &err);
+    blockdev_remove_medium(has_device, device, has_id, id, &err);
     if (err) {
         error_propagate(errp, err);
         goto fail;
-- 
2.13.6
