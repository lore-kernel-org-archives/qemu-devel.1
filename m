Received: from eggs.gnu.org ([2001:4830:134:3::10]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3T-0005ts-Rv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3S-0003UD-6Y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:53782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVH3R-0003Sz-Qg
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:46 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:19 +0800
Message-Id: <1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v12 6/8] mm: support reporting free page blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

This patch adds support for reporting blocks of pages on the free list
specified by the caller.

As pages can leave the free list during this call or immediately
afterwards, they are not guaranteed to be free after the function
returns. The only guarantee this makes is that the page was on the free
list at some point in time after the function has been invoked.

Therefore, it is not safe for caller to use any pages on the returned
block or to discard data that is put there after the function returns.
However, it is safe for caller to discard data that was in one of these
pages before the function was invoked.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 include/linux/mm.h |  5 +++
 mm/page_alloc.c    | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46b9ac5..76cb433 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1835,6 +1835,11 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
 
+#if IS_ENABLED(CONFIG_VIRTIO_BALLOON)
+extern int report_unused_page_block(struct zone *zone, unsigned int order,
+				    unsigned int migratetype,
+				    struct page **page);
+#endif
 /*
  * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
  * into the buddy system. The freed pages will be poisoned with pattern
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64b7d82..8b3c9dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4753,6 +4753,102 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	show_swap_cache_info();
 }
 
+#if IS_ENABLED(CONFIG_VIRTIO_BALLOON)
+
+/*
+ * Heuristically get a page block in the system that is unused.
+ * It is possible that pages from the page block are used immediately after
+ * report_unused_page_block() returns. It is the caller's responsibility
+ * to either detect or prevent the use of such pages.
+ *
+ * The free list to check: zone->free_area[order].free_list[migratetype].
+ *
+ * If the caller supplied page block (i.e. **page) is on the free list, offer
+ * the next page block on the list to the caller. Otherwise, offer the first
+ * page block on the list.
+ *
+ * Note: it is not safe for caller to use any pages on the returned
+ * block or to discard data that is put there after the function returns.
+ * However, it is safe for caller to discard data that was in one of these
+ * pages before the function was invoked.
+ *
+ * Return 0 when a page block is found on the caller specified free list.
+ */
+int report_unused_page_block(struct zone *zone, unsigned int order,
+			     unsigned int migratetype, struct page **page)
+{
+	struct zone *this_zone;
+	struct list_head *this_list;
+	int ret = 0;
+	unsigned long flags;
+
+	/* Sanity check */
+	if (zone == NULL || page == NULL || order >= MAX_ORDER ||
+	    migratetype >= MIGRATE_TYPES)
+		return -EINVAL;
+
+	/* Zone validity check */
+	for_each_populated_zone(this_zone) {
+		if (zone == this_zone)
+			break;
+	}
+
+	/* Got a non-existent zone from the caller? */
+	if (zone != this_zone)
+		return -EINVAL;
+
+	spin_lock_irqsave(&this_zone->lock, flags);
+
+	this_list = &zone->free_area[order].free_list[migratetype];
+	if (list_empty(this_list)) {
+		*page = NULL;
+		ret = 1;
+		goto out;
+	}
+
+	/* The caller is asking for the first free page block on the list */
+	if ((*page) == NULL) {
+		*page = list_first_entry(this_list, struct page, lru);
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * The page block passed from the caller is not on this free list
+	 * anymore (e.g. a 1MB free page block has been split). In this case,
+	 * offer the first page block on the free list that the caller is
+	 * asking for.
+	 */
+	if (PageBuddy(*page) && order != page_order(*page)) {
+		*page = list_first_entry(this_list, struct page, lru);
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * The page block passed from the caller has been the last page block
+	 * on the list.
+	 */
+	if ((*page)->lru.next == this_list) {
+		*page = NULL;
+		ret = 1;
+		goto out;
+	}
+
+	/*
+	 * Finally, fall into the regular case: the page block passed from the
+	 * caller is still on the free list. Offer the next one.
+	 */
+	*page = list_next_entry((*page), lru);
+	ret = 0;
+out:
+	spin_unlock_irqrestore(&this_zone->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(report_unused_page_block);
+
+#endif
+
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
-- 
2.7.4
