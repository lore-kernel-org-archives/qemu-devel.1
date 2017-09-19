Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDGX-0008QF-Uw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDGX-0000xr-12
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:48:22 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 19 Sep 2017 09:46:39 +0200
Message-Id: <1505807208-9063-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 07/16] virtio-iommu: Implement attach/detach
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This patch implements the device attach/detach to an
address space.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 41a4bbc..bd859fb 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -110,8 +110,7 @@ static void virtio_iommu_put_dev(gpointer data)
     g_free(dev);
 }
 
-viommu_as *virtio_iommu_get_as(VirtIOIOMMU *s, uint32_t asid);
-viommu_as *virtio_iommu_get_as(VirtIOIOMMU *s, uint32_t asid)
+static viommu_as *virtio_iommu_get_as(VirtIOIOMMU *s, uint32_t asid)
 {
     viommu_as *as;
 
@@ -205,6 +204,8 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     uint32_t asid = le32_to_cpu(req->address_space);
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    viommu_as *as;
+    viommu_dev *dev;
 
     trace_virtio_iommu_attach(asid, devid);
 
@@ -212,7 +213,22 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    dev = virtio_iommu_get_dev(s, devid);
+    if (dev->as) {
+        /*
+         * the device is already attached to an address space,
+         * detach it first
+         */
+        virtio_iommu_detach_dev_from_as(dev);
+    }
+
+    as = virtio_iommu_get_as(s, asid);
+    QLIST_INSERT_HEAD(&as->device_list, dev, next);
+
+    dev->as = as;
+    g_tree_ref(as->mappings);
+
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -220,14 +236,24 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
-
-    trace_virtio_iommu_detach(devid);
+    viommu_dev *dev;
 
     if (reserved) {
         return VIRTIO_IOMMU_S_INVAL;
     }
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
+    if (!dev) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    if (!dev->as) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    virtio_iommu_detach_dev_from_as(dev);
+    trace_virtio_iommu_detach(devid);
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_map(VirtIOIOMMU *s,
-- 
2.5.5
