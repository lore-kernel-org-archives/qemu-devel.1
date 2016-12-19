Received: from eggs.gnu.org ([2001:4830:134:3::10]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cJ07z-0001mc-T8
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cJ07w-0006yq-PO
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:45:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35224
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cJ07w-0006yR-KM
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:45:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJFef2u040464
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 10:45:22 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27efv52aw5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 10:45:21 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 15:45:19 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 16:44:44 +0100
Message-Id: <20161219154444.13143-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] virtio: fix vq->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

Correct recalculation of vq->inuse after migration for the corner case
where the avail_idx has already wrapped but used_idx not yet.

Also change the type of the VirtQueue.inuse to unsigned int. This is
done to be consistent with other members representing sizes (VRing.num),
and because C99 guarantees max ring size < UINT_MAX but does not
guarantee max ring size < INT_MAX.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
CC: qemu-stable@nongnu.org
---
v1 -> v2:
* Reworded comment explaining the cast. (thanks Stefan)
* Changed type of vq->inuse from signed to unsigned
* Fixed misnomer %s/vring->inuse/vq->inuse/
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
2.8.4
