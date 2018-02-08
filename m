Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZB-00063S-0b
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ9-0008Ge-Sc
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZ9-0008GK-M8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:03 -0500
Date: Thu, 8 Feb 2018 21:09:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-8-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/26] vhost: Regenerate region list from
 changed sections list
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

Compare the sections list that's just been generated, and if it's
different from the old one regenerate the region list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/virtio/vhost.c      | 39 +++++++++++++++++++++++++++++++++++----
 hw/virtio/trace-events |  1 +
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 351c691..f3badc4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -643,21 +643,52 @@ static void vhost_commit(MemoryListener *listener)
     MemoryRegionSection *old_sections;
     int n_old_sections;
     uint64_t log_size;
+    size_t regions_size;
     int r;
     int i;
+    bool changed = false;
 
+    /* Note we can be called before the device is started, but then
+     * starting the device calls set_mem_table, so we need to have
+     * built the data structures.
+     */
     old_sections = dev->mem_sections;
     n_old_sections = dev->n_mem_sections;
     dev->mem_sections = dev->tmp_sections;
     dev->n_mem_sections = dev->n_tmp_sections;
 
-    if (!dev->memory_changed) {
-        goto out;
+    if (dev->n_mem_sections != n_old_sections) {
+        changed = true;
+    } else {
+        /* Same size, lets check the contents */
+        changed = n_old_sections && memcmp(dev->mem_sections, old_sections,
+                         n_old_sections * sizeof(old_sections[0])) != 0;
     }
-    if (!dev->started) {
+
+    trace_vhost_commit(dev->started, changed);
+    if (!changed) {
         goto out;
     }
-    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
+
+    /* Rebuild the regions list from the new sections list */
+    regions_size = offsetof(struct vhost_memory, regions) +
+                       dev->n_mem_sections * sizeof dev->mem->regions[0];
+    dev->mem = g_realloc(dev->mem, regions_size);
+    dev->mem->nregions = dev->n_mem_sections;
+    used_memslots = dev->mem->nregions;
+    for (i = 0; i < dev->n_mem_sections; i++) {
+        struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
+        struct MemoryRegionSection *mrs = dev->mem_sections + i;
+
+        cur_vmr->guest_phys_addr = mrs->offset_within_address_space;
+        cur_vmr->memory_size     = int128_get64(mrs->size);
+        cur_vmr->userspace_addr  =
+            (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
+            mrs->offset_within_region;
+        cur_vmr->flags_padding   = 0;
+    }
+
+    if (!dev->started) {
         goto out;
     }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index ab9da06..606e4fc 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost.c
+vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 
-- 
MST
