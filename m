Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUPOh-0008KD-TD
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUPOf-0004NG-9R
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 00:06:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  5 Dec 2018 16:06:41 +1100
Message-Id: <20181205050641.864-6-david@gibson.dropbear.id.au>
In-Reply-To: <20181205050641.864-1-david@gibson.dropbear.id.au>
References: <20181205050641.864-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFCv2 for-4.0 5/5] virtio-balloon: Safely handle
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
we can only actually discard memory in units of the host page size.

Now, we handle this very badly: we silently ignore balloon requests that
aren't host page aligned, and for requests that are host page aligned we
discard the entire host page.  The latter can corrupt guest memory if its
page size is smaller than the host's.

The obvious choice would be to disable the balloon if the host page size =
is
not 4kiB.  However, that would break the special case where host and gues=
t
have the same page size, but that's larger than 4kiB.  That case currentl=
y
works by accident[1] - and is used in practice on many production POWER
systems where 64kiB has long been the Linux default page size on both hos=
t
and guest.

To make the balloon safe, without breaking that useful special case, we
need to accumulate 4kiB balloon requests until we have a whole contiguous
host page to discard.

We could in principle do that across all guest memory, but it would requi=
re
a large bitmap to track.  This patch represents a compromise: we track
ballooned subpages for a single contiguous host page at a time.  This mea=
ns
that if the guest discards all 4kiB chunks of a host page in succession,
we will discard it.  This is the expected behaviour in the (host page) =3D=
=3D
(guest page) !=3D 4kiB case we want to support.

If the guest scatters 4kiB requests across different host pages, we don't
discard anything, and issue a warning.  Not ideal, but at least we don't
corrupt guest memory as the previous version could.

Warning reporting is kind of a compromise here.  Determining whether we'r=
e
in a problematic state at realize() time is tricky, because we'd have to
look at the host pagesizes of all memory backends, but we can't really kn=
ow
if some of those backends could be for special purpose memory that's not
subject to ballooning.

Reporting only when the guest tries to balloon a partial page also isn't
great because if the guest page size happens to line up it won't indicate
that we're in a non ideal situation.  It could also cause alarming repeat=
ed
warnings whenever a migration is attempted.

So, what we do is warn the first time the guest attempts balloon a partia=
l
host page, whether or not it will end up ballooning the rest of the page
immediately afterwards.

[1] Because when the guest attempts to balloon a page, it will submit
    requests for each 4kiB subpage.  Most will be ignored, but the one
    which happens to be host page aligned will discard the whole lot.

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
=20
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
=20
+typedef struct PartiallyBalloonedPage {
+    RAMBlock *rb;
+    ram_addr_t base;
+    unsigned long bitmap[];
+} PartiallyBalloonedPage;
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr offset)
 {
     void *addr =3D memory_region_get_ram_ptr(mr) + offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset;
+    int subpages;
+    ram_addr_t ram_offset, host_page_base;
=20
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
     rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
     rb_page_size =3D qemu_ram_pagesize(rb);
+    host_page_base =3D ram_offset & ~(rb_page_size - 1);
+
+    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
+        /* Easy case */
=20
-    /* Silently ignore hugepage RAM blocks */
-    if (rb_page_size !=3D getpagesize()) {
+        ram_block_discard_range(rb, ram_offset, rb_page_size);
+        /* We ignore errors from ram_block_discard_range(), because it
+         * has already reported them, and failing to discard a balloon
+         * page is not fatal */
         return;
     }
=20
-    /* Silently ignore unaligned requests */
-    if (ram_offset & (rb_page_size - 1)) {
-        return;
+    /* Hard case
+     *
+     * We've put a piece of a larger host page into the balloon - we
+     * need to keep track until we have a whole host page to
+     * discard
+     */
+    subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
+
+    if (balloon->pbp
+        && (rb !=3D balloon->pbp->rb
+            || host_page_base !=3D balloon->pbp->base)) {
+        /* We've partially ballooned part of a host page, but now
+         * we're trying to balloon part of a different one.  Too hard,
+         * give up on the old partial page */
+        warn_report("Unable to insert a partial page into virtio-balloon=
");
+        free(balloon->pbp);
+        balloon->pbp =3D NULL;
     }
=20
-    ram_block_discard_range(rb, ram_offset, rb_page_size);
-    /* We ignore errors from ram_block_discard_range(), because it has
-     * already reported them, and failing to discard a balloon page is
-     * not fatal */
+    if (!balloon->pbp) {
+        /* Starting on a new host page */
+        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned long=
);
+        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bitl=
en);
+        balloon->pbp->rb =3D rb;
+        balloon->pbp->base =3D host_page_base;
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
+        balloon->pbp =3D NULL;
+    }
 }
=20
 static const char *balloon_stat_names[] =3D {
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index e0df3528c8..99dcd6d105 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -30,6 +30,8 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
=20
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
=20
 #endif
--=20
2.19.2
