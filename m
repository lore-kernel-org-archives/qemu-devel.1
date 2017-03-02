Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjVxC-0008OW-MO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjVx9-000446-HO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:59:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cjVx9-00043f-7y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:59:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22IxKd3069096
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 13:59:49 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xpbq09p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 13:59:49 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 18:59:47 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu,  2 Mar 2017 19:59:42 +0100
Message-Id: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio: fail device if set_event_notifier
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

The function virtio_notify_irqfd used to ignore the return code of
event_notifier_set. Let's fail the device should this occur.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

---

This patch is most likely flawed because virtio_notify_irqfd
is probably supposed to be thread-safe and neither strerror
nor virtio_error are that. Anyway lets get the discussion started with this.

There was a suggestion by Michael to make event_notifier_set void
and assert inside. After some thinking, I settled at the opinion,
that neither doing nothing nor crashing the guest is a good idea
should this failure happen in production. So I came up with this.

Looking forward to your feedback.
---
 hw/virtio/virtio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..e05f3e5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1555,6 +1555,8 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
     bool should_notify;
+    int rc;
+
     rcu_read_lock();
     should_notify = virtio_should_notify(vdev, vq);
     rcu_read_unlock();
@@ -1581,7 +1583,11 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    event_notifier_set(&vq->guest_notifier);
+    rc = event_notifier_set(&vq->guest_notifier);
+    if (unlikely(rc)) {
+        virtio_error(vdev, "guest notifier broken for vdev at %p (%s)", vdev,
+                     strerror(-rc));
+    }
 }
 
 static void virtio_irq(VirtQueue *vq)
-- 
2.8.4
