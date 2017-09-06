Received: from eggs.gnu.org ([2001:4830:134:3::10]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavq-00067U-GL
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavl-0001KW-QS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:46 +0200
Message-Id: <20170906140246.7326-15-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

After calling qcow2_inactivate(), all qcow2 caches must be flushed, but t=
his
may not happen, because the last call qcow2_store_persistent_dirty_bitmap=
s()
can lead to marking l2/refcont cache as dirty.

Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81he f=
lushing
to fix it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ec399663e..bae5893327 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2036,6 +2036,14 @@ static int qcow2_inactivate(BlockDriverState *bs)
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
@@ -2050,14 +2058,6 @@ static int qcow2_inactivate(BlockDriverState *bs)
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
2.13.5
