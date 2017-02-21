Received: from eggs.gnu.org ([2001:4830:134:3::10]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFeZ-0002c5-DH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFeY-0007UU-Dx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgFeY-0007U8-81
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:10 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 579197FB62
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:59:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 18:59:00 +0000
Message-Id: <20170221185901.3256-2-stefanha@redhat.com>
In-Reply-To: <20170221185901.3256-1-stefanha@redhat.com>
References: <20170221185901.3256-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio: invalidate memory in
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
