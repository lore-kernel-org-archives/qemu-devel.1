Received: from eggs.gnu.org ([2001:4830:134:3::10]:52769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corje-0004Wm-0s
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjZ-0000hm-T7
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Mar 2017 14:15:40 +0100
Message-Id: <1489756546-27142-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] replication: clarify permissions
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

From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>

Even if hidden_disk, secondary_disk are backing files, they all need
write permissions in replication scenario. Otherwise we will encouter
below exceptions on secondary side during adding nbd server:

{'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk', 'writable': true } }
{"error": {"class": "GenericError", "desc": "Conflicts with use by hidden-qcow2-driver as 'backing', which does not allow 'write' on sec-qcow2-driver-for-nbd"}}

CC: Zhang Hailiang <zhang.zhanghailiang@huawei.com>
CC: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
CC: Wen Congyang <wencongyang2@huawei.com>
Signed-off-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/replication.c b/block/replication.c
index 22f170f..bf3c395 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -155,6 +155,18 @@ static void replication_close(BlockDriverState *bs)
     replication_remove(s->rs);
 }
 
+static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                   const BdrvChildRole *role,
+                                   uint64_t perm, uint64_t shared,
+                                   uint64_t *nperm, uint64_t *nshared)
+{
+    *nperm = *nshared = BLK_PERM_CONSISTENT_READ \
+                        | BLK_PERM_WRITE \
+                        | BLK_PERM_WRITE_UNCHANGED;
+
+    return;
+}
+
 static int64_t replication_getlength(BlockDriverState *bs)
 {
     return bdrv_getlength(bs->file->bs);
@@ -660,7 +672,7 @@ BlockDriver bdrv_replication = {
 
     .bdrv_open                  = replication_open,
     .bdrv_close                 = replication_close,
-    .bdrv_child_perm            = bdrv_filter_default_perms,
+    .bdrv_child_perm            = replication_child_perm,
 
     .bdrv_getlength             = replication_getlength,
     .bdrv_co_readv              = replication_co_readv,
-- 
1.8.3.1
