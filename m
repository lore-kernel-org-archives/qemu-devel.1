Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUzB-00026N-7A
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUzA-0000vK-17
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:29 -0400
Date: Wed, 23 May 2018 17:43:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-27-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 26/28] intel-iommu: trace domain id during page
 walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Peter Xu <peterx@redhat.com>

This patch only modifies the trace points.

Previously we were tracing page walk levels.  They are redundant since
we have page mask (size) already.  Now we trace something much more
useful which is the domain ID of the page walking.  That can be very
useful when we trace more than one devices on the same system, so that
we can know which map is for which domain.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 16 ++++++++++------
 hw/i386/trace-events  |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a882894..61bb3d3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -756,6 +756,7 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
  * @notify_unmap: whether we should notify invalid entries
  * @as: VT-d address space of the device
  * @aw: maximum address width
+ * @domain: domain ID of the page walk
  */
 typedef struct {
     VTDAddressSpace *as;
@@ -763,17 +764,18 @@ typedef struct {
     void *private;
     bool notify_unmap;
     uint8_t aw;
+    uint16_t domain_id;
 } vtd_page_walk_info;
 
-static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
-                             vtd_page_walk_info *info)
+static int vtd_page_walk_one(IOMMUTLBEntry *entry, vtd_page_walk_info *info)
 {
     vtd_page_walk_hook hook_fn = info->hook_fn;
     void *private = info->private;
 
     assert(hook_fn);
-    trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
-                            entry->addr_mask, entry->perm);
+    trace_vtd_page_walk_one(info->domain_id, entry->iova,
+                            entry->translated_addr, entry->addr_mask,
+                            entry->perm);
     return hook_fn(entry, private);
 }
 
@@ -844,7 +846,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
                 trace_vtd_page_walk_skip_perm(iova, iova_next);
                 goto next;
             }
-            ret = vtd_page_walk_one(&entry, level, info);
+            ret = vtd_page_walk_one(&entry, info);
             if (ret < 0) {
                 return ret;
             }
@@ -856,7 +858,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
                      * Translated address is meaningless, zero it.
                      */
                     entry.translated_addr = 0x0;
-                    ret = vtd_page_walk_one(&entry, level, info);
+                    ret = vtd_page_walk_one(&entry, info);
                     if (ret < 0) {
                         return ret;
                     }
@@ -1466,6 +1468,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                     .notify_unmap = true,
                     .aw = s->aw_bits,
                     .as = vtd_as,
+                    .domain_id = domain_id,
                 };
 
                 /*
@@ -2947,6 +2950,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .notify_unmap = false,
                 .aw = s->aw_bits,
                 .as = vtd_as,
+                .domain_id = VTD_CONTEXT_ENTRY_DID(ce.hi),
             };
 
             vtd_page_walk(&ce, 0, ~0ULL, &info);
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 22d4464..ca23ba9 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -39,7 +39,7 @@ vtd_fault_disabled(void) "Fault processing disabled for context entry"
 vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
-vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
+vtd_page_walk_one(uint16_t domain, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "domain 0x%"PRIu16" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
-- 
MST
