Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1diBdh-0008Bs-Dj
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1diBdg-0003sa-27
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:1602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1diBdf-0003iP-P6
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:38:31 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 17 Aug 2017 11:26:55 +0800
Message-Id: <1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v14 4/5] mm: support reporting free page blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

This patch adds support to walk through the free page blocks in the
system and report them via a callback function. Some page blocks may
leave the free list after zone->lock is released, so it is the caller's
responsibility to either detect or prevent the use of such pages.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/mm.h |  6 ++++++
 mm/page_alloc.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46b9ac5..cd29b9f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1835,6 +1835,12 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
 
+extern void walk_free_mem_block(void *opaque1,
+				unsigned int min_order,
+				void (*visit)(void *opaque2,
+					      unsigned long pfn,
+					      unsigned long nr_pages));
+
 /*
  * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
  * into the buddy system. The freed pages will be poisoned with pattern
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d00f74..a721a35 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4762,6 +4762,50 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	show_swap_cache_info();
 }
 
+/**
+ * walk_free_mem_block - Walk through the free page blocks in the system
+ * @opaque1: the context passed from the caller
+ * @min_order: the minimum order of free lists to check
+ * @visit: the callback function given by the caller
+ *
+ * The function is used to walk through the free page blocks in the system,
+ * and each free page block is reported to the caller via the @visit callback.
+ * Please note:
+ * 1) The function is used to report hints of free pages, so the caller should
+ * not use those reported pages after the callback returns.
+ * 2) The callback is invoked with the zone->lock being held, so it should not
+ * block and should finish as soon as possible.
+ */
+void walk_free_mem_block(void *opaque1,
+			 unsigned int min_order,
+			 void (*visit)(void *opaque2,
+				       unsigned long pfn,
+				       unsigned long nr_pages))
+{
+	struct zone *zone;
+	struct page *page;
+	struct list_head *list;
+	unsigned int order;
+	enum migratetype mt;
+	unsigned long pfn, flags;
+
+	for_each_populated_zone(zone) {
+		for (order = MAX_ORDER - 1;
+		     order < MAX_ORDER && order >= min_order; order--) {
+			for (mt = 0; mt < MIGRATE_TYPES; mt++) {
+				spin_lock_irqsave(&zone->lock, flags);
+				list = &zone->free_area[order].free_list[mt];
+				list_for_each_entry(page, list, lru) {
+					pfn = page_to_pfn(page);
+					visit(opaque1, pfn, 1 << order);
+				}
+				spin_unlock_irqrestore(&zone->lock, flags);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(walk_free_mem_block);
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
2.7.4
