Received: from eggs.gnu.org ([209.51.188.92]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5l-0008Qc-7z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5i-0007EO-ST
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:04 +0100
Message-Id: <20190308125823.32535-15-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/33] qcow2: Basic definitions for external
 data files
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

This adds basic constants, struct fields and helper function for
external data file support to the implementation.

QCOW2_INCOMPAT_MASK and QCOW2_AUTOCLEAR_MASK are not updated yet so that
opening images with an external data file still fails (we don't handle
them correctly yet).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h              | 32 ++++++++++++++++++++++----------
 block/qcow2.c              |  9 +++++++++
 tests/qemu-iotests/031.out |  8 ++++----
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061.out | 14 +++++++-------
 5 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9dd02df831..c63c3959f7 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -197,13 +197,15 @@ enum {
=20
 /* Incompatible feature bits */
 enum {
-    QCOW2_INCOMPAT_DIRTY_BITNR   =3D 0,
-    QCOW2_INCOMPAT_CORRUPT_BITNR =3D 1,
-    QCOW2_INCOMPAT_DIRTY         =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
-    QCOW2_INCOMPAT_CORRUPT       =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
-
-    QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
-                                 | QCOW2_INCOMPAT_CORRUPT,
+    QCOW2_INCOMPAT_DIRTY_BITNR      =3D 0,
+    QCOW2_INCOMPAT_CORRUPT_BITNR    =3D 1,
+    QCOW2_INCOMPAT_DATA_FILE_BITNR  =3D 2,
+    QCOW2_INCOMPAT_DIRTY            =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
+    QCOW2_INCOMPAT_CORRUPT          =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITN=
R,
+    QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_BI=
TNR,
+
+    QCOW2_INCOMPAT_MASK             =3D QCOW2_INCOMPAT_DIRTY
+                                    | QCOW2_INCOMPAT_CORRUPT,
 };
=20
 /* Compatible feature bits */
@@ -216,10 +218,12 @@ enum {
=20
 /* Autoclear feature bits */
 enum {
-    QCOW2_AUTOCLEAR_BITMAPS_BITNR =3D 0,
-    QCOW2_AUTOCLEAR_BITMAPS       =3D 1 << QCOW2_AUTOCLEAR_BITMAPS_BITNR=
,
+    QCOW2_AUTOCLEAR_BITMAPS_BITNR       =3D 0,
+    QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR =3D 1,
+    QCOW2_AUTOCLEAR_BITMAPS             =3D 1 << QCOW2_AUTOCLEAR_BITMAPS=
_BITNR,
+    QCOW2_AUTOCLEAR_DATA_FILE_RAW       =3D 1 << QCOW2_AUTOCLEAR_DATA_FI=
LE_RAW_BITNR,
=20
-    QCOW2_AUTOCLEAR_MASK          =3D QCOW2_AUTOCLEAR_BITMAPS,
+    QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS,
 };
=20
 enum qcow2_discard_type {
@@ -340,6 +344,8 @@ typedef struct BDRVQcow2State {
=20
     CoQueue compress_wait_queue;
     int nb_compress_threads;
+
+    BdrvChild *data_file;
 } BDRVQcow2State;
=20
 typedef struct Qcow2COWRegion {
@@ -457,6 +463,12 @@ typedef enum QCow2MetadataOverlap {
=20
 #define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
=20
+static inline bool has_data_file(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    return (s->data_file !=3D bs->file);
+}
+
 static inline int64_t start_of_cluster(BDRVQcow2State *s, int64_t offset=
)
 {
     return offset & ~(s->cluster_size - 1);
diff --git a/block/qcow2.c b/block/qcow2.c
index 9489d795e5..59cf706dc2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
+#define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
=20
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -1452,6 +1453,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
         goto fail;
     }
=20
+    /* TODO Open external data file */
+    s->data_file =3D bs->file;
+
     /* qcow2_read_extension may have set up the crypto context
      * if the crypt method needs a header region, some methods
      * don't need header extensions, so must check here
@@ -2440,6 +2444,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  =3D QCOW2_INCOMPAT_CORRUPT_BITNR,
                 .name =3D "corrupt bit",
             },
+            {
+                .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  =3D QCOW2_INCOMPAT_DATA_FILE_BITNR,
+                .name =3D "external data file",
+            },
             {
                 .type =3D QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 7f5050b816..68a74d03b9 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 Header extension:
@@ -150,7 +150,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
=20
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x148
+backing_file_offset       0x178
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 9b009b8c15..e489b44386 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -58,7 +58,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
=20
@@ -86,7 +86,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 183f7dd690..758284011b 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 magic                     0x514649fb
@@ -144,7 +144,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -199,7 +199,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 magic                     0x514649fb
@@ -268,7 +268,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 read 65536/65536 bytes at offset 44040192
@@ -306,7 +306,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -335,7 +335,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    144
+length                    192
 data                      <binary>
=20
 read 131072/131072 bytes at offset 0
--=20
2.20.1
