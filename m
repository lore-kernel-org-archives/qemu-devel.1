Received: from eggs.gnu.org ([2001:4830:134:3::10]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPL-0003zI-E1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPK-0007Cb-9K
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:51:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBCPK-0007CS-4E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:51:54 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 12:51:22 +0800
Message-Id: <20180425045129.17449-4-peterx@redhat.com>
In-Reply-To: <20180425045129.17449-1-peterx@redhat.com>
References: <20180425045129.17449-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Add a per-iommu big lock to protect IOMMU status.  Currently the only
thing to be protected is the IOTLB cache, since that can be accessed
even without BQL, e.g., in IO dataplane.

Note that device page tables should not need any protection.  The safety
of that should be provided by guest OS.  E.g., when a page entry is
freed, the guest OS should be responsible to make sure that no device
will be using that page any more.

Reported-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h |  8 ++++++++
 hw/i386/intel_iommu.c         | 31 +++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 220697253f..1a8ba8e415 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -262,6 +262,14 @@ struct IntelIOMMUState {
     uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear) bytes */
     uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) */
     uint32_t version;
+    /*
+     * Protects IOMMU states in general.  Normally we don't need to
+     * take this lock when we are with BQL held.  However we have code
+     * paths that may run even without BQL.  In those cases, we need
+     * to take the lock when we have access to IOMMU state
+     * informations, e.g., the IOTLB.
+     */
+    QemuMutex iommu_lock;
 
     bool caching_mode;          /* RO - is cap CM enabled? */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5987b48d43..e4ee211dde 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -128,6 +128,16 @@ static uint64_t vtd_set_clear_mask_quad(IntelIOMMUState *s, hwaddr addr,
     return new_val;
 }
 
+static inline void vtd_iommu_lock(IntelIOMMUState *s)
+{
+    qemu_mutex_lock(&s->iommu_lock);
+}
+
+static inline void vtd_iommu_unlock(IntelIOMMUState *s)
+{
+    qemu_mutex_unlock(&s->iommu_lock);
+}
+
 /* GHashTable functions */
 static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
 {
@@ -197,12 +207,19 @@ static void vtd_reset_context_cache(IntelIOMMUState *s)
     s->context_cache_gen = 1;
 }
 
-static void vtd_reset_iotlb(IntelIOMMUState *s)
+static void vtd_reset_iotlb_locked(IntelIOMMUState *s)
 {
     assert(s->iotlb);
     g_hash_table_remove_all(s->iotlb);
 }
 
+static void vtd_reset_iotlb(IntelIOMMUState *s)
+{
+    vtd_iommu_lock(s);
+    vtd_reset_iotlb_locked(s);
+    vtd_iommu_unlock(s);
+}
+
 static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
                                   uint32_t level)
 {
@@ -222,6 +239,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t key;
     int level;
 
+    vtd_iommu_lock(s);
     for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
         key = vtd_get_iotlb_key(vtd_get_iotlb_gfn(addr, level),
                                 source_id, level);
@@ -232,6 +250,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
     }
 
 out:
+    vtd_iommu_unlock(s);
     return entry;
 }
 
@@ -244,9 +263,11 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
     trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
+
+    vtd_iommu_lock(s);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
         trace_vtd_iotlb_reset("iotlb exceeds size limit");
-        vtd_reset_iotlb(s);
+        vtd_reset_iotlb_locked(s);
     }
 
     entry->gfn = gfn;
@@ -256,6 +277,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->mask = vtd_slpt_level_page_mask(level);
     *key = vtd_get_iotlb_key(gfn, source_id, level);
     g_hash_table_replace(s->iotlb, key, entry);
+    vtd_iommu_unlock(s);
 }
 
 /* Given the reg addr of both the message data and address, generate an
@@ -1377,8 +1399,10 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 
     trace_vtd_inv_desc_iotlb_domain(domain_id);
 
+    vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
+    vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
@@ -1426,7 +1450,9 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.domain_id = domain_id;
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
+    vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
+    vtd_iommu_unlock(s);
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
 }
 
@@ -3072,6 +3098,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->notifiers_list);
+    qemu_mutex_init(&s->iommu_lock);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
-- 
2.14.3
