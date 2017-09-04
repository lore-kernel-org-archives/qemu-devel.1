Received: from eggs.gnu.org ([2001:4830:134:3::10]:49367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dooSo-0000qW-GL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dooSj-0006AY-O8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:18:42 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Mon,  4 Sep 2017 13:18:00 +0300
Message-ID: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbutsykin@virtuozzo.com, den@openvz.org

After calling qcow2_inactivate(), all qcow2 caches must be flushed, but thi=
s
may not happen, because the last call qcow2_store_persistent_dirty_bitmaps(=
)
can lead to marking l2/refcont cache as dirty.

Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81he flu=
shing
to fix it.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/qcow2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a3679c69e8..dcf49084c5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2037,6 +2037,14 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result =3D 0;
     Error *local_err =3D NULL;
=20
+    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    if (local_err !=3D NULL) {
+        result =3D -EINVAL;
+        error_report_err(local_err);
+        error_report("Persistent bitmaps are lost for node '%s'",
+                     bdrv_get_device_or_node_name(bs));
+    }
+
     ret =3D qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret) {
         result =3D ret;
@@ -2051,14 +2059,6 @@ static int qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
=20
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
-    if (local_err !=3D NULL) {
-        result =3D -EINVAL;
-        error_report_err(local_err);
-        error_report("Persistent bitmaps are lost for node '%s'",
-                     bdrv_get_device_or_node_name(bs));
-    }
-
     if (result =3D=3D 0) {
         qcow2_mark_clean(bs);
     }
--=20
2.14.1
