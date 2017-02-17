Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc7-0004KE-Vd
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc7-0005k8-36
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc6-0005jU-SQ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:43 -0500
Date: Fri, 17 Feb 2017 21:54:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-14-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/23] virtio: Fix no interrupt when not
 creating msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>

For ARM virt machine, if we use virt-2.7 which will not create ITS node,
the virtio-net can not recieve interrupts so it can't get ip address
through dhcp.
This fixes commit 83d768b(virtio: set ISR on dataplane notifications).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c08e50f..23483c7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1584,6 +1584,12 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
     event_notifier_set(&vq->guest_notifier);
 }
 
+static void virtio_irq(VirtQueue *vq)
+{
+    virtio_set_isr(vq->vdev, 0x1);
+    virtio_notify_vector(vq->vdev, vq->vector);
+}
+
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     bool should_notify;
@@ -1596,8 +1602,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
     }
 
     trace_virtio_notify(vdev, vq);
-    virtio_set_isr(vq->vdev, 0x1);
-    virtio_notify_vector(vdev, vq->vector);
+    virtio_irq(vq);
 }
 
 void virtio_notify_config(VirtIODevice *vdev)
@@ -2240,7 +2245,7 @@ static void virtio_queue_guest_notifier_read(EventNotifier *n)
 {
     VirtQueue *vq = container_of(n, VirtQueue, guest_notifier);
     if (event_notifier_test_and_clear(n)) {
-        virtio_notify_vector(vq->vdev, vq->vector);
+        virtio_irq(vq);
     }
 }
 
-- 
MST
