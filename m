Received: from eggs.gnu.org ([2001:4830:134:3::10]:41500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7zf-0002br-5z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7ze-0000Ah-80
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:31 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 13 Jun 2018 18:47:11 +0300
Message-Id: <20180613154711.12977-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 2/2] qmp: add block-set-copy-on-read command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

The command enables/disables copy-on-read mode for VM's disk while
VM is running.

This is needed when using external disk readers to shape access pattern
to the disk backend.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 blockdev.c           | 38 ++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 20 ++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 4862323012..4a297dabef 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4276,6 +4276,44 @@ out:
     aio_context_release(aio_context);
 }
 
+void qmp_block_set_copy_on_read(const char *device, bool enable, Error **errp)
+{
+    Error *local_err = NULL;
+    AioContext *aio_context;
+    BlockDriverState *bs = bdrv_lookup_bs(device, device, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    if (enable) {
+        if (bs->open_flags & BDRV_O_COPY_ON_READ) {
+            error_setg(errp, "Can't enable copy-on-read for the device. "
+                             "Copy-on-read is already enabled.");
+        } else {
+            if (bdrv_enable_copy_on_read(bs)) {
+                bs->open_flags |= BDRV_O_COPY_ON_READ;
+            } else {
+                error_setg(errp, "Can't enable copy-on-read. "
+                                 "The device is read-only.");
+            }
+        }
+    } else {
+        if (bs->open_flags & BDRV_O_COPY_ON_READ) {
+            bs->open_flags &= ~BDRV_O_COPY_ON_READ;
+            bdrv_disable_copy_on_read(bs);
+        } else {
+            error_setg(errp, "Can't disable copy-on-read for the device. "
+                             "Copy-on-read is already disabled.");
+        }
+    }
+
+    aio_context_release(aio_context);
+}
+
 static BdrvChild *bdrv_find_child(BlockDriverState *parent_bs,
                                   const char *child_name)
 {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fff23fc82b..7369a13009 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4701,6 +4701,26 @@
 { 'command': 'block-set-write-threshold',
   'data': { 'node-name': 'str', 'write-threshold': 'uint64' } }
 
+##
+# @block-set-copy-on-read:
+#
+# Enables and disables the copy-on-read property of a block device.
+#
+# @device: device or graph node name on which copy-on-read must be set.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "block-set-copy-on-read",
+#      "arguments": { "device": "scsi0-0-0-0",
+#                     "enable": true } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'block-set-copy-on-read',
+  'data': { 'device': 'str', 'enable': 'bool' } }
+
 ##
 # @x-blockdev-change:
 #
-- 
2.17.0
