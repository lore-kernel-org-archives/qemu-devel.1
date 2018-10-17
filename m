Received: from eggs.gnu.org ([2001:4830:134:3::10]:45011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouT-0007YW-3k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCouK-0004Fm-Ef
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:42:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 17 Oct 2018 18:41:54 +0200
Message-Id: <20181017164200.22344-4-kwolf@redhat.com>
In-Reply-To: <20181017164200.22344-1-kwolf@redhat.com>
References: <20181017164200.22344-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/9] block: Require auto-read-only for
 existing fallbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Some block drivers have traditionally changed their node to read-only
mode without asking the user. This behaviour has been marked deprecated
since 2.11, expecting users to provide an explicit read-only=3Don option.

Now that we have auto-read-only=3Don, enable these drivers to make use of
the option.

This is the only use of bdrv_set_read_only(), so we can make it a bit
more specific and turn it into a bdrv_apply_auto_read_only() that is
more convenient for drivers to use.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  3 ++-
 block.c               | 42 +++++++++++++++++++++++++++---------------
 block/bochs.c         | 17 ++++++-----------
 block/cloop.c         | 16 +++++-----------
 block/dmg.c           | 16 +++++-----------
 block/rbd.c           | 14 ++++----------
 block/vvfat.c         | 10 ++--------
 7 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 580b3716c3..7f5453b45b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -438,7 +438,8 @@ int bdrv_is_allocated_above(BlockDriverState *top, Bl=
ockDriverState *base,
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
-int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **err=
p);
+int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
+                              Error **errp);
 bool bdrv_is_writable(BlockDriverState *bs);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
diff --git a/block.c b/block.c
index ed73522cc6..a97e324f39 100644
--- a/block.c
+++ b/block.c
@@ -266,29 +266,41 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bo=
ol read_only,
     return 0;
 }
=20
-/* TODO Remove (deprecated since 2.11)
- * Block drivers are not supposed to automatically change bs->read_only.
- * Instead, they should just check whether they can provide what the use=
r
- * explicitly requested and error out if read-write is requested, but th=
ey can
- * only provide read-only access. */
-int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **err=
p)
+/*
+ * Called by a driver that can only provide a read-only image.
+ *
+ * Returns 0 if the node is already read-only or it could switch the nod=
e to
+ * read-only because BDRV_O_AUTO_RDONLY is set.
+ *
+ * Returns -EACCES if the node is read-write and BDRV_O_AUTO_RDONLY is n=
ot set
+ * or bdrv_can_set_read_only() forbids making the node read-only. If @er=
rmsg
+ * is not NULL, it is used as the error message for the Error object.
+ */
+int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
+                              Error **errp)
 {
     int ret =3D 0;
=20
-    ret =3D bdrv_can_set_read_only(bs, read_only, false, errp);
-    if (ret < 0) {
-        return ret;
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        return 0;
+    }
+    if (!(bs->open_flags & BDRV_O_AUTO_RDONLY)) {
+        goto fail;
     }
=20
-    bs->read_only =3D read_only;
-
-    if (read_only) {
-        bs->open_flags &=3D ~BDRV_O_RDWR;
-    } else {
-        bs->open_flags |=3D BDRV_O_RDWR;
+    ret =3D bdrv_can_set_read_only(bs, true, false, NULL);
+    if (ret < 0) {
+        goto fail;
     }
=20
+    bs->read_only =3D true;
+    bs->open_flags &=3D ~BDRV_O_RDWR;
+
     return 0;
+
+fail:
+    error_setg(errp, "%s", errmsg ?: "Image is read-only");
+    return -EACCES;
 }
=20
 void bdrv_get_full_backing_filename_from_filename(const char *backed,
diff --git a/block/bochs.c b/block/bochs.c
index 50c630047b..22e7d44211 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -105,23 +105,18 @@ static int bochs_open(BlockDriverState *bs, QDict *=
options, int flags,
     struct bochs_header bochs;
     int ret;
=20
+    /* No write support yet */
+    ret =3D bdrv_apply_auto_read_only(bs, NULL, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
=20
-    if (!bdrv_is_read_only(bs)) {
-        error_report("Opening bochs images without an explicit read-only=
=3Don "
-                     "option is deprecated. Future versions will refuse =
to "
-                     "open the image instead of automatically marking th=
e "
-                     "image read-only.");
-        ret =3D bdrv_set_read_only(bs, true, errp); /* no write support =
yet */
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
     ret =3D bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
     if (ret < 0) {
         return ret;
diff --git a/block/cloop.c b/block/cloop.c
index 2be68987bd..df2b85f723 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -67,23 +67,17 @@ static int cloop_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     uint32_t offsets_size, max_compressed_block_size =3D 1, i;
     int ret;
=20
+    ret =3D bdrv_apply_auto_read_only(bs, NULL, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
=20
-    if (!bdrv_is_read_only(bs)) {
-        error_report("Opening cloop images without an explicit read-only=
=3Don "
-                     "option is deprecated. Future versions will refuse =
to "
-                     "open the image instead of automatically marking th=
e "
-                     "image read-only.");
-        ret =3D bdrv_set_read_only(bs, true, errp);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
     /* read header */
     ret =3D bdrv_pread(bs->file, 128, &s->block_size, 4);
     if (ret < 0) {
diff --git a/block/dmg.c b/block/dmg.c
index c9b3c519c4..1d9283ba2f 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -413,23 +413,17 @@ static int dmg_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     int64_t offset;
     int ret;
=20
+    ret =3D bdrv_apply_auto_read_only(bs, NULL, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
=20
-    if (!bdrv_is_read_only(bs)) {
-        error_report("Opening dmg images without an explicit read-only=3D=
on "
-                     "option is deprecated. Future versions will refuse =
to "
-                     "open the image instead of automatically marking th=
e "
-                     "image read-only.");
-        ret =3D bdrv_set_read_only(bs, true, errp);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
     block_module_load_one("dmg-bz2");
=20
     s->n_chunks =3D 0;
diff --git a/block/rbd.c b/block/rbd.c
index 014c68d629..ee0b4a6941 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -780,16 +780,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDic=
t *options, int flags,
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap !=3D NULL) {
-        if (!bdrv_is_read_only(bs)) {
-            error_report("Opening rbd snapshots without an explicit "
-                         "read-only=3Don option is deprecated. Future ve=
rsions "
-                         "will refuse to open the image instead of "
-                         "automatically marking the image read-only.");
-            r =3D bdrv_set_read_only(bs, true, &local_err);
-            if (r < 0) {
-                error_propagate(errp, local_err);
-                goto failed_open;
-            }
+        r =3D bdrv_apply_auto_read_only(bs, "rbd snapshots are read-only=
", errp);
+        if (r < 0) {
+            rbd_close(s->image);
+            goto failed_open;
         }
     }
=20
diff --git a/block/vvfat.c b/block/vvfat.c
index 98ba5e2bac..e4df255d58 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1262,15 +1262,9 @@ static int vvfat_open(BlockDriverState *bs, QDict =
*options, int flags,
                        "Unable to set VVFAT to 'rw' when drive is read-o=
nly");
             goto fail;
         }
-    } else  if (!bdrv_is_read_only(bs)) {
-        error_report("Opening non-rw vvfat images without an explicit "
-                     "read-only=3Don option is deprecated. Future versio=
ns "
-                     "will refuse to open the image instead of "
-                     "automatically marking the image read-only.");
-        /* read only is the default for safety */
-        ret =3D bdrv_set_read_only(bs, true, &local_err);
+    } else {
+        ret =3D bdrv_apply_auto_read_only(bs, NULL, errp);
         if (ret < 0) {
-            error_propagate(errp, local_err);
             goto fail;
         }
     }
--=20
2.19.1
