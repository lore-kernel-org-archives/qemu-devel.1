Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX8-0007uz-Gw
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX7-0006OK-Ma
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpX7-0006NQ-Eh
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:41 -0400
Date: Fri, 2 Jun 2017 19:34:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-5-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] vhost: propagate errors in
 vhost_device_iotlb_miss()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Some backends might want to know when things went wrong.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  2 +-
 hw/virtio/vhost.c         | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a450321..467dc77 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -105,5 +105,5 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
-void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
+int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 #endif
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 03a46a7..8fab12d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -971,18 +971,20 @@ static int vhost_memory_region_lookup(struct vhost_dev *hdev,
     return -EFAULT;
 }
 
-void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
+int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
 {
     IOMMUTLBEntry iotlb;
     uint64_t uaddr, len;
+    int ret = -EFAULT;
 
     rcu_read_lock();
 
     iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
                                           iova, write);
     if (iotlb.target_as != NULL) {
-        if (vhost_memory_region_lookup(dev, iotlb.translated_addr,
-                                       &uaddr, &len)) {
+        ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
+                                         &uaddr, &len);
+        if (ret) {
             error_report("Fail to lookup the translated address "
                          "%"PRIx64, iotlb.translated_addr);
             goto out;
@@ -991,14 +993,17 @@ void vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
-        if (dev->vhost_ops->vhost_update_device_iotlb(dev, iova, uaddr,
-                                                      len, iotlb.perm)) {
+        ret = dev->vhost_ops->vhost_update_device_iotlb(dev, iova, uaddr,
+                                                      len, iotlb.perm);
+        if (ret) {
             error_report("Fail to update device iotlb");
             goto out;
         }
     }
 out:
     rcu_read_unlock();
+
+    return ret;
 }
 
 static int vhost_virtqueue_start(struct vhost_dev *dev,
-- 
MST
