Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVP2-0000f9-V5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVP1-0003G3-NQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVP1-0003EI-E0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:03 -0500
Date: Tue, 16 Jan 2018 19:51:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-23-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/34] vhost: Simplify ring verification
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/virtio/vhost.c | 79 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8a85dde..8fdd073 100644
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
-{
-    hwaddr l;
-    void *p;
-    int r = 0;
-
-    if (!ranges_overlap(start_addr, size, part_addr, part_size)) {
+static int vhost_verify_ring_part_mapping(void *ring_hva,
+                                          uint64_t ring_gpa,
+                                          uint64_t ring_size,
+                                          void *reg_hva,
+                                          uint64_t reg_gpa,
+                                          uint64_t reg_size)
+{
+    uint64_t hva_ring_offset;
+    uint64_t ring_last = range_get_last(ring_gpa, ring_size);
+    uint64_t reg_last = range_get_last(reg_gpa, reg_size);
+
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
@@ -652,12 +655,16 @@ static void vhost_commit(MemoryListener *listener)
         goto out;
     }
 
-    if (dev->started) {
-        start_addr = dev->mem_changed_start_addr;
-        size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
+    for (i = 0; i < dev->mem->nregions; i++) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
 
-        r = vhost_verify_ring_mappings(dev, start_addr, size);
-        assert(r >= 0);
+        if (vhost_verify_ring_mappings(dev,
+                                       (void *)(uintptr_t)reg->userspace_addr,
+                                       reg->guest_phys_addr,
+                                       reg->memory_size)) {
+            error_report("Verify ring failure on region %d", i);
+            abort();
+        }
     }
 
     if (!dev->log_enabled) {
-- 
MST
