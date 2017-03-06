Received: from eggs.gnu.org ([2001:4830:134:3::10]:54479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP1-0002R9-Dw
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP0-00017j-Kz
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:27 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:21:53 +0100
Message-Id: <1488817322-11397-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] commit: Fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Apparently some kind of mismerge happened in commit 8dfba279, which
broke the error handling without any real reason by removing the
assignment of the return value to ret in a blk_insert_bs() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 22a0a4d..e57c1cf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -364,7 +364,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     /* Required permissions are already taken with block_job_add_bdrv() */
     s->top = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(s->top, top, errp);
+    ret = blk_insert_bs(s->top, top, errp);
     if (ret < 0) {
         goto fail;
     }
-- 
1.8.3.1
