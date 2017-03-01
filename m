Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj8Wl-00018y-Dg
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj8Wi-0008NJ-Af
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:59:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cj8Wi-0008N9-4k
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:59:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21HnuIQ039634
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 12:58:59 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wxrb6n4w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:58:58 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Mar 2017 17:58:57 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed,  1 Mar 2017 18:58:52 +0100
Message-Id: <20170301175852.13517-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, borntraeger@de.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

Switching to vring caches exposed an existing bug in
virtio_queue_set_notification(): We can't access vring structures
if they have not been set up yet. This may happen, for example,
for virtio-blk devices with multiple queues: The code will try to
switch notifiers for every queue, but the guest may have only set up
a subset of them.

Fix this by guarding access to the vring memory by checking for
vring.desc. The first aio poll will iron out any remaining
inconsistencies for later-configured queues (buggy legacy drivers).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
v2->v3:
- Switch to a very simple check for !desc, which should be fine for
  the existing users.

We might want to assert that callers don't start aio before DRIVER_OK
resp. first kick, but that can wait until after we've fixed this bug.
---
 hw/virtio/virtio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e487e36..bf8a644 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -288,6 +288,10 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
 
+    if (!vq->vring.desc) {
+        return;
+    }
+
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
-- 
2.8.4
