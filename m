Received: from eggs.gnu.org ([2001:4830:134:3::10]:43433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCN-0004tn-5b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCK-0001gE-Mo
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54986
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCK-0001fl-EB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbvP084861
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:59 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme91tv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:59 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:58 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:59 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-6-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/67] virtio: zero vq->inuse in virtio_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

vq->inuse must be zeroed upon device reset like most other virtqueue
fields.

In theory, virtio_reset() just needs assert(vq->inuse == 0) since
devices must clean up in-flight requests during reset (requests cannot
not be leaked!).

In practice, it is difficult to achieve vq->inuse == 0 across reset
because balloon, blk, 9p, etc implement various different strategies for
cleaning up requests.  Most devices call g_free(elem) directly without
telling virtio.c that the VirtQueueElement is cleaned up.  Therefore
vq->inuse is not decremented during reset.

This patch zeroes vq->inuse and trusts that devices are not leaking
VirtQueueElements across reset.

I will send a follow-up series that refactors request life-cycle across
all devices and converts vq->inuse = 0 into assert(vq->inuse == 0) but
this more invasive approach is not appropriate for stable trees.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Ladi Prosek <lprosek@redhat.com>
(cherry picked from commit 4b7f91ed0270a371e1933efa21ba600b6da23ab9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 74c085c..e8a13a5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -822,6 +822,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
+        vdev->vq[i].inuse = 0;
     }
 }
 
-- 
1.9.1
