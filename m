Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerN-00017C-HW
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerM-0004k0-HF
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerM-0004jP-8a
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:48 -0400
Date: Wed, 2 Aug 2017 00:37:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-6-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] intel_iommu: use access_flags for iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

It was cached by read/write separately. Let's merge them.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h |  3 +--
 hw/i386/intel_iommu.c         | 15 +++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 08d8a26..ac15e6b 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -103,8 +103,7 @@ struct VTDIOTLBEntry {
     uint16_t domain_id;
     uint64_t slpte;
     uint64_t mask;
-    bool read_flags;
-    bool write_flags;
+    uint8_t access_flags;
 };
 
 /* VT-d Source-ID Qualifier types */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e0b0498..a7bf87a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -237,8 +237,7 @@ out:
 
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
                              uint16_t domain_id, hwaddr addr, uint64_t slpte,
-                             bool read_flags, bool write_flags,
-                             uint32_t level)
+                             uint8_t access_flags, uint32_t level)
 {
     VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
     uint64_t *key = g_malloc(sizeof(*key));
@@ -253,8 +252,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->gfn = gfn;
     entry->domain_id = domain_id;
     entry->slpte = slpte;
-    entry->read_flags = read_flags;
-    entry->write_flags = write_flags;
+    entry->access_flags = access_flags;
     entry->mask = vtd_slpt_level_page_mask(level);
     *key = vtd_get_iotlb_key(gfn, source_id, level);
     g_hash_table_replace(s->iotlb, key, entry);
@@ -1087,6 +1085,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
+    uint8_t access_flags;
     VTDIOTLBEntry *iotlb_entry;
 
     /*
@@ -1101,8 +1100,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
                                  iotlb_entry->domain_id);
         slpte = iotlb_entry->slpte;
-        reads = iotlb_entry->read_flags;
-        writes = iotlb_entry->write_flags;
+        access_flags = iotlb_entry->access_flags;
         page_mask = iotlb_entry->mask;
         goto out;
     }
@@ -1172,13 +1170,14 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
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
-- 
MST
