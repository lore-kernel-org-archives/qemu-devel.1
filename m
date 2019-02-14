Received: from eggs.gnu.org ([209.51.188.92]:46008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8p7-0002GB-3q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8os-0006ye-Mq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 15:39:13 +1100
Message-Id: <20190214043916.22128-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190214043916.22128-1-david@gibson.dropbear.id.au>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] virtio-balloon: Corrections to address
 verification
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

The virtio-balloon device's verification of the address given to it by th=
e
guest has a number of faults:
    * The addresses here are guest physical addresses, which should be
      'hwaddr' rather than 'ram_addr_t' (the distinction is admittedly
      pretty subtle and confusing)
    * We don't check for section.mr being NULL, which is the main way tha=
t
      memory_region_find() reports basic failures.  We really need to che=
ck
      that before looking at any other section fields, because
      memory_region_find() doesn't initialize them on the failure path
    * We're passing a length of '1' to memory_region_find(), but really t=
he
      guest is requesting that we put the entire page into the balloon,
      so it makes more sense to call it with BALLOON_PAGE_SIZE

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 43af521884..eb357824d8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(VirtIODevi=
ce *vdev, VirtQueue *vq)
         }
=20
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
-            ram_addr_t pa;
-            ram_addr_t addr;
+            hwaddr pa;
+            hwaddr addr;
             int p =3D virtio_ldl_p(vdev, &pfn);
=20
-            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
+            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset +=3D 4;
=20
-            /* FIXME: remove get_system_memory(), but how? */
-            section =3D memory_region_find(get_system_memory(), pa, 1);
-            if (!int128_nz(section.size) ||
-                !memory_region_is_ram(section.mr) ||
+            section =3D memory_region_find(get_system_memory(), pa,
+                                         BALLOON_PAGE_SIZE);
+            if (!section.mr) {
+                trace_virtio_balloon_bad_addr(pa);
+                continue;
+            }
+            if (!memory_region_is_ram(section.mr) ||
                 memory_region_is_rom(section.mr) ||
                 memory_region_is_romd(section.mr)) {
                 trace_virtio_balloon_bad_addr(pa);
--=20
2.20.1
