Received: from eggs.gnu.org ([2001:4830:134:3::10]:54070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfz-00014h-SY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfz-00087d-3J
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:43 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  6 Nov 2017 21:31:21 -0500
Message-Id: <5d07b67f40f00586834bfc7e6e3adbfcc058e3de.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] block/parallels: add migration blocker
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
---
 block/parallels.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 7b7a3ef..ffe0a79 100644
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
 
-- 
2.9.5
