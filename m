Received: from eggs.gnu.org ([2001:4830:134:3::10]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVG-0002ep-8R
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcVF-0002j8-7Y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:41:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Jul 2017 13:41:28 +0200
Message-Id: <1499946095-8224-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
References: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/9] block/qapi: Add qdev device name to
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

With -blockdev/-device, users can indirectly create anonymous
BlockBackends, while the state of such backends is still of interest. As
a preparation for making such BBs visible in query-block, make sure that
they can be identified even without a name by adding the ID/QOM path of
their qdev device to BlockInfo.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi.c               | 10 ++++++++++
 hmp.c                      |  3 +++
 qapi/block-core.json       |  9 ++++++++-
 tests/qemu-iotests/067.out |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index 0a41d59..705cd11 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -322,11 +322,21 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
 {
     BlockInfo *info = g_malloc0(sizeof(*info));
     BlockDriverState *bs = blk_bs(blk);
+    char *qdev;
+
     info->device = g_strdup(blk_name(blk));
     info->type = g_strdup("unknown");
     info->locked = blk_dev_is_medium_locked(blk);
     info->removable = blk_dev_has_removable_media(blk);
 
+    qdev = blk_get_attached_dev_id(blk);
+    if (qdev && *qdev) {
+        info->has_qdev = true;
+        info->qdev = qdev;
+    } else {
+        g_free(qdev);
+    }
+
     if (blk_dev_has_tray(blk)) {
         info->has_tray_open = true;
         info->tray_open = blk_dev_is_tray_open(blk);
diff --git a/hmp.c b/hmp.c
index dee4028..d1d769e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -425,6 +425,9 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 
     if (info) {
+        if (info->has_qdev) {
+            monitor_printf(mon, "    Attached to:      %s\n", info->qdev);
+        }
         if (info->has_io_status && info->io_status != BLOCK_DEVICE_IO_STATUS_OK) {
             monitor_printf(mon, "    I/O status:       %s\n",
                            BlockDeviceIoStatus_lookup[info->io_status]);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f85c223..0dd9c30 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -433,6 +433,9 @@
 #
 # @device: The device name associated with the virtual device.
 #
+# @qdev: The qdev ID, or if no ID is assigned, the QOM path of the block
+#        device. (since 2.10)
+#
 # @type: This field is returned only for compatibility reasons, it should
 #        not be used (always returns 'unknown')
 #
@@ -458,7 +461,7 @@
 # Since:  0.14.0
 ##
 { 'struct': 'BlockInfo',
-  'data': {'device': 'str', 'type': 'str', 'removable': 'bool',
+  'data': {'device': 'str', '*qdev': 'str', 'type': 'str', 'removable': 'bool',
            'locked': 'bool', '*inserted': 'BlockDeviceInfo',
            '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
@@ -528,6 +531,7 @@
 #                   }
 #                }
 #             },
+#             "qdev": "ide_disk",
 #             "type":"unknown"
 #          },
 #          {
@@ -535,12 +539,15 @@
 #             "device":"ide1-cd0",
 #             "locked":false,
 #             "removable":true,
+#             "qdev": "/machine/unattached/device[23]",
+#             "tray_open": false,
 #             "type":"unknown"
 #          },
 #          {
 #             "device":"floppy0",
 #             "locked":false,
 #             "removable":true,
+#             "qdev": "/machine/unattached/device[20]",
 #             "type":"unknown"
 #          },
 #          {
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index 782eae2..e3c4496 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -57,6 +57,7 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virti
                 "file": "TEST_DIR/t.qcow2",
                 "encryption_key_missing": false
             },
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
             "type": "unknown"
         }
     ]
-- 
1.8.3.1
