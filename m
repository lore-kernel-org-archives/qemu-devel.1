Received: from eggs.gnu.org ([2001:4830:134:3::10]:37145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyIvl-0003vt-8t
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyIvg-0001ks-Tp
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:07:33 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 12 Apr 2017 22:05:21 +0800
Message-ID: <1492005921-15664-7-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/6] nbd/replication: implement
 .bdrv_get_info() for nbd and replication driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>, Wen
	Congyang <wency@cn.fujitsu.com>

Without this callback, there will be an error reports in the primary side:
"qemu-system-x86_64: Couldn't determine the cluster size of the target image,
which has no backing file: Operation not supported
Aborting, since this may create an unusable destination image"

For nbd driver, it doesn't have cluster size, so here we return
a fake value for it.

This patch should be dropped if Eric's nbd patch be merged.
https://lists.gnu.org/archive/html/qemu-block/2017-02/msg00825.html
'[PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server'.

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 block/nbd.c         | 12 ++++++++++++
 block/replication.c |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 814ab26d..fceb14b 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -43,6 +43,8 @@
 
 #define EN_OPTSTR ":exportname="
 
+#define NBD_FAKE_CLUSTER_SIZE 512
+
 typedef struct BDRVNBDState {
     NBDClientSession client;
 
@@ -561,6 +563,13 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
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
@@ -578,6 +587,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -597,6 +607,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -616,6 +627,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/replication.c b/block/replication.c
index fb604e5..7371caa 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -761,6 +761,11 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
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
@@ -774,6 +779,7 @@ BlockDriver bdrv_replication = {
     .bdrv_co_readv              = replication_co_readv,
     .bdrv_co_writev             = replication_co_writev,
 
+    .bdrv_get_info              = replication_get_info,
     .is_filter                  = true,
     .bdrv_recurse_is_first_non_filter = replication_recurse_is_first_non_filter,
 
-- 
1.8.3.1
