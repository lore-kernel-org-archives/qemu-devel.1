Received: from eggs.gnu.org ([209.51.188.92]:51631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGaI-0006jW-B4
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGa4-0005Od-Tq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:48 +0100
Message-Id: <20190131175549.11691-11-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 10/11] qcow2: Store data file name in the
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Rather than requiring that the external data file node is passed
explicitly when creating the qcow2 node, store the filename in the
designated header extension during .bdrv_create and read it from there
as a default during .bdrv_open.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h              |  1 +
 block/qcow2.c              | 69 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/082.out | 27 +++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index e2114900b4..a1e2600643 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -341,6 +341,7 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+    char *image_data_file;
=20
     CoQueue compress_wait_queue;
     int nb_compress_threads;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6cf862e8b9..4959bf16a4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -398,6 +398,20 @@ static int qcow2_read_extensions(BlockDriverState *b=
s, uint64_t start_offset,
 #endif
             break;
=20
+        case QCOW2_EXT_MAGIC_DATA_FILE:
+        {
+            s->image_data_file =3D g_malloc0(ext.len + 1);
+            ret =3D bdrv_pread(bs->file, offset, s->image_data_file, ext=
.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "ERROR: Could not data file=
 name");
+                return ret;
+            }
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got external data file %s\n", s->image_data_f=
ile);
+#endif
+            break;
+        }
+
         default:
             /* unknown magic - save it in case we need to rewrite the he=
ader */
             /* If you add a new feature, make sure to also update the fa=
st
@@ -1444,7 +1458,18 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
     /* Open external data file */
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs,
-                                       &child_file, false, errp);
+                                       &child_file, false, &local_err);
+        if (!s->data_file) {
+            if (s->image_data_file) {
+                error_free(local_err);
+                local_err =3D NULL;
+                s->data_file =3D bdrv_open_child(s->image_data_file, opt=
ions,
+                                               "data-file", bs, &child_f=
ile,
+                                               false, errp);
+            } else {
+                error_propagate(errp, local_err);
+            }
+        }
         if (!s->data_file) {
             ret =3D -EINVAL;
             goto fail;
@@ -1627,6 +1652,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     return ret;
=20
  fail:
+    g_free(s->image_data_file);
     if (has_data_file(bs)) {
         bdrv_unref_child(bs, s->data_file);
     }
@@ -2246,6 +2272,7 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
=20
+    g_free(s->image_data_file);
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
=20
@@ -2422,6 +2449,19 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -=3D ret;
     }
=20
+    /* External data file header extension */
+    if (has_data_file(bs) && s->image_data_file) {
+        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_DATA_FILE,
+                             s->image_data_file, strlen(s->image_data_fi=
le),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        buf +=3D ret;
+        buflen -=3D ret;
+    }
+
     /* Full disk encryption header pointer extension */
     if (s->crypto_header.offset !=3D 0) {
         s->crypto_header.offset =3D cpu_to_be64(s->crypto_header.offset)=
;
@@ -3166,6 +3206,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
     QDict *qdict;
     Visitor *v;
     BlockDriverState *bs =3D NULL;
+    BlockDriverState *data_bs =3D NULL;
     Error *local_err =3D NULL;
     const char *val;
     int ret;
@@ -3229,6 +3270,26 @@ static int coroutine_fn qcow2_co_create_opts(const=
 char *filename, QemuOpts *opt
         goto finish;
     }
=20
+    /* Create and open an external data file (protocol layer) */
+    val =3D qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
+    if (val) {
+        ret =3D bdrv_create_file(val, opts, errp);
+        if (ret < 0) {
+            goto finish;
+        }
+
+        data_bs =3D bdrv_open(val, NULL, NULL,
+                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCO=
L,
+                            errp);
+        if (data_bs =3D=3D NULL) {
+            ret =3D -EIO;
+            goto finish;
+        }
+
+        qdict_del(qdict, BLOCK_OPT_DATA_FILE);
+        qdict_put_str(qdict, "data-file", data_bs->node_name);
+    }
+
     /* Set 'driver' and 'node' options */
     qdict_put_str(qdict, "driver", "qcow2");
     qdict_put_str(qdict, "file", bs->node_name);
@@ -3263,6 +3324,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
 finish:
     qobject_unref(qdict);
     bdrv_unref(bs);
+    bdrv_unref(data_bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
@@ -4943,6 +5005,11 @@ static QemuOptsList qcow2_create_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "Image format of the base image"
         },
+        {
+            .name =3D BLOCK_OPT_DATA_FILE,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "File name of an external data file"
+        },
         {
             .name =3D BLOCK_OPT_ENCRYPT,
             .type =3D QEMU_OPT_BOOL,
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 0ce18c075b..7dc59f6075 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -48,6 +48,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -69,6 +70,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -90,6 +92,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -111,6 +114,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -132,6 +136,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -153,6 +158,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -174,6 +180,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -195,6 +202,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -231,6 +239,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -304,6 +313,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -325,6 +335,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -346,6 +357,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -367,6 +379,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -388,6 +401,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -409,6 +423,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -430,6 +445,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -451,6 +467,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -487,6 +504,7 @@ Supported options:
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -568,6 +586,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -590,6 +609,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -612,6 +632,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -634,6 +655,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -656,6 +678,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -678,6 +701,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -700,6 +724,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -722,6 +747,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -761,6 +787,7 @@ Creation options for 'qcow2':
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
+  data_file=3D<str>        - File name of an external data file
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
--=20
2.20.1
