Received: from eggs.gnu.org ([209.51.188.92]:55988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gjMcE-0002UJ-OU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gjMcD-00037D-R7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:10:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 15 Jan 2019 11:10:06 +0000
Message-Id: <20190115111007.27159-2-stefanha@redhat.com>
In-Reply-To: <20190115111007.27159-1-stefanha@redhat.com>
References: <20190115111007.27159-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qcow2: include LUKS payload overhead in
 qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

LUKS encryption reserves clusters for its own payload data.  The size of
this area must be included in the qemu-img measure calculation so that
we arrive at the correct minimum required image size.

(Ab)use the qcrypto_block_create() API to determine the payload
overhead.  We discard the payload data that qcrypto thinks will be
written to the image.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..7ab93a5d2f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4231,6 +4231,24 @@ static coroutine_fn int qcow2_co_flush_to_os(Block=
DriverState *bs)
     return ret;
 }
=20
+static ssize_t qcow2_measure_crypto_hdr_init_func(QCryptoBlock *block,
+        size_t headerlen, void *opaque, Error **errp)
+{
+    size_t *headerlenp =3D opaque;
+
+    /* Stash away the payload size */
+    *headerlenp =3D headerlen;
+    return 0;
+}
+
+static ssize_t qcow2_measure_crypto_hdr_write_func(QCryptoBlock *block,
+        size_t offset, const uint8_t *buf, size_t buflen,
+        void *opaque, Error **errp)
+{
+    /* Discard the bytes, we're not actually writing to an image */
+    return buflen;
+}
+
 static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState =
*in_bs,
                                        Error **errp)
 {
@@ -4240,11 +4258,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *=
opts, BlockDriverState *in_bs,
     uint64_t virtual_size; /* disk size as seen by guest */
     uint64_t refcount_bits;
     uint64_t l2_tables;
+    uint64_t luks_payload_size =3D 0;
     size_t cluster_size;
     int version;
     char *optstr;
     PreallocMode prealloc;
     bool has_backing_file;
+    bool has_luks;
=20
     /* Parse image creation options */
     cluster_size =3D qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4274,6 +4294,35 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *o=
pts, BlockDriverState *in_bs,
     has_backing_file =3D !!optstr;
     g_free(optstr);
=20
+    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
+    has_luks =3D optstr && strcmp(optstr, "luks") =3D=3D 0;
+    g_free(optstr);
+
+    if (has_luks) {
+        QCryptoBlockCreateOptions cryptoopts =3D {
+            .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        };
+        QCryptoBlock *crypto;
+        size_t headerlen;
+
+        optstr =3D qemu_opt_get_del(opts, "encrypt.key-secret");
+        cryptoopts.u.luks.has_key_secret =3D !!optstr;
+        cryptoopts.u.luks.key_secret =3D optstr;
+
+        crypto =3D qcrypto_block_create(&cryptoopts, "encrypt.",
+                                      qcow2_measure_crypto_hdr_init_func=
,
+                                      qcow2_measure_crypto_hdr_write_fun=
c,
+                                      &headerlen, &local_err);
+
+        g_free(optstr);
+        if (!crypto) {
+            goto err;
+        }
+        qcrypto_block_free(crypto);
+
+        luks_payload_size =3D ROUND_UP(headerlen, cluster_size);
+    }
+
     virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
     virtual_size =3D ROUND_UP(virtual_size, cluster_size);
=20
@@ -4344,7 +4393,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
     info =3D g_new(BlockMeasureInfo, 1);
     info->fully_allocated =3D
         qcow2_calc_prealloc_size(virtual_size, cluster_size,
-                                 ctz32(refcount_bits));
+                                 ctz32(refcount_bits)) + luks_payload_si=
ze;
=20
     /* Remove data clusters that are not required.  This overestimates t=
he
      * required size because metadata needed for the fully allocated fil=
e is
--=20
2.20.1
