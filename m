Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ec8k8-0003J5-5t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ec8k7-0008Oy-8N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:52:28 -0500
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Date: Thu, 18 Jan 2018 14:51:58 +0300
Message-Id: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Since mirror job supports efficient zero out target mechanism (see
in mirror_dirty_init()), implement bdrv_get_info to make it work
over NBD. Such improvement will allow using the largest chunk possible
and will decrease the number of NBD_CMD_WRITE_ZEROES requests on the wire.

Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
---
 block/nbd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 8b8ba56cdd..94220f6d14 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -566,6 +566,14 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }

+static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP) {
+        bdi->can_write_zeroes_with_unmap = true;
+    }
+    return 0;
+}
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -583,6 +591,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };

 static BlockDriver bdrv_nbd_tcp = {
@@ -602,6 +611,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };

 static BlockDriver bdrv_nbd_unix = {
@@ -621,6 +631,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_get_info              = nbd_get_info,
 };

 static void bdrv_nbd_init(void)
--
2.11.0
