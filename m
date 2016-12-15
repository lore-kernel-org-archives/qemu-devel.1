Received: from eggs.gnu.org ([2001:4830:134:3::10]:43067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCB-00045b-Sk
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC9-0001Wd-3r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC8-0001Vq-Q4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbRR129125
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:47 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkw90yd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:47 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:46 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:42 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-49-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 48/67] vhost: adapt
 vhost_verify_ring_mappings() to virtio 1 ring layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

From: Greg Kurz <groug@kaod.org>

With virtio 1, the vring layout is split in 3 separate regions of
contiguous memory for the descriptor table, the available ring and the
used ring, as opposed with legacy virtio which uses a single region.

In case of memory re-mapping, the code ensures it doesn't affect the
vring mapping. This is done in vhost_verify_ring_mappings() which assumes
the device is legacy.

This patch changes vhost_verify_ring_mappings() to check the mappings of
each part of the vring separately.

This works for legacy mappings as well.

Cc: qemu-stable@nongnu.org
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit f1f9e6c5961ffb36fd4a81cd7edcded7bfad2ab2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c         | 79 +++++++++++++++++++++++++++++++++++------------
 include/hw/virtio/vhost.h |  4 +++
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3d0c807..b89f253 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -421,32 +421,73 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
     dev->log_size = size;
 }
 
+
+static int vhost_verify_ring_part_mapping(void *part,
+                                          uint64_t part_addr,
+                                          uint64_t part_size,
+                                          uint64_t start_addr,
+                                          uint64_t size)
+{
+    hwaddr l;
+    void *p;
+    int r = 0;
+
+    if (!ranges_overlap(start_addr, size, part_addr, part_size)) {
+        return 0;
+    }
+    l = part_size;
+    p = cpu_physical_memory_map(part_addr, &l, 1);
+    if (!p || l != part_size) {
+        r = -ENOMEM;
+    }
+    if (p != part) {
+        r = -EBUSY;
+    }
+    cpu_physical_memory_unmap(p, l, 0, 0);
+    return r;
+}
+
 static int vhost_verify_ring_mappings(struct vhost_dev *dev,
                                       uint64_t start_addr,
                                       uint64_t size)
 {
-    int i;
+    int i, j;
     int r = 0;
+    const char *part_name[] = {
+        "descriptor table",
+        "available ring",
+        "used ring"
+    };
 
-    for (i = 0; !r && i < dev->nvqs; ++i) {
+    for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
-        hwaddr l;
-        void *p;
 
-        if (!ranges_overlap(start_addr, size, vq->ring_phys, vq->ring_size)) {
-            continue;
+        j = 0;
+        r = vhost_verify_ring_part_mapping(vq->desc, vq->desc_phys,
+                                           vq->desc_size, start_addr, size);
+        if (!r) {
+            break;
         }
-        l = vq->ring_size;
-        p = cpu_physical_memory_map(vq->ring_phys, &l, 1);
-        if (!p || l != vq->ring_size) {
-            error_report("Unable to map ring buffer for ring %d", i);
-            r = -ENOMEM;
+
+        j++;
+        r = vhost_verify_ring_part_mapping(vq->avail, vq->avail_phys,
+                                           vq->avail_size, start_addr, size);
+        if (!r) {
+            break;
         }
-        if (p != vq->ring) {
-            error_report("Ring buffer relocated for ring %d", i);
-            r = -EBUSY;
+
+        j++;
+        r = vhost_verify_ring_part_mapping(vq->used, vq->used_phys,
+                                           vq->used_size, start_addr, size);
+        if (!r) {
+            break;
         }
-        cpu_physical_memory_unmap(p, l, 0, 0);
+    }
+
+    if (r == -ENOMEM) {
+        error_report("Unable to map %s for ring %d", part_name[j], i);
+    } else if (r == -EBUSY) {
+        error_report("%s relocated for ring %d", part_name[j], i);
     }
     return r;
 }
@@ -857,15 +898,15 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    s = l = virtio_queue_get_desc_size(vdev, idx);
-    a = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
     vq->desc = cpu_physical_memory_map(a, &l, 0);
     if (!vq->desc || l != s) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
-    s = l = virtio_queue_get_avail_size(vdev, idx);
-    a = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
     vq->avail = cpu_physical_memory_map(a, &l, 0);
     if (!vq->avail || l != s) {
         r = -ENOMEM;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index e433089..56b567f 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -14,6 +14,10 @@ struct vhost_virtqueue {
     void *avail;
     void *used;
     int num;
+    unsigned long long desc_phys;
+    unsigned desc_size;
+    unsigned long long avail_phys;
+    unsigned avail_size;
     unsigned long long used_phys;
     unsigned used_size;
     void *ring;
-- 
1.9.1
