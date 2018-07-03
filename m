Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGH-0004kz-GV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAGG-0005BJ-Gd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:37:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 20:37:27 -0500
Message-Id: <20180703013730.55375-4-eblake@redhat.com>
In-Reply-To: <20180703013730.55375-1-eblake@redhat.com>
References: <20180703013730.55375-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] blockdev: enable non-root nodes for backup
 source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is needed to implement the image-fleecing workflow where we
create a temporary node backed by an active node, then start
backupdev-backup sync=none from the active node to the temp node.

In this case, the active node is now a root node AND a backing node,
so it no longer qualifies as a root node, so we loosen the restriction
on which nodes can be considered as the source for a backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20180702194630.9360-2-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 58d75709327..72f5347df5f 100644
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
2.14.4
