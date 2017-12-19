Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJa5-00058a-O7
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZz-0007Hf-QU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJZz-0007H0-Jb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:13:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:38 +0000
Message-Id: <20171219151144.11120-18-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/23] virtio-blk: reject configs with
 logical block size > physical block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Kanda <mark.kanda@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Mark Kanda <mark.kanda@oracle.com>

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
Message-id: 773169891f9f2deb4cb7c4ef2655580dbe24c1d1.1513005190.git.mark.kanda@oracle.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 66ab0b19c8..b1532e4e91 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -949,6 +949,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 
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
2.14.3
