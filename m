Received: from eggs.gnu.org ([2001:4830:134:3::10]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAgJ-0002kb-5v
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMAgI-0002lW-4p
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:42:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Dec 2017 10:41:40 +0000
Message-Id: <20171205104141.28882-9-stefanha@redhat.com>
In-Reply-To: <20171205104141.28882-1-stefanha@redhat.com>
References: <20171205104141.28882-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] blockdev: add x-blockdev-set-iothread
 testing command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Currently there is no easy way for iotests to ensure that a BDS is bound
to a particular IOThread.  Normally the virtio-blk device calls
blk_set_aio_context() when dataplane is enabled during guest driver
initialization.  This never happens in iotests since -machine
accel=qtest means there is no guest activity (including device driver
initialization).

This patch adds a QMP command to explicitly assign IOThreads in test
cases.  See qapi/block-core.json for a description of the command.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 36 ++++++++++++++++++++++++++++++++++++
 blockdev.c           | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dd763dcf87..d892cc9c78 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3949,3 +3949,39 @@
   'data' : { 'parent': 'str',
              '*child': 'str',
              '*node': 'str' } }
+
+##
+# @x-blockdev-set-iothread:
+#
+# Move @node and its children into the @iothread.  If @iothread is empty then
+# move @node and its children into the main loop.
+#
+# The node must not be attached to a BlockBackend.
+#
+# @node-name: the name of the block driver node
+#
+# @iothread: the name of the IOThread object
+#
+# Note: this command is experimental and intended for test cases that need
+# control over IOThreads only.
+#
+# Since: 2.12
+#
+# Example:
+#
+# 1. Move a node into an IOThread
+# -> { "execute": "x-blockdev-set-iothread",
+#      "arguments": { "node-name": "disk1",
+#                     "iothread": "iothread0" } }
+# <- { "return": {} }
+#
+# 2. Move a node into the main loop
+# -> { "execute": "x-blockdev-set-iothread",
+#      "arguments": { "node-name": "disk1",
+#                     "iothread": "" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'x-blockdev-set-iothread',
+  'data' : { 'node-name': 'str',
+             'iothread': 'str' } }
diff --git a/blockdev.c b/blockdev.c
index e865ae4873..d21faa0b41 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -45,6 +45,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/iothread.h"
 #include "block/block_int.h"
 #include "qmp-commands.h"
 #include "block/trace.h"
@@ -4129,6 +4130,46 @@ BlockJobInfoList *qmp_query_block_jobs(Error **errp)
     return head;
 }
 
+void qmp_x_blockdev_set_iothread(const char *node_name, const char *iothread,
+                                 Error **errp)
+{
+    AioContext *old_context;
+    AioContext *new_context;
+    BlockDriverState *bs;
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Cannot find node %s", node_name);
+        return;
+    }
+
+    /* If we want to allow more extreme test scenarios this guard could be
+     * removed.  For now it protects against accidents. */
+    if (bdrv_has_blk(bs)) {
+        error_setg(errp, "Node %s is in use", node_name);
+        return;
+    }
+
+    if (iothread[0]) {
+        IOThread *obj = iothread_by_id(iothread);
+        if (!obj) {
+            error_setg(errp, "Cannot find iothread %s", iothread);
+            return;
+        }
+
+        new_context = iothread_get_aio_context(obj);
+    } else {
+        new_context = qemu_get_aio_context();
+    }
+
+    old_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(old_context);
+
+    bdrv_set_aio_context(bs, new_context);
+
+    aio_context_release(old_context);
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
-- 
2.14.3
