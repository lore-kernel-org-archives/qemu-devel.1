Received: from eggs.gnu.org ([2001:4830:134:3::10]:51282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVck-0005A5-52
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVci-0003sK-SA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebVci-0003rq-Je
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEACAC059B81
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:06:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 16 Jan 2018 18:04:03 +0000
Message-Id: <20180116180408.11279-3-dgilbert@redhat.com>
In-Reply-To: <20180116180408.11279-1-dgilbert@redhat.com>
References: <20180116180408.11279-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/7] vhost: Simplify ring verification checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

vhost_verify_ring_mappings() were used to verify that
rings are still accessible and related memory hasn't
been moved after flatview is updated.

It was doing checks by mapping ring's GPA+len and
checking that HVA hadn't changed with new memory map.
To avoid maybe expensive mapping call, we were
identifying address range that changed and were doing
mapping only if ring was in changed range.

However it's not neccessary to perform ring's GPA
mapping as we already have its current HVA and all
we need is to verify that ring's GPA translates to
the same HVA in updated flatview.

This will allow the following patches to simplify the range
comparison that was previously needed to avoid expensive
verify_ring_mapping calls.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
with modifications by:
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/virtio/vhost.c | 75 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 610bfe6945..999ce48259 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -449,35 +449,37 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
     }
 }
 
-static int vhost_verify_ring_part_mapping(struct vhost_dev *dev,
-                                          void *part,
-                                          uint64_t part_addr,
-                                          uint64_t part_size,
-                                          uint64_t start_addr,
-                                          uint64_t size)
+static int vhost_verify_ring_part_mapping(void *ring_hva,
+                                          uint64_t ring_gpa,
+                                          uint64_t ring_size,
+                                          void *reg_hva,
+                                          uint64_t reg_gpa,
+                                          uint64_t reg_size)
 {
-    hwaddr l;
-    void *p;
-    int r = 0;
+    uint64_t hva_ring_offset;
+    uint64_t ring_last = range_get_last(ring_gpa, ring_size);
+    uint64_t reg_last = range_get_last(reg_gpa, reg_size);
 
-    if (!ranges_overlap(start_addr, size, part_addr, part_size)) {
+    if (ring_last < reg_gpa || ring_gpa > reg_last) {
         return 0;
     }
-    l = part_size;
-    p = vhost_memory_map(dev, part_addr, &l, 1);
-    if (!p || l != part_size) {
-        r = -ENOMEM;
+    /* check that whole ring's is mapped */
+    if (ring_last > reg_last) {
+        return -ENOMEM;
     }
-    if (p != part) {
-        r = -EBUSY;
+    /* check that ring's MemoryRegion wasn't replaced */
+    hva_ring_offset = ring_gpa - reg_gpa;
+    if (ring_hva != reg_hva + hva_ring_offset) {
+        return -EBUSY;
     }
-    vhost_memory_unmap(dev, p, l, 0, 0);
-    return r;
+
+    return 0;
 }
 
 static int vhost_verify_ring_mappings(struct vhost_dev *dev,
-                                      uint64_t start_addr,
-                                      uint64_t size)
+                                      void *reg_hva,
+                                      uint64_t reg_gpa,
+                                      uint64_t reg_size)
 {
     int i, j;
     int r = 0;
@@ -491,22 +493,25 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
         struct vhost_virtqueue *vq = dev->vqs + i;
 
         j = 0;
-        r = vhost_verify_ring_part_mapping(dev, vq->desc, vq->desc_phys,
-                                           vq->desc_size, start_addr, size);
+        r = vhost_verify_ring_part_mapping(
+                vq->desc, vq->desc_phys, vq->desc_size,
+                reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
         }
 
         j++;
-        r = vhost_verify_ring_part_mapping(dev, vq->avail, vq->avail_phys,
-                                           vq->avail_size, start_addr, size);
+        r = vhost_verify_ring_part_mapping(
+                vq->desc, vq->desc_phys, vq->desc_size,
+                reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
         }
 
         j++;
-        r = vhost_verify_ring_part_mapping(dev, vq->used, vq->used_phys,
-                                           vq->used_size, start_addr, size);
+        r = vhost_verify_ring_part_mapping(
+                vq->desc, vq->desc_phys, vq->desc_size,
+                reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
         }
@@ -629,13 +634,11 @@ static void vhost_commit(MemoryListener *listener)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
-    hwaddr start_addr = 0;
-    ram_addr_t size = 0;
     MemoryRegionSection *old_sections;
     int n_old_sections;
-
     uint64_t log_size;
     int r;
+    int i;
 
     old_sections = dev->mem_sections;
     n_old_sections = dev->n_mem_sections;
@@ -652,12 +655,14 @@ static void vhost_commit(MemoryListener *listener)
         goto out;
     }
 
-    if (dev->started) {
-        start_addr = dev->mem_changed_start_addr;
-        size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
-
-        r = vhost_verify_ring_mappings(dev, start_addr, size);
-        assert(r >= 0);
+    for (i = 0; i < dev->mem->nregions; i++) {
+        if (vhost_verify_ring_mappings(dev,
+                       (void *)(uintptr_t)dev->mem->regions[i].userspace_addr,
+                       dev->mem->regions[i].guest_phys_addr,
+                       dev->mem->regions[i].memory_size)) {
+            error_report("Verify ring failure on region %d", i);
+            abort();
+        }
     }
 
     if (!dev->log_enabled) {
-- 
2.14.3
