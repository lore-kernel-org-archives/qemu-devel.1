Received: from eggs.gnu.org ([2001:4830:134:3::10]:51355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPr-0004xi-2I
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPp-00036O-Ur
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPp-000362-Ma
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B126CC05972E
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:04:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:35 +0800
Message-Id: <1498554219-4942-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] intel_iommu: add iotlb/context cache
 statistics
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

Add statistics for the VT-d IOMMU DMA remapping.

Now "info iommu" shows us this for extra:

Statistics: iotlb=26.35% (6689/25388), context=99.99% (18697/18699)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c         | 21 +++++++++++++++++++++
 include/hw/i386/intel_iommu.h | 10 ++++++++++
 2 files changed, 31 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 39f772a..45d0919 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,11 @@
 #include "kvm_i386.h"
 #include "trace.h"
 
+static void vtd_reset_stats(IntelIOMMUState *s)
+{
+    memset(&s->cache_stat, 0, sizeof(s->cache_stat));
+}
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -1095,9 +1100,12 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      */
     assert(!vtd_is_interrupt_addr(addr));
 
+    s->cache_stat.iotlb_total++;
+
     /* Try to fetch slpte form IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
     if (iotlb_entry) {
+        s->cache_stat.iotlb_hit++;
         trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
                                  iotlb_entry->domain_id);
         slpte = iotlb_entry->slpte;
@@ -1107,8 +1115,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         goto out;
     }
 
+    s->cache_stat.context_total++;
+
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
+        s->cache_stat.context_hit++;
         trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
                                cc_entry->context_entry.lo,
                                cc_entry->context_cache_gen);
@@ -2875,6 +2886,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     vtd_reset_context_cache(s);
     vtd_reset_iotlb(s);
+    vtd_reset_stats(s);
 
     /* Define registers with default values and bit semantics */
     vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
@@ -3022,6 +3034,15 @@ static void vtd_info_dump(X86IOMMUState *x86_iommu, Monitor *mon,
     }
     DUMP("\n");
 
+    DUMP("Statistics: iotlb=%.2lf%% (%"PRIu64"/%"PRIu64"), "
+         "context=%.2lf%% (%"PRIu64"/%"PRIu64")\n",
+         (double)s->cache_stat.iotlb_hit /
+         s->cache_stat.iotlb_total * 100,
+         s->cache_stat.iotlb_hit, s->cache_stat.iotlb_total,
+         (double)s->cache_stat.context_hit /
+         s->cache_stat.context_total * 100,
+         s->cache_stat.context_hit, s->cache_stat.context_total);
+
     DUMP("Caching-mode: %s\n", s->caching_mode ? "enabled" : "disabled");
     DUMP("Misc: next_frr=%d, context_gen=%d, buggy_eim=%d\n",
          s->next_frcd_reg, s->context_cache_gen, s->buggy_eim);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 3e51876..fc69ff3 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -255,6 +255,13 @@ struct IntelIOMMUNotifierNode {
     QLIST_ENTRY(IntelIOMMUNotifierNode) next;
 };
 
+typedef struct IOMMUCacheStats {
+    uint64_t iotlb_hit;
+    uint64_t iotlb_total;
+    uint64_t context_hit;
+    uint64_t context_total;
+} IOMMUCacheStats;
+
 /* The iommu (DMAR) device state struct */
 struct IntelIOMMUState {
     X86IOMMUState x86_iommu;
@@ -302,6 +309,9 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
+
+    /* For statistics */
+    IOMMUCacheStats cache_stat;
 };
 
 /* Find the VTD Address space associated with the given bus pointer,
-- 
2.7.4
