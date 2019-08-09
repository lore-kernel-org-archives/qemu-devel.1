Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B7C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9511520C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9511520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7jU-0004Tw-Tt
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7YN-0003zm-UG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7YM-0004ho-0o
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7YC-0004e3-2j; Fri, 09 Aug 2019 12:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6694C99BAC;
 Fri,  9 Aug 2019 16:15:31 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C64D65D6A9;
 Fri,  9 Aug 2019 16:15:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:59 +0200
Message-Id: <20190809161407.11920-35-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 09 Aug 2019 16:15:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 34/42] block: Inline
 bdrv_co_block_status_from_*()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With bdrv_filtered_rw_bs(), we can easily handle this default filter
behavior in bdrv_co_block_status().

blkdebug wants to have an additional assertion, so it keeps its own
implementation, except bdrv_co_block_status_from_file() needs to be
inlined there.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
index c17df3808a..42ee2fcf7f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1227,28 +1227,6 @@ void bdrv_format_default_perms(BlockDriverState *b=
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
index 5ae96c52b0..0011e068ce 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -679,8 +679,11 @@ static int coroutine_fn blkdebug_co_block_status(Blo=
ckDriverState *bs,
         return err;
     }
=20
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
index 04d8b33607..8982fd15c4 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -519,7 +519,6 @@ static BlockDriver bdrv_blk_log_writes =3D {
     .bdrv_co_pwrite_zeroes  =3D blk_log_writes_co_pwrite_zeroes,
     .bdrv_co_flush_to_disk  =3D blk_log_writes_co_flush_to_disk,
     .bdrv_co_pdiscard       =3D blk_log_writes_co_pdiscard,
-    .bdrv_co_block_status   =3D bdrv_co_block_status_from_file,
=20
     .is_filter              =3D true,
     .strong_runtime_opts    =3D blk_log_writes_strong_runtime_opts,
diff --git a/block/commit.c b/block/commit.c
index 40d1c8eeac..c94678bea3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -252,7 +252,6 @@ static void bdrv_commit_top_child_perm(BlockDriverSta=
te *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top =3D {
     .format_name                =3D "commit_top",
     .bdrv_co_preadv             =3D bdrv_commit_top_preadv,
-    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_commit_top_child_perm,
=20
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 16bdf630b6..ad6577d078 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -160,8 +160,6 @@ static BlockDriver bdrv_copy_on_read =3D {
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
index e222d91893..d7d9757f46 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2028,36 +2028,6 @@ typedef struct BdrvCoBlockStatusData {
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
@@ -2098,6 +2068,7 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
riverState *bs,
     BlockDriverState *local_file =3D NULL;
     int64_t aligned_offset, aligned_bytes;
     uint32_t align;
+    bool has_filtered_child;
=20
     assert(pnum);
     *pnum =3D 0;
@@ -2123,7 +2094,8 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
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
@@ -2144,9 +2116,20 @@ static int coroutine_fn bdrv_co_block_status(Block=
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
index 6ddbfb9708..88155faaec 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1508,7 +1508,6 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_pwrite_zeroes      =3D bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           =3D bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              =3D bdrv_mirror_top_flush,
-    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
     .bdrv_refresh_limits        =3D bdrv_mirror_top_refresh_limits,
diff --git a/block/throttle.c b/block/throttle.c
index 958a2bcfa6..d0436f875b 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -270,7 +270,6 @@ static BlockDriver bdrv_throttle =3D {
     .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
     .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
     .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
-    .bdrv_co_block_status               =3D   bdrv_co_block_status_from_=
file,
=20
     .bdrv_co_drain_begin                =3D   throttle_co_drain_begin,
     .bdrv_co_drain_end                  =3D   throttle_co_drain_end,
--=20
2.21.0


