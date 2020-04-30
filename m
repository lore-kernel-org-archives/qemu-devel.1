Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B18C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4632076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjGa4S9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4632076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBcC-00076f-JI
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBWm-0007pL-7T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBUg-0003Hr-CY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBUf-0003FV-Vu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odSGjzcO3TIattQ1FPfJuDeZ58OgcFllw8TFACRUapk=;
 b=SjGa4S9reWeJz3aC7ZZpzIatbof/4hSPVNvm0BJLHN6SidpG1xtYXLh/gxij7HZOJGLhOo
 NABKDUIn69uleJ9vJgZ849+Wd/6rL0+o45OAN8EmUnigR6G68cW+4ZY7X7BNwiEyxG4YMk
 6l9E6diE2Ho0XjIVH0SAjcB6dhHbkvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-oeLc6rLlMYWDxP3QJfXNwA-1; Thu, 30 Apr 2020 11:52:54 -0400
X-MC-Unique: oeLc6rLlMYWDxP3QJfXNwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66867106C0B4;
 Thu, 30 Apr 2020 15:52:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE3A5610D6;
 Thu, 30 Apr 2020 15:52:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/15] block: Add flags to bdrv(_co)_truncate()
Date: Thu, 30 Apr 2020 17:52:20 +0200
Message-Id: <20200430155231.473156-5-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
References: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that block drivers can support flags for .bdrv_co_truncate, expose
the parameter in the node level interfaces bdrv_co_truncate() and
bdrv_truncate().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200424125448.63318-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h       |  5 +++--
 block/block-backend.c       |  2 +-
 block/crypto.c              |  2 +-
 block/io.c                  | 12 +++++++-----
 block/parallels.c           |  6 +++---
 block/qcow.c                |  4 ++--
 block/qcow2-refcount.c      |  2 +-
 block/qcow2.c               | 15 +++++++++------
 block/raw-format.c          |  2 +-
 block/vhdx-log.c            |  2 +-
 block/vhdx.c                |  2 +-
 block/vmdk.c                |  2 +-
 tests/test-block-iothread.c |  6 +++---
 13 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b05995fe9c..8b62429aa4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -339,9 +339,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverS=
tate *bs,
 void bdrv_refresh_filename(BlockDriverState *bs);
=20
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool e=
xact,
-                                  PreallocMode prealloc, Error **errp);
+                                  PreallocMode prealloc, BdrvRequestFlags =
flags,
+                                  Error **errp);
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, Error **errp);
+                  PreallocMode prealloc, BdrvRequestFlags flags, Error **e=
rrp);
=20
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
diff --git a/block/block-backend.c b/block/block-backend.c
index 38ae413826..8be20060d3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2144,7 +2144,7 @@ int blk_truncate(BlockBackend *blk, int64_t offset, b=
ool exact,
         return -ENOMEDIUM;
     }
=20
-    return bdrv_truncate(blk->root, offset, exact, prealloc, errp);
+    return bdrv_truncate(blk->root, offset, exact, prealloc, 0, errp);
 }
=20
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
diff --git a/block/crypto.c b/block/crypto.c
index 3721a8495c..ab33545c92 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -313,7 +313,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t =
offset, bool exact,
=20
     offset +=3D payload_offset;
=20
-    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
 }
=20
 static void block_crypto_close(BlockDriverState *bs)
diff --git a/block/io.c b/block/io.c
index 04ac5cf023..795075954e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3339,12 +3339,12 @@ static void bdrv_parent_cb_resize(BlockDriverState =
*bs)
  * 'offset' bytes in length.
  */
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool e=
xact,
-                                  PreallocMode prealloc, Error **errp)
+                                  PreallocMode prealloc, BdrvRequestFlags =
flags,
+                                  Error **errp)
 {
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
     BdrvTrackedRequest req;
-    BdrvRequestFlags flags =3D 0;
     int64_t old_size, new_bytes;
     int ret;
=20
@@ -3402,7 +3402,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, i=
nt64_t offset, bool exact,
         }
         ret =3D drv->bdrv_co_truncate(bs, offset, exact, prealloc, flags, =
errp);
     } else if (bs->file && drv->is_filter) {
-        ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+        ret =3D bdrv_co_truncate(bs->file, offset, exact, prealloc, flags,=
 errp);
     } else {
         error_setg(errp, "Image format driver does not support resize");
         ret =3D -ENOTSUP;
@@ -3435,6 +3435,7 @@ typedef struct TruncateCo {
     int64_t offset;
     bool exact;
     PreallocMode prealloc;
+    BdrvRequestFlags flags;
     Error **errp;
     int ret;
 } TruncateCo;
@@ -3443,12 +3444,12 @@ static void coroutine_fn bdrv_truncate_co_entry(voi=
d *opaque)
 {
     TruncateCo *tco =3D opaque;
     tco->ret =3D bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                                tco->prealloc, tco->errp);
+                                tco->prealloc, tco->flags, tco->errp);
     aio_wait_kick();
 }
=20
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, Error **errp)
+                  PreallocMode prealloc, BdrvRequestFlags flags, Error **e=
rrp)
 {
     Coroutine *co;
     TruncateCo tco =3D {
@@ -3456,6 +3457,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, b=
ool exact,
         .offset     =3D offset,
         .exact      =3D exact,
         .prealloc   =3D prealloc,
+        .flags      =3D flags,
         .errp       =3D errp,
         .ret        =3D NOT_DONE,
     };
diff --git a/block/parallels.c b/block/parallels.c
index 6d4ed77f16..2be92cf417 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -203,7 +203,7 @@ static int64_t allocate_clusters(BlockDriverState *bs, =
int64_t sector_num,
         } else {
             ret =3D bdrv_truncate(bs->file,
                                 (s->data_end + space) << BDRV_SECTOR_BITS,
-                                false, PREALLOC_MODE_OFF, NULL);
+                                false, PREALLOC_MODE_OFF, 0, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -493,7 +493,7 @@ static int coroutine_fn parallels_co_check(BlockDriverS=
tate *bs,
              * That means we have to pass exact=3Dtrue.
              */
             ret =3D bdrv_truncate(bs->file, res->image_end_offset, true,
-                                PREALLOC_MODE_OFF, &local_err);
+                                PREALLOC_MODE_OFF, 0, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
                 res->check_errors++;
@@ -889,7 +889,7 @@ static void parallels_close(BlockDriverState *bs)
=20
         /* errors are ignored, so we might as well pass exact=3Dtrue */
         bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, NULL);
+                      PREALLOC_MODE_OFF, 0, NULL);
     }
=20
     g_free(s->bat_dirty_bmap);
diff --git a/block/qcow.c b/block/qcow.c
index 8973e4e565..6b5f2269f0 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -480,7 +480,7 @@ static int get_cluster_offset(BlockDriverState *bs,
                     return -E2BIG;
                 }
                 ret =3D bdrv_truncate(bs->file, cluster_offset + s->cluste=
r_size,
-                                    false, PREALLOC_MODE_OFF, NULL);
+                                    false, PREALLOC_MODE_OFF, 0, NULL);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1035,7 +1035,7 @@ static int qcow_make_empty(BlockDriverState *bs)
             l1_length) < 0)
         return -1;
     ret =3D bdrv_truncate(bs->file, s->l1_table_offset + l1_length, false,
-                        PREALLOC_MODE_OFF, NULL);
+                        PREALLOC_MODE_OFF, 0, NULL);
     if (ret < 0)
         return ret;
=20
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7ef1c0e42a..d9650b9b6c 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2018,7 +2018,7 @@ static int check_refblocks(BlockDriverState *bs, Bdrv=
CheckResult *res,
                 }
=20
                 ret =3D bdrv_truncate(bs->file, offset + s->cluster_size, =
false,
-                                    PREALLOC_MODE_OFF, &local_err);
+                                    PREALLOC_MODE_OFF, 0, &local_err);
                 if (ret < 0) {
                     error_report_err(local_err);
                     goto resize_fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 0b406b22fb..c5b0711357 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3095,7 +3095,7 @@ static int coroutine_fn preallocate_co(BlockDriverSta=
te *bs, uint64_t offset,
             mode =3D PREALLOC_MODE_OFF;
         }
         ret =3D bdrv_co_truncate(s->data_file, host_offset + cur_bytes, fa=
lse,
-                               mode, errp);
+                               mode, 0, errp);
         if (ret < 0) {
             return ret;
         }
@@ -4061,7 +4061,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
              * always fulfilled, so there is no need to pass it on.)
              */
             bdrv_co_truncate(bs->file, (last_cluster + 1) * s->cluster_siz=
e,
-                             false, PREALLOC_MODE_OFF, &local_err);
+                             false, PREALLOC_MODE_OFF, 0, &local_err);
             if (local_err) {
                 warn_reportf_err(local_err,
                                  "Failed to truncate the tail of the image=
: ");
@@ -4083,7 +4083,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
              * file should be resized to the exact target size, too,
              * so we pass @exact here.
              */
-            ret =3D bdrv_co_truncate(s->data_file, offset, exact, prealloc=
, errp);
+            ret =3D bdrv_co_truncate(s->data_file, offset, exact, prealloc=
, 0,
+                                   errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -4169,7 +4170,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
         new_file_size =3D allocation_start +
                         nb_new_data_clusters * s->cluster_size;
         /* Image file grows, so @exact does not matter */
-        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 errp);
+        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 0,
+                               errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
             qcow2_free_clusters(bs, allocation_start,
@@ -4348,7 +4350,8 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs=
,
         if (len < 0) {
             return len;
         }
-        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, N=
ULL);
+        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, 0=
,
+                                NULL);
     }
=20
     if (offset_into_cluster(s, offset)) {
@@ -4563,7 +4566,7 @@ static int make_completely_empty(BlockDriverState *bs=
)
     }
=20
     ret =3D bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size, f=
alse,
-                        PREALLOC_MODE_OFF, &local_err);
+                        PREALLOC_MODE_OFF, 0, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         goto fail;
diff --git a/block/raw-format.c b/block/raw-format.c
index 9331368f43..3465c9a865 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverStat=
e *bs, int64_t offset,
=20
     s->size =3D offset;
     offset +=3D s->offset;
-    return bdrv_co_truncate(bs->file, offset, exact, prealloc, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
 }
=20
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 13a49c2a33..404fb5f3cb 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -558,7 +558,7 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHD=
XState *s,
                     goto exit;
                 }
                 ret =3D bdrv_truncate(bs->file, new_file_size, false,
-                                    PREALLOC_MODE_OFF, NULL);
+                                    PREALLOC_MODE_OFF, 0, NULL);
                 if (ret < 0) {
                     goto exit;
                 }
diff --git a/block/vhdx.c b/block/vhdx.c
index e16fdc2f2d..3a33eda99c 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1264,7 +1264,7 @@ static int vhdx_allocate_block(BlockDriverState *bs, =
BDRVVHDXState *s,
     }
=20
     return bdrv_truncate(bs->file, *new_offset + s->block_size, false,
-                         PREALLOC_MODE_OFF, NULL);
+                         PREALLOC_MODE_OFF, 0, NULL);
 }
=20
 /*
diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c9800..5de99fe813 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2077,7 +2077,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, uint=
64_t offset,
             }
             length =3D QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
             ret =3D bdrv_truncate(s->extents[i].file, length, false,
-                                PREALLOC_MODE_OFF, NULL);
+                                PREALLOC_MODE_OFF, 0, NULL);
             if (ret < 0) {
                 return ret;
             }
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 2f3b76323d..71e9bce3b1 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -186,18 +186,18 @@ static void test_sync_op_truncate(BdrvChild *c)
     int ret;
=20
     /* Normal success path */
-    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, 0, NULL);
     g_assert_cmpint(ret, =3D=3D, 0);
=20
     /* Early error: Negative offset */
-    ret =3D bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, -2, false, PREALLOC_MODE_OFF, 0, NULL);
     g_assert_cmpint(ret, =3D=3D, -EINVAL);
=20
     /* Error: Read-only image */
     c->bs->read_only =3D true;
     c->bs->open_flags &=3D ~BDRV_O_RDWR;
=20
-    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, NULL);
+    ret =3D bdrv_truncate(c, 65536, false, PREALLOC_MODE_OFF, 0, NULL);
     g_assert_cmpint(ret, =3D=3D, -EACCES);
=20
     c->bs->read_only =3D false;
--=20
2.25.3


