Received: from eggs.gnu.org ([2001:4830:134:3::10]:44928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFE-0005uM-7t
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFD-0003Wz-Iw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:45 +0200
Message-Id: <1491572865-8549-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] mirror: Fix aio context of mirror_top_bs
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

From: Fam Zheng <famz@redhat.com>

It should be moved to the same context as source, before inserting to the
graph.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mirror.c b/block/mirror.c
index 46ecd38..164438f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1148,6 +1148,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
      * it alive until block_job_create() succeeds even if bs has no parent. */
-- 
1.8.3.1
