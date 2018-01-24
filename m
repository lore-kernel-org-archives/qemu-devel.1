Received: from eggs.gnu.org ([2001:4830:134:3::10]:48142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl4-0007yw-8A
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl2-0006Xv-90
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeOl2-0006Wf-2c
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:44 -0500
Date: Wed, 24 Jan 2018 19:22:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516814467-25906-2-git-send-email-mst@redhat.com>
References: <1516814467-25906-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516814467-25906-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/3] Revert "virtio: improve virtio devices
 initialization time"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Sitong Liu <siliu@redhat.com>, Xiaoling Gao <xiagao@redhat.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This reverts commit 6f0bb230722931d17fb284eee8efd40b9d653822.

This reverts commit f87d72f5c5bff0837d409a56bd34f439a90119ca as that is
reported to break cleanup and migration.

Cc: Gal Hammer <ghammer@redhat.com>
Cc: Sitong Liu <siliu@redhat.com>
Cc: Xiaoling Gao <xiagao@redhat.com>
Suggested-by: Greg Kurz <groug@kaod.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3ac3491..d6002ee 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2574,7 +2574,6 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int n, r, err;
 
-    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
         if (!virtio_queue_get_num(vdev, n)) {
@@ -2597,7 +2596,6 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
         }
         event_notifier_set(&vq->host_notifier);
     }
-    memory_region_transaction_commit();
     return 0;
 
 assign_error:
@@ -2611,7 +2609,6 @@ assign_error:
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
-    memory_region_transaction_commit();
     return err;
 }
 
@@ -2628,7 +2625,6 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
     VirtioBusState *qbus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int n, r;
 
-    memory_region_transaction_begin();
     for (n = 0; n < VIRTIO_QUEUE_MAX; n++) {
         VirtQueue *vq = &vdev->vq[n];
 
@@ -2639,7 +2635,6 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
-    memory_region_transaction_commit();
 }
 
 void virtio_device_stop_ioeventfd(VirtIODevice *vdev)
-- 
MST
