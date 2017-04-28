Received: from eggs.gnu.org ([2001:4830:134:3::10]:55579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cas-0001iY-UO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cas-0001GY-6R
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:21 +0200
Message-Id: <1493411622-5343-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/34] block: Remove NULL check in bdrv_co_flush
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

Reported by Coverity. We already use bs in bdrv_inc_in_flight before
checking for NULL. It is unnecessary as all callers pass non-NULL bs, so
drop it.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index a32fd1d..80d6c62 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2300,7 +2300,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
     bdrv_inc_in_flight(bs);
 
-    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
+    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
         bdrv_is_sg(bs)) {
         goto early_exit;
     }
-- 
1.8.3.1
