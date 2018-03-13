Received: from eggs.gnu.org ([2001:4830:134:3::10]:59568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdI-0001Wn-TA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdH-0004hB-ON
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:46 +0100
Message-Id: <20180313161803.1814-25-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/41] luks: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to luks, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qapi/block-core.json | 17 ++++++++++++++++-
 block/crypto.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3e52d248eb..ba2d10d13a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3596,6 +3596,21 @@
             '*preallocation':   'PreallocMode' } }
=20
 ##
+# @BlockdevCreateOptionsLUKS:
+#
+# Driver specific image creation options for LUKS.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsLUKS',
+  'base': 'QCryptoBlockCreateOptionsLUKS',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size' } }
+
+##
 # @BlockdevCreateOptionsNfs:
 #
 # Driver specific image creation options for NFS.
@@ -3787,7 +3802,7 @@
       'http':           'BlockdevCreateNotSupported',
       'https':          'BlockdevCreateNotSupported',
       'iscsi':          'BlockdevCreateNotSupported',
-      'luks':           'BlockdevCreateNotSupported',
+      'luks':           'BlockdevCreateOptionsLUKS',
       'nbd':            'BlockdevCreateNotSupported',
       'nfs':            'BlockdevCreateOptionsNfs',
       'null-aio':       'BlockdevCreateNotSupported',
diff --git a/block/crypto.c b/block/crypto.c
index b0a4cb3388..a1139b6f09 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -543,6 +543,39 @@ static int block_crypto_open_luks(BlockDriverState *=
bs,
                                      bs, options, flags, errp);
 }
=20
+static int coroutine_fn
+block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error=
 **errp)
+{
+    BlockdevCreateOptionsLUKS *luks_opts;
+    BlockDriverState *bs =3D NULL;
+    QCryptoBlockCreateOptions create_opts;
+    int ret;
+
+    assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_LUKS);
+    luks_opts =3D &create_options->u.luks;
+
+    bs =3D bdrv_open_blockdev_ref(luks_opts->file, errp);
+    if (bs =3D=3D NULL) {
+        return -EIO;
+    }
+
+    create_opts =3D (QCryptoBlockCreateOptions) {
+        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
+    };
+
+    ret =3D block_crypto_co_create_generic(bs, luks_opts->size, &create_=
opts,
+                                         errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret =3D 0;
+fail:
+    bdrv_unref(bs);
+    return ret;
+}
+
 static int coroutine_fn block_crypto_co_create_opts_luks(const char *fil=
ename,
                                                          QemuOpts *opts,
                                                          Error **errp)
@@ -647,6 +680,7 @@ BlockDriver bdrv_crypto_luks =3D {
     .bdrv_open          =3D block_crypto_open_luks,
     .bdrv_close         =3D block_crypto_close,
     .bdrv_child_perm    =3D bdrv_format_default_perms,
+    .bdrv_co_create     =3D block_crypto_co_create_luks,
     .bdrv_co_create_opts =3D block_crypto_co_create_opts_luks,
     .bdrv_truncate      =3D block_crypto_truncate,
     .create_opts        =3D &block_crypto_create_opts_luks,
--=20
2.13.6
