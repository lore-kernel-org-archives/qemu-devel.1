Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVdL-0005cF-4c
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVdG-0004Mz-Dw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebVdG-0004M2-6H
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:06:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68E3E78522
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:06:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 16 Jan 2018 18:04:05 +0000
Message-Id: <20180116180408.11279-5-dgilbert@redhat.com>
In-Reply-To: <20180116180408.11279-1-dgilbert@redhat.com>
References: <20180116180408.11279-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v6 4/7] vhost: Regenerate region list from
 changed sections list
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

Compare the sections list that's just been generated, and if it's
different from the old one regenerate the region list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost.c      | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index ab9da06244..606e4fc949 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost.c
+vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 15d466356e..cf8d5a0a92 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -637,21 +637,52 @@ static void vhost_commit(MemoryListener *listener)
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
+        changed = memcmp(dev->mem_sections, old_sections,
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
 
-- 
2.14.3
