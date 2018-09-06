Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fxsCJ-0007HZ-4s
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fxsCF-0001rX-Qs
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:39 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fxsCD-0001o1-Fl
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:34 -0400
Received: by mail-qt0-x241.google.com with SMTP id x7-v6so11709033qtk.5
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 04:11:32 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu,  6 Sep 2018 08:11:06 -0300
Message-Id: <20180906111107.30684-3-danielhb413@gmail.com>
In-Reply-To: <20180906111107.30684-1-danielhb413@gmail.com>
References: <20180906111107.30684-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/snapshot: remove
 bdrv_snapshot_delete_by_id_or_name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

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
After that, there is no instances left of bdrv_snapshot_delete_by_id_or_name
in the code, so it is safe to remove it entirely.

Suggested-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/snapshot.c         | 20 --------------------
 include/block/snapshot.h |  3 ---
 qemu-img.c               | 15 +++++++++++----
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index e371d2243d..f2f48f926a 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -301,26 +301,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
     return ret;
 }
 
-int bdrv_snapshot_delete_by_id_or_name(BlockDriverState *bs,
-                                       const char *id_or_name,
-                                       Error **errp)
-{
-    int ret;
-    Error *local_err = NULL;
-
-    ret = bdrv_snapshot_delete(bs, id_or_name, NULL, &local_err);
-    if (ret == -ENOENT || ret == -EINVAL) {
-        error_free(local_err);
-        local_err = NULL;
-        ret = bdrv_snapshot_delete(bs, NULL, id_or_name, &local_err);
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
diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd19b..62bb35f1f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3121,11 +3121,18 @@ static int img_snapshot(int argc, char **argv)
         break;
 
     case SNAPSHOT_DELETE:
-        bdrv_snapshot_delete_by_id_or_name(bs, snapshot_name, &err);
-        if (err) {
-            error_reportf_err(err, "Could not delete snapshot '%s': ",
-                              snapshot_name);
+        ret = bdrv_snapshot_find(bs, &sn, snapshot_name);
+        if (ret < 0) {
+            error_report("Could not delete snapshot '%s': snapshot not "
+                         "found", snapshot_name);
             ret = 1;
+        } else {
+            ret = bdrv_snapshot_delete(bs, sn.id_str, sn.name, &err);
+            if (ret < 0) {
+                error_reportf_err(err, "Could not delete snapshot '%s': ",
+                                  snapshot_name);
+                ret = 1;
+            }
         }
         break;
     }
-- 
2.17.1
