Received: from eggs.gnu.org ([2001:4830:134:3::10]:48353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAS-0000DX-AA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAR-00051f-3a
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJAQ-00051F-Pz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:11 -0500
Date: Tue, 16 Jan 2018 06:48:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-25-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] vhost: Merge sections added to temporary
 list
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

As sections are reported by the listener to the _nop and _add
methods, add them to the temporary section list but now merge them
with the previous section if the new one abuts and the backend allows.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/interop/vhost-user.txt |  2 +-
 hw/virtio/vhost.c           | 72 ++++++++++++++++++++++++++++++++++++++-------
 hw/virtio/trace-events      |  2 ++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 9fcf48d..a8c5623 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -551,7 +551,7 @@ Master message types
       Master payload: N/A
       Slave payload: u64
 
-      Query how many queues the backend supports. This request should be
+      Query how many queue pairs the backend supports. This request should be
       sent only when VHOST_USER_PROTOCOL_F_MQ is set in queried protocol
       features by VHOST_USER_GET_PROTOCOL_FEATURES.
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0bdd833..e63099f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -709,14 +709,65 @@ out:
     return;
 }
 
-static void vhost_add_section(struct vhost_dev *dev,
-                              MemoryRegionSection *section)
-{
-    ++dev->n_tmp_sections;
-    dev->tmp_sections = g_renew(MemoryRegionSection, dev->tmp_sections,
-                                dev->n_tmp_sections);
-    dev->tmp_sections[dev->n_tmp_sections - 1] = *section;
-    memory_region_ref(section->mr);
+/* Adds the section data to the tmp_section structure.
+ * It relies on the listener calling us in memory address order
+ * and for each region (via the _add and _nop methods) to
+ * join neighbours.
+ */
+static void vhost_region_add_section(struct vhost_dev *dev,
+                                     MemoryRegionSection *section)
+{
+    bool need_add = true;
+    uint64_t mrs_size = int128_get64(section->size);
+    uint64_t mrs_gpa = section->offset_within_address_space;
+    uintptr_t mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+                         section->offset_within_region;
+
+    trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
+                                   mrs_host);
+
+    if (dev->n_tmp_sections) {
+        /* Since we already have at least one section, lets see if
+         * this extends it; since we're scanning in order, we only
+         * have to look at the last one, and the FlatView that calls
+         * us shouldn't have overlaps.
+         */
+        MemoryRegionSection *prev_sec = dev->tmp_sections +
+                                               (dev->n_tmp_sections - 1);
+        uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+        uint64_t prev_size = int128_get64(prev_sec->size);
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
+        uint64_t prev_host_start =
+                        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+                        prev_sec->offset_within_region;
+        uint64_t prev_host_end   = range_get_last(prev_host_start, prev_size);
+
+        if (prev_gpa_end + 1 == mrs_gpa &&
+            prev_host_end + 1 == mrs_host &&
+            section->mr == prev_sec->mr &&
+            (!dev->vhost_ops->vhost_backend_can_merge ||
+                dev->vhost_ops->vhost_backend_can_merge(dev,
+                    mrs_host, mrs_size,
+                    prev_host_start, prev_size))) {
+            /* The two sections abut */
+            need_add = false;
+            prev_sec->size = int128_add(prev_sec->size, section->size);
+            trace_vhost_region_add_section_abut(section->mr->name,
+                                                mrs_size + prev_size);
+        }
+    }
+
+    if (need_add) {
+        ++dev->n_tmp_sections;
+        dev->tmp_sections = g_renew(MemoryRegionSection, dev->tmp_sections,
+                                    dev->n_tmp_sections);
+        dev->tmp_sections[dev->n_tmp_sections - 1] = *section;
+        /* The flatview isn't stable and we don't use it, making it NULL
+         * means we can memcmp the list.
+         */
+        dev->tmp_sections[dev->n_tmp_sections - 1].fv = NULL;
+        memory_region_ref(section->mr);
+    }
 }
 
 static void vhost_region_add(MemoryListener *listener,
@@ -728,11 +779,12 @@ static void vhost_region_add(MemoryListener *listener,
     if (!vhost_section(section)) {
         return;
     }
+    vhost_region_add_section(dev, section);
 
-    vhost_add_section(dev, section);
     vhost_set_memory(listener, section, true);
 }
 
+/* Called on regions that have not changed */
 static void vhost_region_nop(MemoryListener *listener,
                              MemoryRegionSection *section)
 {
@@ -743,7 +795,7 @@ static void vhost_region_nop(MemoryListener *listener,
         return;
     }
 
-    vhost_add_section(dev, section);
+    vhost_region_add_section(dev, section);
 }
 
 static void vhost_region_del(MemoryListener *listener,
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4a493bc..0e63c87 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost.c
+vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
+vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/virtio.c
-- 
MST
