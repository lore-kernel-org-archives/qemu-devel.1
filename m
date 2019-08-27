Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EDC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA182077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA182077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i12-0005jo-As
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2huH-00064i-Pw
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huF-0000mn-Ln
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huA-0000lD-Ei; Tue, 27 Aug 2019 16:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B58BA300CB6A;
 Tue, 27 Aug 2019 20:17:25 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E502D5D6B0;
 Tue, 27 Aug 2019 20:17:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:31 +0100
Message-Id: <20190827201639.30368-5-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 27 Aug 2019 20:17:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/12] block: define .*_part io handlers in
 BlockDriver
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add handlers supporting qiov_offset parameter:
    bdrv_co_preadv_part
    bdrv_co_pwritev_part
    bdrv_co_pwritev_compressed_part
This is used to reduce need of defining local_qiovs and hd_qiovs in all
corners of block layer code. The following patches will increase usage
of this new API part by part.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-5-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-5-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h | 15 ++++++
 block/backup.c            |  2 +-
 block/io.c                | 96 +++++++++++++++++++++++++++++++--------
 qemu-img.c                |  4 +-
 4 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ceec8c2f56..79a1fdb258 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -210,6 +210,9 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+    int coroutine_fn (*bdrv_co_preadv_part)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flag=
s);
     /**
@@ -229,6 +232,9 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+    int coroutine_fn (*bdrv_co_pwritev_part)(BlockDriverState *bs,
+        uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags);
=20
     /*
      * Efficiently zero a region of the disk image.  Typically an image =
format
@@ -339,6 +345,9 @@ struct BlockDriver {
=20
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
+    int coroutine_fn (*bdrv_co_pwritev_compressed_part)(BlockDriverState=
 *bs,
+        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
+        size_t qiov_offset);
=20
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info);
@@ -570,6 +579,12 @@ struct BlockDriver {
     const char *const *strong_runtime_opts;
 };
=20
+static inline bool block_driver_can_compress(BlockDriver *drv)
+{
+    return drv->bdrv_co_pwritev_compressed ||
+           drv->bdrv_co_pwritev_compressed_part;
+}
+
 typedef struct BlockLimits {
     /* Alignment requirement, in bytes, for offset/length of I/O
      * requests. Must be a power of 2 less than INT_MAX; defaults to
diff --git a/block/backup.c b/block/backup.c
index 2baf7bed65..03637aeb11 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -674,7 +674,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         return NULL;
     }
=20
-    if (compress && target->drv->bdrv_co_pwritev_compressed =3D=3D NULL)=
 {
+    if (compress && !block_driver_can_compress(target->drv)) {
         error_setg(errp, "Compression is not supported for this drive %s=
",
                    bdrv_get_device_name(target));
         return NULL;
diff --git a/block/io.c b/block/io.c
index 04e69400d8..fd2fc7d5ff 100644
--- a/block/io.c
+++ b/block/io.c
@@ -146,7 +146,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error =
**errp)
=20
     /* Default alignment based on whether driver has byte interface */
     bs->bl.request_alignment =3D (drv->bdrv_co_preadv ||
-                                drv->bdrv_aio_preadv) ? 1 : 512;
+                                drv->bdrv_aio_preadv ||
+                                drv->bdrv_co_preadv_part) ? 1 : 512;
=20
     /* Take some limits from the children as a default */
     if (bs->file) {
@@ -1044,11 +1045,14 @@ static void bdrv_co_io_em_complete(void *opaque, =
int ret)
=20
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
                                            uint64_t offset, uint64_t byt=
es,
-                                           QEMUIOVector *qiov, int flags=
)
+                                           QEMUIOVector *qiov,
+                                           size_t qiov_offset, int flags=
)
 {
     BlockDriver *drv =3D bs->drv;
     int64_t sector_num;
     unsigned int nb_sectors;
+    QEMUIOVector local_qiov;
+    int ret;
=20
     assert(!(flags & ~BDRV_REQ_MASK));
     assert(!(flags & BDRV_REQ_NO_FALLBACK));
@@ -1057,8 +1061,19 @@ static int coroutine_fn bdrv_driver_preadv(BlockDr=
iverState *bs,
         return -ENOMEDIUM;
     }
=20
+    if (drv->bdrv_co_preadv_part) {
+        return drv->bdrv_co_preadv_part(bs, offset, bytes, qiov, qiov_of=
fset,
+                                        flags);
+    }
+
+    if (qiov_offset > 0 || bytes !=3D qiov->size) {
+        qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+        qiov =3D &local_qiov;
+    }
+
     if (drv->bdrv_co_preadv) {
-        return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
+        ret =3D drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
+        goto out;
     }
=20
     if (drv->bdrv_aio_preadv) {
@@ -1070,10 +1085,12 @@ static int coroutine_fn bdrv_driver_preadv(BlockD=
riverState *bs,
         acb =3D drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
                                    bdrv_co_io_em_complete, &co);
         if (acb =3D=3D NULL) {
-            return -EIO;
+            ret =3D -EIO;
+            goto out;
         } else {
             qemu_coroutine_yield();
-            return co.ret;
+            ret =3D co.ret;
+            goto out;
         }
     }
=20
@@ -1085,16 +1102,25 @@ static int coroutine_fn bdrv_driver_preadv(BlockD=
riverState *bs,
     assert(bytes <=3D BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
=20
-    return drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
+    ret =3D drv->bdrv_co_readv(bs, sector_num, nb_sectors, qiov);
+
+out:
+    if (qiov =3D=3D &local_qiov) {
+        qemu_iovec_destroy(&local_qiov);
+    }
+
+    return ret;
 }
=20
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
                                             uint64_t offset, uint64_t by=
tes,
-                                            QEMUIOVector *qiov, int flag=
s)
+                                            QEMUIOVector *qiov,
+                                            size_t qiov_offset, int flag=
s)
 {
     BlockDriver *drv =3D bs->drv;
     int64_t sector_num;
     unsigned int nb_sectors;
+    QEMUIOVector local_qiov;
     int ret;
=20
     assert(!(flags & ~BDRV_REQ_MASK));
@@ -1104,6 +1130,18 @@ static int coroutine_fn bdrv_driver_pwritev(BlockD=
riverState *bs,
         return -ENOMEDIUM;
     }
=20
+    if (drv->bdrv_co_pwritev_part) {
+        ret =3D drv->bdrv_co_pwritev_part(bs, offset, bytes, qiov, qiov_=
offset,
+                                        flags & bs->supported_write_flag=
s);
+        flags &=3D ~bs->supported_write_flags;
+        goto emulate_flags;
+    }
+
+    if (qiov_offset > 0 || bytes !=3D qiov->size) {
+        qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+        qiov =3D &local_qiov;
+    }
+
     if (drv->bdrv_co_pwritev) {
         ret =3D drv->bdrv_co_pwritev(bs, offset, bytes, qiov,
                                    flags & bs->supported_write_flags);
@@ -1147,24 +1185,44 @@ emulate_flags:
         ret =3D bdrv_co_flush(bs);
     }
=20
+    if (qiov =3D=3D &local_qiov) {
+        qemu_iovec_destroy(&local_qiov);
+    }
+
     return ret;
 }
=20
 static int coroutine_fn
 bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                               uint64_t bytes, QEMUIOVector *qiov)
+                               uint64_t bytes, QEMUIOVector *qiov,
+                               size_t qiov_offset)
 {
     BlockDriver *drv =3D bs->drv;
+    QEMUIOVector local_qiov;
+    int ret;
=20
     if (!drv) {
         return -ENOMEDIUM;
     }
=20
-    if (!drv->bdrv_co_pwritev_compressed) {
+    if (!block_driver_can_compress(drv)) {
         return -ENOTSUP;
     }
=20
-    return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
+    if (drv->bdrv_co_pwritev_compressed_part) {
+        return drv->bdrv_co_pwritev_compressed_part(bs, offset, bytes,
+                                                    qiov, qiov_offset);
+    }
+
+    if (qiov_offset =3D=3D 0) {
+        return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
+    }
+
+    qemu_iovec_init_slice(&local_qiov, qiov, qiov_offset, bytes);
+    ret =3D drv->bdrv_co_pwritev_compressed(bs, offset, bytes, &local_qi=
ov);
+    qemu_iovec_destroy(&local_qiov);
+
+    return ret;
 }
=20
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
@@ -1249,7 +1307,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
=20
             ret =3D bdrv_driver_preadv(bs, cluster_offset, pnum,
-                                     &local_qiov, 0);
+                                     &local_qiov, 0, 0);
             if (ret < 0) {
                 goto err;
             }
@@ -1267,7 +1325,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
                  * necessary to flush even in cache=3Dwritethrough mode.
                  */
                 ret =3D bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov,
+                                          &local_qiov, 0,
                                           BDRV_REQ_WRITE_UNCHANGED);
             }
=20
@@ -1289,7 +1347,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
             qemu_iovec_init(&local_qiov, qiov->niov);
             qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_b=
ytes);
             ret =3D bdrv_driver_preadv(bs, offset + progress, local_qiov=
.size,
-                                     &local_qiov, 0);
+                                     &local_qiov, 0, 0);
             qemu_iovec_destroy(&local_qiov);
             if (ret < 0) {
                 goto err;
@@ -1380,7 +1438,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
=20
     max_bytes =3D ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <=3D max_bytes && bytes <=3D max_transfer) {
-        ret =3D bdrv_driver_preadv(bs, offset, bytes, qiov, 0);
+        ret =3D bdrv_driver_preadv(bs, offset, bytes, qiov, 0, 0);
         goto out;
     }
=20
@@ -1396,7 +1454,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
             qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining=
, num);
=20
             ret =3D bdrv_driver_preadv(bs, offset + bytes - bytes_remain=
ing,
-                                     num, &local_qiov, 0);
+                                     num, &local_qiov, 0, 0);
             max_bytes -=3D num;
             qemu_iovec_destroy(&local_qiov);
         } else {
@@ -1701,7 +1759,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
             }
             qemu_iovec_init_buf(&qiov, buf, num);
=20
-            ret =3D bdrv_driver_pwritev(bs, offset, num, &qiov, write_fl=
ags);
+            ret =3D bdrv_driver_pwritev(bs, offset, num, &qiov, 0, write=
_flags);
=20
             /* Keep bounce buffer around if it is big enough for all
              * all future requests.
@@ -1857,10 +1915,10 @@ static int coroutine_fn bdrv_aligned_pwritev(Bdrv=
Child *child,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret =3D bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
     } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
-        ret =3D bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov);
+        ret =3D bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov, =
0);
     } else if (bytes <=3D max_transfer) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
-        ret =3D bdrv_driver_pwritev(bs, offset, bytes, qiov, flags);
+        ret =3D bdrv_driver_pwritev(bs, offset, bytes, qiov, 0, flags);
     } else {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
         while (bytes_remaining) {
@@ -1879,7 +1937,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvCh=
ild *child,
             qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining=
, num);
=20
             ret =3D bdrv_driver_pwritev(bs, offset + bytes - bytes_remai=
ning,
-                                      num, &local_qiov, local_flags);
+                                      num, &local_qiov, 0, local_flags);
             qemu_iovec_destroy(&local_qiov);
             if (ret < 0) {
                 break;
diff --git a/qemu-img.c b/qemu-img.c
index 7daa05e51a..4ee436fc94 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2388,7 +2388,7 @@ static int img_convert(int argc, char **argv)
         const char *preallocation =3D
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
=20
-        if (drv && !drv->bdrv_co_pwritev_compressed) {
+        if (drv && !block_driver_can_compress(drv)) {
             error_report("Compression not supported for this file format=
");
             ret =3D -1;
             goto out;
@@ -2459,7 +2459,7 @@ static int img_convert(int argc, char **argv)
     }
     out_bs =3D blk_bs(s.target);
=20
-    if (s.compressed && !out_bs->drv->bdrv_co_pwritev_compressed) {
+    if (s.compressed && !block_driver_can_compress(out_bs->drv)) {
         error_report("Compression not supported for this file format");
         ret =3D -1;
         goto out;
--=20
2.21.0


