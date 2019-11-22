Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46395C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F221E20721
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaQln+Zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F221E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBVF-0005X7-RE
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iYBR6-0000LU-PF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iYBR3-0002kv-MW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iYBR3-0002ka-HS
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574438729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8ok8XK7Tfda8KpjFnC6PElx66iJN+3u/JTZmrrKNXY=;
 b=KaQln+Zf5lRGU9npnm4/aC2gkVbUCce9dqYVArp0L//ZQ52yUw45MXH90rwASrVgRgBZtA
 LTqvJkLccZfxlFJcLthScXJcS+5RLYYkj6bt4ZLdhEXCBgL1j3hVtfhjAm3uMMKBJS0cYH
 aSEl9X+UKt/7QHP6aGQNpisbk7XgLqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-q2ysPz5BPN2PbfOSXcO2BQ-1; Fri, 22 Nov 2019 11:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E3541883522;
 Fri, 22 Nov 2019 16:05:24 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-252.ams2.redhat.com
 [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 956E7100032E;
 Fri, 22 Nov 2019 16:05:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/8] block: Add no_fallback parameter to bdrv_co_truncate()
Date: Fri, 22 Nov 2019 17:05:05 +0100
Message-Id: <20191122160511.8377-3-kwolf@redhat.com>
In-Reply-To: <20191122160511.8377-1-kwolf@redhat.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: q2ysPz5BPN2PbfOSXcO2BQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a no_fallback parameter to bdrv_co_truncate(), bdrv_truncate()
and blk_truncate() in preparation for a fix that potentially needs to
zero-write the new area. no_fallback will use BDRV_REQ_NO_FALLBACK for
this operation and lets the truncate fail if an efficient zero write
isn't possible.

Only qmp_block_resize() passes true for this parameter because it is a
blocking monitor command, so we don't want to add more potentially slow
I/O operations to it than we already have.

All other users will accept even a slow fallback to avoid failure.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h          |  5 +++--
 include/sysemu/block-backend.h |  2 +-
 block/block-backend.c          |  4 ++--
 block/commit.c                 |  4 ++--
 block/crypto.c                 |  4 ++--
 block/io.c                     | 16 ++++++++++++----
 block/mirror.c                 |  2 +-
 block/parallels.c              |  6 +++---
 block/qcow.c                   |  4 ++--
 block/qcow2-refcount.c         |  2 +-
 block/qcow2.c                  | 19 +++++++++++--------
 block/qed.c                    |  2 +-
 block/raw-format.c             |  2 +-
 block/vdi.c                    |  2 +-
 block/vhdx-log.c               |  2 +-
 block/vhdx.c                   |  6 +++---
 block/vmdk.c                   | 10 ++++++----
 block/vpc.c                    |  2 +-
 blockdev.c                     |  2 +-
 qemu-img.c                     |  2 +-
 qemu-io-cmds.c                 |  2 +-
 tests/test-block-iothread.c    |  6 +++---
 22 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 1df9848e74..3e44677905 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -347,9 +347,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverS=
tate *bs,
 void bdrv_refresh_filename(BlockDriverState *bs);
=20
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool e=
xact,
-                                  PreallocMode prealloc, Error **errp);
+                                  PreallocMode prealloc, bool no_fallback,
+                                  Error **errp);
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, Error **errp);
+                  PreallocMode prealloc, bool no_fallback, Error **errp);
=20
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index b198deca0b..487b29d13e 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -238,7 +238,7 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk=
, int64_t offset,
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *b=
uf,
                           int bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
-                 PreallocMode prealloc, Error **errp);
+                 PreallocMode prealloc, bool no_fallback, Error **errp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0..fcc9d60cdb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2073,14 +2073,14 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_=
t offset, const void *buf,
 }
=20
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
-                 PreallocMode prealloc, Error **errp)
+                 PreallocMode prealloc, bool no_fallback, Error **errp)
 {
     if (!blk_is_available(blk)) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
=20
-    return bdrv_truncate(blk->root, offset, exact, prealloc, errp);
+    return bdrv_truncate(blk->root, offset, exact, prealloc, no_fallback, =
errp);
 }
=20
 static void blk_pdiscard_entry(void *opaque)
diff --git a/block/commit.c b/block/commit.c
index 23c90b3b91..f074181d83 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -155,7 +155,7 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
     }
=20
     if (base_len < len) {
-        ret =3D blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, NULL)=
;
+        ret =3D blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, false=
, NULL);
         if (ret) {
             goto out;
         }
@@ -472,7 +472,7 @@ int bdrv_commit(BlockDriverState *bs)
      * we must return an error */
     if (length > backing_length) {
         ret =3D blk_truncate(backing, length, false, PREALLOC_MODE_OFF,
-                           &local_err);
+                           false, &local_err);
         if (ret < 0) {
             error_report_err(local_err);
             goto ro_cleanup;
diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..0f28e8b4e1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -114,7 +114,7 @@ static ssize_t block_crypto_init_func(QCryptoBlock *blo=
ck,
      * which will be used by the crypto header
      */
     return blk_truncate(data->blk, data->size + headerlen, false,
-                        data->prealloc, errp);
+                        data->prealloc, false, errp);
 }
=20
=20
@@ -311,7 +311,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t =
offset, bool exact,
=20
     offset +=3D payload_offset;
=20
-    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, false, errp=
);
 }
=20
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/io.c b/block/io.c
index 003f4ea38c..42e7558954 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3313,9 +3313,15 @@ static void bdrv_parent_cb_resize(BlockDriverState *=
bs)
  * If 'exact' is true, the file must be resized to exactly the given
  * 'offset'.  Otherwise, it is sufficient for the node to be at least
  * 'offset' bytes in length.
+ *
+ * If 'no_fallback' is true, a possibly needed writte_zeroes operation to =
avoid
+ * making a longer backing file visible will use BDRV_REQ_NO_FALLBACK. If =
the
+ * zero write is necessary and this flag is set, bdrv_co_truncate() will f=
ail
+ * if efficient zero writes cannot be provided.
  */
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool e=
xact,
-                                  PreallocMode prealloc, Error **errp)
+                                  PreallocMode prealloc, bool no_fallback,
+                                  Error **errp)
 {
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
@@ -3372,7 +3378,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset, bool exact,
     if (drv->bdrv_co_truncate) {
         ret =3D drv->bdrv_co_truncate(bs, offset, exact, prealloc, errp);
     } else if (bs->file && drv->is_filter) {
-        ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+        ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, no_fal=
lback,
+                               errp);
     } else {
         error_setg(errp, "Image format driver does not support resize");
         ret =3D -ENOTSUP;
@@ -3405,6 +3412,7 @@ typedef struct TruncateCo {
     int64_t offset;
     bool exact;
     PreallocMode prealloc;
+    bool no_fallback;
     Error **errp;
     int ret;
 } TruncateCo;
@@ -3413,12 +3421,12 @@ static void coroutine_fn bdrv_truncate_co_entry(voi=
d *opaque)
 {
     TruncateCo *tco =3D opaque;
     tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                                tco->prealloc, tco->errp);
+                                tco->prealloc, tco->no_fallback, tco->errp=
);
     aio_wait_kick();
 }
=20
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, Error **errp)
+                  PreallocMode prealloc, bool no_fallback, Error **errp)
 {
     Coroutine *co;
     TruncateCo tco =3D {
diff --git a/block/mirror.c b/block/mirror.c
index f0f2d9dff1..a333533a38 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -879,7 +879,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
=20
         if (s->bdev_length > base_length) {
             ret =3D blk_truncate(s->target, s->bdev_length, false,
-                               PREALLOC_MODE_OFF, NULL);
+                               PREALLOC_MODE_OFF, false, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/parallels.c b/block/parallels.c
index 7a01997659..859f3f4904 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -203,7 +203,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, =
int64_t sector_num,
         } else {
             ret =3D bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BITS,
-                                false, PREALLOC_MODE_OFF, NULL);
+                                false, PREALLOC_MODE_OFF, false, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -493,7 +493,7 @@ static int coroutine_fn parallels_co_check(BlockDriverS=
tate *bs,
              * That means we have to pass exact=3Dtrue.
              */
             ret =3D bdrv_truncate(bs->file, res->image_end_offset, true,
-                                PREALLOC_MODE_OFF, &local_err);
+                                PREALLOC_MODE_OFF, false, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
                 res->check_errors++;
@@ -888,7 +888,7 @@ static void parallels_close(BlockDriverState *bs)
=20
         /* errors are ignored, so we might as well pass exact=3Dtrue */
         bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, NULL);
+                      PREALLOC_MODE_OFF, false, NULL);
     }
=20
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index fce8989868..f43cb59cc0 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -480,7 +480,7 @@ static int get_cluster_offset(BlockDriverState *bs,
                     return -E2BIG;
                 }
                 ret =3D bdrv_truncate(bs->file, cluster_offset + s->cluste=
r_size,
-                                    false, PREALLOC_MODE_OFF, NULL);
+                                    false, PREALLOC_MODE_OFF, false, NULL)=
;
                 if (ret < 0) {
                     return ret;
                 }
@@ -1034,7 +1034,7 @@ static int qcow_make_empty(BlockDriverState *bs)
             l1_length) < 0)
         return -1;
     ret =3D bdrv_truncate(bs->file, s->l1_table_offset + l1_length, false,
-                        PREALLOC_MODE_OFF, NULL);
+                        PREALLOC_MODE_OFF, false, NULL);
     if (ret < 0)
         return ret;
=20
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..fdfdec336d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2017,7 +2017,7 @@ static int check_refblocks(BlockDriverState *bs, Bdrv=
CheckResult *res,
                 }
=20
                 ret =3D bdrv_truncate(bs->file, offset + s->cluster_size, =
false,
-                                    PREALLOC_MODE_OFF, &local_err);
+                                    PREALLOC_MODE_OFF, false, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
                     goto resize_fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c18721741..b201383c3d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3075,7 +3075,7 @@ static int coroutine_fn preallocate_co(BlockDriverSta=
te *bs, uint64_t offset,
             mode =3D PREALLOC_MODE_OFF;
         }
         ret =3D bdrv_co_truncate(s->data_file, host_offset + cur_bytes, fa=
lse,
-                               mode, errp);
+                               mode, false, errp);
         if (ret < 0) {
             return ret;
         }
@@ -3490,7 +3490,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
=20
     /* Okay, now that we have a valid image, let's give it the right size =
*/
     ret =3D blk_truncate(blk, qcow2_opts->size, false, qcow2_opts->preallo=
cation,
-                       errp);
+                       false, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
@@ -4035,7 +4035,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
              * always fulfilled, so there is no need to pass it on.)
              */
             bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_siz=
e,
-                             false, PREALLOC_MODE_OFF, &local_err);
+                             false, PREALLOC_MODE_OFF, false, &local_err);
             if (local_err) {
                 warn_reportf_err(local_err,
                                  "Failed to truncate the tail of the image=
: ");
@@ -4057,7 +4057,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
              * file should be resized to the exact target size, too,
              * so we pass @exact here.
              */
-            ret =3D bdrv_co_truncate(s->data_file, offset, exact, prealloc=
, errp);
+            ret =3D bdrv_co_truncate(s->data_file, offset, exact, prealloc=
, false,
+                                   errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -4143,7 +4144,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
         new_file_size =3D allocation_start +
                         nb_new_data_clusters * s->cluster_size;
         /* Image file grows, so @exact does not matter */
-        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 errp);
+        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 false,
+                               errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
             qcow2_free_clusters(bs, allocation_start,
@@ -4246,7 +4248,8 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs=
,
         if (len < 0) {
             return len;
         }
-        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, N=
ULL);
+        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, f=
alse,
+                                NULL);
     }
=20
     if (offset_into_cluster(s, offset)) {
@@ -4484,7 +4487,7 @@ static int make_completely_empty(BlockDriverState *bs=
)
     }
=20
     ret =3D bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size, f=
alse,
-                        PREALLOC_MODE_OFF, &local_err);
+                        PREALLOC_MODE_OFF, false, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         goto fail;
@@ -5327,7 +5330,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
          * Amending image options should ensure that the image has
          * exactly the given new values, so pass exact=3Dtrue here.
          */
-        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, errp)=
;
+        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, false=
, errp);
         blk_unref(blk);
         if (ret < 0) {
             return ret;
diff --git a/block/qed.c b/block/qed.c
index d8c4e5fb1e..11e5cb37d9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -677,7 +677,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCrea=
teOptions *opts,
      * The QED format associates file length with allocation status,
      * so a new file (which is empty) must have a length of 0.
      */
-    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, false, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a76ec7dd2..950334cdb4 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverStat=
e *bs, int64_t offset,
=20
     s->size =3D offset;
     offset +=3D s->offset;
-    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, false, errp=
);
 }
=20
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
diff --git a/block/vdi.c b/block/vdi.c
index 0142da7233..2deb600614 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -875,7 +875,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreate=
Options *create_options,
=20
     if (image_type =3D=3D VDI_TYPE_STATIC) {
         ret =3D blk_truncate(blk, offset + blocks * block_size, false,
-                           PREALLOC_MODE_OFF, errp);
+                           PREALLOC_MODE_OFF, false, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to statically allocate file");
             goto exit;
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 13a49c2a33..4cd32a1231 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -558,7 +558,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHD=
XState *s,
                     goto exit;
                 }
                 ret =3D bdrv_truncate(bs->file, new_file_size, false,
-                                    PREALLOC_MODE_OFF, NULL);
+                                    PREALLOC_MODE_OFF, false, NULL);
                 if (ret < 0) {
                     goto exit;
                 }
diff --git a/block/vhdx.c b/block/vhdx.c
index f02d2611be..a58b2e2768 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1264,7 +1264,7 @@ static int vhdx_allocate_block(BlockDriverState *bs, =
BDRVVHDXState *s,
     }
=20
     return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
-                         PREALLOC_MODE_OFF, NULL);
+                         PREALLOC_MODE_OFF, false, NULL);
 }
=20
 /*
@@ -1703,13 +1703,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVV=
HDXState *s,
         /* All zeroes, so we can just extend the file - the end of the BAT
          * is the furthest thing we have written yet */
         ret =3D blk_truncate(blk, data_file_offset, false, PREALLOC_MODE_O=
FF,
-                           errp);
+                           false, errp);
         if (ret < 0) {
             goto exit;
         }
     } else if (type =3D=3D VHDX_TYPE_FIXED) {
         ret =3D blk_truncate(blk, data_file_offset + image_size, false,
-                           PREALLOC_MODE_OFF, errp);
+                           PREALLOC_MODE_OFF, false, errp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d997..1fbfed45ce 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2077,7 +2077,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, uint=
64_t offset,
             }
             length =3D QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
             ret =3D bdrv_truncate(s->extents[i].file, length, false,
-                                PREALLOC_MODE_OFF, NULL);
+                                PREALLOC_MODE_OFF, false, NULL);
             if (ret < 0) {
                 return ret;
             }
@@ -2118,7 +2118,8 @@ static int vmdk_init_extent(BlockBackend *blk,
     int gd_buf_size;
=20
     if (flat) {
-        ret =3D blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, errp=
);
+        ret =3D blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, fals=
e,
+                           errp);
         goto exit;
     }
     magic =3D cpu_to_be32(VMDK4_MAGIC);
@@ -2182,7 +2183,7 @@ static int vmdk_init_extent(BlockBackend *blk,
     }
=20
     ret =3D blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false=
,
-                       PREALLOC_MODE_OFF, errp);
+                       PREALLOC_MODE_OFF, false, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -2523,7 +2524,8 @@ static int coroutine_fn vmdk_co_do_create(int64_t siz=
e,
     /* bdrv_pwrite write padding zeros to align to sector, we don't need t=
hat
      * for description file */
     if (desc_offset =3D=3D 0) {
-        ret =3D blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, errp=
);
+        ret =3D blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, fals=
e,
+                           errp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vpc.c b/block/vpc.c
index a65550298e..9202a517e1 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -898,7 +898,7 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t=
 *buf,
     /* Add footer to total size */
     total_size +=3D HEADER_SIZE;
=20
-    ret =3D blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, false,=
 errp);
     if (ret < 0) {
         return ret;
     }
diff --git a/blockdev.c b/blockdev.c
index 8e029e9c01..d7d3c250f6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3204,7 +3204,7 @@ void qmp_block_resize(bool has_device, const char *de=
vice,
     }
=20
     bdrv_drained_begin(bs);
-    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, true, errp);
     bdrv_drained_end(bs);
=20
 out:
diff --git a/qemu-img.c b/qemu-img.c
index 95a24b9762..7ee450bc18 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3836,7 +3836,7 @@ static int img_resize(int argc, char **argv)
      * resizing, so pass @exact=3Dtrue.  It is of no use to report
      * success when the image has not actually been resized.
      */
-    ret =3D blk_truncate(blk, total_size, true, prealloc, &err);
+    ret =3D blk_truncate(blk, total_size, true, prealloc, false, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
     } else {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 1b7e700020..08cce9d4cf 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1715,7 +1715,7 @@ static int truncate_f(BlockBackend *blk, int argc, ch=
ar **argv)
      * exact=3Dtrue.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, &local_err)=
;
+    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, false, &loc=
al_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 0c861809f0..339dc2c9bd 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -185,18 +185,18 @@ static void test_sync_op_truncate(BdrvChild *c)
     int ret;
=20
     /* Normal success path */
-    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, false, NULL)=
;
     g_assert_cmpint(ret, =3D=3D, 0);
=20
     /* Early error: Negative offset */
-    ret =3D bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, false, NULL);
     g_assert_cmpint(ret, =3D=3D, -EINVAL);
=20
     /* Error: Read-only image */
     c->bs->read_only =3D true;
     c->bs->open_flags &=3D ~BDRV_O_RDWR;
=20
-    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, false, NULL)=
;
     g_assert_cmpint(ret, =3D=3D, -EACCES);
=20
     c->bs->read_only =3D false;
--=20
2.20.1


