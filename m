Received: from eggs.gnu.org ([2001:4830:134:3::10]:46803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQC9-0005PD-RD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQC8-0006di-6j
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:48:57 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:48:00 +0800
Message-ID: <1484884080-28836-7-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 6/6] nbd/replication: implement
 .bdrv_get_info() for nbd and replication driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric
	Blake <eblake@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>

Without this callback, there will be an error reports in the primary side:
"qemu-system-x86_64: Couldn't determine the cluster size of the target image,
which has no backing file: Operation not supported
Aborting, since this may create an unusable destination image"

For nbd driver, it doesn't have cluster size, so here we return
a fake value for it.

This patch should be dropped if Eric's nbd patch be merged.
https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg03567.html

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 block/nbd.c         | 12 ++++++++++++
 block/replication.c |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 35f24be..b71a13d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -43,6 +43,8 @@
 
 #define EN_OPTSTR ":exportname="
 
+#define NBD_FAKE_CLUSTER_SIZE 512
+
 typedef struct BDRVNBDState {
     NBDClientSession client;
 
@@ -552,6 +554,13 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    bdi->cluster_size  = NBD_FAKE_CLUSTER_SIZE;
+
+    return 0;
+}
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -569,6 +578,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -588,6 +598,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -607,6 +618,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/replication.c b/block/replication.c
index a0b3e41..e4f8069 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -731,6 +731,11 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
     aio_context_release(aio_context);
 }
 
+static int replication_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    return bdrv_get_info(bs->file->bs, bdi);
+}
+
 BlockDriver bdrv_replication = {
     .format_name                = "replication",
     .protocol_name              = "replication",
@@ -743,6 +748,7 @@ BlockDriver bdrv_replication = {
     .bdrv_co_readv              = replication_co_readv,
     .bdrv_co_writev             = replication_co_writev,
 
+    .bdrv_get_info              = replication_get_info,
     .is_filter                  = true,
     .bdrv_recurse_is_first_non_filter = replication_recurse_is_first_non_filter,
 
-- 
1.8.3.1
