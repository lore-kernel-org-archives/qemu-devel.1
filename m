Received: from eggs.gnu.org ([2001:4830:134:3::10]:35851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cVSvU-00085Z-01
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 19:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cVSvP-0004Ps-AJ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 19:56:04 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 23 Jan 2017 08:55:04 +0800
Message-ID: <1485132904-17632-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2] virtio: Fix no interrupt when not creating
 msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, christoffer.dall@linaro.org

From: Shannon Zhao <shannon.zhao@linaro.org>

For ARM virt machine, if we use virt-2.7 which will not create ITS node,
the virtio-net can not recieve interrupts so it can't get ip address
through dhcp.
This fixes commit 83d768b(virtio: set ISR on dataplane notifications).

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
V2: Factor out a common function instead of duplicating code
---
 hw/virtio/virtio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index aa4f38f..00e8f74 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1441,6 +1441,12 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
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
     if (!virtio_should_notify(vdev, vq)) {
@@ -1448,8 +1454,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
     }
 
     trace_virtio_notify(vdev, vq);
-    virtio_set_isr(vq->vdev, 0x1);
-    virtio_notify_vector(vdev, vq->vector);
+    virtio_irq(vq);
 }
 
 void virtio_notify_config(VirtIODevice *vdev)
@@ -2082,7 +2087,7 @@ static void virtio_queue_guest_notifier_read(EventNotifier *n)
 {
     VirtQueue *vq = container_of(n, VirtQueue, guest_notifier);
     if (event_notifier_test_and_clear(n)) {
-        virtio_notify_vector(vq->vdev, vq->vector);
+        virtio_irq(vq);
     }
 }
 
-- 
2.0.4
