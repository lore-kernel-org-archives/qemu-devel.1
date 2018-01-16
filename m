Received: from eggs.gnu.org ([2001:4830:134:3::10]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVei-0006mq-VJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebVee-0005YN-Nq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:08:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebVee-0005Xg-HM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:08:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC48113D15
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:08:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 16 Jan 2018 18:04:08 +0000
Message-Id: <20180116180408.11279-8-dgilbert@redhat.com>
In-Reply-To: <20180116180408.11279-1-dgilbert@redhat.com>
References: <20180116180408.11279-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v6 7/7] vhost: Move log_dirty check
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

Move the log_dirty check into vhost_section.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events |  1 +
 hw/virtio/vhost.c      | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 606e4fc949..742ff0f90b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -4,6 +4,7 @@
 vhost_commit(bool started, bool changed) "Started: %d Changed: %d"
 vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
 vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
+vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0c7ae94e6d..3062ad28d5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -373,8 +374,19 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
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
@@ -504,12 +516,6 @@ static void vhost_region_add_section(struct vhost_dev *dev,
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
-- 
2.14.3
