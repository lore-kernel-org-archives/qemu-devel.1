Received: from eggs.gnu.org ([2001:4830:134:3::10]:54782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonx-0000ns-Fz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonw-000758-Kz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:49 -0500
Date: Fri, 1 Dec 2017 19:08:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-4-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] vhost: restore avail index from vring used
 index on disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-stable@nongnu.org

From: Maxime Coquelin <maxime.coquelin@redhat.com>

vhost_virtqueue_stop() gets avail index value from the backend,
except if the backend is not responding.

It happens when the backend crashes, and in this case, internal
state of the virtio queue is inconsistent, making packets
to corrupt the vring state.

With a Linux guest, it results in following error message on
backend reconnection:

[   22.444905] virtio_net virtio0: output.0:id 0 is not a head!
[   22.446746] net enp0s3: Unexpected TXQ (0) queue failure: -5
[   22.476360] net enp0s3: Unexpected TXQ (0) queue failure: -5

Fixes: 283e2c2adcb8 ("net: virtio-net discards TX data after link down")
Cc: qemu-stable@nongnu.org
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..5404194 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1138,6 +1138,10 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
+        /* Connection to the backend is broken, so let's sync internal
+         * last avail idx to the device used idx.
+         */
+        virtio_queue_restore_last_avail_idx(vdev, idx);
     } else {
         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
     }
-- 
MST
