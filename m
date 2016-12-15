Received: from eggs.gnu.org ([2001:4830:134:3::10]:47094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHYCC-00060O-B9
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHYC9-0005Z6-86
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:43:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43935
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHYC9-0005YE-3Q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:43:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFFYEwT112512
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 10:43:43 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bvg27ktd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 10:43:43 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 15:43:41 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 16:43:30 +0100
Message-Id: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

Correct recalculation of vring->inuse after migration for
the corner case where the avail_idx has already wrapped
but used_idx not yet.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
CC: qemu-stable@nongnu.org
---

I think we could also change the type of inuse to uint16_t.
Would this be considered a good idea?
---
 hw/virtio/virtio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1af2de2..089c6f6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1855,9 +1855,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             /*
              * Some devices migrate VirtQueueElements that have been popped
              * from the avail ring but not yet returned to the used ring.
+             * Cast to uint16_t is OK because max ring size is 0x8000. Thus
+             * no the size of largest array indexable by an integral type
+             * can not be represented by the same type problem.
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
