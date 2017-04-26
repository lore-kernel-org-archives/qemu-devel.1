Received: from eggs.gnu.org ([2001:4830:134:3::10]:50288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6l-0002Jw-8n
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6j-00021n-2x
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:34289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K6i-0001zT-Pl
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:37 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:34 +0800
Message-Id: <1493201210-14357-5-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 04/20] Memory: modify parameter in
 IOMMUNotifier func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch modifies parameter of IOMMUNotifier, use "void *data" instead
of "IOMMUTLBEntry*". This is to extend it to support notifiers other than
MAP/UNMAP.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c      | 3 ++-
 hw/virtio/vhost.c     | 3 ++-
 include/exec/memory.h | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6b33b9f..14473f1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -332,10 +332,11 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
     return true;
 }
 
-static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vfio_iommu_map_notify(IOMMUNotifier *n, void *data)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainer *container = giommu->container;
+    IOMMUTLBEntry *iotlb = (IOMMUTLBEntry *)data;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     bool read_only;
     void *vaddr;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ccf8b2e..fd20fd0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1161,9 +1161,10 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     event_notifier_cleanup(&vq->masked_notifier);
 }
 
-static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vhost_iommu_unmap_notify(IOMMUNotifier *n, void *data)
 {
     struct vhost_dev *hdev = container_of(n, struct vhost_dev, n);
+    IOMMUTLBEntry *iotlb = (IOMMUTLBEntry *)data;
 
     if (hdev->vhost_ops->vhost_invalidate_device_iotlb(hdev,
                                                        iotlb->iova,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 267f399..1faca3b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -81,7 +81,7 @@ typedef enum {
 
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
-                            IOMMUTLBEntry *data);
+                            void *data);
 
 struct IOMMUNotifier {
     IOMMUNotify notify;
-- 
1.9.1
