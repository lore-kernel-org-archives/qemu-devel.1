Received: from eggs.gnu.org ([209.51.188.92]:45973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8p5-0002EK-6a
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu8on-0006up-L7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:40:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 15:39:12 +1100
Message-Id: <20190214043916.22128-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190214043916.22128-1-david@gibson.dropbear.id.au>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
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

When the balloon is inflated, we discard memory place in it using madvise=
()
with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
sounds like it makes sense but is actually unnecessary.

The misleadingly named MADV_DONTNEED just discards the memory in question=
,
it doesn't set any persistent state on it in-kernel; all that's necessary
to bring the memory back is to touch it.  MADV_WILLNEED in contrast
specifically says that the memory will be used soon and faults it in.

This patch simplify's the balloon operation by dropping the madvise()
on deflate.  This might have an impact on performance - it will move a
delay at deflate time until that memory is actually touched, which
might be more latency sensitive.  However:

  * Memory that's being given back to the guest by deflating the
    balloon *might* be used soon, but it equally could just sit around
    in the guest's pools until needed (or even be faulted out again if
    the host is under memory pressure).

  * Usually, the timescale over which you'll be adjusting the balloon
    is long enough that a few extra faults after deflation aren't
    going to make a difference.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a12677d4d5..43af521884 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -35,9 +35,8 @@
=20
 static void balloon_page(void *addr, int deflate)
 {
-    if (!qemu_balloon_is_inhibited()) {
-        qemu_madvise(addr, BALLOON_PAGE_SIZE,
-                deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
+    if (!qemu_balloon_is_inhibited() && !deflate) {
+        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
     }
 }
=20
--=20
2.20.1
