Received: from eggs.gnu.org ([2001:4830:134:3::10]:40964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qj-0001hK-IB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qd-0004vJ-Qo
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qd-0004uE-I2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8jTW025511
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ae098udu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:29 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:02 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-39-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/81] virtio: fix vq->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit e66bcc408146730958d1a840bda85d7ad51e0cd7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1af2de2..e37641a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -92,7 +92,7 @@ struct VirtQueue
 
     uint16_t queue_index;
 
-    int inuse;
+    unsigned int inuse;
 
     uint16_t vector;
     VirtIOHandleOutput handle_output;
@@ -1855,9 +1855,11 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
2.7.4
