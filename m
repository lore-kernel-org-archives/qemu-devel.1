Received: from eggs.gnu.org ([2001:4830:134:3::10]:33994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4b-0000Wv-WA
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4Z-0007og-Bz
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 22:31:54 +0300
Message-Id: <20170225193155.447462-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170225193155.447462-1-vsementsov@virtuozzo.com>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] savevm: fix savevm after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

After migration all drives are inactive and savevm will fail with

qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
   Assertion `!(bs->open_flags & 0x0800)' failed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/snapshot.c   |  3 ++-
 migration/savevm.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index bf5c2ca5e1..256d06ac9f 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -145,7 +145,8 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
-    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
+        (bs->open_flags & BDRV_O_INACTIVE)) {
         return 0;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 5ecd264134..75e56d2d07 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2068,6 +2068,17 @@ int save_vmstate(Monitor *mon, const char *name)
     Error *local_err = NULL;
     AioContext *aio_context;
 
+    if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
+        runstate_check(RUN_STATE_POSTMIGRATE) ||
+        runstate_check(RUN_STATE_PRELAUNCH))
+    {
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+    }
+
     if (!bdrv_all_can_snapshot(&bs)) {
         monitor_printf(mon, "Device '%s' is writable but does not "
                        "support snapshots.\n", bdrv_get_device_name(bs));
-- 
2.11.1
