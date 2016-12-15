Received: from eggs.gnu.org ([2001:4830:134:3::10]:43650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCV-0005DL-Nz
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCT-0001nN-V3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCT-0001mU-Km
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbDk130809
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:08 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkvs7pb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:08 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:07 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:00 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-7-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 06/67] virtio-balloon: discard virtqueue
 element on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ladi Prosek <lprosek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

The one pending element is being freed but not discarded on device
reset, which causes svq->inuse to creep up, eventually hitting the
"Virtqueue size exceeded" error.

Properly discarding the element on device reset makes sure that its
buffers are unmapped and the inuse counter stays balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 104e70cae78bd4afd95d948c6aff188f10508a9c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 5af429a..ad4189a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -463,6 +463,7 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
 
     if (s->stats_vq_elem != NULL) {
+        virtqueue_discard(s->svq, s->stats_vq_elem, 0);
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
-- 
1.9.1
