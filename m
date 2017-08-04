Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddaFY-000435-5t
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddaES-0006Qf-AA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:54:34 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  4 Aug 2017 11:50:36 +0100
Message-Id: <20170804105036.11879-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] block: move trace probes into
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
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

There are trace probes in bdrv_co_readv|writev, however, the
block drivers are being gradually moved over to using the
bdrv_co_preadv|pwritev functions instead. As a result some
block drivers miss the current probes. Move the probes
into bdrv_co_preadv|pwritev instead, so that they are triggered
by more (all?) I/O code paths.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
