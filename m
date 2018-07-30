Received: from eggs.gnu.org ([2001:4830:134:3::10]:44124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oV-0003NV-Ag
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oR-0008LR-Hb
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:56 +0200
Message-Id: <20180730150958.14607-12-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] block/qapi: Add 'qdev' field to
 query-blockstats result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Like for query-block, the client needs to identify which BlockBackend
the returned data is for. Anonymous BlockBackends are identified by the
device model they are attached to. Add a 'qdev' field that contains the
qdev ID or QOM path of the attached device model.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 14 ++++++++++----
 block/qapi.c         | 10 ++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d40d5ecc3b..5b9084a394 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -866,6 +866,9 @@
 #
 # @node-name: The node name of the device. (Since 2.3)
 #
+# @qdev: The qdev ID, or if no ID is assigned, the QOM path of the block
+#        device. (since 3.0)
+#
 # @stats:  A @BlockDeviceStats for the device.
 #
 # @parent: This describes the file block device if it has one.
@@ -879,7 +882,7 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockStats',
-  'data': {'*device': 'str', '*node-name': 'str',
+  'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
            'stats': 'BlockDeviceStats',
            '*parent': 'BlockStats',
            '*backing': 'BlockStats'} }
@@ -941,7 +944,8 @@
 #                "idle_time_ns":2953431879,
 #                "account_invalid":true,
 #                "account_failed":false
-#             }
+#             },
+#             "qdev": "/machine/unattached/device[23]"
 #          },
 #          {
 #             "device":"ide1-cd0",
@@ -959,7 +963,8 @@
 #                "wr_merged":0,
 #                "account_invalid":false,
 #                "account_failed":false
-#             }
+#             },
+#             "qdev": "/machine/unattached/device[24]"
 #          },
 #          {
 #             "device":"floppy0",
@@ -977,7 +982,8 @@
 #                "wr_merged":0,
 #                "account_invalid":false,
 #                "account_failed":false
-#             }
+#             },
+#             "qdev": "/machine/unattached/device[16]"
 #          },
 #          {
 #             "device":"sd0",
diff --git a/block/qapi.c b/block/qapi.c
index e12968fec8..50f867d634 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -597,11 +597,21 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
             BlockStatsList *info = g_malloc0(sizeof(*info));
             AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
+            char *qdev;
 
             aio_context_acquire(ctx);
             s = bdrv_query_bds_stats(blk_bs(blk), true);
             s->has_device = true;
             s->device = g_strdup(blk_name(blk));
+
+            qdev = blk_get_attached_dev_id(blk);
+            if (qdev && *qdev) {
+                s->has_qdev = true;
+                s->qdev = qdev;
+            } else {
+                g_free(qdev);
+            }
+
             bdrv_query_blk_stats(s->stats, blk);
             aio_context_release(ctx);
 
-- 
2.13.6
