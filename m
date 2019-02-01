Received: from eggs.gnu.org ([209.51.188.92]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVx-0005te-Tf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVs-0002VK-52
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:13 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:09 +0100
Message-Id: <20190201192935.18394-6-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 05/31] block: Respect backing bs in
 bdrv_refresh_filename
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

Basically, bdrv_refresh_filename() should respect all children of a
BlockDriverState. However, generally those children are driver-specific,
so this function cannot handle the general case. On the other hand,
there are only few drivers which use other children than @file and
@backing (that being vmdk, quorum, and blkverify).

Most block drivers only use @file and/or @backing (if they use any
children at all). Both can be implemented directly in
bdrv_refresh_filename.

The user overriding the file's filename is already handled, however, the
user overriding the backing file is not. If this is done, opening the
BDS with the plain filename of its file will not be correct, so we may
not set bs->exact_filename in that case.

iotest 051 contains test cases for overriding the backing file, and so
its output changes with this patch applied.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c                       | 38 ++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/051.out    |  8 ++++----
 tests/qemu-iotests/051.pc.out |  8 ++++----
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index c2fab44265..223b9b19cb 100644
--- a/block.c
+++ b/block.c
@@ -5479,6 +5479,21 @@ static bool append_open_options(QDict *d, BlockDri=
verState *bs)
     return found_any;
 }
=20
+/* Note: This function may return false positives; it may return true
+ * even if opening the backing file specified by bs's image header
+ * would result in exactly bs->backing. */
+static bool bdrv_backing_overridden(BlockDriverState *bs)
+{
+    if (bs->backing) {
+        return strcmp(bs->auto_backing_file,
+                      bs->backing->bs->filename);
+    } else {
+        /* No backing BDS, so if the image header reports any backing
+         * file, it must have been suppressed */
+        return bs->auto_backing_file[0] !=3D '\0';
+    }
+}
+
 /* Updates the following BDS fields:
  *  - exact_filename: A filename which may be used for opening a block d=
evice
  *                    which (mostly) equals the given BDS (even without =
any
@@ -5496,6 +5511,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BlockDriver *drv =3D bs->drv;
     BdrvChild *child;
     QDict *opts;
+    bool backing_overridden;
=20
     if (!drv) {
         return;
@@ -5521,6 +5537,16 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         return;
     }
=20
+    backing_overridden =3D bdrv_backing_overridden(bs);
+
+    if (bs->open_flags & BDRV_O_NO_IO) {
+        /* Without I/O, the backing file does not change anything.
+         * Therefore, in such a case (primarily qemu-img), we can
+         * pretend the backing file has not been overridden even if
+         * it technically has been. */
+        backing_overridden =3D false;
+    }
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file =
name
          * information before refreshing it */
@@ -5546,6 +5572,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
=20
         opts =3D qdict_new();
         has_open_options =3D append_open_options(opts, bs);
+        has_open_options |=3D backing_overridden;
=20
         /* If no specific options have been given for this BDS, the file=
name of
          * the underlying file should suffice for this one as well */
@@ -5557,11 +5584,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * file BDS. The full options QDict of that file BDS should some=
how
          * contain a representation of the filename, therefore the follo=
wing
          * suffices without querying the (exact_)filename of this BDS. *=
/
-        if (bs->file->bs->full_open_options) {
+        if (bs->file->bs->full_open_options &&
+            (!bs->backing || bs->backing->bs->full_open_options))
+        {
             qdict_put_str(opts, "driver", drv->format_name);
             qdict_put(opts, "file",
                       qobject_ref(bs->file->bs->full_open_options));
=20
+            if (bs->backing) {
+                qdict_put(opts, "backing",
+                          qobject_ref(bs->backing->bs->full_open_options=
));
+            } else if (backing_overridden) {
+                qdict_put_null(opts, "backing");
+            }
+
             bs->full_open_options =3D opts;
         } else {
             qobject_unref(opts);
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 793af2ab96..b900935fbc 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -82,7 +82,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,backing.file.file=
name=3DTEST_DIR/t.qcow2.orig,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -172,7 +172,7 @@ QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_va=
lue: invalid cache option
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwriteback,backing.file.f=
ilename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-=
name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfil=
e,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -192,7 +192,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwritethrough,backing.fil=
e.filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.no=
de-name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3D=
file,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -212,7 +212,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dunsafe,backing.file.file=
name=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-nam=
e=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,i=
f=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.ou=
t
index ca64edae6a..8c5c735dfd 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -82,7 +82,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,backing.file.file=
name=3DTEST_DIR/t.qcow2.orig,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -244,7 +244,7 @@ QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_va=
lue: invalid cache option
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwriteback,backing.file.f=
ilename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-=
name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfil=
e,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -264,7 +264,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwritethrough,backing.fil=
e.filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.no=
de-name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3D=
file,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -284,7 +284,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dunsafe,backing.file.file=
name=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-nam=
e=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,i=
f=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "fi=
le": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
--=20
2.20.1
