Received: from eggs.gnu.org ([209.51.188.92]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8p5-0002EF-6O
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8on-0006uh-JH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 15:39:14 +1100
Message-Id: <20190214043916.22128-4-david@gibson.dropbear.id.au>
In-Reply-To: <20190214043916.22128-1-david@gibson.dropbear.id.au>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] virtio-balloon: Rework ballon_page()
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>

This replaces the balloon_page() internal interface with
ballon_inflate_page(), with a slightly different interface.  The new
interface will make future alterations simpler.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index eb357824d8..bf93148486 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -33,11 +33,12 @@
=20
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
=20
-static void balloon_page(void *addr, int deflate)
+static void balloon_inflate_page(VirtIOBalloon *balloon,
+                                 MemoryRegion *mr, hwaddr offset)
 {
-    if (!qemu_balloon_is_inhibited() && !deflate) {
-        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
-    }
+    void *addr =3D memory_region_get_ram_ptr(mr) + offset;
+
+    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
 }
=20
 static const char *balloon_stat_names[] =3D {
@@ -222,7 +223,6 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
=20
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
             hwaddr pa;
-            hwaddr addr;
             int p =3D virtio_ldl_p(vdev, &pfn);
=20
             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
@@ -244,11 +244,9 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
=20
             trace_virtio_balloon_handle_output(memory_region_name(sectio=
n.mr),
                                                pa);
-            /* Using memory_region_get_ram_ptr is bending the rules a bi=
t, but
-               should be OK because we only want a single page.  */
-            addr =3D section.offset_within_region;
-            balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
-                         !!(vq =3D=3D s->dvq));
+            if (!qemu_balloon_is_inhibited() && vq !=3D s->dvq) {
+                balloon_inflate_page(s, section.mr, section.offset_withi=
n_region);
+            }
             memory_region_unref(section.mr);
         }
=20
--=20
2.20.1
