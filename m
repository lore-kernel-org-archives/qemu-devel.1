Received: from eggs.gnu.org ([209.51.188.92]:60056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F64-0000Nr-Nu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F61-0000RD-4E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:16 +0100
Message-Id: <20190308125823.32535-27-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/33] qcow2: Store data file name in the image
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

Rather than requiring that the external data file node is passed
explicitly when creating the qcow2 node, store the filename in the
designated header extension during .bdrv_create and read it from there
as a default during .bdrv_open.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       |  8 +++-
 block/qcow2.h              |  1 +
 block/qcow2.c              | 94 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/082.out | 27 +++++++++++
 4 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2303266bc4..e6faa94fa2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -59,6 +59,9 @@
 #
 # @compat: compatibility level
 #
+# @data-file: the filename of the external data file that is stored in t=
he
+#             image and used as a default for opening the image (since: =
4.0)
+#
 # @lazy-refcounts: on or off; only valid for compat >=3D 1.1
 #
 # @corrupt: true if the image has been marked corrupt; only valid for
@@ -76,6 +79,7 @@
 { 'struct': 'ImageInfoSpecificQCow2',
   'data': {
       'compat': 'str',
+      '*data-file': 'str',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
@@ -3082,7 +3086,9 @@
 #
 # @data-file:             reference to or definition of the external dat=
a file.
 #                         This may only be specified for images that req=
uire an
-#                         external data file. (since 4.0)
+#                         external data file. If it is not specified for=
 such
+#                         an image, the data file name is loaded from th=
e image
+#                         file. (since 4.0)
 #
 # Since: 2.9
 ##
diff --git a/block/qcow2.h b/block/qcow2.h
index f23c003a46..a9c9cb4a26 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -343,6 +343,7 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+    char *image_data_file;
=20
     CoQueue compress_wait_queue;
     int nb_compress_threads;
diff --git a/block/qcow2.c b/block/qcow2.c
index c20141b4e7..f32ddda2a7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -398,6 +398,21 @@ static int qcow2_read_extensions(BlockDriverState *b=
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
+                error_setg_errno(errp, -ret,
+                                 "ERROR: Could not read data file name")=
;
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
@@ -1463,6 +1478,15 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
     }
=20
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
+        if (!s->data_file && s->image_data_file) {
+            s->data_file =3D bdrv_open_child(s->image_data_file, options=
,
+                                           "data-file", bs, &child_file,
+                                           false, errp);
+            if (!s->data_file) {
+                ret =3D -EINVAL;
+                goto fail;
+            }
+        }
         if (!s->data_file) {
             error_setg(errp, "'data-file' is required for this image");
             ret =3D -EINVAL;
@@ -1650,6 +1674,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     return ret;
=20
  fail:
+    g_free(s->image_data_file);
     if (has_data_file(bs)) {
         bdrv_unref_child(bs, s->data_file);
     }
@@ -2269,6 +2294,7 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
=20
+    g_free(s->image_data_file);
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
=20
@@ -2445,6 +2471,19 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3086,6 +3125,12 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
         abort();
     }
=20
+    /* Set the external data file if necessary */
+    if (data_bs) {
+        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
+        s->image_data_file =3D g_strdup(data_bs->filename);
+    }
+
     /* Create a full header (including things like feature table) */
     ret =3D qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
@@ -3165,6 +3210,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
     QDict *qdict;
     Visitor *v;
     BlockDriverState *bs =3D NULL;
+    BlockDriverState *data_bs =3D NULL;
     Error *local_err =3D NULL;
     const char *val;
     int ret;
@@ -3228,6 +3274,26 @@ static int coroutine_fn qcow2_co_create_opts(const=
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
@@ -3262,6 +3328,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
 finish:
     qobject_unref(qdict);
     bdrv_unref(bs);
+    bdrv_unref(data_bs);
     qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
@@ -4552,6 +4619,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs,
             .refcount_bits      =3D s->refcount_bits,
             .has_bitmaps        =3D !!bitmaps,
             .bitmaps            =3D bitmaps,
+            .has_data_file      =3D !!s->image_data_file,
+            .data_file          =3D g_strdup(s->image_data_file),
         };
     } else {
         /* if this assertion fails, this probably means a new version wa=
s
@@ -4754,7 +4823,7 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
     BDRVQcow2State *s =3D bs->opaque;
     int old_version =3D s->qcow_version, new_version =3D old_version;
     uint64_t new_size =3D 0;
-    const char *backing_file =3D NULL, *backing_format =3D NULL;
+    const char *backing_file =3D NULL, *backing_format =3D NULL, *data_f=
ile =3D NULL;
     bool lazy_refcounts =3D s->use_lazy_refcounts;
     const char *compat =3D NULL;
     uint64_t cluster_size =3D s->cluster_size;
@@ -4836,6 +4905,13 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
                            "may not exceed 64 bits");
                 return -EINVAL;
             }
+        } else if (!strcmp(desc->name, BLOCK_OPT_DATA_FILE)) {
+            data_file =3D qemu_opt_get(opts, BLOCK_OPT_DATA_FILE);
+            if (data_file && !has_data_file(bs)) {
+                error_setg(errp, "data-file can only be set for images t=
hat "
+                                 "use an external data file");
+                return -EINVAL;
+            }
         } else {
             /* if this point is reached, this probably means a new optio=
n was
              * added without having it covered here */
@@ -4882,6 +4958,17 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
         }
     }
=20
+    if (data_file) {
+        g_free(s->image_data_file);
+        s->image_data_file =3D *data_file ? g_strdup(data_file) : NULL;
+    }
+
+    ret =3D qcow2_update_header(bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to update the image header"=
);
+        return ret;
+    }
+
     if (backing_file || backing_format) {
         ret =3D qcow2_change_backing_file(bs,
                     backing_file ?: s->image_backing_file,
@@ -5029,6 +5116,11 @@ static QemuOptsList qcow2_create_opts =3D {
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
