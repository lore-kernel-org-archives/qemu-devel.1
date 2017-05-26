Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dEGFH-0001K4-6s
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dEGFD-0008GF-8z
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dEGFD-0008Dr-3Q
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:35 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 26 May 2017 16:28:55 +0200
Message-Id: <20170526142858.19931-4-maxime.coquelin@redhat.com>
In-Reply-To: <20170526142858.19931-1-maxime.coquelin@redhat.com>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] vhost: extend ring information update
 for IOTLB to all rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

Vhost-kernel backend need to receive IOTLB entry for used ring
information early, which is done by triggering a miss event on
its address.

This patch extends this behaviour to all rings information, to be
compatible with vhost-user backend design.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
v2:
 - Revert back to existing behaviour, i.e. only send IOTLB updates
at ring enablement time, not at ring address setting time (mst).
 - Extend IOTLB misses to all ring addresses, not only used ring.

 hw/virtio/vhost.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb09..7867034 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1552,11 +1552,15 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
     if (vhost_dev_has_iommu(hdev)) {
         hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
 
-        /* Update used ring information for IOTLB to work correctly,
-         * vhost-kernel code requires for this.*/
+        /*
+         * Update rings information for IOTLB to work correctly,
+         * vhost-kernel and vhost-user codes require for this.
+         */
         for (i = 0; i < hdev->nvqs; ++i) {
             struct vhost_virtqueue *vq = hdev->vqs + i;
             vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            vhost_device_iotlb_miss(hdev, vq->desc_phys, true);
+            vhost_device_iotlb_miss(hdev, vq->avail_phys, true);
         }
     }
     return 0;
-- 
2.9.4
