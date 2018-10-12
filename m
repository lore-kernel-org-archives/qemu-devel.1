Received: from eggs.gnu.org ([2001:4830:134:3::10]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo4D-0003GM-3i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo49-0007X5-4b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Oct 2018 14:24:30 +1100
Message-Id: <20181012032431.32693-5-david@gibson.dropbear.id.au>
In-Reply-To: <20181012032431.32693-1-david@gibson.dropbear.id.au>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 4/5] virtio-balloon: Use
 ram_block_discard_range() instead of raw madvise()
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

Currently, virtio-balloon uses madvise() with MADV_DONTNEED to actually
discard RAM pages inserted into the balloon.  This is basically a Linux
only interface (MADV_DONTNEED exists on some other platforms, but doesn't
always have the same semantics).  It also doesn't work on hugepages and has
some other limitations.

It turns out that postcopy also needs to discard chunks of memory, and uses
a better interface for it: ram_block_discard_range().  It doesn't cover
every case, but it covers more than going direct to madvise() and this
gives us a single place to update for more possibilities in future.

There are some subtleties here to maintain the current balloon behaviour:

* For now, we just ignore requests to balloon in a hugepage backed region.
  That matches current behaviour, because MADV_DONTNEED on a hugepage would
  simply fail, and we ignore the error.

* If host page size is > BALLOON_PAGE_SIZE we can frequently call this on
  non-host-page-aligned addresses.  These would also fail in madvise(),
  which we then ignored.  ram_block_discard_range() error_report()s calls
  on unaligned addresses, so we explicitly check that case to avoid
  spamming the logs.

* We now call ram_block_discard_range() with the *host* page size, whereas
  we previously called madvise() with BALLOON_PAGE_SIZE.  Surprisingly,
  this also matches existing behaviour.  Although the kernel fails madvise
  on unaligned addresses, it will round unaligned sizes *up* to the host
  page size.  Yes, this means that if BALLOON_PAGE_SIZE < guest page size
  we can incorrectly discard more memory than the guest asked us to.  I'm
  planning to address that soon.

Errors other than the ones discussed above, will now be reported by
ram_block_discard_range(), rather than silently ignored, which means we
have a much better chance of seeing when something is going wrong.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7229afad6e..4435905c87 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -37,7 +37,29 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr offset)
 {
     void *addr = memory_region_get_ram_ptr(mr) + offset;
-    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
+    RAMBlock *rb;
+    size_t rb_page_size;
+    ram_addr_t ram_offset;
+
+    /* XXX is there a better way to get to the RAMBlock than via a
+     * host address? */
+    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb_page_size = qemu_ram_pagesize(rb);
+
+    /* Silently ignore hugepage RAM blocks */
+    if (rb_page_size != getpagesize()) {
+        return;
+    }
+
+    /* Silently ignore unaligned requests */
+    if (ram_offset & (rb_page_size - 1)) {
+        return;
+    }
+
+    ram_block_discard_range(rb, ram_offset, rb_page_size);
+    /* We ignore errors from ram_block_discard_range(), because it has
+     * already reported them, and failing to discard a balloon page is
+     * not fatal */
 }
 
 static const char *balloon_stat_names[] = {
-- 
2.17.1
