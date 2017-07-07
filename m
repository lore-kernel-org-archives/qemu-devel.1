Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWm5-00064a-8c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWm3-0000KY-G8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:17 +0200
Message-Id: <1499447335-6125-63-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 062/100] mirror: Fix inconsistent backing
 AioContext for after mirroring
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

From: "sochin.jiang" <sochin.jiang@huawei.com>

mirror_complete opens the backing chain, which should have the same
AioContext as the top when using iothreads. Make the code guarantee
this, which fixes a failed assertion in bdrv_attach_child.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
Message-id: 1498475064-39816-1-git-send-email-sochin.jiang@huawei.com
[mreitz: Reworded commit message]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index edfa6b7..b9e5114 100644
--- a/block.c
+++ b/block.c
@@ -2185,6 +2185,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         ret = -EINVAL;
         goto free_exit;
     }
+    bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-- 
1.8.3.1
