Received: from eggs.gnu.org ([2001:4830:134:3::10]:57269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cnksN-0008LB-8o
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiecl.fnst@cn.fujitsu.com>) id 1cnksM-0006u0-E3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:44:27 -0400
From: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 19:46:52 +0800
Message-ID: <1489492012-8002-1-git-send-email-xiecl.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V1] replication: clarify permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Wen Congyang <wencongyang2@huawei.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Even if hidden_disk, secondary_disk are backing files, they all need
write permissions in replication scenario. Otherwise we will encouter
below exceptions on secondary side during adding nbd server:

{'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk', 'writable': true } }
{"error": {"class": "GenericError", "desc": "Conflicts with use by hidden-qcow2-driver as 'backing', which does not allow 'write' on sec-qcow2-driver-for-nbd"}}

CC: Zhang Hailiang <zhang.zhanghailiang@huawei.com>
CC: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
CC: Wen Congyang <wencongyang2@huawei.com>
Signed-off-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
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
1.9.3
