Received: from eggs.gnu.org ([209.51.188.92]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZv-0005m1-Db
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZt-0001hK-Fe
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 16:37:57 +0100
Message-Id: <20190308153757.25794-9-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/8] file-posix: Make auto-read-only dynamic
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

Until now, with auto-read-only=3Don we tried to open the file read-write
first and if that failed, read-only was tried. This is actually not good
enough for libvirt, which gives QEMU SELinux permissions for read-write
only as soon as it actually intends to write to the image. So we need to
be able to switch between read-only and read-write at runtime.

This patch makes auto-read-only dynamic, i.e. the file is opened
read-only as long as no user of the node has requested write
permissions, but it is automatically reopened read-write as soon as the
first writer is attached. Conversely, if the last writer goes away, the
file is reopened read-only again.

bs->read_only is no longer set for auto-read-only=3Don files even if the
file descriptor is opened read-only because it will be transparently
upgraded as soon as a writer is attached. This changes the output of
qemu-iotests 232.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c         | 36 +++++++++++++++++-------------------
 tests/qemu-iotests/232.out | 12 ++++++------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index bcfb38ec4b..6718bc2e9c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -376,13 +376,21 @@ static void raw_probe_alignment(BlockDriverState *b=
s, int fd, Error **errp)
     }
 }
=20
-static void raw_parse_flags(int bdrv_flags, int *open_flags)
+static void raw_parse_flags(int bdrv_flags, int *open_flags, bool has_wr=
iters)
 {
+    bool read_write =3D false;
     assert(open_flags !=3D NULL);
=20
     *open_flags |=3D O_BINARY;
     *open_flags &=3D ~O_ACCMODE;
-    if (bdrv_flags & BDRV_O_RDWR) {
+
+    if (bdrv_flags & BDRV_O_AUTO_RDONLY) {
+        read_write =3D has_writers;
+    } else if (bdrv_flags & BDRV_O_RDWR) {
+        read_write =3D true;
+    }
+
+    if (read_write) {
         *open_flags |=3D O_RDWR;
     } else {
         *open_flags |=3D O_RDONLY;
@@ -518,24 +526,12 @@ static int raw_open_common(BlockDriverState *bs, QD=
ict *options,
                                                false);
=20
     s->open_flags =3D open_flags;
-    raw_parse_flags(bdrv_flags, &s->open_flags);
+    raw_parse_flags(bdrv_flags, &s->open_flags, false);
=20
     s->fd =3D -1;
     fd =3D qemu_open(filename, s->open_flags, 0644);
     ret =3D fd < 0 ? -errno : 0;
=20
-    if (ret =3D=3D -EACCES || ret =3D=3D -EROFS) {
-        /* Try to degrade to read-only, but if it doesn't work, still us=
e the
-         * normal error message. */
-        if (bdrv_apply_auto_read_only(bs, NULL, NULL) =3D=3D 0) {
-            bdrv_flags &=3D ~BDRV_O_RDWR;
-            raw_parse_flags(bdrv_flags, &s->open_flags);
-            assert(!(s->open_flags & O_CREAT));
-            fd =3D qemu_open(filename, s->open_flags);
-            ret =3D fd < 0 ? -errno : 0;
-        }
-    }
-
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not open '%s'", filename);
         if (ret =3D=3D -EROFS) {
@@ -846,12 +842,14 @@ static int raw_handle_perm_lock(BlockDriverState *b=
s,
 }
=20
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
-                                 int *open_flags, bool force_dup,
+                                 int *open_flags, uint64_t perm, bool fo=
rce_dup,
                                  Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
     int fd =3D -1;
     int ret;
+    bool has_writers =3D perm &
+        (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED | BLK_PERM_RESIZE);
     int fcntl_flags =3D O_APPEND | O_NONBLOCK;
 #ifdef O_NOATIME
     fcntl_flags |=3D O_NOATIME;
@@ -862,7 +860,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs=
, int flags,
         *open_flags |=3D O_NONBLOCK;
     }
=20
-    raw_parse_flags(flags, open_flags);
+    raw_parse_flags(flags, open_flags, has_writers);
=20
 #ifdef O_ASYNC
     /* Not all operating systems have O_ASYNC, and those that don't
@@ -942,7 +940,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     qemu_opts_to_qdict(opts, state->options);
=20
     rs->fd =3D raw_reconfigure_getfd(state->bs, state->flags, &rs->open_=
flags,
-                                   true, &local_err);
+                                   state->perm, true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -1;
@@ -2715,7 +2713,7 @@ static int raw_check_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared,
     } else {
         /* We may need a new fd if auto-read-only switches the mode */
         assert(!s->perm_change_fd);
-        ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags,
+        ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags, p=
erm,
                                     false, errp);
         if (ret < 0) {
             return ret;
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
index dcb683afa3..3bd1a920af 100644
--- a/tests/qemu-iotests/232.out
+++ b/tests/qemu-iotests/232.out
@@ -22,12 +22,12 @@ NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
=20
 QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,read-=
only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Perm=
ission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
=20
 QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,auto-=
read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
=20
 =3D=3D=3D -blockdev with read-write image: read-only/auto-read-only comb=
inations =3D=3D=3D
=20
@@ -50,10 +50,10 @@ node0: TEST_DIR/t.IMGFMT (file, read-only)
 node0: TEST_DIR/t.IMGFMT (file, read-only)
=20
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,read-only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/=
t.IMGFMT': Permission denied
-node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file)
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission=
 denied
=20
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permi=
ssion denied
-node0: TEST_DIR/t.IMGFMT (file, read-only)
+node0: TEST_DIR/t.IMGFMT (file)
 QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-nam=
e=3Dnode0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
 *** done
--=20
2.20.1
