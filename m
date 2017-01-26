Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8x-0001a8-NH
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8w-000674-IX
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:03 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:17 +0000
Message-Id: <20170126101827.22378-9-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/18] qcow: make encrypt_sectors encrypt in
 place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Instead of requiring separate input/output buffers for
encrypting data, change encrypt_sectors() to assume
use of a single buffer, encrypting in place. One current
caller uses the same buffer for input/output already
and the other two callers are easily converted to do so.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 101c973..38d7298 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -310,11 +310,10 @@ static int qcow_set_key(BlockDriverState *bs, const char *key)
 }
 
 /* The crypt function is compatible with the linux cryptoloop
-   algorithm for < 4 GB images. NOTE: out_buf == in_buf is
-   supported */
+   algorithm for < 4 GB images. */
 static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
-                           uint8_t *out_buf, const uint8_t *in_buf,
-                           int nb_sectors, bool enc, Error **errp)
+                           uint8_t *buf, int nb_sectors, bool enc,
+                           Error **errp)
 {
     union {
         uint64_t ll[2];
@@ -333,14 +332,12 @@ static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
         }
         if (enc) {
             ret = qcrypto_cipher_encrypt(s->cipher,
-                                         in_buf,
-                                         out_buf,
+                                         buf, buf,
                                          512,
                                          errp);
         } else {
             ret = qcrypto_cipher_decrypt(s->cipher,
-                                         in_buf,
-                                         out_buf,
+                                         buf, buf,
                                          512,
                                          errp);
         }
@@ -348,8 +345,7 @@ static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
             return -1;
         }
         sector_num++;
-        in_buf += 512;
-        out_buf += 512;
+        buf += 512;
     }
     return 0;
 }
@@ -469,13 +465,12 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                     uint64_t start_sect;
                     assert(s->cipher);
                     start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
-                    memset(s->cluster_data + 512, 0x00, 512);
                     for(i = 0; i < s->cluster_sectors; i++) {
                         if (i < n_start || i >= n_end) {
                             Error *err = NULL;
+                            memset(s->cluster_data, 0x00, 512);
                             if (encrypt_sectors(s, start_sect + i,
-                                                s->cluster_data,
-                                                s->cluster_data + 512, 1,
+                                                s->cluster_data, 1,
                                                 true, &err) < 0) {
                                 error_free(err);
                                 errno = EIO;
@@ -653,7 +648,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
             }
             if (bs->encrypted) {
                 assert(s->cipher);
-                if (encrypt_sectors(s, sector_num, buf, buf,
+                if (encrypt_sectors(s, sector_num, buf,
                                     n, false, &err) < 0) {
                     goto fail;
                 }
@@ -688,9 +683,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
     BDRVQcowState *s = bs->opaque;
     int index_in_cluster;
     uint64_t cluster_offset;
-    const uint8_t *src_buf;
     int ret = 0, n;
-    uint8_t *cluster_data = NULL;
     struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
@@ -698,7 +691,9 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
 
     s->cluster_cache_offset = -1; /* disable compressed cache */
 
-    if (qiov->niov > 1) {
+    /* We must always copy the iov when encrypting, so we
+     * don't modify the original data buffer during encryption */
+    if (bs->encrypted || qiov->niov > 1) {
         buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
         if (buf == NULL) {
             return -ENOMEM;
@@ -728,21 +723,15 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         if (bs->encrypted) {
             Error *err = NULL;
             assert(s->cipher);
-            if (!cluster_data) {
-                cluster_data = g_malloc0(s->cluster_size);
-            }
-            if (encrypt_sectors(s, sector_num, cluster_data, buf,
+            if (encrypt_sectors(s, sector_num, buf,
                                 n, true, &err) < 0) {
                 error_free(err);
                 ret = -EIO;
                 break;
             }
-            src_buf = cluster_data;
-        } else {
-            src_buf = buf;
         }
 
-        hd_iov.iov_base = (void *)src_buf;
+        hd_iov.iov_base = (void *)buf;
         hd_iov.iov_len = n * 512;
         qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
         qemu_co_mutex_unlock(&s->lock);
@@ -761,10 +750,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
     }
     qemu_co_mutex_unlock(&s->lock);
 
-    if (qiov->niov > 1) {
-        qemu_vfree(orig_buf);
-    }
-    g_free(cluster_data);
+    qemu_vfree(orig_buf);
 
     return ret;
 }
-- 
2.9.3
