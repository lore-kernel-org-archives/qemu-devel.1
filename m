Received: from eggs.gnu.org ([2001:4830:134:3::10]:44782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF5-0005kL-09
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF4-0003NR-BA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:38 +0200
Message-Id: <1491572865-8549-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] commit: Set commit_top_bs->total_sectors
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

Like in the mirror filter driver, we also need to set the image size for
the commit filter driver. This is less likely to be a problem in
practice than for the mirror because we're not at the active layer here,
but attaching new parents to a node in the middle of the chain is
possible, so the size needs to be correct anyway.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/commit.c b/block/commit.c
index 4c38220..91d2c34 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -335,6 +335,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     if (commit_top_bs == NULL) {
         goto fail;
     }
+    commit_top_bs->total_sectors = top->total_sectors;
     bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
 
     bdrv_set_backing_hd(commit_top_bs, top, &local_err);
-- 
1.8.3.1
