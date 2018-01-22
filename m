Received: from eggs.gnu.org ([2001:4830:134:3::10]:52294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVCA-0000MR-6P
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVC9-0004Vj-7g
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edVC9-0004VS-0d
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:01 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 22 Jan 2018 14:02:41 +0800
Message-Id: <20180122060244.29368-2-peterx@redhat.com>
In-Reply-To: <20180122060244.29368-1-peterx@redhat.com>
References: <20180122060244.29368-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] vhost: add traces for memory listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

Trace these operations on two memory listeners.  It helps to verify the
new memory listener fix, and good to keep them there.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/trace-events | 6 ++++++
 hw/virtio/vhost.c      | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 775461ae98..2b8f81eb25 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -25,3 +25,9 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
+
+# hw/virtio/vhost.c
+vhost_region_add(void *p, const char *mr) "dev %p mr %s"
+vhost_region_del(void *p, const char *mr) "dev %p mr %s"
+vhost_iommu_region_add(void *p, const char *mr) "dev %p mr %s"
+vhost_iommu_region_del(void *p, const char *mr) "dev %p mr %s"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce93d..19a7a3cb37 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -687,6 +688,7 @@ static void vhost_region_add(MemoryListener *listener,
         return;
     }
 
+    trace_vhost_region_add(dev, section->mr->name ?: NULL);
     ++dev->n_mem_sections;
     dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
                                 dev->n_mem_sections);
@@ -706,6 +708,7 @@ static void vhost_region_del(MemoryListener *listener,
         return;
     }
 
+    trace_vhost_region_del(dev, section->mr->name ?: NULL);
     vhost_set_memory(listener, section, false);
     memory_region_unref(section->mr);
     for (i = 0; i < dev->n_mem_sections; ++i) {
@@ -743,6 +746,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
         return;
     }
 
+    trace_vhost_iommu_region_add(dev, section->mr->name ?: NULL);
+
     iommu = g_malloc0(sizeof(*iommu));
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
@@ -771,6 +776,8 @@ static void vhost_iommu_region_del(MemoryListener *listener,
         return;
     }
 
+    trace_vhost_iommu_region_del(dev, section->mr->name ?: NULL);
+
     QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
         if (iommu->mr == section->mr &&
             iommu->n.start == section->offset_within_region) {
-- 
2.14.3
