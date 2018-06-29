Received: from eggs.gnu.org ([2001:4830:134:3::10]:40082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7U-0001G3-Q1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7R-0006Ay-IO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 29 Jun 2018 18:15:22 +0300
Message-Id: <20180629151524.138542-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180629151524.138542-1-vsementsov@virtuozzo.com>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/3] blockdev-backup: enable non-root nodes
 for backup source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This is needed to implement image-fleecing scheme, when we create
a temporary node, mark our active node to be backing for the temp,
and start backup(sync=none) from active node to the temp node.
Temp node then represents a kind of snapshot and may be used
for external backup through NBD.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 58d7570932..72f5347df5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1859,7 +1859,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
     assert(common->action->type == TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
     backup = common->action->u.blockdev_backup.data;
 
-    bs = qmp_get_root_bs(backup->device, errp);
+    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return;
     }
@@ -3517,7 +3517,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
         backup->compress = false;
     }
 
-    bs = qmp_get_root_bs(backup->device, errp);
+    bs = bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
-- 
2.11.1
