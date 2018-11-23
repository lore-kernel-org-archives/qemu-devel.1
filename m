Received: from eggs.gnu.org ([2001:4830:134:3::10]:34843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjj-00083Q-SV
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002CZ-J0
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:11 +0300
Message-Id: <20181123165511.416480-12-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/11] qcow2: do encryption in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Do encryption/decryption in threads, like it is already done for
compression. This improves asynchronous encrypted io.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3fa7e3ea27..a7d77a2178 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2007,13 +2007,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcrypto_block_decrypt(s->crypto,
-                                          (s->crypt_physical_offset ?
-                                           cluster_offset + offset_in_cluster :
-                                           offset),
-                                          cluster_data,
-                                          cur_bytes,
-                                          NULL) < 0) {
+                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                                     cluster_data, cur_bytes) < 0) {
                     ret = -EIO;
                     goto fail;
                 }
@@ -2151,12 +2146,8 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
-            if (qcrypto_block_encrypt(s->crypto,
-                                      (s->crypt_physical_offset ?
-                                       cluster_offset + offset_in_cluster :
-                                       offset),
-                                      cluster_data,
-                                      cur_bytes, NULL) < 0) {
+            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+                                 cluster_data, cur_bytes) < 0) {
                 ret = -EIO;
                 goto out_unlocked;
             }
-- 
2.18.0
