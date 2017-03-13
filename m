Received: from eggs.gnu.org ([2001:4830:134:3::10]:35039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNa-0005eS-Rb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNZ-0002rR-UI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:54:57 +0100
Message-Id: <1489416908-3771-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] backup: allow target without
 .bdrv_get_info
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Currently backup to nbd target is broken, as nbd doesn't have
.bdrv_get_info realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index d1ab617..d3d20db 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -24,6 +24,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
 #include "qemu/bitmap.h"
+#include "qemu/error-report.h"
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 #define SLICE_TIME 100000000ULL /* ns */
@@ -648,7 +649,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
      * backup cluster size is smaller than the target cluster size. Even for
      * targets with a backing file, try to avoid COW if possible. */
     ret = bdrv_get_info(target, &bdi);
-    if (ret < 0 && !target->backing) {
+    if (ret == -ENOTSUP && !target->backing) {
+        /* Cluster size is not defined */
+        error_report("WARNING: The target block device doesn't provide "
+                     "information about the block size and it doesn't have a "
+                     "backing file. The default block size of %u bytes is "
+                     "used. If the actual block size of the target exceeds "
+                     "this default, the backup may be unusable",
+                     BACKUP_CLUSTER_SIZE_DEFAULT);
+        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else if (ret < 0 && !target->backing) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
-- 
1.8.3.1
