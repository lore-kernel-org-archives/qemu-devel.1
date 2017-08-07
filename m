Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1defys-0007AW-By
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1defyr-0006gJ-2e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1defyq-0006fx-Pd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  7 Aug 2017 12:04:07 +0100
Message-Id: <20170807110407.15511-2-stefanha@redhat.com>
In-Reply-To: <20170807110407.15511-1-stefanha@redhat.com>
References: <20170807110407.15511-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] block: move trace probes into
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

There are trace probes in bdrv_co_readv|writev, however, the
block drivers are being gradually moved over to using the
bdrv_co_preadv|pwritev functions instead. As a result some
block drivers miss the current probes. Move the probes
into bdrv_co_preadv|pwritev instead, so that they are triggered
by more (all?) I/O code paths.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170804105036.11879-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c         | 8 ++++----
 block/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index d9dc822173..26003814eb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1135,6 +1135,8 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     bool use_local_qiov = false;
     int ret;
 
+    trace_bdrv_co_preadv(child->bs, offset, bytes, flags);
+
     if (!drv) {
         return -ENOMEDIUM;
     }
@@ -1207,8 +1209,6 @@ static int coroutine_fn bdrv_co_do_readv(BdrvChild *child,
 int coroutine_fn bdrv_co_readv(BdrvChild *child, int64_t sector_num,
                                int nb_sectors, QEMUIOVector *qiov)
 {
-    trace_bdrv_co_readv(child->bs, sector_num, nb_sectors);
-
     return bdrv_co_do_readv(child, sector_num, nb_sectors, qiov, 0);
 }
 
@@ -1526,6 +1526,8 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     bool use_local_qiov = false;
     int ret;
 
+    trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
+
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
@@ -1660,8 +1662,6 @@ static int coroutine_fn bdrv_co_do_writev(BdrvChild *child,
 int coroutine_fn bdrv_co_writev(BdrvChild *child, int64_t sector_num,
     int nb_sectors, QEMUIOVector *qiov)
 {
-    trace_bdrv_co_writev(child->bs, sector_num, nb_sectors);
-
     return bdrv_co_do_writev(child, sector_num, nb_sectors, qiov, 0);
 }
 
diff --git a/block/trace-events b/block/trace-events
index 071a8d77ba..25dd5a3026 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -9,8 +9,8 @@ blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 
 # block/io.c
-bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
-bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
+bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
+bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
 
-- 
2.13.3
