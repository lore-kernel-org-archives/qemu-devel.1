Received: from eggs.gnu.org ([209.51.188.92]:51461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZu-0006HT-Hk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZm-0005EY-Ip
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:46 +0100
Message-Id: <20190131175549.11691-9-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
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

This adds a .bdrv_open option to specify the external data file node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  3 ++-
 block/qcow2.h        |  4 +++-
 block/qcow2.c        | 25 +++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7f6b4b3ddd..fc46396079 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2928,7 +2928,8 @@
             '*l2-cache-entry-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
-            '*encrypt': 'BlockdevQcow2Encryption' } }
+            '*encrypt': 'BlockdevQcow2Encryption',
+            '*data-file': 'BlockdevRef' } }
=20
 ##
 # @SshHostKeyCheckMode:
diff --git a/block/qcow2.h b/block/qcow2.h
index c161970882..e2114900b4 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -91,6 +91,7 @@
=20
 #define DEFAULT_CLUSTER_SIZE 65536
=20
+#define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
 #define QCOW2_OPT_DISCARD_SNAPSHOT "pass-discard-snapshot"
@@ -205,7 +206,8 @@ enum {
     QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_BI=
TNR,
=20
     QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
-                                 | QCOW2_INCOMPAT_CORRUPT,
+                                 | QCOW2_INCOMPAT_CORRUPT
+                                 | QCOW2_INCOMPAT_DATA_FILE,
 };
=20
 /* Compatible feature bits */
diff --git a/block/qcow2.c b/block/qcow2.c
index ac9934b3ed..376232d3f0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
         goto fail;
     }
=20
-    /* TODO Open external data file */
-    s->data_file =3D bs->file;
+    /* Open external data file */
+    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
+        s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs,
+                                       &child_file, false, errp);
+        if (!s->data_file) {
+            ret =3D -EINVAL;
+            goto fail;
+        }
+    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {
+        error_setg(errp, "'data-file' can only be set for images with an=
 "
+                         "external data file");
+        ret =3D -EINVAL;
+        goto fail;
+    } else {
+        s->data_file =3D bs->file;
+    }
=20
     /* qcow2_read_extension may have set up the crypto context
      * if the crypt method needs a header region, some methods
@@ -1613,6 +1627,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     return ret;
=20
  fail:
+    if (has_data_file(bs)) {
+        bdrv_unref_child(bs, s->data_file);
+    }
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
     qcow2_free_snapshots(bs);
@@ -2232,6 +2249,10 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
=20
+    if (has_data_file(bs)) {
+        bdrv_unref_child(bs, s->data_file);
+    }
+
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
 }
--=20
2.20.1
