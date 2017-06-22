Received: from eggs.gnu.org ([2001:4830:134:3::10]:45170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1Rm-0006TM-Sf
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1Ri-0005xk-Uq
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:41 +0200
Message-Id: <20170622124204.19407-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/31] qcow2: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2-cluster.c  | 2 +-
 block/qcow2-refcount.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d779ea19cf..da9008815c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -61,7 +61,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t =
min_size,
             new_l1_size =3D 1;
         }
         while (min_size > new_l1_size) {
-            new_l1_size =3D (new_l1_size * 3 + 1) / 2;
+            new_l1_size =3D DIV_ROUND_UP(new_l1_size * 3, 2);
         }
     }
=20
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..75107cf093 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -293,7 +293,7 @@ static unsigned int next_refcount_table_size(BDRVQcow=
2State *s,
         MAX(1, s->refcount_table_size >> (s->cluster_bits - 3));
=20
     while (min_clusters > refcount_table_clusters) {
-        refcount_table_clusters =3D (refcount_table_clusters * 3 + 1) / =
2;
+        refcount_table_clusters =3D DIV_ROUND_UP(refcount_table_clusters=
 * 3, 2);
     }
=20
     return refcount_table_clusters << (s->cluster_bits - 3);
--=20
2.13.1.395.gf7b71de06
