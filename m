Received: from eggs.gnu.org ([2001:4830:134:3::10]:56829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eC3eb-0008ER-Qx
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eC3ea-0003d1-PL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:10:57 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 08:10:35 -0500
Message-Id: <5e04a7c8a3089913fa58d484af42dab7993984ad.1510059970.git.jcody@redhat.com>
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
References: <cover.1510059970.git.jcody@redhat.com>
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
References: <cover.1510059970.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] block/parallels: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

Migration does not work for parallels, and has been broken for a while
(see patch 'block/parallels: Do not update header or truncate image when
 INMIGRATE').  The bdrv_invalidate_cache() method needs to be added for
migration to be supported.  Until this is done, prohibit migration.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/parallels.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 7b7a3ef..9545761 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -35,6 +35,7 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
+#include "migration/blocker.h"
 
 /**************************************************************/
 
@@ -100,6 +101,7 @@ typedef struct BDRVParallelsState {
     unsigned int tracks;
 
     unsigned int off_multiplier;
+    Error *migration_blocker;
 } BDRVParallelsState;
 
 
@@ -720,6 +722,16 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     s->bat_dirty_bmap =
         bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
 
+    /* Disable migration until bdrv_invalidate_cache method is added */
+    error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
+               "does not support live migration",
+               bdrv_get_device_or_node_name(bs));
+    ret = migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_free(s->migration_blocker);
+        goto fail;
+    }
     qemu_co_mutex_init(&s->lock);
     return 0;
 
@@ -750,6 +762,9 @@ static void parallels_close(BlockDriverState *bs)
 
     g_free(s->bat_dirty_bmap);
     qemu_vfree(s->header);
+
+    migrate_del_blocker(s->migration_blocker);
+    error_free(s->migration_blocker);
 }
 
 static QemuOptsList parallels_create_opts = {
-- 
2.9.5
