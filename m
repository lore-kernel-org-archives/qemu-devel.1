Received: from eggs.gnu.org ([209.51.188.92]:36927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4B-00088D-6c
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4A-0000Zl-6c
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:46 +0100
Message-Id: <20190225152053.15976-5-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/71] block/snapshot: remove
 bdrv_snapshot_delete_by_id_or_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Daniel Henrique Barboza <danielhb413@gmail.com>

After the previous patch, the only instance of this function left
is inside qemu-img.c.

qemu-img is using it inside the 'img_snapshot' function to delete
snapshots in the SNAPSHOT_DELETE case, based on a "snapshot_name"
string that refers to the tag, not ID, of the QEMUSnapshotInfo struct.
This can be verified by checking the SNAPSHOT_CREATE case that
comes shortly before SNAPSHOT_DELETE. In that case, the same
"snapshot_name" variable is being strcpy to the 'name' field
of the QEMUSnapshotInfo struct sn:

pstrcpy(sn.name, sizeof(sn.name), snapshot_name);

Based on that, it is unlikely that "snapshot_name" might contain
an "id" in SNAPSHOT_DELETE.

This patch changes SNAPSHOT_DELETE to use snapshot_find() and
snapshot_delete() instead of bdrv_snapshot_delete_by_id_or_name.
After that, there is no instances left of bdrv_snapshot_delete_by_id_or_n=
ame
in the code, so it is safe to remove it entirely.

Suggested-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/snapshot.h |  3 ---
 block/snapshot.c         | 20 --------------------
 qemu-img.c               | 15 +++++++++++----
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index f73d1094af..b5d5084a12 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -61,9 +61,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          const char *snapshot_id,
                          const char *name,
                          Error **errp);
-int bdrv_snapshot_delete_by_id_or_name(BlockDriverState *bs,
-                                       const char *id_or_name,
-                                       Error **errp);
 int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info);
 int bdrv_snapshot_load_tmp(BlockDriverState *bs,
diff --git a/block/snapshot.c b/block/snapshot.c
index e371d2243d..f2f48f926a 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -301,26 +301,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
     return ret;
 }
=20
-int bdrv_snapshot_delete_by_id_or_name(BlockDriverState *bs,
-                                       const char *id_or_name,
-                                       Error **errp)
-{
-    int ret;
-    Error *local_err =3D NULL;
-
-    ret =3D bdrv_snapshot_delete(bs, id_or_name, NULL, &local_err);
-    if (ret =3D=3D -ENOENT || ret =3D=3D -EINVAL) {
-        error_free(local_err);
-        local_err =3D NULL;
-        ret =3D bdrv_snapshot_delete(bs, NULL, id_or_name, &local_err);
-    }
-
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-    }
-    return ret;
-}
-
 int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
diff --git a/qemu-img.c b/qemu-img.c
index 25288c4d18..9737b815e4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3123,11 +3123,18 @@ static int img_snapshot(int argc, char **argv)
         break;
=20
     case SNAPSHOT_DELETE:
-        bdrv_snapshot_delete_by_id_or_name(bs, snapshot_name, &err);
-        if (err) {
-            error_reportf_err(err, "Could not delete snapshot '%s': ",
-                              snapshot_name);
+        ret =3D bdrv_snapshot_find(bs, &sn, snapshot_name);
+        if (ret < 0) {
+            error_report("Could not delete snapshot '%s': snapshot not "
+                         "found", snapshot_name);
             ret =3D 1;
+        } else {
+            ret =3D bdrv_snapshot_delete(bs, sn.id_str, sn.name, &err);
+            if (ret < 0) {
+                error_reportf_err(err, "Could not delete snapshot '%s': =
",
+                                  snapshot_name);
+                ret =3D 1;
+            }
         }
         break;
     }
--=20
2.20.1
