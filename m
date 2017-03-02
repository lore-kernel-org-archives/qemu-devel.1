Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6b-0001jG-Bz
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6X-0003rv-P7
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:49 -0500
Received: from mail.kernel.org ([198.145.29.136]:51270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6X-0003pU-HN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:45 -0500
Date: Thu, 2 Mar 2017 08:20:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-10-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Switching to vring caches exposed an existing bug in
virtio_queue_set_notification(): We can't access vring structures
if they have not been set up yet. This may happen, for example,
for virtio-blk devices with multiple queues: The code will try to
switch notifiers for every queue, but the guest may have only set up
a subset of them.

Fix this by guarding access to the vring memory by checking for
vring.desc. The first aio poll will iron out any remaining
inconsistencies for later-configured queues (buggy legacy drivers).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e487e36..bf8a644 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -288,6 +288,10 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
 
+    if (!vq->vring.desc) {
+        return;
+    }
+
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
-- 
MST
