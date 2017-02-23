Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgp7i-0005Xa-Ic
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgp7d-0004uS-OJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:51:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgp7d-0004uN-IJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:51:33 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64F9C2E6051
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:51:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Feb 2017 09:51:30 +0100
Message-Id: <20170223085130.19954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: check for vring setup in
 virtio_queue_empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, alex.williamson@redhat.com, lersek@redhat.com, mst@redhat.com

If the vring has not been set up, there is nothing in the virtqueue.
virtio_queue_host_notifier_aio_poll calls virtio_queue_empty even in
this case; we have to filter it out just like virtio_queue_notify_aio_vq.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..e487e36 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,7 +2291,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
     bool progress;
 
-    if (virtio_queue_empty(vq)) {
+    if (!vq->vring.desc || virtio_queue_empty(vq)) {
         return false;
     }
 
-- 
2.9.3
