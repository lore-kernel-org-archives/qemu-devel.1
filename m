Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1e7FXX-0004HO-Uq
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1e7FXX-0002PO-BY
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:51:48 -0400
From: Wang Guang <wang.guang55@zte.com.cn>
Date: Wed, 25 Oct 2017 14:51:23 +0800
Message-Id: <1508914283-2531-1-git-send-email-wang.guang55@zte.com.cn>
Subject: [Qemu-devel] [PATCH] replication: Fix replication open fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com, mreitz@redhat.com
Cc: zhang.zhanghailiang@huawei.com, zhangckid@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Wang Guang <wang.guang55@zte.com.cn>, Wang Yong <wang.yong155@zte.com.cn>

replication_child_perm request write
permissions for all child which will lead bdrv_check_perm fail.
replication_child_perm() should request write
permissions only if it is writable itself.

Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
---
 block/replication.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 3a4e682..1c95d67 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -161,10 +161,13 @@ static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
 {
-    *nperm = *nshared = BLK_PERM_CONSISTENT_READ \
-                        | BLK_PERM_WRITE \
-                        | BLK_PERM_WRITE_UNCHANGED;
-
+    *nperm = BLK_PERM_CONSISTENT_READ;
+    if ((bs->open_flags & (BDRV_O_INACTIVE | BDRV_O_RDWR)) == BDRV_O_RDWR) {
+        *nperm |= BLK_PERM_WRITE;
+    }
+    *nshared = BLK_PERM_CONSISTENT_READ \
+               | BLK_PERM_WRITE \
+               | BLK_PERM_WRITE_UNCHANGED;
     return;
 }
 
-- 
1.8.3.1
