Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3CJK-0006HR-NU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 22:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3CJJ-0000vA-QB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 22:04:06 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 26 Apr 2017 10:03:49 +0800
Message-Id: <20170426020349.25257-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Remove NULL check in bdrv_co_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Reported by Coverity. We already use bs in bdrv_inc_in_flight before
checking for NULL. It is unnecessary as all callers pass non-NULL bs, so
drop it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index a7142e0..a039966 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2308,7 +2308,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
     bdrv_inc_in_flight(bs);
 
-    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
+    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
         bdrv_is_sg(bs)) {
         goto early_exit;
     }
-- 
2.9.3
