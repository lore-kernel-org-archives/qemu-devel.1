Received: from eggs.gnu.org ([2001:4830:134:3::10]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eddZo-0001fs-CC
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eddZn-0007sM-Kd
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:00:00 -0500
From: Mark Kanda <mark.kanda@oracle.com>
Date: Mon, 22 Jan 2018 09:01:49 -0600
Message-Id: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: check for NULL BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, karl.heubaum@oracle.com, ameya.more@oracle.com, Mark Kanda <mark.kanda@oracle.com>

Add a BlockDriverState NULL check to virtio_blk_handle_request()
to prevent a segfault if the drive is forcibly removed using HMP
'drive_del' (without performing a hotplug 'device_del' first).

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
---
 hw/block/virtio-blk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b1532e4..76ddbbf 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         return -1;
     }
 
+    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the block
+     * driver state may be NULL and there is nothing left to do. */
+    if (!blk_bs(req->dev->blk)) {
+        virtio_error(vdev, "virtio-blk BlockDriverState is NULL");
+        return -1;
+    }
+
     /* We always touch the last byte, so just see how big in_iov is.  */
     req->in_len = iov_size(in_iov, in_num);
     req->in = (void *)in_iov[in_num - 1].iov_base
-- 
1.8.3.1
