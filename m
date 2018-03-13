Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdI-0001W3-6Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdG-0004gV-So
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:45 +0100
Message-Id: <20180313161803.1814-24-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/41] luks: Create
 block_crypto_co_create_generic()
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

Everything that refers to the protocol layer or QemuOpts is moved out of
block_crypto_create_generic(), so that the remaining function is
suitable to be called by a .bdrv_co_create implementation.

LUKS is the only driver that actually implements the old interface, and
we don't intend to use it in any new drivers, so put the moved out code
directly into a LUKS function rather than creating a generic
intermediate one.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++---------------=
------
 1 file changed, 61 insertions(+), 34 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 77871640cc..b0a4cb3388 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -306,43 +306,29 @@ static int block_crypto_open_generic(QCryptoBlockFo=
rmat format,
 }
=20
=20
-static int block_crypto_create_generic(QCryptoBlockFormat format,
-                                       const char *filename,
-                                       QemuOpts *opts,
-                                       Error **errp)
+static int block_crypto_co_create_generic(BlockDriverState *bs,
+                                          int64_t size,
+                                          QCryptoBlockCreateOptions *opt=
s,
+                                          Error **errp)
 {
-    int ret =3D -EINVAL;
-    QCryptoBlockCreateOptions *create_opts =3D NULL;
+    int ret;
+    BlockBackend *blk;
     QCryptoBlock *crypto =3D NULL;
-    struct BlockCryptoCreateData data =3D {
-        .size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0=
),
-                         BDRV_SECTOR_SIZE),
-    };
-    QDict *cryptoopts;
-
-    /* Parse options */
-    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
+    struct BlockCryptoCreateData data;
=20
-    create_opts =3D block_crypto_create_opts_init(format, cryptoopts, er=
rp);
-    if (!create_opts) {
-        return -1;
-    }
+    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
=20
-    /* Create protocol layer */
-    ret =3D bdrv_create_file(filename, opts, errp);
+    ret =3D blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-        return ret;
+        goto cleanup;
     }
=20
-    data.blk =3D blk_new_open(filename, NULL, NULL,
-                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCO=
L,
-                            errp);
-    if (!data.blk) {
-        return -EINVAL;
-    }
+    data =3D (struct BlockCryptoCreateData) {
+        .blk =3D blk,
+        .size =3D size,
+    };
=20
-    /* Create format layer */
-    crypto =3D qcrypto_block_create(create_opts, NULL,
+    crypto =3D qcrypto_block_create(opts, NULL,
                                   block_crypto_init_func,
                                   block_crypto_write_func,
                                   &data,
@@ -355,10 +341,8 @@ static int block_crypto_create_generic(QCryptoBlockF=
ormat format,
=20
     ret =3D 0;
  cleanup:
-    QDECREF(cryptoopts);
     qcrypto_block_free(crypto);
-    blk_unref(data.blk);
-    qapi_free_QCryptoBlockCreateOptions(create_opts);
+    blk_unref(blk);
     return ret;
 }
=20
@@ -563,8 +547,51 @@ static int coroutine_fn block_crypto_co_create_opts_=
luks(const char *filename,
                                                          QemuOpts *opts,
                                                          Error **errp)
 {
-    return block_crypto_create_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
-                                       filename, opts, errp);
+    QCryptoBlockCreateOptions *create_opts =3D NULL;
+    BlockDriverState *bs =3D NULL;
+    QDict *cryptoopts;
+    int64_t size;
+    int ret;
+
+    /* Parse options */
+    size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+
+    cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
+                                             &block_crypto_create_opts_l=
uks,
+                                             true);
+
+    create_opts =3D block_crypto_create_opts_init(Q_CRYPTO_BLOCK_FORMAT_=
LUKS,
+                                                cryptoopts, errp);
+    if (!create_opts) {
+        ret =3D -EINVAL;
+        goto fail;
+    }
+
+    /* Create protocol layer */
+    ret =3D bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bs =3D bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (!bs) {
+        ret =3D -EINVAL;
+        goto fail;
+    }
+
+    /* Create format layer */
+    ret =3D block_crypto_co_create_generic(bs, size, create_opts, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret =3D 0;
+fail:
+    bdrv_unref(bs);
+    qapi_free_QCryptoBlockCreateOptions(create_opts);
+    QDECREF(cryptoopts);
+    return ret;
 }
=20
 static int block_crypto_get_info_luks(BlockDriverState *bs,
--=20
2.13.6
