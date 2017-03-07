Received: from eggs.gnu.org ([2001:4830:134:3::10]:42392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEa-000225-BG
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEZ-0002Y4-IZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:28 +0100
Message-Id: <1488901251-16214-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/27] mirror: Fix error path for dirty bitmap
 creation
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

mirror_top_bs must be removed from the graph again when creating the
dirty bitmap fails.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 001b5f0..f24dc51 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1197,10 +1197,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
     if (!s->dirty_bitmap) {
-        g_free(s->replaces);
-        blk_unref(s->target);
-        block_job_unref(&s->common);
-        return;
+        goto fail;
     }
 
     /* Required permissions are already taken with blk_new() */
-- 
1.8.3.1
