Received: from eggs.gnu.org ([2001:4830:134:3::10]:52114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDg-0001kC-RS
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDd-0003yp-Mo
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1cGiDd-0003uo-Gd
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so16565146wma.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:13:27 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Dec 2016 10:12:05 +0200
Message-Id: <1481616728-148412-2-git-send-email-yuri.benditovich@daynix.com>
In-Reply-To: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
References: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v3 1/4] net: Add virtio queue interface to
 update used index from vring state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Bring virtio queue to correct internal  state for host-to-guest
operations when vhost is temporary stopped.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c         | 5 +++++
 include/hw/virtio/virtio.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1af2de2..45536e4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1995,6 +1995,11 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
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
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ab0e030..a1a75ed 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -266,6 +266,7 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
+void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
 uint16_t virtio_get_queue_index(VirtQueue *vq);
 EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
-- 
1.9.1
