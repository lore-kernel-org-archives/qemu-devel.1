Received: from eggs.gnu.org ([209.51.188.92]:37732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Pp-0004iX-5y
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3PF-0006AQ-6p
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:53:30 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:04 +0100
Message-Id: <20190213225311.17876-6-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/12] block: Inline
 bdrv_co_block_status_from_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

With bdrv_filtered_rw_bs(), we can easily handle this default filter
behavior in bdrv_co_block_status().

blkdebug wants to have an additional assertion, so it keeps its own
implementation, except bdrv_co_block_status_from_file() needs to be
inlined there.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 22 -----------------
 block/blkdebug.c          |  7 ++++--
 block/blklogwrites.c      |  1 -
 block/commit.c            |  1 -
 block/copy-on-read.c      |  2 --
 block/io.c                | 51 +++++++++++++--------------------------
 block/mirror.c            |  1 -
 block/throttle.c          |  1 -
 8 files changed, 22 insertions(+), 64 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3e3b055c64..c81aa4132d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1164,28 +1164,6 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
=20
-/*
- * Default implementation for drivers to pass bdrv_co_block_status() to
- * their file.
- */
-int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
-                                                bool want_zero,
-                                                int64_t offset,
-                                                int64_t bytes,
-                                                int64_t *pnum,
-                                                int64_t *map,
-                                                BlockDriverState **file)=
;
-/*
- * Default implementation for drivers to pass bdrv_co_block_status() to
- * their backing file.
- */
-int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **fi=
le);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp)=
;
 bool blk_dev_has_removable_media(BlockBackend *blk);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 1ea835c2b9..f3095b95ba 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -637,8 +637,11 @@ static int coroutine_fn blkdebug_co_block_status(Blo=
ckDriverState *bs,
                                                  BlockDriverState **file=
)
 {
     assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
-    return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
-                                          pnum, map, file);
+    assert(bs->file && bs->file->bs);
+    *pnum =3D bytes;
+    *map =3D offset;
+    *file =3D bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }
=20
 static void blkdebug_close(BlockDriverState *bs)
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index eb2b4901a5..1eb4a5c613 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -518,7 +518,6 @@ static BlockDriver bdrv_blk_log_writes =3D {
     .bdrv_co_pwrite_zeroes  =3D blk_log_writes_co_pwrite_zeroes,
     .bdrv_co_flush_to_disk  =3D blk_log_writes_co_flush_to_disk,
     .bdrv_co_pdiscard       =3D blk_log_writes_co_pdiscard,
-    .bdrv_co_block_status   =3D bdrv_co_block_status_from_file,
=20
     .is_filter              =3D true,
     .strong_runtime_opts    =3D blk_log_writes_strong_runtime_opts,
diff --git a/block/commit.c b/block/commit.c
index 4482ea8486..3d3ead5af3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -251,7 +251,6 @@ static void bdrv_commit_top_child_perm(BlockDriverSta=
te *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top =3D {
     .format_name                =3D "commit_top",
     .bdrv_co_preadv             =3D bdrv_commit_top_preadv,
-    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_commit_top_child_perm,
=20
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 64dcc424b5..1b13ea9673 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -151,8 +151,6 @@ BlockDriver bdrv_copy_on_read =3D {
     .bdrv_eject                         =3D cor_eject,
     .bdrv_lock_medium                   =3D cor_lock_medium,
=20
-    .bdrv_co_block_status               =3D bdrv_co_block_status_from_fi=
le,
-
     .bdrv_recurse_is_first_non_filter   =3D cor_recurse_is_first_non_fil=
ter,
=20
     .has_variable_length                =3D true,
diff --git a/block/io.c b/block/io.c
index e3750cd566..a13af7ab4a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2029,36 +2029,6 @@ typedef struct BdrvCoBlockStatusData {
     bool done;
 } BdrvCoBlockStatusData;
=20
-int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
-                                                bool want_zero,
-                                                int64_t offset,
-                                                int64_t bytes,
-                                                int64_t *pnum,
-                                                int64_t *map,
-                                                BlockDriverState **file)
-{
-    assert(bs->file && bs->file->bs);
-    *pnum =3D bytes;
-    *map =3D offset;
-    *file =3D bs->file->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
-}
-
-int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **fi=
le)
-{
-    assert(bs->backing && bs->backing->bs);
-    *pnum =3D bytes;
-    *map =3D offset;
-    *file =3D bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
-}
-
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
@@ -2099,6 +2069,7 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
riverState *bs,
     BlockDriverState *local_file =3D NULL;
     int64_t aligned_offset, aligned_bytes;
     uint32_t align;
+    bool has_filtered_child;
=20
     assert(pnum);
     *pnum =3D 0;
@@ -2124,7 +2095,8 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
riverState *bs,
=20
     /* Must be non-NULL or bdrv_getlength() would have failed */
     assert(bs->drv);
-    if (!bs->drv->bdrv_co_block_status) {
+    has_filtered_child =3D bs->drv->is_filter && bdrv_filtered_rw_child(=
bs);
+    if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
         *pnum =3D bytes;
         ret =3D BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes =3D=3D total_size) {
@@ -2145,9 +2117,20 @@ static int coroutine_fn bdrv_co_block_status(Block=
DriverState *bs,
     aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
     aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offset;
=20
-    ret =3D bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
-                                        aligned_bytes, pnum, &local_map,
-                                        &local_file);
+    if (bs->drv->bdrv_co_block_status) {
+        ret =3D bs->drv->bdrv_co_block_status(bs, want_zero, aligned_off=
set,
+                                            aligned_bytes, pnum, &local_=
map,
+                                            &local_file);
+    } else {
+        /* Default code for filters */
+
+        local_file =3D bdrv_filtered_rw_bs(bs);
+        assert(local_file);
+
+        *pnum =3D aligned_bytes;
+        local_map =3D aligned_offset;
+        ret =3D BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
+    }
     if (ret < 0) {
         *pnum =3D 0;
         goto out;
diff --git a/block/mirror.c b/block/mirror.c
index 06b68f5cf2..c5609e3d68 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1467,7 +1467,6 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_pwrite_zeroes      =3D bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           =3D bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              =3D bdrv_mirror_top_flush,
-    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
=20
diff --git a/block/throttle.c b/block/throttle.c
index f64dcc27b9..b6922e734f 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -259,7 +259,6 @@ static BlockDriver bdrv_throttle =3D {
     .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
     .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
     .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
-    .bdrv_co_block_status               =3D   bdrv_co_block_status_from_=
file,
=20
     .bdrv_co_drain_begin                =3D   throttle_co_drain_begin,
     .bdrv_co_drain_end                  =3D   throttle_co_drain_end,
--=20
2.20.1
