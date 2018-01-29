Received: from eggs.gnu.org ([2001:4830:134:3::10]:42746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJA-0002gY-Bu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJ9-0007XV-8H
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1egAJ9-0007XI-1q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 495CC7AEBA
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 14:21:14 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Mon, 29 Jan 2018 16:20:57 +0200
Message-Id: <1517235657-22547-3-git-send-email-ghammer@redhat.com>
In-Reply-To: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
References: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] virtio: improve virtio devices
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
Cc: mst@redhat.com, Gal Hammer <ghammer@redhat.com>

The loading time of a VM is quite significant when its virtio
devices use a large amount of virt-queues (e.g. a virtio-serial
device with max_ports=511). Most of the time is spend in the
creation of all the required event notifiers (ioeventfd and memory
regions).

This patch pack all the changes to the memory regions in a
single memory transaction.

Reported-by: Sitong Liu <address@hidden>
Reported-by: Xiaoling Gao <address@hidden>
Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3667cd6..006d3d1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2572,8 +2572,9 @@ static Property virtio_properties[] = {
 static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
 {
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    int n, r, err;
+    int i, n, r, err;
 
+    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
         if (!virtio_queue_get_num(vdev, n)) {
@@ -2596,9 +2597,11 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
         }
         event_notifier_set(&vq->host_notifier);
     }
+    memory_region_transaction_commit();
     return 0;
 
 assign_error:
+    i = n; /* save n for a second iteration after transaction is committed. */
     while (--n >= 0) {
         VirtQueue *vq = &vdev->vq[n];
         if (!virtio_queue_get_num(vdev, n)) {
@@ -2608,7 +2611,14 @@ assign_error:
         event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
-        virtio_bus_cleanup_host_notifier(qbus, n);
+    }
+    memory_region_transaction_commit();
+
+    while (--i >= 0) {
+        if (!virtio_queue_get_num(vdev, i)) {
+            continue;
+        }
+        virtio_bus_cleanup_host_notifier(qbus, i);
     }
     return err;
 }
@@ -2626,6 +2636,7 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int n, r;
 
+    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
 
@@ -2635,6 +2646,13 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
         event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
+    }
+    memory_region_transaction_commit();
+
+    for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
+        if (!virtio_queue_get_num(vdev, n)) {
+            continue;
+        }
         virtio_bus_cleanup_host_notifier(qbus, n);
     }
 }
-- 
2.7.5
