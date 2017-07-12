Received: from eggs.gnu.org ([2001:4830:134:3::10]:50782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCmX-0000wd-VE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCmW-0001uF-UV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVCmW-0001th-M2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B723580F6D
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:13:59 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jul 2017 16:13:42 +0800
Message-Id: <1499847223-8078-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1499847223-8078-1-git-send-email-peterx@redhat.com>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] intel_iommu: use access_flags for iotlb
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

It was cached by read/write separately. Let's merge them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c         | 15 +++++++--------
 include/hw/i386/intel_iommu.h |  3 +--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9c36866..e17340c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -241,8 +241,7 @@ out:
 
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
                              uint16_t domain_id, hwaddr addr, uint64_t slpte,
-                             bool read_flags, bool write_flags,
-                             uint32_t level)
+                             uint8_t access_flags, uint32_t level)
 {
     VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
     uint64_t *key = g_malloc(sizeof(*key));
@@ -261,8 +260,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->gfn = gfn;
     entry->domain_id = domain_id;
     entry->slpte = slpte;
-    entry->read_flags = read_flags;
-    entry->write_flags = write_flags;
+    entry->access_flags = access_flags;
     entry->mask = vtd_slpt_level_page_mask(level);
     *key = vtd_get_iotlb_key(gfn, source_id, level);
     g_hash_table_replace(s->iotlb, key, entry);
@@ -1095,6 +1093,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
+    uint8_t access_flags;
     VTDIOTLBEntry *iotlb_entry;
 
     /*
@@ -1109,8 +1108,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
                                  iotlb_entry->domain_id);
         slpte = iotlb_entry->slpte;
-        reads = iotlb_entry->read_flags;
-        writes = iotlb_entry->write_flags;
+        access_flags = iotlb_entry->access_flags;
         page_mask = iotlb_entry->mask;
         goto out;
     }
@@ -1180,13 +1178,14 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     page_mask = vtd_slpt_level_page_mask(level);
+    access_flags = IOMMU_ACCESS_FLAG(reads, writes);
     vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
-                     reads, writes, level);
+                     access_flags, level);
 out:
     entry->iova = addr & page_mask;
     entry->translated_addr = vtd_get_slpte_addr(slpte) & page_mask;
     entry->addr_mask = ~page_mask;
-    entry->perm = IOMMU_ACCESS_FLAG(reads, writes);
+    entry->perm = access_flags;
     return true;
 
 error:
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index a57f419..1b51c9f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -101,8 +101,7 @@ struct VTDIOTLBEntry {
     uint16_t domain_id;
     uint64_t slpte;
     uint64_t mask;
-    bool read_flags;
-    bool write_flags;
+    uint8_t access_flags;
 };
 
 /* VT-d Source-ID Qualifier types */
-- 
2.7.4
