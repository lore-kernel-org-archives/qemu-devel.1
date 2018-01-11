Received: from eggs.gnu.org ([2001:4830:134:3::10]:57468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eZZvX-0001u8-Oq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eZZvS-0001AS-RI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1eZZvS-00017B-KD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:17:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CC018763C
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:17:23 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Thu, 11 Jan 2018 12:16:56 +0200
Message-Id: <1515665816-10313-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: improve virtio devices initialization
 time
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
devices uses a large amount of virt-queues (e.g. a virtio-serial
device with max_ports=511). Most of the time is spend in the
creation of all the required event notifiers (ioeventfd and memory
regions).

This patch pack all the changes to the memory regions in a
single memory transaction.

Reported-by: Sitong Liu <siliu@redhat.com>
Reported-by: Xiaoling Gao <xiagao@redhat.com>
Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 hw/virtio/virtio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ad564b0..8d8d93d 100644
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
 
@@ -2632,6 +2636,13 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
             continue;
         }
         event_notifier_set_handler(&vq->host_notifier, NULL);
+    }
+    memory_region_transaction_commit();
+
+    for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
+        if (!virtio_queue_get_num(vdev, n)) {
+            continue;
+        }
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
-- 
2.7.5
