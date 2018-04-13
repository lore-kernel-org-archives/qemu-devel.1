Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6oye-0006Vp-UJ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 23:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6oyY-0003tx-FW
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 23:02:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6oyY-0003tU-Aa
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 23:02:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B1208185338
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 03:01:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Apr 2018 11:01:49 +0800
Message-Id: <1523588509-4868-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] vhost: do not verify ring mappings when IOMMU
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

When IOMMU is enabled, we store virtqueue metadata as iova (though it
may has _phys suffix) and access them through dma helpers. Any
translation failures could be reported by IOMMU.

In this case, trying to validate iova against gpa won't work and will
cause a false error reporting. So this patch bypasses the ring
verification if IOMMU is enabled which is similar to the behavior
before 0ca1fd2d6878 that calls vhost_memory_map() which is a nop when
IOMMU is enabled.

Fixes: 0ca1fd2d6878 ("vhost: Simplify ring verification checks")
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f51bf57..9d5850a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -342,6 +342,10 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
         "used ring"
     };
 
+    if (vhost_dev_has_iommu(dev)) {
+        return 0;
+    }
+
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
 
-- 
2.7.4
