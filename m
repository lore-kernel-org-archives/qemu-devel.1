Received: from eggs.gnu.org ([2001:4830:134:3::10]:59112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj3S5-0006v2-4N
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cj3S1-0003IO-TA
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:33:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33730
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cj3S1-00032v-Nj
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:33:49 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21CXAO0028538
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 07:33:13 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wxd7r05r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 07:33:10 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 12:25:30 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  1 Mar 2017 12:50:04 +0100
Message-Id: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to non-irqfd
 notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
changed how notifications are done for virtio-blk substantially. Due to a
race condition interrupts are lost when irqfd is torn down after
notify_guest_bh was scheduled but before it actually runs.  Furthermore
virtio_notify_irqfd ignores the value returned by event_notifier_set
which correctly indicates that notification has failed due to bad file
descriptor.

Let's fix this by making virtio_notify_irqfd fall back to the non-irqfd
notification mechanism if event_notifier_set fails.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

This is probably not the only way to fix this: suggestions welcome. I
did not use a fixes tag because I'm not sure yet where exactly things got
broken. Maybe guys more familiar with dataplane an coroutines can help
(Paolo, Stefan).
---
 hw/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..8e1c1e9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1581,7 +1581,9 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    event_notifier_set(&vq->guest_notifier);
+    if (event_notifier_set(&vq->guest_notifier)) {
+        virtio_notify_vector(vdev, vq->vector);
+    }
 }
 
 static void virtio_irq(VirtQueue *vq)
-- 
2.8.4
