Received: from eggs.gnu.org ([2001:4830:134:3::10]:42572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkX-0005Yf-2Q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkT-0005vq-3t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKkS-0005ve-Rz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:22:05 +0100
Message-Id: <20170831082210.8362-11-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.10 10/15] misc: Remove unused Error
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alberto Garcia <berto@igalia.com>

There's a few cases which we're passing an Error pointer to a function
only to discard it immediately afterwards without checking it. In
these cases we can simply remove the variable and pass NULL instead.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170829120836.16091-1-berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow.c  | 12 +++---------
 block/qcow2.c |  8 ++------
 dump.c        |  4 +---
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index c08cdc4a7b..63904a26ee 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -454,13 +454,11 @@ static uint64_t get_cluster_offset(BlockDriverState=
 *bs,
                     start_sect =3D (offset & ~(s->cluster_size - 1)) >> =
9;
                     for(i =3D 0; i < s->cluster_sectors; i++) {
                         if (i < n_start || i >=3D n_end) {
-                            Error *err =3D NULL;
                             memset(s->cluster_data, 0x00, 512);
                             if (qcrypto_block_encrypt(s->crypto, start_s=
ect + i,
                                                       s->cluster_data,
                                                       BDRV_SECTOR_SIZE,
-                                                      &err) < 0) {
-                                error_free(err);
+                                                      NULL) < 0) {
                                 errno =3D EIO;
                                 return -1;
                             }
@@ -572,7 +570,6 @@ static coroutine_fn int qcow_co_readv(BlockDriverStat=
e *bs, int64_t sector_num,
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
-    Error *err =3D NULL;
=20
     if (qiov->niov > 1) {
         buf =3D orig_buf =3D qemu_try_blockalign(bs, qiov->size);
@@ -637,7 +634,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverStat=
e *bs, int64_t sector_num,
             if (bs->encrypted) {
                 assert(s->crypto);
                 if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
-                                          n * BDRV_SECTOR_SIZE, &err) < =
0) {
+                                          n * BDRV_SECTOR_SIZE, NULL) < =
0) {
                     goto fail;
                 }
             }
@@ -660,7 +657,6 @@ done:
     return ret;
=20
 fail:
-    error_free(err);
     ret =3D -EIO;
     goto done;
 }
@@ -709,11 +705,9 @@ static coroutine_fn int qcow_co_writev(BlockDriverSt=
ate *bs, int64_t sector_num,
             break;
         }
         if (bs->encrypted) {
-            Error *err =3D NULL;
             assert(s->crypto);
             if (qcrypto_block_encrypt(s->crypto, sector_num, buf,
-                                      n * BDRV_SECTOR_SIZE, &err) < 0) {
-                error_free(err);
+                                      n * BDRV_SECTOR_SIZE, NULL) < 0) {
                 ret =3D -EIO;
                 break;
             }
diff --git a/block/qcow2.c b/block/qcow2.c
index 40ba26c111..fbfffadc76 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1820,15 +1820,13 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
                 assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
-                Error *err =3D NULL;
                 if (qcrypto_block_decrypt(s->crypto,
                                           (s->crypt_physical_offset ?
                                            cluster_offset + offset_in_cl=
uster :
                                            offset) >> BDRV_SECTOR_BITS,
                                           cluster_data,
                                           cur_bytes,
-                                          &err) < 0) {
-                    error_free(err);
+                                          NULL) < 0) {
                     ret =3D -EIO;
                     goto fail;
                 }
@@ -1942,7 +1940,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
=20
         if (bs->encrypted) {
-            Error *err =3D NULL;
             assert(s->crypto);
             if (!cluster_data) {
                 cluster_data =3D qemu_try_blockalign(bs->file->bs,
@@ -1963,8 +1960,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
                                        cluster_offset + offset_in_cluste=
r :
                                        offset) >> BDRV_SECTOR_BITS,
                                       cluster_data,
-                                      cur_bytes, &err) < 0) {
-                error_free(err);
+                                      cur_bytes, NULL) < 0) {
                 ret =3D -EIO;
                 goto fail;
             }
diff --git a/dump.c b/dump.c
index d9090a24cc..a79773d0f7 100644
--- a/dump.c
+++ b/dump.c
@@ -1695,10 +1695,8 @@ static void dump_process(DumpState *s, Error **err=
p)
=20
 static void *dump_thread(void *data)
 {
-    Error *err =3D NULL;
     DumpState *s =3D (DumpState *)data;
-    dump_process(s, &err);
-    error_free(err);
+    dump_process(s, NULL);
     return NULL;
 }
=20
--=20
2.13.5
