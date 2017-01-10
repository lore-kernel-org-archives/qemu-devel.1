Received: from eggs.gnu.org ([2001:4830:134:3::10]:33733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAW-0007vN-Qb
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAV-0005l2-3m
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:24 -0500
Date: Tue, 10 Jan 2017 07:40:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-24-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/41] virtio: fix vq->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Correct recalculation of vq->inuse after migration for the corner case
where the avail_idx has already wrapped but used_idx not yet.

Also change the type of the VirtQueue.inuse to unsigned int. This is
done to be consistent with other members representing sizes (VRing.num),
and because C99 guarantees max ring size < UINT_MAX but does not
guarantee max ring size < INT_MAX.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
CC: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 933a3d7..8357218 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -93,7 +93,7 @@ struct VirtQueue
 
     uint16_t queue_index;
 
-    int inuse;
+    unsigned int inuse;
 
     uint16_t vector;
     VirtIOHandleOutput handle_output;
@@ -1878,9 +1878,11 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             /*
              * Some devices migrate VirtQueueElements that have been popped
              * from the avail ring but not yet returned to the used ring.
+             * Since max ring size < UINT16_MAX it's safe to use modulo
+             * UINT16_MAX + 1 subtraction.
              */
-            vdev->vq[i].inuse = vdev->vq[i].last_avail_idx -
-                                vdev->vq[i].used_idx;
+            vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -
+                                vdev->vq[i].used_idx);
             if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
                 error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
                              "used_idx 0x%x",
-- 
MST
