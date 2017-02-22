Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZvD-0002zM-Gz
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZv9-00054M-Mj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgZv9-000547-Gu
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Feb 2017 16:37:33 +0000
Message-Id: <20170222163734.13104-2-stefanha@redhat.com>
In-Reply-To: <20170222163734.13104-1-stefanha@redhat.com>
References: <20170222163734.13104-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] virtio: invalidate memory in
 vring_set_avail_event()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Remember to invalidate the avail event field so the memory pages are
marked dirty.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..da5c6fe 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -282,6 +282,7 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     caches = atomic_rcu_read(&vq->vring.caches);
     pa = offsetof(VRingUsed, ring[vq->vring.num]);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
+    address_space_cache_invalidate(&caches->used, pa, sizeof(val));
 }
 
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
-- 
2.9.3
