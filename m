Received: from eggs.gnu.org ([2001:4830:134:3::10]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gKNbb-0006pc-CK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gKNba-0002th-3E
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:10:47 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gKNbZ-0002BT-B3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:10:45 -0500
Received: by mail-qk1-x741.google.com with SMTP id v68-v6so20648751qka.2
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 05:10:27 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed,  7 Nov 2018 11:09:59 -0200
Message-Id: <20181107131000.27744-3-danielhb413@gmail.com>
In-Reply-To: <20181107131000.27744-1-danielhb413@gmail.com>
References: <20181107131000.27744-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH for-3.2 v3 2/3] block/snapshot: remove
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
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

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
index 4c96db7ba4..7b4910adcf 100644
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
2.17.2
