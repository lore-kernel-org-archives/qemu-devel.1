Received: from eggs.gnu.org ([209.51.188.92]:34334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLcBJ-0002jz-Gv
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbyR-0001YQ-Ry
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:15:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 30 Apr 2019 19:15:36 -0400
Message-Id: <20190430231536.25353-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC] migration/dirty-bitmaps: change bitmap
 enumeration method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Shift from looking at every root BDS to *every* BDS.
Tested only lightly via iotests.

Counter-examples that break this approach welcome.
---
 migration/block-dirty-bitmap.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index d1bb863cb6..4a896a09eb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -273,7 +273,6 @@ static int init_dirty_bitmap_migration(void)
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
-    BdrvNextIterator it;
     Error *local_err =3D NULL;
=20
     dirty_bitmap_mig_state.bulk_completed =3D false;
@@ -281,13 +280,8 @@ static int init_dirty_bitmap_migration(void)
     dirty_bitmap_mig_state.prev_bitmap =3D NULL;
     dirty_bitmap_mig_state.no_bitmaps =3D false;
=20
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        const char *drive_name =3D bdrv_get_device_or_node_name(bs);
-
-        /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
-            bs =3D backing_bs(bs);
-        }
+    for (bs =3D bdrv_next_all_states(NULL); bs; bs =3D bdrv_next_all_sta=
tes(bs)) {
+        const char *name =3D bdrv_get_device_or_node_name(bs);
=20
         for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
@@ -296,7 +290,7 @@ static int init_dirty_bitmap_migration(void)
                 continue;
             }
=20
-            if (drive_name =3D=3D NULL) {
+            if (!name || strcmp(name, "") =3D=3D 0) {
                 error_report("Found bitmap '%s' in unnamed node %p. It c=
an't "
                              "be migrated", bdrv_dirty_bitmap_name(bitma=
p), bs);
                 goto fail;
@@ -313,7 +307,7 @@ static int init_dirty_bitmap_migration(void)
=20
             dbms =3D g_new0(DirtyBitmapMigBitmapState, 1);
             dbms->bs =3D bs;
-            dbms->node_name =3D drive_name;
+            dbms->node_name =3D name;
             dbms->bitmap =3D bitmap;
             dbms->total_sectors =3D bdrv_nb_sectors(bs);
             dbms->sectors_per_chunk =3D CHUNK_SIZE * 8 *
--=20
2.20.1
