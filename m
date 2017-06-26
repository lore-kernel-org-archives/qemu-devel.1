Received: from eggs.gnu.org ([2001:4830:134:3::10]:48932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dPRts-0001Uh-02
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dPRtr-0000Mb-2r
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:09:47 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Date: Mon, 26 Jun 2017 19:04:24 +0800
Message-ID: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] mirror: fix the inconsistent AioContext
 problem in the backing BDSs during mirroring.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

 mirror_complete opens the backings, BDSs of the new open backings should have a
 same AioContext with the top when using iothreads, fix the code to guarantee this,
 also avoiding unexpected qemu exit(assert fails in bdrv_attach_child).

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index 6943962..b312fe6 100644
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
