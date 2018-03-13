Received: from eggs.gnu.org ([2001:4830:134:3::10]:59661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdN-0001cI-CD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdM-0004kX-8v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:44 +0100
Message-Id: <20180313161803.1814-23-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/41] luks: Separate image file creation from
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The crypto driver used to create the image file in a callback from the
crypto subsystem. If we want to implement .bdrv_co_create, this needs to
go away because that callback will get a reference to an already
existing block node.

Move the image file creation to block_crypto_create_generic().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/crypto.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index e6095e7807..77871640cc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -71,8 +71,6 @@ static ssize_t block_crypto_read_func(QCryptoBlock *blo=
ck,
=20
=20
 struct BlockCryptoCreateData {
-    const char *filename;
-    QemuOpts *opts;
     BlockBackend *blk;
     uint64_t size;
 };
@@ -103,27 +101,13 @@ static ssize_t block_crypto_init_func(QCryptoBlock =
*block,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data =3D opaque;
-    int ret;
=20
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    data->size +=3D headerlen;
-
-    qemu_opt_set_number(data->opts, BLOCK_OPT_SIZE, data->size, &error_a=
bort);
-    ret =3D bdrv_create_file(data->filename, data->opts, errp);
-    if (ret < 0) {
-        return -1;
-    }
-
-    data->blk =3D blk_new_open(data->filename, NULL, NULL,
-                             BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
-    if (!data->blk) {
-        return -1;
-    }
-
-    return 0;
+    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE=
_OFF,
+                        errp);
 }
=20
=20
@@ -333,11 +317,10 @@ static int block_crypto_create_generic(QCryptoBlock=
Format format,
     struct BlockCryptoCreateData data =3D {
         .size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0=
),
                          BDRV_SECTOR_SIZE),
-        .opts =3D opts,
-        .filename =3D filename,
     };
     QDict *cryptoopts;
=20
+    /* Parse options */
     cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
=20
     create_opts =3D block_crypto_create_opts_init(format, cryptoopts, er=
rp);
@@ -345,6 +328,20 @@ static int block_crypto_create_generic(QCryptoBlockF=
ormat format,
         return -1;
     }
=20
+    /* Create protocol layer */
+    ret =3D bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    data.blk =3D blk_new_open(filename, NULL, NULL,
+                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCO=
L,
+                            errp);
+    if (!data.blk) {
+        return -EINVAL;
+    }
+
+    /* Create format layer */
     crypto =3D qcrypto_block_create(create_opts, NULL,
                                   block_crypto_init_func,
                                   block_crypto_write_func,
--=20
2.13.6
