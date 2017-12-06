Received: from eggs.gnu.org ([2001:4830:134:3::10]:49728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCc-0000tU-2q
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCZ-0000u2-Mk
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCZ-0000sx-E6
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEb0h013906
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm4274x4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:50 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:48 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:34 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-42-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 41/55] virtio: Add queue interface to restore
 avail index from vring used index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

In case of backend crash, it is not possible to restore internal
avail index from the backend value as vhost_get_vring_base
callback fails.

This patch provides a new interface to restore internal avail index
from the vring used index, as done by some vhost-user backend on
reconnection.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2d4ba6cc741df15df6fbb4feaa706a02e103083a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c         | 10 ++++++++++
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f76d..15cf6021a0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2311,6 +2311,16 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
     vdev->vq[n].shadow_avail_idx = idx;
 }
 
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+{
+    rcu_read_lock();
+    if (vdev->vq[n].vring.desc) {
+        vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
+        vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
+    }
+    rcu_read_unlock();
+}
+
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
     rcu_read_lock();
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c321e..3d5c84e829 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -272,6 +272,7 @@ hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
-- 
2.11.0
