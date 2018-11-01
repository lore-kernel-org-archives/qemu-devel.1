Received: from eggs.gnu.org ([2001:4830:134:3::10]:55893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002Xe-8y
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh9-0007jW-1n
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:36 +0300
Message-Id: <20181101182738.70462-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/7] qcow2: use byte-based read in
 qcow2_decompress_cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

We are gradually moving away from sector-based interfaces, towards
byte-based.  Get rid of it here too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e9d24b801e..950b9f7ec6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3956,14 +3956,15 @@ fail:
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
 {
     BDRVQcow2State *s = bs->opaque;
-    int ret, csize, nb_csectors, sector_offset;
+    int ret, csize, nb_csectors;
     uint64_t coffset;
+    struct iovec iov;
+    QEMUIOVector local_qiov;
 
     coffset = cluster_offset & s->cluster_offset_mask;
     if (s->cluster_cache_offset != coffset) {
         nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
-        sector_offset = coffset & 511;
-        csize = nb_csectors * 512 - sector_offset;
+        csize = nb_csectors * 512 - (coffset & 511);
 
         /* Allocate buffers on first decompress operation, most images are
          * uncompressed and the memory overhead can be avoided.  The buffers
@@ -3981,14 +3982,17 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
             s->cluster_cache = g_malloc(s->cluster_size);
         }
 
+        iov.iov_base = s->cluster_data;
+        iov.iov_len = csize;
+        qemu_iovec_init_external(&local_qiov, &iov, 1);
+
         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
-                        nb_csectors);
+        ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
         if (ret < 0) {
             return ret;
         }
         if (qcow2_decompress(s->cluster_cache, s->cluster_size,
-                             s->cluster_data + sector_offset, csize) < 0) {
+                             s->cluster_data, csize) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
-- 
2.18.0
