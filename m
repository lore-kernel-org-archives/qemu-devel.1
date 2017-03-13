Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNi-0005mZ-Il
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNe-0002uz-Lm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:55:02 +0100
Message-Id: <1489416908-3771-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] migration: Document handling of
 bdrv_is_allocated() errors
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

From: Eric Blake <eblake@redhat.com>

Migration is the only code left in the tree that does not react
to bdrv_is_allocated() failures.  But as there is no useful way
to react to the failure, and we are merely skipping unallocated
sectors on success, just document that our choice of handling
is intended.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/block.c b/migration/block.c
index 1941bc2..6741228 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -276,6 +276,8 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     if (bmds->shared_base) {
         qemu_mutex_lock_iothread();
         aio_context_acquire(blk_get_aio_context(bb));
+        /* Skip unallocated sectors; intentionally treats failure as
+         * an allocated sector */
         while (cur_sector < total_sectors &&
                !bdrv_is_allocated(blk_bs(bb), cur_sector,
                                   MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
-- 
1.8.3.1
