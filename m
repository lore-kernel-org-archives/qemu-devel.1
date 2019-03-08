Received: from eggs.gnu.org ([209.51.188.92]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F6E-0000YC-9k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F68-00015j-Ic
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:17 +0100
Message-Id: <20190308125823.32535-28-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/33] qcow2: Implement data-file-raw create
 option
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

Provide an option to force QEMU to always keep the external data file
consistent as a standalone read-only raw image.

At the moment, this means making sure that write_zeroes requests are
forwarded to the data file instead of just updating the metadata, and
checking that no backing file is used.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       |  9 ++++++
 block/qcow2.h              |  9 +++++-
 include/block/block_int.h  |  1 +
 block/qcow2-cluster.c      | 10 +++++++
 block/qcow2.c              | 56 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/082.out | 27 ++++++++++++++++++
 6 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6faa94fa2..919d0530b2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -62,6 +62,10 @@
 # @data-file: the filename of the external data file that is stored in t=
he
 #             image and used as a default for opening the image (since: =
4.0)
 #
+# @data-file-raw: True if the external data file must stay valid as a
+#                 standalone (read-only) raw image without looking at qc=
ow2
+#                 metadata (since: 4.0)
+#
 # @lazy-refcounts: on or off; only valid for compat >=3D 1.1
 #
 # @corrupt: true if the image has been marked corrupt; only valid for
@@ -80,6 +84,7 @@
   'data': {
       'compat': 'str',
       '*data-file': 'str',
+      '*data-file-raw': 'bool',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
@@ -4144,6 +4149,9 @@
 # @data-file        Node to use as an external data file in which all gu=
est
 #                   data is stored so that only metadata remains in the =
qcow2
 #                   file (since: 4.0)
+# @data-file-raw    True if the external data file must stay valid as a
+#                   standalone (read-only) raw image without looking at =
qcow2
+#                   metadata (default: false; since: 4.0)
 # @size             Size of the virtual disk in bytes
 # @version          Compatibility level (default: v3)
 # @backing-file     File name of the backing file if a backing file
@@ -4160,6 +4168,7 @@
 { 'struct': 'BlockdevCreateOptionsQcow2',
   'data': { 'file':             'BlockdevRef',
             '*data-file':       'BlockdevRef',
+            '*data-file-raw':   'bool',
             'size':             'size',
             '*version':         'BlockdevQcow2Version',
             '*backing-file':    'str',
diff --git a/block/qcow2.h b/block/qcow2.h
index a9c9cb4a26..de2a3bdfc5 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -225,7 +225,8 @@ enum {
     QCOW2_AUTOCLEAR_BITMAPS             =3D 1 << QCOW2_AUTOCLEAR_BITMAPS=
_BITNR,
     QCOW2_AUTOCLEAR_DATA_FILE_RAW       =3D 1 << QCOW2_AUTOCLEAR_DATA_FI=
LE_RAW_BITNR,
=20
-    QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS,
+    QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS
+                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
 };
=20
 enum qcow2_discard_type {
@@ -474,6 +475,12 @@ static inline bool has_data_file(BlockDriverState *b=
s)
     return (s->data_file !=3D bs->file);
 }
=20
+static inline bool data_file_is_raw(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    return !!(s->autoclear_features & QCOW2_AUTOCLEAR_DATA_FILE_RAW);
+}
+
 static inline int64_t start_of_cluster(BDRVQcow2State *s, int64_t offset=
)
 {
     return offset & ~(s->cluster_size - 1);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index acd29ce521..a23cabaddd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_OBJECT_SIZE       "object_size"
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
+#define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
=20
 #define BLOCK_PROBE_BUF_SIZE        512
=20
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 7579f5a5ae..974a4e8656 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1783,6 +1783,16 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, ui=
nt64_t offset,
     int64_t cleared;
     int ret;
=20
+    /* If we have to stay in sync with an external data file, zero out
+     * s->data_file first. */
+    if (data_file_is_raw(bs)) {
+        assert(has_data_file(bs));
+        ret =3D bdrv_co_pwrite_zeroes(s->data_file, offset, bytes, flags=
);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
diff --git a/block/qcow2.c b/block/qcow2.c
index f32ddda2a7..c4dd876fb4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1498,8 +1498,14 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
                              "external data file");
             ret =3D -EINVAL;
             goto fail;
-        } else {
-            s->data_file =3D bs->file;
+        }
+
+        s->data_file =3D bs->file;
+
+        if (data_file_is_raw(bs)) {
+            error_setg(errp, "data-file-raw requires a data file");
+            ret =3D -EINVAL;
+            goto fail;
         }
     }
=20
@@ -2606,6 +2612,12 @@ static int qcow2_change_backing_file(BlockDriverSt=
ate *bs,
 {
     BDRVQcow2State *s =3D bs->opaque;
=20
+    /* Adding a backing file means that the external data file alone won=
't be
+     * enough to make sense of the content */
+    if (backing_file && data_file_is_raw(bs)) {
+        return -EINVAL;
+    }
+
     if (backing_file && strlen(backing_file) > 1023) {
         return -EINVAL;
     }
@@ -3016,6 +3028,18 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
     }
     refcount_order =3D ctz32(qcow2_opts->refcount_bits);
=20
+    if (qcow2_opts->data_file_raw && !qcow2_opts->data_file) {
+        error_setg(errp, "data-file-raw requires data-file");
+        ret =3D -EINVAL;
+        goto out;
+    }
+    if (qcow2_opts->data_file_raw && qcow2_opts->has_backing_file) {
+        error_setg(errp, "Backing file and data-file-raw cannot be used =
at "
+                   "the same time");
+        ret =3D -EINVAL;
+        goto out;
+    }
+
     if (qcow2_opts->data_file) {
         if (version < 3) {
             error_setg(errp, "External data files are only supported wit=
h "
@@ -3072,6 +3096,10 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
         header->incompatible_features |=3D
             cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
     }
+    if (qcow2_opts->data_file_raw) {
+        header->autoclear_features |=3D
+            cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
+    }
=20
     ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
@@ -3253,6 +3281,7 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
         { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
         { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
+        { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { NULL, NULL },
     };
=20
@@ -4621,6 +4650,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs,
             .bitmaps            =3D bitmaps,
             .has_data_file      =3D !!s->image_data_file,
             .data_file          =3D g_strdup(s->image_data_file),
+            .has_data_file_raw  =3D has_data_file(bs),
+            .data_file_raw      =3D data_file_is_raw(bs),
         };
     } else {
         /* if this assertion fails, this probably means a new version wa=
s
@@ -4825,6 +4856,7 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
     uint64_t new_size =3D 0;
     const char *backing_file =3D NULL, *backing_format =3D NULL, *data_f=
ile =3D NULL;
     bool lazy_refcounts =3D s->use_lazy_refcounts;
+    bool data_file_raw =3D data_file_is_raw(bs);
     const char *compat =3D NULL;
     uint64_t cluster_size =3D s->cluster_size;
     bool encrypt;
@@ -4912,6 +4944,14 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
                                  "use an external data file");
                 return -EINVAL;
             }
+        } else if (!strcmp(desc->name, BLOCK_OPT_DATA_FILE_RAW)) {
+            data_file_raw =3D qemu_opt_get_bool(opts, BLOCK_OPT_DATA_FIL=
E_RAW,
+                                              data_file_raw);
+            if (data_file_raw && !data_file_is_raw(bs)) {
+                error_setg(errp, "data-file-raw cannot be set on existin=
g "
+                                 "images");
+                return -EINVAL;
+            }
         } else {
             /* if this point is reached, this probably means a new optio=
n was
              * added without having it covered here */
@@ -4958,6 +4998,13 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
         }
     }
=20
+    /* data-file-raw blocks backing files, so clear it first if requeste=
d */
+    if (data_file_raw) {
+        s->autoclear_features |=3D QCOW2_AUTOCLEAR_DATA_FILE_RAW;
+    } else {
+        s->autoclear_features &=3D ~QCOW2_AUTOCLEAR_DATA_FILE_RAW;
+    }
+
     if (data_file) {
         g_free(s->image_data_file);
         s->image_data_file =3D *data_file ? g_strdup(data_file) : NULL;
@@ -5121,6 +5168,11 @@ static QemuOptsList qcow2_create_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "File name of an external data file"
         },
+        {
+            .name =3D BLOCK_OPT_DATA_FILE_RAW,
+            .type =3D QEMU_OPT_BOOL,
+            .help =3D "The external data file must stay valid as a raw i=
mage"
+        },
         {
             .name =3D BLOCK_OPT_ENCRYPT,
             .type =3D QEMU_OPT_BOOL,
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 7dc59f6075..915640613f 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -49,6 +49,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -71,6 +72,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -93,6 +95,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -115,6 +118,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -137,6 +141,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -159,6 +164,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -181,6 +187,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -203,6 +210,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -240,6 +248,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -314,6 +323,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -336,6 +346,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -358,6 +369,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -380,6 +392,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -402,6 +415,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -424,6 +438,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -446,6 +461,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -468,6 +484,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -505,6 +522,7 @@ Supported options:
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -587,6 +605,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -610,6 +629,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -633,6 +653,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -656,6 +677,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -679,6 +701,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -702,6 +725,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -725,6 +749,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -748,6 +773,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
@@ -788,6 +814,7 @@ Creation options for 'qcow2':
   cluster_size=3D<size>    - qcow2 cluster size
   compat=3D<str>           - Compatibility level (0.10 or 1.1)
   data_file=3D<str>        - File name of an external data file
+  data_file_raw=3D<bool (on/off)> - The external data file must stay val=
id as a raw image
   encrypt.cipher-alg=3D<str> - Name of encryption cipher algorithm
   encrypt.cipher-mode=3D<str> - Name of encryption cipher mode
   encrypt.format=3D<str>   - Encrypt the image, format choices: 'aes', '=
luks'
--=20
2.20.1
