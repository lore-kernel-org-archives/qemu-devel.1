Received: from eggs.gnu.org ([2001:4830:134:3::10]:44357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6b-0001jF-Bg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6a-0003yt-8e
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:49 -0500
Received: from mail.kernel.org ([198.145.29.136]:51296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6a-0003wR-2M
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:48 -0500
Date: Thu, 2 Mar 2017 08:20:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-11-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] virtio: invalidate memory in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Remember to invalidate the avail event field so the memory pages are
marked dirty.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index bf8a644..294c909 100644
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
MST
