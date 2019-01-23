Received: from eggs.gnu.org ([209.51.188.92]:40228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqw-0007sb-FQ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmFqt-00088p-RZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:33:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 10:33:22 +0000
Message-Id: <20190123103323.4516-2-stefanha@redhat.com>
In-Reply-To: <20190123103323.4516-1-stefanha@redhat.com>
References: <20190123103323.4516-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] qcow2: include LUKS payload overhead in
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

LUKS encryption reserves clusters for its own payload data.  The size of
this area must be included in the qemu-img measure calculation so that
we arrive at the correct minimum required image size.

(Ab)use the qcrypto_block_create() API to determine the payload
overhead.  We discard the payload data that qcrypto thinks will be
written to the image.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..e6f7685706 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4231,6 +4231,60 @@ static coroutine_fn int qcow2_co_flush_to_os(Block=
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
+/* Determine the number of bytes for the LUKS payload */
+static bool qcow2_measure_luks_headerlen(QemuOpts *opts, size_t *len,
+                                         Error **errp)
+{
+    QDict *opts_qdict;
+    QDict *cryptoopts_qdict;
+    QCryptoBlockCreateOptions *cryptoopts;
+    QCryptoBlock *crypto;
+
+    /* Extract "encrypt." options into a qdict */
+    opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
+    qobject_unref(opts_qdict);
+
+    /* Build QCryptoBlockCreateOptions object from qdict */
+    qdict_put_str(cryptoopts_qdict, "format", "luks");
+    cryptoopts =3D block_crypto_create_opts_init(cryptoopts_qdict, errp)=
;
+    qobject_unref(cryptoopts_qdict);
+    if (!cryptoopts) {
+        return false;
+    }
+
+    /* Fake LUKS creation in order to determine the payload size */
+    crypto =3D qcrypto_block_create(cryptoopts, "encrypt.",
+                                  qcow2_measure_crypto_hdr_init_func,
+                                  qcow2_measure_crypto_hdr_write_func,
+                                  len, errp);
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
+    if (!crypto) {
+        return false;
+    }
+
+    qcrypto_block_free(crypto);
+    return true;
+}
+
 static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState =
*in_bs,
                                        Error **errp)
 {
@@ -4240,11 +4294,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *=
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
@@ -4274,6 +4330,20 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *o=
pts, BlockDriverState *in_bs,
     has_backing_file =3D !!optstr;
     g_free(optstr);
=20
+    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
+    has_luks =3D optstr && strcmp(optstr, "luks") =3D=3D 0;
+    g_free(optstr);
+
+    if (has_luks) {
+        size_t headerlen;
+
+        if (!qcow2_measure_luks_headerlen(opts, &headerlen, &local_err))=
 {
+            goto err;
+        }
+
+        luks_payload_size =3D ROUND_UP(headerlen, cluster_size);
+    }
+
     virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
     virtual_size =3D ROUND_UP(virtual_size, cluster_size);
=20
@@ -4344,7 +4414,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
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
