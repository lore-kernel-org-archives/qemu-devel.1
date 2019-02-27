Received: from eggs.gnu.org ([209.51.188.92]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2wi-0003w0-FO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2wf-0003yP-BF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:24:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 27 Feb 2019 18:22:51 +0100
Message-Id: <20190227172256.30368-16-kwolf@redhat.com>
In-Reply-To: <20190227172256.30368-1-kwolf@redhat.com>
References: <20190227172256.30368-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/20] qcow2: Creating images with external
 data file
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

This adds a .bdrv_create option to use an external data file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json      |  4 ++++
 include/block/block_int.h |  1 +
 block/qcow2.c             | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index de4d4fd0e4..2303266bc4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4135,6 +4135,9 @@
 # Driver specific image creation options for qcow2.
 #
 # @file             Node to create the image format on
+# @data-file        Node to use as an external data file in which all gu=
est
+#                   data is stored so that only metadata remains in the =
qcow2
+#                   file (since: 4.0)
 # @size             Size of the virtual disk in bytes
 # @version          Compatibility level (default: v3)
 # @backing-file     File name of the backing file if a backing file
@@ -4150,6 +4153,7 @@
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
   'data': { 'file':             'BlockdevRef',
+            '*data-file':       'BlockdevRef',
             'size':             'size',
             '*version':         'BlockdevQcow2Version',
             '*backing-file':    'str',
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 836d67c1ae..acd29ce521 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -56,6 +56,7 @@
 #define BLOCK_OPT_NOCOW             "nocow"
 #define BLOCK_OPT_OBJECT_SIZE       "object_size"
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
+#define BLOCK_OPT_DATA_FILE         "data_file"
=20
 #define BLOCK_PROBE_BUF_SIZE        512
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 37ab645e7b..a6144689ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2868,6 +2868,7 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
      */
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs =3D NULL;
+    BlockDriverState *data_bs =3D NULL;
     QCowHeader *header;
     size_t cluster_size;
     int version;
@@ -2964,6 +2965,20 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
     }
     refcount_order =3D ctz32(qcow2_opts->refcount_bits);
=20
+    if (qcow2_opts->data_file) {
+        if (version < 3) {
+            error_setg(errp, "External data files are only supported wit=
h "
+                       "compatibility level 1.1 and above (use version=3D=
v3 or "
+                       "greater)");
+            ret =3D -EINVAL;
+            goto out;
+        }
+        data_bs =3D bdrv_open_blockdev_ref(qcow2_opts->data_file, errp);
+        if (bs =3D=3D NULL) {
+            ret =3D -EIO;
+            goto out;
+        }
+    }
=20
     /* Create BlockBackend to write to the image */
     blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
@@ -3002,6 +3017,10 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
         header->compatible_features |=3D
             cpu_to_be64(QCOW2_COMPAT_LAZY_REFCOUNTS);
     }
+    if (data_bs) {
+        header->incompatible_features |=3D
+            cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
+    }
=20
     ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
@@ -3032,6 +3051,9 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
     options =3D qdict_new();
     qdict_put_str(options, "driver", "qcow2");
     qdict_put_str(options, "file", bs->node_name);
+    if (data_bs) {
+        qdict_put_str(options, "data-file", data_bs->node_name);
+    }
     blk =3D blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
                        &local_err);
@@ -3104,6 +3126,9 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
     options =3D qdict_new();
     qdict_put_str(options, "driver", "qcow2");
     qdict_put_str(options, "file", bs->node_name);
+    if (data_bs) {
+        qdict_put_str(options, "data-file", data_bs->node_name);
+    }
     blk =3D blk_new_open(NULL, NULL, options,
                        BDRV_O_RDWR | BDRV_O_NO_BACKING | BDRV_O_NO_IO,
                        &local_err);
@@ -3117,6 +3142,7 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
 out:
     blk_unref(blk);
     bdrv_unref(bs);
+    bdrv_unref(data_bs);
     return ret;
 }
=20
--=20
2.20.1
