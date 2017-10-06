Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyd-0001Qu-TY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyd-0004PO-40
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:18 +0200
Message-Id: <20171006155422.10135-51-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 50/54] block/mirror: check backing in
 bdrv_mirror_top_refresh_filename
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Backing may be zero after failed bdrv_attach_child in
bdrv_set_backing_hd, which leads to SIGSEGV.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170928120300.58164-1-vsementsov@virtuozzo.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 459b80f8f3..3b6f0c5772 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1058,6 +1058,11 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_attach_child in
+         * bdrv_set_backing_hd */
+        return;
+    }
     bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
-- 
2.13.6
