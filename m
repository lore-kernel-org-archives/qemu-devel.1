Received: from eggs.gnu.org ([2001:4830:134:3::10]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCM-0004oz-60
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCJ-0001ee-14
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCI-0001dx-NB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haOo064443
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:57 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bgh8h412-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:57 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:56 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:52 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-59-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 58/67] vhost: drop legacy vring layout bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

From: Greg Kurz <groug@kaod.org>

The legacy vring layout is not used anymore as we use the separate
mappings even for legacy devices.
This patch simply removes it.

This also fixes a bug with virtio 1 devices when the vring descriptor table
is mapped at a higher address than the used vring because the following
function may return an insanely great value:

hwaddr virtio_queue_get_ring_size(VirtIODevice *vdev, int n)
{
    return vdev->vq[n].vring.used - vdev->vq[n].vring.desc +
           virtio_queue_get_used_size(vdev, n);
}

and the mapping fails.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1cdce7c54d26e64f5eddb10a6f4f7dd938dfc2c4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c         | 13 -------------
 include/hw/virtio/vhost.h |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b89f253..e01fdd7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -920,14 +920,6 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         goto fail_alloc_used;
     }
 
-    vq->ring_size = s = l = virtio_queue_get_ring_size(vdev, idx);
-    vq->ring_phys = a = virtio_queue_get_ring_addr(vdev, idx);
-    vq->ring = cpu_physical_memory_map(a, &l, 1);
-    if (!vq->ring || l != s) {
-        r = -ENOMEM;
-        goto fail_alloc_ring;
-    }
-
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
         r = -errno;
@@ -957,9 +949,6 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 
 fail_kick:
 fail_alloc:
-    cpu_physical_memory_unmap(vq->ring, virtio_queue_get_ring_size(vdev, idx),
-                              0, 0);
-fail_alloc_ring:
     cpu_physical_memory_unmap(vq->used, virtio_queue_get_used_size(vdev, idx),
                               0, 0);
 fail_alloc_used:
@@ -1000,8 +989,6 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    cpu_physical_memory_unmap(vq->ring, virtio_queue_get_ring_size(vdev, idx),
-                              0, virtio_queue_get_ring_size(vdev, idx));
     cpu_physical_memory_unmap(vq->used, virtio_queue_get_used_size(vdev, idx),
                               1, virtio_queue_get_used_size(vdev, idx));
     cpu_physical_memory_unmap(vq->avail, virtio_queue_get_avail_size(vdev, idx),
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 56b567f..1fe5aad 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -20,9 +20,6 @@ struct vhost_virtqueue {
     unsigned avail_size;
     unsigned long long used_phys;
     unsigned used_size;
-    void *ring;
-    unsigned long long ring_phys;
-    unsigned ring_size;
     EventNotifier masked_notifier;
 };
 
-- 
1.9.1
