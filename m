Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ6-0005vw-3f
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZ2-00085M-BR
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZ2-00083s-69
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:08:56 -0500
Date: Thu, 8 Feb 2018 21:08:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-2-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/26] Revert "vhost: add traces for memory
 listeners"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This reverts commit 0750b060216de69ed1f14bc08181bf4ad27fc622.

Follow up patches are reworking the memory listeners, the new mechanism
will add its own set of traces.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c      | 7 -------
 hw/virtio/trace-events | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 338e439..23b9e17 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,7 +27,6 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
-#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -694,7 +693,6 @@ static void vhost_region_add(MemoryListener *listener,
         return;
     }
 
-    trace_vhost_region_add(dev, section->mr->name ?: NULL);
     ++dev->n_mem_sections;
     dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
                                 dev->n_mem_sections);
@@ -714,7 +712,6 @@ static void vhost_region_del(MemoryListener *listener,
         return;
     }
 
-    trace_vhost_region_del(dev, section->mr->name ?: NULL);
     vhost_set_memory(listener, section, false);
     memory_region_unref(section->mr);
     for (i = 0; i < dev->n_mem_sections; ++i) {
@@ -752,8 +749,6 @@ static void vhost_iommu_region_add(MemoryListener *listener,
         return;
     }
 
-    trace_vhost_iommu_region_add(dev, section->mr->name ?: NULL);
-
     iommu = g_malloc0(sizeof(*iommu));
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
@@ -782,8 +777,6 @@ static void vhost_iommu_region_del(MemoryListener *listener,
         return;
     }
 
-    trace_vhost_iommu_region_del(dev, section->mr->name ?: NULL);
-
     QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
         if (iommu->mr == section->mr &&
             iommu->n.start == section->offset_within_region) {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 2b8f81e..775461a 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -25,9 +25,3 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
-
-# hw/virtio/vhost.c
-vhost_region_add(void *p, const char *mr) "dev %p mr %s"
-vhost_region_del(void *p, const char *mr) "dev %p mr %s"
-vhost_iommu_region_add(void *p, const char *mr) "dev %p mr %s"
-vhost_iommu_region_del(void *p, const char *mr) "dev %p mr %s"
-- 
MST
