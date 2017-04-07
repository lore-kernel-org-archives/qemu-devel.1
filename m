Received: from eggs.gnu.org ([2001:4830:134:3::10]:44756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF4-0005i8-2U
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF3-0003Mm-9B
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:37 +0200
Message-Id: <1491572865-8549-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] commit: Set commit_top_bs->aio_context
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

The filter driver that is inserted by the commit job needs to use the
same AioContext as its parent and child nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 2832482..4c38220 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -335,6 +335,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     if (commit_top_bs == NULL) {
         goto fail;
     }
+    bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
 
     bdrv_set_backing_hd(commit_top_bs, top, &local_err);
     if (local_err) {
@@ -482,6 +483,7 @@ int bdrv_commit(BlockDriverState *bs)
         error_report_err(local_err);
         goto ro_cleanup;
     }
+    bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(backing_file_bs));
 
     bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
     bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
-- 
1.8.3.1
