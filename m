Received: from eggs.gnu.org ([2001:4830:134:3::10]:50190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKh-0002YT-An
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKg-0001Z9-Bf
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNPKg-0001YD-3O
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:18 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Dec 2017 20:32:57 +0000
Message-Id: <20171208203257.13102-9-dgilbert@redhat.com>
In-Reply-To: <20171208203257.13102-1-dgilbert@redhat.com>
References: <20171208203257.13102-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 8/8] vhost: Move mem_sections maintenance into
 commit/update routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Mvoe the maintenance of mem_sections into the vhost_update_mem routines,
this removes the need for the vhost_region_add/del callbacks.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
  (and mostly written by Igor!)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 58 +++++++++++++++----------------------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2cfb13272f..79927ab93d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -408,6 +408,13 @@ static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
     if (!vhost_section(mrs)) {
         return 0;
     }
+    ++vtmp->dev->n_mem_sections;
+    vtmp->dev->mem_sections = g_renew(MemoryRegionSection,
+                                      vtmp->dev->mem_sections,
+                                      vtmp->dev->n_mem_sections);
+    vtmp->dev->mem_sections[vtmp->dev->n_mem_sections - 1] = *mrs;
+    memory_region_ref(mrs->mr);
+
     mrs_size = int128_get64(mrs->size);
     mrs_gpa  = mrs->offset_within_address_space;
     mrs_host = (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
@@ -461,6 +468,7 @@ static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
 static int vhost_update_mem(struct vhost_dev *dev, bool *changed)
 {
     int res;
+    unsigned i;
     struct vhost_update_mem_tmp vtmp;
     size_t mem_size;
     vtmp.regions = 0;
@@ -469,6 +477,14 @@ static int vhost_update_mem(struct vhost_dev *dev, bool *changed)
 
     trace_vhost_update_mem();
     *changed = false;
+    /* Clear out the section list, it'll get rebuilt */
+    for (i = 0; i < dev->n_mem_sections; i++) {
+        memory_region_unref(dev->mem_sections[i].mr);
+    }
+    g_free(dev->mem_sections);
+    dev->mem_sections = NULL;
+    dev->n_mem_sections = 0;
+
     res = address_space_iterate(&address_space_memory,
                                 vhost_update_mem_cb, &vtmp);
     if (res) {
@@ -553,46 +569,6 @@ static void vhost_commit(MemoryListener *listener)
     }
 }
 
-static void vhost_region_add(MemoryListener *listener,
-                             MemoryRegionSection *section)
-{
-    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
-                                         memory_listener);
-
-    if (!vhost_section(section)) {
-        return;
-    }
-
-    ++dev->n_mem_sections;
-    dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
-                                dev->n_mem_sections);
-    dev->mem_sections[dev->n_mem_sections - 1] = *section;
-    memory_region_ref(section->mr);
-}
-
-static void vhost_region_del(MemoryListener *listener,
-                             MemoryRegionSection *section)
-{
-    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
-                                         memory_listener);
-    int i;
-
-    if (!vhost_section(section)) {
-        return;
-    }
-
-    memory_region_unref(section->mr);
-    for (i = 0; i < dev->n_mem_sections; ++i) {
-        if (dev->mem_sections[i].offset_within_address_space
-            == section->offset_within_address_space) {
-            --dev->n_mem_sections;
-            memmove(&dev->mem_sections[i], &dev->mem_sections[i+1],
-                    (dev->n_mem_sections - i) * sizeof(*dev->mem_sections));
-            break;
-        }
-    }
-}
-
 static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
@@ -1161,8 +1137,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->memory_listener = (MemoryListener) {
         .commit = vhost_commit,
-        .region_add = vhost_region_add,
-        .region_del = vhost_region_del,
         .region_nop = vhost_region_nop,
         .log_start = vhost_log_start,
         .log_stop = vhost_log_stop,
-- 
2.14.3
