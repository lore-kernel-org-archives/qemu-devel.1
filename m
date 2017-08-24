Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpL-0003nO-L2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxpI-0005gM-Dt
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxpI-0005ft-4m
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:30:00 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:28 +0100
Message-Id: <20170824192730.8440-31-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 30/32] vhost: Merge neighbouring hugepage
 regions where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Where two regions are created with a gap such that when aligned
to hugepage boundaries, the two regions overlap, merge them.

I also add quite a few trace events to see what's going on.

Note: This doesn't handle all the cases, but does handle the common
case on a PC due to the 640k hole.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/trace-events | 11 +++++++
 hw/virtio/vhost.c      | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 5b599617a1..f98efb39fd 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,5 +1,16 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/virtio/vhost.c
+vhost_dev_assign_memory_merged(int from, int to, uint64_t size, uint64_t start_addr, uint64_t uaddr) "f/t=%d/%d 0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
+vhost_dev_assign_memory_not_merged(uint64_t size, uint64_t start_addr, uint64_t uaddr) "0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
+vhost_dev_assign_memory_entry(uint64_t size, uint64_t start_addr, uint64_t uaddr) "0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
+vhost_dev_assign_memory_exit(uint32_t nregions) "%"PRId32
+vhost_huge_page_stretch_and_merge_entry(uint32_t nregions) "%"PRId32
+vhost_huge_page_stretch_and_merge_can(void) ""
+vhost_huge_page_stretch_and_merge_size_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
+vhost_huge_page_stretch_and_merge_start_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
+vhost_section(const char *name, int r) "%s:%d"
+
 # hw/virtio/vhost-user.c
 vhost_user_postcopy_end_entry(void) ""
 vhost_user_postcopy_end_exit(void) ""
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb099b0..fb506e747f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -250,6 +251,8 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
 {
     int from, to;
     struct vhost_memory_region *merged = NULL;
+    trace_vhost_dev_assign_memory_entry(size, start_addr, uaddr);
+
     for (from = 0, to = 0; from < dev->mem->nregions; ++from, ++to) {
         struct vhost_memory_region *reg = dev->mem->regions + to;
         uint64_t prlast, urlast;
@@ -293,11 +296,13 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
         uaddr = merged->userspace_addr = u;
         start_addr = merged->guest_phys_addr = s;
         size = merged->memory_size = e - s + 1;
+        trace_vhost_dev_assign_memory_merged(from, to, size, start_addr, uaddr);
         assert(merged->memory_size);
     }
 
     if (!merged) {
         struct vhost_memory_region *reg = dev->mem->regions + to;
+        trace_vhost_dev_assign_memory_not_merged(size, start_addr, uaddr);
         memset(reg, 0, sizeof *reg);
         reg->memory_size = size;
         assert(reg->memory_size);
@@ -307,6 +312,7 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
     }
     assert(to <= dev->mem->nregions + 1);
     dev->mem->nregions = to;
+    trace_vhost_dev_assign_memory_exit(to);
 }
 
 static uint64_t vhost_get_log_size(struct vhost_dev *dev)
@@ -610,8 +616,12 @@ static void vhost_set_memory(MemoryListener *listener,
 
 static bool vhost_section(MemoryRegionSection *section)
 {
-    return memory_region_is_ram(section->mr) &&
+    bool result;
+    result = memory_region_is_ram(section->mr) &&
         !memory_region_is_rom(section->mr);
+
+    trace_vhost_section(section->mr->name, result);
+    return result;
 }
 
 static void vhost_begin(MemoryListener *listener)
@@ -622,6 +632,68 @@ static void vhost_begin(MemoryListener *listener)
     dev->mem_changed_start_addr = -1;
 }
 
+/* Look for regions that are hugepage backed but not aligned
+ * and fix them up to be aligned.
+ * TODO: For now this is just enough to deal with the 640k hole
+ */
+static bool vhost_huge_page_stretch_and_merge(struct vhost_dev *dev)
+{
+    int i, j;
+    bool result = true;
+    trace_vhost_huge_page_stretch_and_merge_entry(dev->mem->nregions);
+
+    for (i = 0; i < dev->mem->nregions; i++) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        RAMBlock *rb = qemu_ram_block_from_host((void *)reg->userspace_addr,
+                                                false, &offset);
+        size_t pagesize = qemu_ram_pagesize(rb);
+        uint64_t alignage;
+        alignage = reg->guest_phys_addr & (pagesize - 1);
+        if (alignage) {
+
+            trace_vhost_huge_page_stretch_and_merge_start_align(i,
+                                                (uint64_t)reg->guest_phys_addr,
+                                                alignage);
+            for (j = 0; j < dev->mem->nregions; j++) {
+                struct vhost_memory_region *oreg = dev->mem->regions + j;
+                if (j == i) {
+                    continue;
+                }
+
+                if (oreg->guest_phys_addr ==
+                        (reg->guest_phys_addr - alignage) &&
+                    oreg->userspace_addr ==
+                         (reg->userspace_addr - alignage)) {
+                    struct vhost_memory_region treg = *reg;
+                    trace_vhost_huge_page_stretch_and_merge_can();
+                    vhost_dev_unassign_memory(dev, oreg->guest_phys_addr,
+                                              oreg->memory_size);
+                    vhost_dev_unassign_memory(dev, treg.guest_phys_addr,
+                                              treg.memory_size);
+                    vhost_dev_assign_memory(dev,
+                                            treg.guest_phys_addr - alignage,
+                                            treg.memory_size + alignage,
+                                            treg.userspace_addr - alignage);
+                    return vhost_huge_page_stretch_and_merge(dev);
+                }
+            }
+        }
+        alignage = reg->memory_size & (pagesize - 1);
+        if (alignage) {
+            trace_vhost_huge_page_stretch_and_merge_size_align(i,
+                                               (uint64_t)reg->guest_phys_addr,
+                                               alignage);
+            /* We ignore this if we find something else to merge,
+             * so we only return false if we're left with this
+             */
+            result = false;
+        }
+    }
+
+    return result;
+}
+
 static void vhost_commit(MemoryListener *listener)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
@@ -641,6 +713,7 @@ static void vhost_commit(MemoryListener *listener)
         return;
     }
 
+    vhost_huge_page_stretch_and_merge(dev);
     if (dev->started) {
         start_addr = dev->mem_changed_start_addr;
         size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
@@ -1512,6 +1585,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         goto fail_features;
     }
 
+    if (!vhost_huge_page_stretch_and_merge(hdev)) {
+        VHOST_OPS_DEBUG("vhost_huge_page_stretch_and_merge failed");
+        goto fail_mem;
+    }
     if (vhost_dev_has_iommu(hdev)) {
         memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
     }
-- 
2.13.5
