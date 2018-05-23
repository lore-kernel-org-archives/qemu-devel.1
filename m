Received: from eggs.gnu.org ([2001:4830:134:3::10]:48812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyi-0001de-5y
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyf-0000l6-1y
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUye-0000ky-Rr
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:56 -0400
Date: Wed, 23 May 2018 17:42:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-5-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/28] vhost: add trace for IOTLB miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Add some trace points for IOTLB translation for vhost. After vhost-user
is setup, the only IO path that QEMU will participate should be the
IOMMU translation, so it'll be good we can track this with explicit
timestamps when needed to see how long time we take to do the
translation, and whether there's anything stuck inside.  It might be
useful for triaging vhost-user problems.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c      | 7 +++++++
 hw/virtio/trace-events | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9d5850a..b082900 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -894,12 +894,15 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
 
     rcu_read_lock();
 
+    trace_vhost_iotlb_miss(dev, 1);
+
     iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
                                           iova, write);
     if (iotlb.target_as != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
                                          &uaddr, &len);
         if (ret) {
+            trace_vhost_iotlb_miss(dev, 3);
             error_report("Fail to lookup the translated address "
                          "%"PRIx64, iotlb.translated_addr);
             goto out;
@@ -911,10 +914,14 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
                                                 len, iotlb.perm);
         if (ret) {
+            trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
             goto out;
         }
     }
+
+    trace_vhost_iotlb_miss(dev, 2);
+
 out:
     rcu_read_unlock();
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1422ff0..07bcbe9 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -6,6 +6,7 @@ vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t
 vhost_region_add_section_merge(const char *name, uint64_t new_size, uint64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"PRIx64
 vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
+vhost_iotlb_miss(void *dev, int step) "%p step %d"
 
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_end_entry(void) ""
-- 
MST
