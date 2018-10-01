Received: from eggs.gnu.org ([2001:4830:134:3::10]:40703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSk-0005Dz-FK
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSj-0002yk-K9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:25 +0300
Message-Id: <20181001102928.20533-16-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 15/18] qapi: add x-drop-fleecing qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

To insert fleecing-hook, it should be just created (blockdev-add) with
corresponding parameters. But it can't be properly removed by
blockdev-del (we can't restore backing chain in fleecing-hook .close),
So, let's add this expiremental api to drop the hook.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 17 +++++++++++++++++
 blockdev.c           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 13cf90eab6..eda6fb6b7e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3856,6 +3856,23 @@
 ##
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
+##
+# @x-drop-fleecing:
+#
+# Deletes fleecing-hook filter from the top of the backing chain.
+#
+# @node-name: Name of the fleecing-hook node name.
+#
+# Since: 3.1
+#
+# -> { "execute": "x-drop-fleecing",
+#      "arguments": { "node-name": "fleece0" }
+#    }
+# <- { "return": {} }
+#
+##
+{ 'command': 'x-drop-fleecing', 'data': { 'node-name': 'str' } }
+
 ##
 # @BlockdevCreateOptionsFile:
 #
diff --git a/blockdev.c b/blockdev.c
index 407e03d22a..90c09d5cee 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4250,6 +4250,43 @@ out:
     aio_context_release(aio_context);
 }
 
+void qmp_x_drop_fleecing(const char *node_name, Error **errp)
+{
+    AioContext *aio_context;
+    BlockDriverState *bs;
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Cannot find node %s", node_name);
+        return;
+    }
+
+    if (!bdrv_has_blk(bs)) {
+        error_setg(errp, "Node %s is not inserted", node_name);
+        return;
+    }
+
+    if (!bs->backing) {
+        error_setg(errp, "'%s' has no backing", node_name);
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_begin(bs);
+
+    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
+    bdrv_set_backing_hd(bs, NULL, &error_abort);
+
+    bdrv_drained_end(bs);
+
+    qmp_blockdev_del(node_name, &error_abort);
+
+    aio_context_release(aio_context);
+}
+
 static BdrvChild *bdrv_find_child(BlockDriverState *parent_bs,
                                   const char *child_name)
 {
-- 
2.18.0
