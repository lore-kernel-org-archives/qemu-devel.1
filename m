Received: from eggs.gnu.org ([209.51.188.92]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msm-0005Kv-LY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msl-0003sM-QT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  6 Mar 2019 14:05:59 +1100
Message-Id: <20190306030601.21986-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190306030601.21986-1-david@gibson.dropbear.id.au>
References: <20190306030601.21986-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] virtio-balloon: Don't mismatch
 g_malloc()/free (CID 1399146)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tsirkin <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

ed48c59875b6 "virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host
page size" introduced a new temporary data structure which tracks 4kiB
chunks which have been inserted into the balloon by the guest but
don't yet form a full host page which we can discard.

Unfortunately, I had a thinko and allocated that structure with
g_malloc0() but freed it with a plain free() rather than g_free().
This corrects the problem.

Fixes: ed48c59875b6
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d3f2913a85..127289ae0e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -81,7 +81,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon=
,
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        free(balloon->pbp);
+        g_free(balloon->pbp);
         balloon->pbp =3D NULL;
     }
=20
@@ -106,7 +106,7 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
=20
-        free(balloon->pbp);
+        g_free(balloon->pbp);
         balloon->pbp =3D NULL;
     }
 }
--=20
2.20.1
