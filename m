Received: from eggs.gnu.org ([2001:4830:134:3::10]:37075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC8-0003BM-EJ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC7-0005HZ-FH
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Nov 2017 16:10:14 +0100
Message-Id: <20171121151017.28158-5-kwolf@redhat.com>
In-Reply-To: <20171121151017.28158-1-kwolf@redhat.com>
References: <20171121151017.28158-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] block: Add errp to bdrv_all_goto_snapshot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/snapshot.h |  3 ++-
 block/snapshot.c         | 11 ++++++-----
 migration/savevm.c       |  6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index aeb80405e8..9407799941 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -84,7 +84,8 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
 bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
                              Error **err);
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bsd_bs);
+int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
+                           Error **errp);
 int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs);
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
diff --git a/block/snapshot.c b/block/snapshot.c
index 75562df4cc..8585599579 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -467,9 +467,10 @@ fail:
 }
 
 
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
+int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
+                           Error **errp)
 {
-    int err = 0;
+    int ret = 0;
     BlockDriverState *bs;
     BdrvNextIterator it;
 
@@ -478,10 +479,10 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
 
         aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs)) {
-            err = bdrv_snapshot_goto(bs, name, NULL);
+            ret = bdrv_snapshot_goto(bs, name, errp);
         }
         aio_context_release(ctx);
-        if (err < 0) {
+        if (ret < 0) {
             bdrv_next_cleanup(&it);
             goto fail;
         }
@@ -489,7 +490,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
 
 fail:
     *first_bad_bs = bs;
-    return err;
+    return ret;
 }
 
 int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
diff --git a/migration/savevm.c b/migration/savevm.c
index 4a88228614..192f2d82cd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2346,10 +2346,10 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, &bs);
+    ret = bdrv_all_goto_snapshot(name, &bs, errp);
     if (ret < 0) {
-        error_setg(errp, "Error %d while activating snapshot '%s' on '%s'",
-                     ret, name, bdrv_get_device_name(bs));
+        error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
+                      name, bdrv_get_device_name(bs));
         goto err_drain;
     }
 
-- 
2.13.6
