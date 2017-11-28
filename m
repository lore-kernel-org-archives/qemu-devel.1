Received: from eggs.gnu.org ([2001:4830:134:3::10]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa6B-0006lg-2s
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa67-0000Uh-R6
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:31 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:30019 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eJa67-0000U0-Fc
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 28 Nov 2017 10:14:07 +0300
Message-Id: <20171128071409.21887-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171128071409.21887-1-vsementsov@virtuozzo.com>
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Consider migration with shared storage. Persistent bitmaps are stored
on bdrv_inactivate. Then, on destination
process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
are already loaded on destination start. In this case we should call
qcow2_reopen_bitmaps_rw instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1914a940e5..f5f205e1b7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1450,7 +1450,13 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        if (!bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
+            bool header_updated = false;
+            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
+            update_header = update_header && !header_updated;
+        }
+    } else if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
         update_header = false;
     }
     if (local_err != NULL) {
-- 
2.11.1
