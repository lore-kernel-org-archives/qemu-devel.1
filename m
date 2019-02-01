Received: from eggs.gnu.org ([209.51.188.92]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVs-0005nN-Jq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVo-0002Qr-GY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:08 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:08 +0100
Message-Id: <20190201192935.18394-5-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 04/31] block: Add BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

If the backing file is overridden, this most probably does change the
guest-visible data of a BDS.  Therefore, we will need to consider this
in bdrv_refresh_filename().

To see whether it has been overridden, we might want to compare
bs->backing_file and bs->backing->bs->filename.  However,
bs->backing_file is changed by bdrv_set_backing_hd() (which is just used
to change the backing child at runtime, without modifying the image
header), so bs->backing_file most of the time simply contains a copy of
bs->backing->bs->filename anyway, so it is useless for such a
comparison.

This patch adds an auto_backing_file BDS field which contains the
backing file path as indicated by the image header, which is not changed
by bdrv_set_backing_hd().

Because of bdrv_refresh_filename() magic, however, a BDS's filename may
differ from what has been specified during bdrv_open().  Then, the
comparison between bs->auto_backing_file and bs->backing->bs->filename
may fail even though bs->backing was opened from bs->auto_backing_file.
To mitigate this, we can copy the real BDS's filename (after the whole
bdrv_open() and bdrv_refresh_filename() process) into
bs->auto_backing_file, if we know the former has been opened based on
the latter.  This is only possible if no options modifying the backing
file's behavior have been specified, though.  To simplify things, this
patch only copies the filename from the backing file if no options have
been specified for it at all.

Furthermore, there are cases where an overlay is created by qemu which
already contains a BDS's filename (e.g. in blockdev-snapshot-sync).  We
do not need to worry about updating the overlay's bs->auto_backing_file
there, because we actually wrote a post-bdrv_refresh_filename() filename
into the image header.

So all in all, there will be false negatives where (as of a future
patch) bdrv_refresh_filename() will assume that the backing file differs
from what was specified in the image header, even though it really does
not.  However, these cases should be limited to where (1) the user
actually did override something in the backing chain (e.g. by specifying
options for the backing file), or (2) the user executed a QMP command to
change some node's backing file (e.g. change-backing-file or
block-commit with @backing-file given) where the given filename does not
happen to coincide with qemu's idea of the backing BDS's filename.

Then again, (1) really is limited to -drive.  With -blockdev or
blockdev-add, you have to adhere to the schema, so a user cannot give
partial "unimportant" options (e.g. by just setting backing.node-name
and leaving the rest to the image header).  Therefore, trying to fix
this would mean trying to fix something for -drive only.

To improve on (2), we would need a full infrastructure to "canonicalize"
an arbitrary filename (+ options), so it can be compared against
another.  That seems a bit over the top, considering that filenames
nowadays are there mostly for the user's entertainment.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block_int.h |  4 ++++
 block.c                   | 19 +++++++++++++++++++
 block/qcow.c              |  7 +++++--
 block/qcow2.c             | 10 +++++++---
 block/qed.c               |  7 +++++--
 block/vmdk.c              |  6 ++++--
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..93cd669a35 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -696,6 +696,10 @@ struct BlockDriverState {
     char filename[PATH_MAX];
     char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
                                     this file image */
+    /* The backing filename indicated by the image header; if we ever
+     * open this file, then this is replaced by the resulting BDS's
+     * filename (i.e. after a bdrv_refresh_filename() run). */
+    char auto_backing_file[PATH_MAX];
     char backing_format[16]; /* if non-zero and backing_file exists */
=20
     QDict *full_open_options;
diff --git a/block.c b/block.c
index 96fed5d7e6..c2fab44265 100644
--- a/block.c
+++ b/block.c
@@ -2336,6 +2336,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
     char *bdref_key_dot;
     const char *reference =3D NULL;
     int ret =3D 0;
+    bool implicit_backing =3D false;
     BlockDriverState *backing_hd;
     QDict *options;
     QDict *tmp_parent_options =3D NULL;
@@ -2371,6 +2372,16 @@ int bdrv_open_backing_file(BlockDriverState *bs, Q=
Dict *parent_options,
         qobject_unref(options);
         goto free_exit;
     } else {
+        if (qdict_size(options) =3D=3D 0) {
+            /* If the user specifies options that do not modify the
+             * backing file's behavior, we might still consider it the
+             * implicit backing file.  But it's easier this way, and
+             * just specifying some of the backing BDS's options is
+             * only possible with -drive anyway (otherwise the QAPI
+             * schema forces the user to specify everything). */
+            implicit_backing =3D !strcmp(bs->auto_backing_file, bs->back=
ing_file);
+        }
+
         bdrv_get_full_backing_filename(bs, backing_filename, PATH_MAX,
                                        &local_err);
         if (local_err) {
@@ -2404,6 +2415,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, Q=
Dict *parent_options,
     }
     bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
=20
+    if (implicit_backing) {
+        bdrv_refresh_filename(backing_hd);
+        pstrcpy(bs->auto_backing_file, sizeof(bs->auto_backing_file),
+                backing_hd->filename);
+    }
+
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
     bdrv_set_backing_hd(bs, backing_hd, &local_err);
@@ -3792,6 +3809,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
     if (ret =3D=3D 0) {
         pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_file=
 ?: "");
         pstrcpy(bs->backing_format, sizeof(bs->backing_format), backing_=
fmt ?: "");
+        pstrcpy(bs->auto_backing_file, sizeof(bs->auto_backing_file),
+                backing_file ?: "");
     }
     return ret;
 }
diff --git a/block/qcow.c b/block/qcow.c
index 0a235bf393..d47515d3df 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -31,6 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 #include <zlib.h>
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -295,11 +296,13 @@ static int qcow_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
             goto fail;
         }
         ret =3D bdrv_pread(bs->file, header.backing_file_offset,
-                   bs->backing_file, len);
+                   bs->auto_backing_file, len);
         if (ret < 0) {
             goto fail;
         }
-        bs->backing_file[len] =3D '\0';
+        bs->auto_backing_file[len] =3D '\0';
+        pstrcpy(bs->backing_file, sizeof(bs->backing_file),
+                bs->auto_backing_file);
     }
=20
     /* Disable migration when qcow images are used */
diff --git a/block/qcow2.c b/block/qcow2.c
index 8c91b92865..662737275a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1474,13 +1474,15 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
             goto fail;
         }
         ret =3D bdrv_pread(bs->file, header.backing_file_offset,
-                         bs->backing_file, len);
+                         bs->auto_backing_file, len);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not read backing file na=
me");
             goto fail;
         }
-        bs->backing_file[len] =3D '\0';
-        s->image_backing_file =3D g_strdup(bs->backing_file);
+        bs->auto_backing_file[len] =3D '\0';
+        pstrcpy(bs->backing_file, sizeof(bs->backing_file),
+                bs->auto_backing_file);
+        s->image_backing_file =3D g_strdup(bs->auto_backing_file);
     }
=20
     /* Internal snapshots */
@@ -2518,6 +2520,8 @@ static int qcow2_change_backing_file(BlockDriverSta=
te *bs,
         return -EINVAL;
     }
=20
+    pstrcpy(bs->auto_backing_file, sizeof(bs->auto_backing_file),
+            backing_file ?: "");
     pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_file ?: =
"");
     pstrcpy(bs->backing_format, sizeof(bs->backing_format), backing_fmt =
?: "");
=20
diff --git a/block/qed.c b/block/qed.c
index 1280870024..81a1bedd41 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -454,11 +454,14 @@ static int coroutine_fn bdrv_qed_do_open(BlockDrive=
rState *bs, QDict *options,
         }
=20
         ret =3D qed_read_string(bs->file, s->header.backing_filename_off=
set,
-                              s->header.backing_filename_size, bs->backi=
ng_file,
-                              sizeof(bs->backing_file));
+                              s->header.backing_filename_size,
+                              bs->auto_backing_file,
+                              sizeof(bs->auto_backing_file));
         if (ret < 0) {
             return ret;
         }
+        pstrcpy(bs->backing_file, sizeof(bs->backing_file),
+                bs->auto_backing_file);
=20
         if (s->header.features & QED_F_BACKING_FORMAT_NO_PROBE) {
             pstrcpy(bs->backing_format, sizeof(bs->backing_format), "raw=
");
diff --git a/block/vmdk.c b/block/vmdk.c
index db8bf996c4..d21f6a9f2c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -386,12 +386,14 @@ static int vmdk_parent_open(BlockDriverState *bs)
             ret =3D -EINVAL;
             goto out;
         }
-        if ((end_name - p_name) > sizeof(bs->backing_file) - 1) {
+        if ((end_name - p_name) > sizeof(bs->auto_backing_file) - 1) {
             ret =3D -EINVAL;
             goto out;
         }
=20
-        pstrcpy(bs->backing_file, end_name - p_name + 1, p_name);
+        pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name);
+        pstrcpy(bs->backing_file, sizeof(bs->backing_file),
+                bs->auto_backing_file);
     }
=20
 out:
--=20
2.20.1
