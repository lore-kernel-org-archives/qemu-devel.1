Received: from eggs.gnu.org ([2001:4830:134:3::10]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAQ-0000BW-IY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAO-00050q-ES
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJAO-00050b-6x
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:08 -0500
Date: Tue, 16 Jan 2018 06:48:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-23-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/33] vhost: Move log_dirty check
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
 hw/virtio/trace-events |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8a85dde..83df043 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -567,18 +568,12 @@ static void vhost_set_memory(MemoryListener *listener,
                                          memory_listener);
     hwaddr start_addr = section->offset_within_address_space;
     ram_addr_t size = int128_get64(section->size);
-    bool log_dirty =
-        memory_region_get_dirty_log_mask(section->mr) & ~(1 << DIRTY_MEMORY_MIGRATION);
     int s = offsetof(struct vhost_memory, regions) +
         (dev->mem->nregions + 1) * sizeof dev->mem->regions[0];
     void *ram;
 
     dev->mem = g_realloc(dev->mem, s);
 
-    if (log_dirty) {
-        add = false;
-    }
-
     assert(size);
 
     /* Optimize no-change case. At least cirrus_vga does this a lot at this time. */
@@ -611,8 +606,19 @@ static void vhost_set_memory(MemoryListener *listener,
 
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
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 775461a..4a493bc 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/virtio/vhost.c
+vhost_section(const char *name, int r) "%s:%d"
+
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
-- 
MST
