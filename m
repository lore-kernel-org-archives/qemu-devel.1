Received: from eggs.gnu.org ([2001:4830:134:3::10]:35371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csPx9-0004dy-KR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csPx4-0003zM-NL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:24:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:57810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1csPx4-0003z3-8Z
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:24:34 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue, 28 Mar 2017 16:39:25 +0800
Message-Id: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: add DISCARD support to virtio-blk
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
Cc: qemu-devel@nongnu.org

Currently virtio-blk driver does not provide discard feature flag, so the
filesystems which built on top of the block device will not send discard
command. This is okay for HDD backend, but it will impact the performance
for SSD backend.

Add a feature flag VIRTIO_BLK_F_DISCARD and command VIRTIO_BLK_T_DISCARD
to extend exist virtio-blk protocol. virtio-blk protocol uses a single
8 bytes descriptor containing type,reserved and sector, currently Linux
uses the reserved field as IO priority, here we also re-use the reserved
field as number of discard sectors.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 drivers/block/virtio_blk.c      | 38 +++++++++++++++++++++++++++++---------
 include/uapi/linux/virtio_blk.h | 12 ++++++++++--
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1d4c9f8..550cfe7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -241,6 +241,9 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
 		break;
+	case REQ_OP_DISCARD:
+		type = VIRTIO_BLK_T_DISCARD;
+		break;
 	case REQ_OP_SCSI_IN:
 	case REQ_OP_SCSI_OUT:
 		type = VIRTIO_BLK_T_SCSI_CMD;
@@ -256,16 +259,24 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, type);
 	vbr->out_hdr.sector = type ?
 		0 : cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
+	vbr->out_hdr.u.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
 
 	blk_mq_start_request(req);
 
-	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
-	if (num) {
-		if (rq_data_dir(req) == WRITE)
-			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
-		else
-			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
+	if (type == VIRTIO_BLK_T_DISCARD) {
+		vbr->out_hdr.u.discard_nr_sectors = cpu_to_virtio32(vblk->vdev,
+								    blk_rq_sectors(req));
+		num = 0;
+	} else {
+		num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
+		if (num) {
+			if (rq_data_dir(req) == WRITE)
+				vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
+								     VIRTIO_BLK_T_OUT);
+			else
+				vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
+								     VIRTIO_BLK_T_IN);
+		}
 	}
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
@@ -775,6 +786,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (!err && opt_io_size)
 		blk_queue_io_opt(q, blk_size * opt_io_size);
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
+		q->limits.discard_zeroes_data = 0;
+		q->limits.discard_alignment = blk_size;
+		q->limits.discard_granularity = blk_size;
+		blk_queue_max_discard_sectors(q, UINT_MAX);
+		blk_queue_max_discard_segments(q, 1);
+		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+	}
+
 	virtio_device_ready(vdev);
 
 	device_add_disk(&vdev->dev, vblk->disk);
@@ -882,14 +902,14 @@ static int virtblk_restore(struct virtio_device *vdev)
 	VIRTIO_BLK_F_SCSI,
 #endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
-	VIRTIO_BLK_F_MQ,
+	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
 }
 ;
 static unsigned int features[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
-	VIRTIO_BLK_F_MQ,
+	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 9ebe4d9..d608649 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -38,6 +38,7 @@
 #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
+#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD command is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -114,6 +115,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Discard command */
+#define VIRTIO_BLK_T_DISCARD	16
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -127,8 +131,12 @@ struct virtio_blk_config {
 struct virtio_blk_outhdr {
 	/* VIRTIO_BLK_T* */
 	__virtio32 type;
-	/* io priority. */
-	__virtio32 ioprio;
+	union {
+		/* io priority. */
+		__virtio32 ioprio;
+		/* discard number of sectors */
+		__virtio32 discard_nr_sectors;
+	} u;
 	/* Sector (ie. 512 byte offset) */
 	__virtio64 sector;
 };
-- 
1.9.3
