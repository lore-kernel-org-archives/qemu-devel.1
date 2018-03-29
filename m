Received: from eggs.gnu.org ([2001:4830:134:3::10]:60745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRK-0001hU-PM
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRJ-0003Gw-Ly
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:11 +0800
Message-Id: <20180329110914.20888-6-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/8] file-posix: Implement bdrv_co_map_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index b13bc89423..4e615d937e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1656,6 +1656,17 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
 }
 
+static int raw_co_map_range(BlockDriverState *bs, int64_t offset,
+                         int64_t bytes, int64_t *pnum, int64_t *map,
+                         BlockDriverState **file,
+                         int flags)
+{
+    *file = bs;
+    *pnum = bytes;
+    *map = offset;
+    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+}
+
 static int raw_co_copy_range(BlockDriverState *bs, int64_t off_in,
                              BlockDriverState *out, int64_t off_out,
                              int bytes)
@@ -2389,6 +2400,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_copy_range     = raw_co_copy_range,
+    .bdrv_co_map_range      = raw_co_map_range,
     .bdrv_aio_flush = raw_aio_flush,
     .bdrv_aio_pdiscard = raw_aio_pdiscard,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -2867,6 +2879,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_copy_range     = raw_co_copy_range,
+    .bdrv_co_map_range      = raw_co_map_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_aio_pdiscard   = hdev_aio_pdiscard,
     .bdrv_refresh_limits = raw_refresh_limits,
@@ -2990,6 +3003,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_copy_range     = raw_co_copy_range,
+    .bdrv_co_map_range      = raw_co_map_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
@@ -3121,6 +3135,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_copy_range     = raw_co_copy_range,
+    .bdrv_co_map_range      = raw_co_map_range,
     .bdrv_aio_flush	= raw_aio_flush,
     .bdrv_refresh_limits = raw_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
-- 
2.14.3
