Received: from eggs.gnu.org ([2001:4830:134:3::10]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eOPmw-0006qP-94
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eOPmv-0000JV-DQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:14:38 -0500
From: Mark Kanda <mark.kanda@oracle.com>
Date: Mon, 11 Dec 2017 09:16:25 -0600
Message-Id: <773169891f9f2deb4cb7c4ef2655580dbe24c1d1.1513005190.git.mark.kanda@oracle.com>
In-Reply-To: <cover.1513004957.git.mark.kanda@oracle.com>
References: <cover.1513004957.git.mark.kanda@oracle.com>
In-Reply-To: <52e6d742811f10dbd16e996e86cf375b9577c187.1513005190.git.mark.kanda@oracle.com>
References: <52e6d742811f10dbd16e996e86cf375b9577c187.1513005190.git.mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-blk: reject configs with logical
 block size > physical block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com, Mark Kanda <mark.kanda@oracle.com>

virtio-blk logical block size should never be larger than physical block
size because it doesn't make sense to have such configurations. QEMU doesn't
have a way to effectively express this condition; the best it can do is
report the physical block exponent as 0 - indicating the logical block size
equals the physical block size.

This is identical to commit 3da023b5827543ee4c022986ea2ad9d1274410b2
but applied to virtio-blk (instead of virtio-scsi).

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index fb59f57..36c7608 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -952,6 +952,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
     blkconf_blocksizes(&conf->conf);
 
+    if (conf->conf.logical_block_size >
+        conf->conf.physical_block_size) {
+        error_setg(errp,
+                   "logical_block_size > physical_block_size not supported");
+        return;
+    }
+
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
 
-- 
1.8.3.1
