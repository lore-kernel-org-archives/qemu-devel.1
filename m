Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MaJ-0006Kd-V3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MaF-0001KL-4H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8MaE-0001KD-Rk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:55 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:49 +0800
Message-Id: <1494403315-12760-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1494403315-12760-1-git-send-email-peterx@redhat.com>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/12] intel_iommu: renaming context entry
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

The old names are too long and less ordered. Let's start to use
vtd_ce_*() as a pattern.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ea54ec3..4628f04 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -512,7 +512,7 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
     return 0;
 }
 
-static inline bool vtd_context_entry_present(VTDContextEntry *context)
+static inline bool vtd_ce_present(VTDContextEntry *context)
 {
     return context->lo & VTD_CONTEXT_ENTRY_P;
 }
@@ -533,7 +533,7 @@ static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
     return 0;
 }
 
-static inline dma_addr_t vtd_get_slpt_base_from_context(VTDContextEntry *ce)
+static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
 {
     return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
 }
@@ -585,19 +585,19 @@ static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
 /* Get the page-table level that hardware should use for the second-level
  * page-table walk from the Address Width field of context-entry.
  */
-static inline uint32_t vtd_get_level_from_context_entry(VTDContextEntry *ce)
+static inline uint32_t vtd_ce_get_level(VTDContextEntry *ce)
 {
     return 2 + (ce->hi & VTD_CONTEXT_ENTRY_AW);
 }
 
-static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
+static inline uint32_t vtd_ce_get_agaw(VTDContextEntry *ce)
 {
     return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
 }
 
 static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
 {
-    uint32_t ce_agaw = vtd_get_agaw_from_context_entry(ce);
+    uint32_t ce_agaw = vtd_ce_get_agaw(ce);
     return 1ULL << MIN(ce_agaw, VTD_MGAW);
 }
 
@@ -642,8 +642,8 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
                              uint64_t *slptep, uint32_t *slpte_level,
                              bool *reads, bool *writes)
 {
-    dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
-    uint32_t level = vtd_get_level_from_context_entry(ce);
+    dma_addr_t addr = vtd_ce_get_slpt_base(ce);
+    uint32_t level = vtd_ce_get_level(ce);
     uint32_t offset;
     uint64_t slpte;
     uint64_t access_right_check;
@@ -664,7 +664,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
             VTD_DPRINTF(GENERAL, "error: fail to access second-level paging "
                         "entry at level %"PRIu32 " for iova 0x%"PRIx64,
                         level, iova);
-            if (level == vtd_get_level_from_context_entry(ce)) {
+            if (level == vtd_ce_get_level(ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
             } else {
@@ -809,8 +809,8 @@ static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
                          vtd_page_walk_hook hook_fn, void *private,
                          bool notify_unmap)
 {
-    dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
-    uint32_t level = vtd_get_level_from_context_entry(ce);
+    dma_addr_t addr = vtd_ce_get_slpt_base(ce);
+    uint32_t level = vtd_ce_get_level(ce);
 
     if (!vtd_iova_range_check(start, ce)) {
         return -VTD_FR_ADDR_BEYOND_MGAW;
@@ -851,7 +851,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return ret_fr;
     }
 
-    if (!vtd_context_entry_present(ce)) {
+    if (!vtd_ce_present(ce)) {
         /* Not error - it's okay we don't have context entry. */
         trace_vtd_ce_not_present(bus_num, devfn);
         return -VTD_FR_CONTEXT_ENTRY_P;
@@ -861,7 +861,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
     /* Check if the programming of context-entry is valid */
-    if (!vtd_is_level_supported(s, vtd_get_level_from_context_entry(ce))) {
+    if (!vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_INV;
     } else {
-- 
2.7.4
