Received: from eggs.gnu.org ([2001:4830:134:3::10]:52327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f87IG-0006i8-Ru
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f87IC-0003Im-QI
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f87IC-0003Hv-MW
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:48 -0400
Date: Mon, 16 Apr 2018 19:47:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523895458-475479-2-git-send-email-mst@redhat.com>
References: <1523895458-475479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523895458-475479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] vhost: do not verify ring mappings when
 IOMMU is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Jason Wang <jasowang@redhat.com>

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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
