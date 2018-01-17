Received: from eggs.gnu.org ([2001:4830:134:3::10]:59866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ebjgl-0004KC-Kv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ebjgk-0004dg-QX
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:07:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 17 Jan 2018 09:07:00 +0000
Message-Id: <20180117090700.25811-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] block: add block_set_io_throttle
 virtio-blk-pci QMP example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The block_set_io_throttle command can look up BlockBackends by the
attached qdev device ID.  virtio-blk-pci is a special case because the
actual VirtIOBlock device is the "/virtio-backend" child of the PCI
adapter device.

Add a QMP schema example so clients will know how to use
block_set_io_throttle on the virtio-blk-pci device.

The alternative is to implement some sort of aliasing for qmp_get_blk()
but that is likely to cause confusion and could break future use cases.
Let's not go there.

Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a6881b2..4e84cf29db 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1799,6 +1799,24 @@
 # Example:
 #
 # -> { "execute": "block_set_io_throttle",
+#      "arguments": { "id": "virtio-blk-pci0/virtio-backend",
+#                     "bps": 0,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 512,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 0,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 0,
+#                     "iops_size": 0 } }
+# <- { "return": {} }
+#
+# -> { "execute": "block_set_io_throttle",
 #      "arguments": { "id": "ide0-1-0",
 #                     "bps": 1000000,
 #                     "bps_rd": 0,
-- 
2.14.3
