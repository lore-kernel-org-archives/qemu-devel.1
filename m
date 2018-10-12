Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo4G-0003Hv-E5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo4D-0007a1-HU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Oct 2018 14:24:31 +1100
Message-Id: <20181012032431.32693-6-david@gibson.dropbear.id.au>
In-Reply-To: <20181012032431.32693-1-david@gibson.dropbear.id.au>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 5/5] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The virtio-balloon always works in units of 4kiB (BALLOON_PAGE_SIZE), but
on the host side, we can only actually discard memory in units of the host
page size.

At present we handle this very badly: we silently ignore balloon requests
that aren't host page aligned, and for requests that are host page aligned
we discard the entire host page.  The latter potentially corrupts guest
memory if its page size is smaller than the host's.

We could just disable the balloon if the host page size is not 4kiB, but
that would break a the special case where host and guest have the same page
size, but that's larger than 4kiB.  Thius case currently works by accident:
when the guest puts its page into the balloon, it will submit balloon
requests for each 4kiB subpage.  Most will be ignored, but the one which
happens to be host page aligned will discard the whole lot.

This occurs in practice routinely for POWER KVM systems, since both host
and guest typically use 64kiB pages.

To make this safe, without breaking that useful case, we need to
accumulate 4kiB balloon requests until we have a whole contiguous host page
at which point we can discard it.

We could in principle do that across all guest memory, but it would require
a large bitmap to track.  This patch represents a compromise: instead we
track ballooned subpages for a single contiguous host page at a time.  This
means that if the guest discards all 4kiB chunks of a host page in
succession, we will discard it.  In particular that means the balloon will
continue to work for the (host page size) == (guest page size) > 4kiB case.

If the guest scatters 4kiB requests across different host pages, we don't
discard anything, and issue a warning.  Not ideal, but at least we don't
corrupt guest memory as the previous version could.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c         | 67 +++++++++++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |  3 ++
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4435905c87..39573ef2e3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -33,33 +33,80 @@
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
+typedef struct PartiallyBalloonedPage {
+    RAMBlock *rb;
+    ram_addr_t base;
+    unsigned long bitmap[];
+} PartiallyBalloonedPage;
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr offset)
 {
     void *addr = memory_region_get_ram_ptr(mr) + offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset;
+    int subpages;
+    ram_addr_t ram_offset, host_page_base;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
     rb = qemu_ram_block_from_host(addr, false, &ram_offset);
     rb_page_size = qemu_ram_pagesize(rb);
+    host_page_base = ram_offset & ~(rb_page_size - 1);
+
+    if (rb_page_size == BALLOON_PAGE_SIZE) {
+        /* Easy case */
 
-    /* Silently ignore hugepage RAM blocks */
-    if (rb_page_size != getpagesize()) {
+        ram_block_discard_range(rb, ram_offset, rb_page_size);
+        /* We ignore errors from ram_block_discard_range(), because it
+         * has already reported them, and failing to discard a balloon
+         * page is not fatal */
         return;
     }
 
-    /* Silently ignore unaligned requests */
-    if (ram_offset & (rb_page_size - 1)) {
-        return;
+    /* Hard case
+     *
+     * We've put a piece of a larger host page into the balloon - we
+     * need to keep track until we have a whole host page to
+     * discard
+     */
+    subpages = rb_page_size / BALLOON_PAGE_SIZE;
+
+    if (balloon->pbp
+        && (rb != balloon->pbp->rb
+            || host_page_base != balloon->pbp->base)) {
+        /* We've partially ballooned part of a host page, but now
+         * we're trying to balloon part of a different one.  Too hard,
+         * give up on the old partial page */
+        warn_report("Unable to insert a partial page into virtio-balloon");
+        free(balloon->pbp);
+        balloon->pbp = NULL;
     }
 
-    ram_block_discard_range(rb, ram_offset, rb_page_size);
-    /* We ignore errors from ram_block_discard_range(), because it has
-     * already reported them, and failing to discard a balloon page is
-     * not fatal */
+    if (!balloon->pbp) {
+        /* Starting on a new host page */
+        size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
+        balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);
+        balloon->pbp->rb = rb;
+        balloon->pbp->base = host_page_base;
+    }
+
+    bitmap_set(balloon->pbp->bitmap,
+               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+               subpages);
+
+    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
+        /* We've accumulated a full host page, we can actually discard
+         * it now */
+
+        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
+        /* We ignore errors from ram_block_discard_range(), because it
+         * has already reported them, and failing to discard a balloon
+         * page is not fatal */
+
+        free(balloon->pbp);
+        balloon->pbp = NULL;
+    }
 }
 
 static const char *balloon_stat_names[] = {
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index e0df3528c8..99dcd6d105 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -30,6 +30,8 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
+typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
+
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq;
@@ -42,6 +44,7 @@ typedef struct VirtIOBalloon {
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
+    PartiallyBalloonedPage *pbp;
 } VirtIOBalloon;
 
 #endif
-- 
2.17.1
