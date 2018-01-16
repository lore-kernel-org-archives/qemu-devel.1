Received: from eggs.gnu.org ([2001:4830:134:3::10]:47723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ9K-0007ej-Fz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ9J-0004h8-P8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJ9J-0004gk-JM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:01 -0500
Date: Tue, 16 Jan 2018 06:46:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-9-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Sitong Liu <siliu@redhat.com>, Xiaoling Gao <xiagao@redhat.com>

From: Gal Hammer <ghammer@redhat.com>

The loading time of a VM is quite significant when its virtio
devices use a large amount of virt-queues (e.g. a virtio-serial
device with max_ports=511). Most of the time is spend in the
creation of all the required event notifiers (ioeventfd and memory
regions).

This patch pack all the changes to the memory regions in a
single memory transaction.

Reported-by: Sitong Liu <siliu@redhat.com>
Reported-by: Xiaoling Gao <xiagao@redhat.com>
Signed-off-by: Gal Hammer <ghammer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d6002ee..3ac3491 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2574,6 +2574,7 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int n, r, err;
 
+    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
         if (!virtio_queue_get_num(vdev, n)) {
@@ -2596,6 +2597,7 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
         }
         event_notifier_set(&vq->host_notifier);
     }
+    memory_region_transaction_commit();
     return 0;
 
 assign_error:
@@ -2609,6 +2611,7 @@ assign_error:
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
+    memory_region_transaction_commit();
     return err;
 }
 
@@ -2625,6 +2628,7 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int n, r;
 
+    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
 
@@ -2635,6 +2639,7 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
+    memory_region_transaction_commit();
 }
 
 void virtio_device_stop_ioeventfd(VirtIODevice *vdev)
-- 
MST
