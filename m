Received: from eggs.gnu.org ([2001:4830:134:3::10]:35854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1esrgT-00032Q-Ti
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1esrgS-0003xJ-Po
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:05:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Mar 2018 16:05:29 +0100
Message-Id: <20180305150529.11203-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Fix NULL dereference on empty drive
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

blk_error_action() sends a BLOCK_IO_ERROR QMP event which includes the
node name of its root node. If the BlockBackend represents an empty
drive, there is no root node, so we should not try to access its node
name. Make the field optional in the event and include it only when
the BlockBackend isn't empty.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---

Stefan, this is needed for your patch that reverts the workaround in the
IDE flush code. Without it, make check seems to succeed, but if you look
closer, qemu actually segfaults.

qapi/block-core.json  | 6 ++++--
 block/block-backend.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5c5921bfb7..00475f08d4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3676,7 +3676,8 @@
 #
 # @node-name: node name. Note that errors may be reported for the root node
 #             that is directly attached to a guest device rather than for the
-#             node where the error occurred. (Since: 2.8)
+#             node where the error occurred. The node name is not present if
+#             the drive is empty. (Since: 2.8)
 #
 # @operation: I/O operation
 #
@@ -3707,7 +3708,8 @@
 #
 ##
 { 'event': 'BLOCK_IO_ERROR',
-  'data': { 'device': 'str', 'node-name': 'str', 'operation': 'IoOperationType',
+  'data': { 'device': 'str', '*node-name': 'str',
+            'operation': 'IoOperationType',
             'action': 'BlockErrorAction', '*nospace': 'bool',
             'reason': 'str' } }
 
diff --git a/block/block-backend.c b/block/block-backend.c
index a775a3dd2f..a4421252f8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1615,10 +1615,11 @@ static void send_qmp_error_event(BlockBackend *blk,
                                  bool is_read, int error)
 {
     IoOperationType optype;
+    BlockDriverState *bs = blk_bs(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   bdrv_get_node_name(blk_bs(blk)), optype,
+    qapi_event_send_block_io_error(blk_name(blk), !!bs,
+                                   bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error),
                                    &error_abort);
-- 
2.13.6
