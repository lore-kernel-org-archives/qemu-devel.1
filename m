Received: from eggs.gnu.org ([2001:4830:134:3::10]:51400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPz-00055X-RW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPu-00037v-TY
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPu-00037a-Kv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9F91C04B93B
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:04:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:37 +0800
Message-Id: <1498554219-4942-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 6/8] intel_iommu: let iotlb size tunable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We were having static IOTLB size as 1024. Let it be a tunable. We can
also turns IOTLB off if we want, by specify the size as zero.

The tunable is named as "x-iotlb-size" since that should not really be
something used by user yet, but mostly for debugging purpose now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 14 ++++++++++++--
 hw/i386/intel_iommu_internal.h |  1 -
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 72b39f0..fc05764 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -227,6 +227,10 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t key;
     int level;
 
+    if (s->iotlb_size == 0) {
+        return NULL;
+    }
+
     for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
         key = vtd_get_iotlb_key(vtd_get_iotlb_gfn(addr, level),
                                 source_id, level);
@@ -249,8 +253,12 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t *key = g_malloc(sizeof(*key));
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
+    if (s->iotlb_size == 0) {
+        return;
+    }
+
     trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
-    if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
+    if (g_hash_table_size(s->iotlb) >= s->iotlb_size) {
         trace_vtd_iotlb_reset("iotlb exceeds size limit");
         vtd_reset_iotlb(s);
     }
@@ -2388,6 +2396,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
+    DEFINE_PROP_UINT16("x-iotlb-size", IntelIOMMUState, iotlb_size, 1024),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3047,7 +3056,8 @@ static void vtd_info_dump(X86IOMMUState *x86_iommu, Monitor *mon,
     DUMP("Caching-mode: %s\n", s->caching_mode ? "enabled" : "disabled");
     DUMP("Misc: next_frr=%d, context_gen=%d, buggy_eim=%d\n",
          s->next_frcd_reg, s->context_cache_gen, s->buggy_eim);
-    DUMP("      iotlb_size=%d\n", g_hash_table_size(s->iotlb));
+    DUMP("      iotlb_size=%d/%d\n", g_hash_table_size(s->iotlb),
+         s->iotlb_size);
 
     if (clear_stats) {
         vtd_reset_stats(s);
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d1d6290..dc0257c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -116,7 +116,6 @@
 /* The shift of source_id in the key of IOTLB hash table */
 #define VTD_IOTLB_SID_SHIFT         36
 #define VTD_IOTLB_LVL_SHIFT         52
-#define VTD_IOTLB_MAX_SIZE          1024    /* Max size of the hash table */
 
 /* IOTLB_REG */
 #define VTD_TLB_GLOBAL_FLUSH        (1ULL << 60) /* Global invalidation */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fc69ff3..947c153 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -295,6 +295,7 @@ struct IntelIOMMUState {
 
     uint32_t context_cache_gen;     /* Should be in [1,MAX] */
     GHashTable *iotlb;              /* IOTLB */
+    uint16_t iotlb_size;            /* IOTLB max cache entries */
 
     MemoryRegionIOMMUOps iommu_ops;
     GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
-- 
2.7.4
