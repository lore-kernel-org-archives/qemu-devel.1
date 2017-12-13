Received: from eggs.gnu.org ([2001:4830:134:3::10]:49763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBSH-0000z5-0b
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBSE-0004FB-K8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePBSE-0004ER-AL
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:26 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 13 Dec 2017 18:08:05 +0000
Message-Id: <20171213180807.7066-5-dgilbert@redhat.com>
In-Reply-To: <20171213180807.7066-1-dgilbert@redhat.com>
References: <20171213180807.7066-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

As regions are reported by the listener to the _nop and _add
methods, add them to our new temporary list.
Regions that abut can be merged if the backend allows.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  2 ++
 hw/virtio/vhost.c      | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4a493bcd46..7de0663652 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost.c
+vhost_region_add_tmp(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
+vhost_region_add_tmp_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/virtio.c
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4523f45587..2084888aa7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -694,6 +694,67 @@ static void vhost_commit(MemoryListener *listener)
     dev->memory_changed = false;
 }
 
+/* Adds the section data to the tmp_mem structure.
+ * It relies on the listener calling us in memory address order
+ * and for each region (via the _add and _nop methods).
+ */
+static void vhost_region_add_tmp(struct vhost_dev *dev,
+                                 MemoryRegionSection *section)
+{
+    bool need_add = true;
+    uint64_t mrs_size = int128_get64(section->size);
+    uint64_t mrs_gpa = section->offset_within_address_space;
+    uintptr_t mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+                         section->offset_within_region;
+
+    trace_vhost_region_add_tmp(section->mr->name, mrs_gpa, mrs_size, mrs_host);
+
+    if (dev->tmp_mem->nregions) {
+        /* Since we already have at least one region, lets see if
+         * this extends it; since we're scanning in order, we only
+         * have to look at the last one, and the FlatView that calls
+         * us shouldn't have overlaps.
+         */
+        struct vhost_memory_region *prev_vmr = dev->tmp_mem->regions +
+                                               (dev->tmp_mem->nregions - 1);
+        uint64_t prev_gpa_start = prev_vmr->guest_phys_addr;
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start,
+                                                 prev_vmr->memory_size);
+        uint64_t prev_host_start = prev_vmr->userspace_addr;
+        uint64_t prev_host_end   = range_get_last(prev_host_start,
+                                                  prev_vmr->memory_size);
+
+        if (prev_gpa_end + 1 == mrs_gpa &&
+            prev_host_end + 1 == mrs_host &&
+            (!dev->vhost_ops->vhost_backend_can_merge ||
+                dev->vhost_ops->vhost_backend_can_merge(dev,
+                    mrs_host, mrs_size,
+                    prev_host_start, prev_vmr->memory_size))) {
+            /* The two regions abut */
+            need_add = false;
+            mrs_size = mrs_size + prev_vmr->memory_size;
+            prev_vmr->memory_size = mrs_size;
+            trace_vhost_region_add_tmp_abut(section->mr->name, mrs_size);
+        }
+    }
+
+    if (need_add) {
+        uint32_t nregions = dev->tmp_mem->nregions;
+        size_t s = offsetof(struct vhost_memory, regions) +
+                            (nregions + 1) * sizeof dev->tmp_mem->regions[0];
+        dev->tmp_mem = g_realloc(dev->tmp_mem, s);
+        dev->tmp_mem->nregions++;
+        struct vhost_memory_region *cur_vmr = &dev->tmp_mem->regions[nregions];
+
+        cur_vmr->guest_phys_addr = mrs_gpa;
+        cur_vmr->memory_size     = mrs_size;
+        cur_vmr->userspace_addr  = mrs_host;
+        cur_vmr->flags_padding = 0;
+    }
+
+
+}
+
 static void vhost_region_add(MemoryListener *listener,
                              MemoryRegionSection *section)
 {
@@ -703,6 +764,7 @@ static void vhost_region_add(MemoryListener *listener,
     if (!vhost_section(section)) {
         return;
     }
+    vhost_region_add_tmp(dev, section);
 
     ++dev->n_mem_sections;
     dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
@@ -800,9 +862,17 @@ static void vhost_iommu_region_del(MemoryListener *listener,
     }
 }
 
+/* Called on regions that have not changed */
 static void vhost_region_nop(MemoryListener *listener,
                              MemoryRegionSection *section)
 {
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    if (!vhost_section(section)) {
+        return;
+    }
+
+    vhost_region_add_tmp(dev, section);
 }
 
 static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
-- 
2.14.3
