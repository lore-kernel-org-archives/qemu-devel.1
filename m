Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAa-0007zR-LY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAZ-0005n5-Sr
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:28 -0500
Received: from mail.kernel.org ([198.145.29.136]:48290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAZ-0005mm-Lq
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:27 -0500
Date: Tue, 10 Jan 2017 07:40:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-26-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/41] net: Add virtio queue interface to update
 used index from vring state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Bring virtio queue to correct internal  state for host-to-guest
operations when vhost is temporary stopped.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 1 +
 hw/virtio/virtio.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 5e4176f..e15c064 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -269,6 +269,7 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
+void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
 uint16_t virtio_get_queue_index(VirtQueue *vq);
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8357218..baffff7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2020,6 +2020,11 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
     vdev->vq[n].shadow_avail_idx = idx;
 }
 
+void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
+{
+    vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
+}
+
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
 {
     vdev->vq[n].signalled_used_valid = false;
-- 
MST
