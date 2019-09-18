Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F46C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B42B21906
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B42B21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWfJ-0003Bz-Nv
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAWdG-0001I6-V5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAWdD-0005jd-J6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAWd4-0005by-MC; Wed, 18 Sep 2019 05:52:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C3A310F2E86;
 Wed, 18 Sep 2019 09:52:05 +0000 (UTC)
Received: from localhost (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 259D35D6A5;
 Wed, 18 Sep 2019 09:52:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 11:51:40 +0200
Message-Id: <20190918095144.955-5-mreitz@redhat.com>
In-Reply-To: <20190918095144.955-1-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 18 Sep 2019 09:52:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/8] block: Add @exact parameter to
 bdrv_co_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have two drivers (iscsi and file-posix) that (in some cases) return
success from their .bdrv_co_truncate() implementation if the block
device is larger than the requested offset, but cannot be shrunk.  Some
callers do not want that behavior, so this patch adds a new parameter
that they can use to turn off that behavior.

This patch just adds the parameter and lets the block/io.c and
block/block-backend.c functions pass it around.  All other callers
always pass false and none of the implementations evaluate it, so that
this patch does not change existing behavior.  Future patches take care
of that.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h          |  6 +++---
 include/block/block_int.h      | 17 ++++++++++++++++-
 include/sysemu/block-backend.h |  4 ++--
 block/block-backend.c          |  6 +++---
 block/commit.c                 |  5 +++--
 block/crypto.c                 |  8 ++++----
 block/file-posix.c             |  3 ++-
 block/file-win32.c             |  3 ++-
 block/gluster.c                |  1 +
 block/io.c                     | 20 +++++++++++++-------
 block/iscsi.c                  |  3 ++-
 block/mirror.c                 |  4 ++--
 block/nfs.c                    |  2 +-
 block/parallels.c              |  6 +++---
 block/qcow.c                   |  4 ++--
 block/qcow2-refcount.c         |  2 +-
 block/qcow2.c                  | 22 ++++++++++++----------
 block/qed.c                    |  3 ++-
 block/raw-format.c             |  5 +++--
 block/rbd.c                    |  1 +
 block/sheepdog.c               |  5 +++--
 block/ssh.c                    |  3 ++-
 block/vdi.c                    |  2 +-
 block/vhdx-log.c               |  4 ++--
 block/vhdx.c                   |  7 ++++---
 block/vmdk.c                   |  8 ++++----
 block/vpc.c                    |  2 +-
 blockdev.c                     |  2 +-
 qemu-img.c                     |  2 +-
 qemu-io-cmds.c                 |  2 +-
 tests/test-block-iothread.c    |  8 ++++----
 31 files changed, 102 insertions(+), 68 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 37c9de7446..2f905ae4b7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -346,10 +346,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
=20
-int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
+int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool=
 exact,
                                   PreallocMode prealloc, Error **errp);
-int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode preallo=
c,
-                  Error **errp);
+int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
+                  PreallocMode prealloc, Error **errp);
=20
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..197cc6e7c3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -334,8 +334,23 @@ struct BlockDriver {
      * bdrv_parse_filename.
      */
     const char *protocol_name;
+
+    /*
+     * Truncate @bs to @offset bytes using the given @prealloc mode
+     * when growing.  Modes other than PREALLOC_MODE_OFF should be
+     * rejected when shrinking @bs.
+     *
+     * If @exact is true, @bs must be resized to exactly @offset.
+     * Otherwise, it is sufficient for @bs (if it is a host block
+     * device and thus there is no way to resize it) to be at least
+     * @offset bytes in length.
+     *
+     * If @exact is true and this function fails but would succeed
+     * with @exact =3D false, it should return -ENOTSUP.
+     */
     int coroutine_fn (*bdrv_co_truncate)(BlockDriverState *bs, int64_t o=
ffset,
-                                         PreallocMode prealloc, Error **=
errp);
+                                         bool exact, PreallocMode preall=
oc,
+                                         Error **errp);
=20
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 368d53af77..841804c3cb 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -233,8 +233,8 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *b=
lk, int64_t offset,
                                       int bytes, BdrvRequestFlags flags)=
;
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void =
*buf,
                           int bytes);
-int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode preallo=
c,
-                 Error **errp);
+int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
+                 PreallocMode prealloc, Error **errp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block/block-backend.c b/block/block-backend.c
index 1c605d5444..e6d8240f40 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2060,15 +2060,15 @@ int blk_pwrite_compressed(BlockBackend *blk, int6=
4_t offset, const void *buf,
                    BDRV_REQ_WRITE_COMPRESSED);
 }
=20
-int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode preallo=
c,
-                 Error **errp)
+int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
+                 PreallocMode prealloc, Error **errp)
 {
     if (!blk_is_available(blk)) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
=20
-    return bdrv_truncate(blk->root, offset, prealloc, errp);
+    return bdrv_truncate(blk->root, offset, exact, prealloc, errp);
 }
=20
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/commit.c b/block/commit.c
index bc8454463d..23c90b3b91 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -155,7 +155,7 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
     }
=20
     if (base_len < len) {
-        ret =3D blk_truncate(s->base, len, PREALLOC_MODE_OFF, NULL);
+        ret =3D blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, NUL=
L);
         if (ret) {
             goto out;
         }
@@ -471,7 +471,8 @@ int bdrv_commit(BlockDriverState *bs)
      * grow the backing file image if possible.  If not possible,
      * we must return an error */
     if (length > backing_length) {
-        ret =3D blk_truncate(backing, length, PREALLOC_MODE_OFF, &local_=
err);
+        ret =3D blk_truncate(backing, length, false, PREALLOC_MODE_OFF,
+                           &local_err);
         if (ret < 0) {
             error_report_err(local_err);
             goto ro_cleanup;
diff --git a/block/crypto.c b/block/crypto.c
index 7eb698774e..e5a1a2cdf3 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -113,8 +113,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock *b=
lock,
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, data->preallo=
c,
-                        errp);
+    return blk_truncate(data->blk, data->size + headerlen, false,
+                        data->prealloc, errp);
 }
=20
=20
@@ -297,7 +297,7 @@ static int block_crypto_co_create_generic(BlockDriver=
State *bs,
 }
=20
 static int coroutine_fn
-block_crypto_co_truncate(BlockDriverState *bs, int64_t offset,
+block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exac=
t,
                          PreallocMode prealloc, Error **errp)
 {
     BlockCrypto *crypto =3D bs->opaque;
@@ -311,7 +311,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_=
t offset,
=20
     offset +=3D payload_offset;
=20
-    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
 }
=20
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/file-posix.c b/block/file-posix.c
index f12c06de2d..d8755c5fac 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2014,7 +2014,8 @@ raw_regular_truncate(BlockDriverState *bs, int fd, =
int64_t offset,
 }
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t of=
fset,
-                                        PreallocMode prealloc, Error **e=
rrp)
+                                        bool exact, PreallocMode preallo=
c,
+                                        Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
     struct stat st;
diff --git a/block/file-win32.c b/block/file-win32.c
index 41f55dfece..77e8ff7b68 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -468,7 +468,8 @@ static void raw_close(BlockDriverState *bs)
 }
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t of=
fset,
-                                        PreallocMode prealloc, Error **e=
rrp)
+                                        bool exact, PreallocMode preallo=
c,
+                                        Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
     LONG low, high;
diff --git a/block/gluster.c b/block/gluster.c
index 64028b2cba..4fa4a77a47 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1225,6 +1225,7 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDri=
verState *bs,
=20
 static coroutine_fn int qemu_gluster_co_truncate(BlockDriverState *bs,
                                                  int64_t offset,
+                                                 bool exact,
                                                  PreallocMode prealloc,
                                                  Error **errp)
 {
diff --git a/block/io.c b/block/io.c
index 723655c792..5b02642b98 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3243,8 +3243,12 @@ static void bdrv_parent_cb_resize(BlockDriverState=
 *bs)
=20
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
+ *
+ * If 'exact' is true, the file must be resized to exactly the given
+ * 'offset'.  Otherwise, it is sufficient for the node to be at least
+ * 'offset' bytes in length.
  */
-int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
+int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool=
 exact,
                                   PreallocMode prealloc, Error **errp)
 {
     BlockDriverState *bs =3D child->bs;
@@ -3300,9 +3304,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset,
     }
=20
     if (drv->bdrv_co_truncate) {
-        ret =3D drv->bdrv_co_truncate(bs, offset, prealloc, errp);
+        ret =3D drv->bdrv_co_truncate(bs, offset, exact, prealloc, errp)=
;
     } else if (bs->file && drv->is_filter) {
-        ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
+        ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, errp=
);
     } else {
         error_setg(errp, "Image format driver does not support resize");
         ret =3D -ENOTSUP;
@@ -3333,6 +3337,7 @@ out:
 typedef struct TruncateCo {
     BdrvChild *child;
     int64_t offset;
+    bool exact;
     PreallocMode prealloc;
     Error **errp;
     int ret;
@@ -3341,18 +3346,19 @@ typedef struct TruncateCo {
 static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
 {
     TruncateCo *tco =3D opaque;
-    tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->prealloc=
,
-                                tco->errp);
+    tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->exact,
+                                tco->prealloc, tco->errp);
     aio_wait_kick();
 }
=20
-int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode preallo=
c,
-                  Error **errp)
+int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
+                  PreallocMode prealloc, Error **errp)
 {
     Coroutine *co;
     TruncateCo tco =3D {
         .child      =3D child,
         .offset     =3D offset,
+        .exact      =3D exact,
         .prealloc   =3D prealloc,
         .errp       =3D errp,
         .ret        =3D NOT_DONE,
diff --git a/block/iscsi.c b/block/iscsi.c
index 506bf5f875..a90426270a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2122,7 +2122,8 @@ static void iscsi_reopen_commit(BDRVReopenState *re=
open_state)
 }
=20
 static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t =
offset,
-                                          PreallocMode prealloc, Error *=
*errp)
+                                          bool exact, PreallocMode preal=
loc,
+                                          Error **errp)
 {
     IscsiLun *iscsilun =3D bs->opaque;
     Error *local_err =3D NULL;
diff --git a/block/mirror.c b/block/mirror.c
index fe984efb90..2cfd035571 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -873,8 +873,8 @@ static int coroutine_fn mirror_run(Job *job, Error **=
errp)
         }
=20
         if (s->bdev_length > base_length) {
-            ret =3D blk_truncate(s->target, s->bdev_length, PREALLOC_MOD=
E_OFF,
-                               NULL);
+            ret =3D blk_truncate(s->target, s->bdev_length, false,
+                               PREALLOC_MODE_OFF, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/nfs.c b/block/nfs.c
index f39acfdb28..ba8b41775a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -750,7 +750,7 @@ static int64_t nfs_get_allocated_file_size(BlockDrive=
rState *bs)
 }
=20
 static int coroutine_fn
-nfs_file_co_truncate(BlockDriverState *bs, int64_t offset,
+nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
                      PreallocMode prealloc, Error **errp)
 {
     NFSClient *client =3D bs->opaque;
diff --git a/block/parallels.c b/block/parallels.c
index 905cac35c6..a1a92c97a4 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -203,7 +203,7 @@ static int64_t allocate_clusters(BlockDriverState *bs=
, int64_t sector_num,
         } else {
             ret =3D bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BIT=
S,
-                                PREALLOC_MODE_OFF, NULL);
+                                false, PREALLOC_MODE_OFF, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -487,7 +487,7 @@ static int coroutine_fn parallels_co_check(BlockDrive=
rState *bs,
         res->leaks +=3D count;
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err =3D NULL;
-            ret =3D bdrv_truncate(bs->file, res->image_end_offset,
+            ret =3D bdrv_truncate(bs->file, res->image_end_offset, false=
,
                                 PREALLOC_MODE_OFF, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
@@ -880,7 +880,7 @@ static void parallels_close(BlockDriverState *bs)
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INAC=
TIVE)) {
         s->header->inuse =3D 0;
         parallels_update_header(bs);
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, false,
                       PREALLOC_MODE_OFF, NULL);
     }
=20
diff --git a/block/qcow.c b/block/qcow.c
index 17705015ca..fce8989868 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -480,7 +480,7 @@ static int get_cluster_offset(BlockDriverState *bs,
                     return -E2BIG;
                 }
                 ret =3D bdrv_truncate(bs->file, cluster_offset + s->clus=
ter_size,
-                                    PREALLOC_MODE_OFF, NULL);
+                                    false, PREALLOC_MODE_OFF, NULL);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1033,7 +1033,7 @@ static int qcow_make_empty(BlockDriverState *bs)
     if (bdrv_pwrite_sync(bs->file, s->l1_table_offset, s->l1_table,
             l1_length) < 0)
         return -1;
-    ret =3D bdrv_truncate(bs->file, s->l1_table_offset + l1_length,
+    ret =3D bdrv_truncate(bs->file, s->l1_table_offset + l1_length, fals=
e,
                         PREALLOC_MODE_OFF, NULL);
     if (ret < 0)
         return ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index ef965d7895..7b70d8683a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2016,7 +2016,7 @@ static int check_refblocks(BlockDriverState *bs, Bd=
rvCheckResult *res,
                     goto resize_fail;
                 }
=20
-                ret =3D bdrv_truncate(bs->file, offset + s->cluster_size=
,
+                ret =3D bdrv_truncate(bs->file, offset + s->cluster_size=
, false,
                                     PREALLOC_MODE_OFF, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
diff --git a/block/qcow2.c b/block/qcow2.c
index 4978ccc7be..157b9b75d9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2869,8 +2869,8 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
         if (mode =3D=3D PREALLOC_MODE_METADATA) {
             mode =3D PREALLOC_MODE_OFF;
         }
-        ret =3D bdrv_co_truncate(s->data_file, host_offset + cur_bytes, =
mode,
-                               errp);
+        ret =3D bdrv_co_truncate(s->data_file, host_offset + cur_bytes, =
false,
+                               mode, errp);
         if (ret < 0) {
             return ret;
         }
@@ -3284,7 +3284,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
     }
=20
     /* Okay, now that we have a valid image, let's give it the right siz=
e */
-    ret =3D blk_truncate(blk, qcow2_opts->size, qcow2_opts->preallocatio=
n, errp);
+    ret =3D blk_truncate(blk, qcow2_opts->size, false, qcow2_opts->preal=
location,
+                       errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
@@ -3732,7 +3733,8 @@ fail:
 }
=20
 static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t =
offset,
-                                          PreallocMode prealloc, Error *=
*errp)
+                                          bool exact, PreallocMode preal=
loc,
+                                          Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t old_length;
@@ -3821,7 +3823,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
             Error *local_err =3D NULL;
=20
             bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_s=
ize,
-                             PREALLOC_MODE_OFF, &local_err);
+                             false, PREALLOC_MODE_OFF, &local_err);
             if (local_err) {
                 warn_reportf_err(local_err,
                                  "Failed to truncate the tail of the ima=
ge: ");
@@ -3838,7 +3840,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
         if (has_data_file(bs)) {
-            ret =3D bdrv_co_truncate(s->data_file, offset, prealloc, err=
p);
+            ret =3D bdrv_co_truncate(s->data_file, offset, false, preall=
oc, errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -3923,7 +3925,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
         /* Allocate the data area */
         new_file_size =3D allocation_start +
                         nb_new_data_clusters * s->cluster_size;
-        ret =3D bdrv_co_truncate(bs->file, new_file_size, prealloc, errp=
);
+        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, preallo=
c, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
             qcow2_free_clusters(bs, allocation_start,
@@ -4026,7 +4028,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *=
bs,
         if (len < 0) {
             return len;
         }
-        return bdrv_co_truncate(bs->file, len, PREALLOC_MODE_OFF, NULL);
+        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF,=
 NULL);
     }
=20
     if (offset_into_cluster(s, offset)) {
@@ -4263,7 +4265,7 @@ static int make_completely_empty(BlockDriverState *=
bs)
         goto fail;
     }
=20
-    ret =3D bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
+    ret =3D bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,=
 false,
                         PREALLOC_MODE_OFF, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -5042,7 +5044,7 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
             return ret;
         }
=20
-        ret =3D blk_truncate(blk, new_size, PREALLOC_MODE_OFF, errp);
+        ret =3D blk_truncate(blk, new_size, false, PREALLOC_MODE_OFF, er=
rp);
         blk_unref(blk);
         if (ret < 0) {
             return ret;
diff --git a/block/qed.c b/block/qed.c
index 0d8fd507aa..7c2a65af40 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -674,7 +674,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
     l1_size =3D header.cluster_size * header.table_size;
=20
     /* File must start empty and grow, check truncate is supported */
-    ret =3D blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, 0, false, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
@@ -1461,6 +1461,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(B=
lockDriverState *bs,
=20
 static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
+                                             bool exact,
                                              PreallocMode prealloc,
                                              Error **errp)
 {
diff --git a/block/raw-format.c b/block/raw-format.c
index 42c28cc29a..57d84d0bae 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -370,7 +370,8 @@ static void raw_refresh_limits(BlockDriverState *bs, =
Error **errp)
 }
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t of=
fset,
-                                        PreallocMode prealloc, Error **e=
rrp)
+                                        bool exact, PreallocMode preallo=
c,
+                                        Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
=20
@@ -386,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverSt=
ate *bs, int64_t offset,
=20
     s->size =3D offset;
     offset +=3D s->offset;
-    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, false, prealloc, errp);
 }
=20
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
diff --git a/block/rbd.c b/block/rbd.c
index 057af43d48..cdccf01d68 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1086,6 +1086,7 @@ static int64_t qemu_rbd_getlength(BlockDriverState =
*bs)
=20
 static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
+                                             bool exact,
                                              PreallocMode prealloc,
                                              Error **errp)
 {
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 773dfc6ab1..cfa84338a2 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2285,7 +2285,8 @@ static int64_t sd_getlength(BlockDriverState *bs)
 }
=20
 static int coroutine_fn sd_co_truncate(BlockDriverState *bs, int64_t off=
set,
-                                       PreallocMode prealloc, Error **er=
rp)
+                                       bool exact, PreallocMode prealloc=
,
+                                       Error **errp)
 {
     BDRVSheepdogState *s =3D bs->opaque;
     int ret, fd;
@@ -2601,7 +2602,7 @@ static coroutine_fn int sd_co_writev(BlockDriverSta=
te *bs, int64_t sector_num,
=20
     assert(!flags);
     if (offset > s->inode.vdi_size) {
-        ret =3D sd_co_truncate(bs, offset, PREALLOC_MODE_OFF, NULL);
+        ret =3D sd_co_truncate(bs, offset, false, PREALLOC_MODE_OFF, NUL=
L);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/ssh.c b/block/ssh.c
index 84d01e892b..b4375cf7d2 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1295,7 +1295,8 @@ static int64_t ssh_getlength(BlockDriverState *bs)
 }
=20
 static int coroutine_fn ssh_co_truncate(BlockDriverState *bs, int64_t of=
fset,
-                                        PreallocMode prealloc, Error **e=
rrp)
+                                        bool exact, PreallocMode preallo=
c,
+                                        Error **errp)
 {
     BDRVSSHState *s =3D bs->opaque;
=20
diff --git a/block/vdi.c b/block/vdi.c
index 806ba7f53c..0142da7233 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -874,7 +874,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCrea=
teOptions *create_options,
     }
=20
     if (image_type =3D=3D VDI_TYPE_STATIC) {
-        ret =3D blk_truncate(blk, offset + blocks * block_size,
+        ret =3D blk_truncate(blk, offset + blocks * block_size, false,
                            PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to statically allocate file");
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index fdd3a7adc3..13a49c2a33 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -557,8 +557,8 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVV=
HDXState *s,
                     ret =3D -EINVAL;
                     goto exit;
                 }
-                ret =3D bdrv_truncate(bs->file, new_file_size, PREALLOC_=
MODE_OFF,
-                                    NULL);
+                ret =3D bdrv_truncate(bs->file, new_file_size, false,
+                                    PREALLOC_MODE_OFF, NULL);
                 if (ret < 0) {
                     goto exit;
                 }
diff --git a/block/vhdx.c b/block/vhdx.c
index 6a09d0a55c..8ae14d97f9 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1180,7 +1180,7 @@ static int vhdx_allocate_block(BlockDriverState *bs=
, BDRVVHDXState *s,
         return -EINVAL;
     }
=20
-    return bdrv_truncate(bs->file, *new_offset + s->block_size,
+    return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
                          PREALLOC_MODE_OFF, NULL);
 }
=20
@@ -1619,12 +1619,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDR=
VVHDXState *s,
     if (type =3D=3D VHDX_TYPE_DYNAMIC) {
         /* All zeroes, so we can just extend the file - the end of the B=
AT
          * is the furthest thing we have written yet */
-        ret =3D blk_truncate(blk, data_file_offset, PREALLOC_MODE_OFF, e=
rrp);
+        ret =3D blk_truncate(blk, data_file_offset, false, PREALLOC_MODE=
_OFF,
+                           errp);
         if (ret < 0) {
             goto exit;
         }
     } else if (type =3D=3D VHDX_TYPE_FIXED) {
-        ret =3D blk_truncate(blk, data_file_offset + image_size,
+        ret =3D blk_truncate(blk, data_file_offset + image_size, false,
                            PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
             goto exit;
diff --git a/block/vmdk.c b/block/vmdk.c
index fed3b50c8a..20e909d997 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2076,7 +2076,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
                 return length;
             }
             length =3D QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
-            ret =3D bdrv_truncate(s->extents[i].file, length,
+            ret =3D bdrv_truncate(s->extents[i].file, length, false,
                                 PREALLOC_MODE_OFF, NULL);
             if (ret < 0) {
                 return ret;
@@ -2118,7 +2118,7 @@ static int vmdk_init_extent(BlockBackend *blk,
     int gd_buf_size;
=20
     if (flat) {
-        ret =3D blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
+        ret =3D blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, er=
rp);
         goto exit;
     }
     magic =3D cpu_to_be32(VMDK4_MAGIC);
@@ -2181,7 +2181,7 @@ static int vmdk_init_extent(BlockBackend *blk,
         goto exit;
     }
=20
-    ret =3D blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9,
+    ret =3D blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, fal=
se,
                        PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto exit;
@@ -2523,7 +2523,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t s=
ize,
     /* bdrv_pwrite write padding zeros to align to sector, we don't need=
 that
      * for description file */
     if (desc_offset =3D=3D 0) {
-        ret =3D blk_truncate(blk, desc_len, PREALLOC_MODE_OFF, errp);
+        ret =3D blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, er=
rp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vpc.c b/block/vpc.c
index 5cd3890780..a65550298e 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -898,7 +898,7 @@ static int create_fixed_disk(BlockBackend *blk, uint8=
_t *buf,
     /* Add footer to total size */
     total_size +=3D HEADER_SIZE;
=20
-    ret =3D blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, errp=
);
     if (ret < 0) {
         return ret;
     }
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..6b04eca2a4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3225,7 +3225,7 @@ void qmp_block_resize(bool has_device, const char *=
device,
     }
=20
     bdrv_drained_begin(bs);
-    ret =3D blk_truncate(blk, size, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
     bdrv_drained_end(bs);
=20
 out:
diff --git a/qemu-img.c b/qemu-img.c
index 384c6f38bc..f8694f4f72 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3823,7 +3823,7 @@ static int img_resize(int argc, char **argv)
         }
     }
=20
-    ret =3D blk_truncate(blk, total_size, prealloc, &err);
+    ret =3D blk_truncate(blk, total_size, false, prealloc, &err);
     if (ret < 0) {
         error_report_err(err);
         goto out;
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 349256a5fe..5e9017c979 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1710,7 +1710,7 @@ static int truncate_f(BlockBackend *blk, int argc, =
char **argv)
         return offset;
     }
=20
-    ret =3D blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
+    ret =3D blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, &local_e=
rr);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index cfe30bab21..0c861809f0 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -45,7 +45,7 @@ static int coroutine_fn bdrv_test_co_pdiscard(BlockDriv=
erState *bs,
 }
=20
 static int coroutine_fn
-bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset,
+bdrv_test_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
                       PreallocMode prealloc, Error **errp)
 {
     return 0;
@@ -185,18 +185,18 @@ static void test_sync_op_truncate(BdrvChild *c)
     int ret;
=20
     /* Normal success path */
-    ret =3D bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
     g_assert_cmpint(ret, =3D=3D, 0);
=20
     /* Early error: Negative offset */
-    ret =3D bdrv_truncate(c, -2, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, NULL);
     g_assert_cmpint(ret, =3D=3D, -EINVAL);
=20
     /* Error: Read-only image */
     c->bs->read_only =3D true;
     c->bs->open_flags &=3D ~BDRV_O_RDWR;
=20
-    ret =3D bdrv_truncate(c, 65536, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
     g_assert_cmpint(ret, =3D=3D, -EACCES);
=20
     c->bs->read_only =3D false;
--=20
2.21.0


