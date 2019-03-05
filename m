Received: from eggs.gnu.org ([209.51.188.92]:54533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mi-0001Cy-ED
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mh-0005qj-Jc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  5 Mar 2019 16:11:33 +1100
Message-Id: <20190305051134.27930-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190305051134.27930-1-david@gibson.dropbear.id.au>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 1/2] virtio-balloon: Fix possible guest memory
 corruption with inflates & deflates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, david@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This fixes a balloon bug with a nasty consequence - potentially
corrupting guest memory - but which is extremely unlikely to be
triggered in practice.

The balloon always works in 4kiB units, but the host could have a
larger page size on certain platforms.  Since ed48c59 "virtio-balloon:
Safely handle BALLOON_PAGE_SIZE < host page size" we've handled this
by accumulating requests to balloon 4kiB subpages until they formed a
full host page.  Since f6deb6d "virtio-balloon: Remove unnecessary
MADV_WILLNEED on deflate" we essentially ignore deflate requests.

Suppose we have a host with 8kiB pages, and one host page has subpages
A & B.  If we get this sequence of events -
	inflate A
	deflate A
	inflate B
- the current logic will discard the whole host page.  That's
incorrect because the guest has deflated subpage A, and could have
written important data to it.

This patch fixes the problem by adjusting our state information about
partially ballooned host pages when deflate requests are received.

Fixes: ed48c59 "virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host pa=
ge size"

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d3f2913a85..e5e82b556d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -111,6 +111,43 @@ static void balloon_inflate_page(VirtIOBalloon *ball=
oon,
     }
 }
=20
+static void balloon_deflate_page(VirtIOBalloon *balloon,
+                                 MemoryRegion *mr, hwaddr offset)
+{
+    void *addr =3D memory_region_get_ram_ptr(mr) + offset;
+    RAMBlock *rb;
+    size_t rb_page_size;
+    ram_addr_t ram_offset, host_page_base;
+
+    /* XXX is there a better way to get to the RAMBlock than via a
+     * host address? */
+    rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb_page_size =3D qemu_ram_pagesize(rb);
+    host_page_base =3D ram_offset & ~(rb_page_size - 1);
+
+    if (balloon->pbp
+        && rb =3D=3D balloon->pbp->rb
+        && host_page_base =3D=3D balloon->pbp->base) {
+        int subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
+
+        /*
+         * This means the guest has asked to discard some of the 4kiB
+         * subpages of a host page, but then changed its mind and
+         * asked to keep them after all.  It's exceedingly unlikely
+         * for a guest to do this in practice, but handle it anyway,
+         * since getting it wrong could mean discarding memory the
+         * guest is still using. */
+        bitmap_clear(balloon->pbp->bitmap,
+                     (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SI=
ZE,
+                     subpages);
+
+        if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
+            free(balloon->pbp);
+            balloon->pbp =3D NULL;
+        }
+    }
+}
+
 static const char *balloon_stat_names[] =3D {
    [VIRTIO_BALLOON_S_SWAP_IN] =3D "stat-swap-in",
    [VIRTIO_BALLOON_S_SWAP_OUT] =3D "stat-swap-out",
@@ -314,8 +351,15 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
=20
             trace_virtio_balloon_handle_output(memory_region_name(sectio=
n.mr),
                                                pa);
-            if (!qemu_balloon_is_inhibited() && vq !=3D s->dvq) {
-                balloon_inflate_page(s, section.mr, section.offset_withi=
n_region);
+            if (!qemu_balloon_is_inhibited()) {
+                if (vq =3D=3D s->ivq) {
+                    balloon_inflate_page(s, section.mr,
+                                         section.offset_within_region);
+                } else if (vq =3D=3D s->dvq) {
+                    balloon_deflate_page(s, section.mr, section.offset_w=
ithin_region);
+                } else {
+                    g_assert_not_reached();
+                }
             }
             memory_region_unref(section.mr);
         }
--=20
2.20.1
