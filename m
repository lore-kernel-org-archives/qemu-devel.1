Received: from eggs.gnu.org ([2001:4830:134:3::10]:42698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCL-0000k1-N8
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCK-00029T-ND
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:29 +0100
Message-Id: <20171117181653.20651-2-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/25] replication: Fix replication open fail
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

From: Wang Guang <wang.guang55@zte.com.cn>

replication_child_perm request write
permissions for all child which will lead bdrv_check_perm fail.
replication_child_perm() should request write
permissions only if it is writable itself.

Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 3a4e6822e4..1c95d673ff 100644
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
2.13.6
