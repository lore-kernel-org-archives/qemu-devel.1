Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwAzP-0004G3-P1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwAzP-00009N-2A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:14:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  6 Apr 2017 19:14:10 +0200
Message-Id: <1491498851-16709-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/2] commit: Set
 commit_top_bs->aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The filter driver that is inserted by the commit job needs to use the
same AioContext as its parent and child nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
