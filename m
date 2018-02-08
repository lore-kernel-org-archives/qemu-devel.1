Received: from eggs.gnu.org ([2001:4830:134:3::10]:54115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZC-00064n-7Y
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZB-0008Hy-6z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZB-0008He-28
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:05 -0500
Date: Thu, 8 Feb 2018 21:09:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-11-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/26] vhost: Move log_dirty check
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

Move the log_dirty check into vhost_section.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c      | 20 +++++++++++++-------
 hw/virtio/trace-events |  1 +
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 326f168..4a44e6e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -379,8 +380,19 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
 static bool vhost_section(MemoryRegionSection *section)
 {
-    return memory_region_is_ram(section->mr) &&
+    bool result;
+    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
+                     ~(1 << DIRTY_MEMORY_MIGRATION);
+    result = memory_region_is_ram(section->mr) &&
         !memory_region_is_rom(section->mr);
+
+    /* Vhost doesn't handle any block which is doing dirty-tracking other
+     * than migration; this typically fires on VGA areas.
+     */
+    result &= !log_dirty;
+
+    trace_vhost_section(section->mr->name, result);
+    return result;
 }
 
 static void vhost_begin(MemoryListener *listener)
@@ -510,12 +522,6 @@ static void vhost_region_add_section(struct vhost_dev *dev,
     trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
                                    mrs_host);
 
-    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
-                        ~(1 << DIRTY_MEMORY_MIGRATION);
-    if (log_dirty) {
-        return;
-    }
-
     if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
          * this extends it; since we're scanning in order, we only
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 606e4fc..742ff0f 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -4,6 +4,7 @@
 vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
+vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
-- 
MST
