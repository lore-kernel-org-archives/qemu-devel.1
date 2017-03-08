Received: from eggs.gnu.org ([2001:4830:134:3::10]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljEO-0004hK-1T
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljEM-0000F8-R7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Mar 2017 15:34:29 -0600
Message-Id: <20170308213429.29244-4-eblake@redhat.com>
In-Reply-To: <20170308213429.29244-1-eblake@redhat.com>
References: <20170308213429.29244-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] migration: Document handling of
 bdrv_is_allocated() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Migration is the only code left in the tree that does not react
to bdrv_is_allocated() failures.  But as there is no useful way
to react to the failure, and we are merely skipping unallocated
sectors on success, just document that our choice of handling
is intended.

Signed-off-by: Eric Blake <eblake@redhat.com>
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
2.9.3
