Received: from eggs.gnu.org ([209.51.188.92]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8p7-0002G8-3M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8os-0006yt-OW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 15:39:15 +1100
Message-Id: <20190214043916.22128-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190214043916.22128-1-david@gibson.dropbear.id.au>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] virtio-balloon: Use
 ram_block_discard_range() instead of raw madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently, virtio-balloon uses madvise() with MADV_DONTNEED to actually
discard RAM pages inserted into the balloon.  This is basically a Linux
only interface (MADV_DONTNEED exists on some other platforms, but doesn't
always have the same semantics).  It also doesn't work on hugepages and h=
as
some other limitations.

It turns out that postcopy also needs to discard chunks of memory, and us=
es
a better interface for it: ram_block_discard_range().  It doesn't cover
every case, but it covers more than going direct to madvise() and this
gives us a single place to update for more possibilities in future.

There are some subtleties here to maintain the current balloon behaviour:

* For now, we just ignore requests to balloon in a hugepage backed region=
.
  That matches current behaviour, because MADV_DONTNEED on a hugepage wou=
ld
  simply fail, and we ignore the error.

* If host page size is > BALLOON_PAGE_SIZE we can frequently call this on
  non-host-page-aligned addresses.  These would also fail in madvise(),
  which we then ignored.  ram_block_discard_range() error_report()s calls
  on unaligned addresses, so we explicitly check that case to avoid
  spamming the logs.

* We now call ram_block_discard_range() with the *host* page size, wherea=
s
  we previously called madvise() with BALLOON_PAGE_SIZE.  Surprisingly,
  this also matches existing behaviour.  Although the kernel fails madvis=
e
  on unaligned addresses, it will round unaligned sizes *up* to the host
  page size.  Yes, this means that if BALLOON_PAGE_SIZE < guest page size
  we can incorrectly discard more memory than the guest asked us to.  I'm
  planning to address that soon.

Errors other than the ones discussed above, will now be reported by
ram_block_discard_range(), rather than silently ignored, which means we
have a much better chance of seeing when something is going wrong.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index bf93148486..e4cd8d566b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -37,8 +37,29 @@ static void balloon_inflate_page(VirtIOBalloon *balloo=
n,
                                  MemoryRegion *mr, hwaddr offset)
 {
     void *addr =3D memory_region_get_ram_ptr(mr) + offset;
+    RAMBlock *rb;
+    size_t rb_page_size;
+    ram_addr_t ram_offset;
=20
-    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
+    /* XXX is there a better way to get to the RAMBlock than via a
+     * host address? */
+    rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb_page_size =3D qemu_ram_pagesize(rb);
+
+    /* Silently ignore hugepage RAM blocks */
+    if (rb_page_size !=3D getpagesize()) {
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
=20
 static const char *balloon_stat_names[] =3D {
--=20
2.20.1
