Received: from eggs.gnu.org ([2001:4830:134:3::10]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mk-00073W-Ax
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mj-0008Q5-4t
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mi-0008Ph-UR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:18:01 -0400
Date: Tue, 20 Mar 2018 05:18:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-48-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 47/50] vhost: Huge page align and merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Align RAMBlocks to page size alignment, and adjust the merging code
to deal with partial overlap due to that alignment.

This is needed for postcopy so that we can place/fetch whole hugepages
when under userfault.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c      | 66 ++++++++++++++++++++++++++++++++++++++++++--------
 hw/virtio/trace-events |  3 ++-
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d8d0ef9..250f886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -522,10 +522,28 @@ static void vhost_region_add_section(struct vhost_dev *dev,
     uint64_t mrs_gpa = section->offset_within_address_space;
     uintptr_t mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
                          section->offset_within_region;
+    RAMBlock *mrs_rb = section->mr->ram_block;
+    size_t mrs_page = qemu_ram_pagesize(mrs_rb);
 
     trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
                                    mrs_host);
 
+    /* Round the section to it's page size */
+    /* First align the start down to a page boundary */
+    uint64_t alignage = mrs_host & (mrs_page - 1);
+    if (alignage) {
+        mrs_host -= alignage;
+        mrs_size += alignage;
+        mrs_gpa  -= alignage;
+    }
+    /* Now align the size up to a page boundary */
+    alignage = mrs_size & (mrs_page - 1);
+    if (alignage) {
+        mrs_size += mrs_page - alignage;
+    }
+    trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa, mrs_size,
+                                           mrs_host);
+
     if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
          * this extends it; since we're scanning in order, we only
@@ -542,18 +560,46 @@ static void vhost_region_add_section(struct vhost_dev *dev,
                         prev_sec->offset_within_region;
         uint64_t prev_host_end   = range_get_last(prev_host_start, prev_size);
 
-        if (prev_gpa_end + 1 == mrs_gpa &&
-            prev_host_end + 1 == mrs_host &&
-            section->mr == prev_sec->mr &&
-            (!dev->vhost_ops->vhost_backend_can_merge ||
-                dev->vhost_ops->vhost_backend_can_merge(dev,
+        if (mrs_gpa <= (prev_gpa_end + 1)) {
+            /* OK, looks like overlapping/intersecting - it's possible that
+             * the rounding to page sizes has made them overlap, but they should
+             * match up in the same RAMBlock if they do.
+             */
+            if (mrs_gpa < prev_gpa_start) {
+                error_report("%s:Section rounded to %"PRIx64
+                             " prior to previous %"PRIx64,
+                             __func__, mrs_gpa, prev_gpa_start);
+                /* A way to cleanly fail here would be better */
+                return;
+            }
+            /* Offset from the start of the previous GPA to this GPA */
+            size_t offset = mrs_gpa - prev_gpa_start;
+
+            if (prev_host_start + offset == mrs_host &&
+                section->mr == prev_sec->mr &&
+                (!dev->vhost_ops->vhost_backend_can_merge ||
+                 dev->vhost_ops->vhost_backend_can_merge(dev,
                     mrs_host, mrs_size,
                     prev_host_start, prev_size))) {
-            /* The two sections abut */
-            need_add = false;
-            prev_sec->size = int128_add(prev_sec->size, section->size);
-            trace_vhost_region_add_section_abut(section->mr->name,
-                                                mrs_size + prev_size);
+                uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
+                need_add = false;
+                prev_sec->offset_within_address_space =
+                    MIN(prev_gpa_start, mrs_gpa);
+                prev_sec->offset_within_region =
+                    MIN(prev_host_start, mrs_host) -
+                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+                prev_sec->size = int128_make64(max_end - MIN(prev_host_start,
+                                               mrs_host));
+                trace_vhost_region_add_section_merge(section->mr->name,
+                                        int128_get64(prev_sec->size),
+                                        prev_sec->offset_within_address_space,
+                                        prev_sec->offset_within_region);
+            } else {
+                error_report("%s: Overlapping but not coherent sections "
+                             "at %"PRIx64,
+                             __func__, mrs_gpa);
+                return;
+            }
         }
     }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 857c495..1422ff0 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -3,7 +3,8 @@
 # hw/virtio/vhost.c
 vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
-vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
+vhost_region_add_section_merge(const char *name, uint64_t new_size, uint64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"PRIx64
+vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/vhost-user.c
-- 
MST
