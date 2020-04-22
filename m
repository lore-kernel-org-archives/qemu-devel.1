Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E23FC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2537720774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddKh9XCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2537720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHH2-0001F8-9s
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRHC9-0002rr-Fd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRHC7-0003LP-Oe
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRHC7-0003Ic-3V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587568906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg4Ypu151+SNBr8vJ5VcAoMs07WQmG6Zm85GkTcPAkU=;
 b=ddKh9XCCpAROhrfj17gFtytypHZbC8Cma3WrWXKgVT5LRaK466FbePfTXksOkHemYWBzjB
 7BZ3/ZWu//fvtvj9HUB4YhVOYn34azugxRSsCc0D19RFDzQjPmPBGHBwU9vihtd2/VxwYJ
 IlwkUatgfF/l68LupUKhbEChMHsbIjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-NCbOrNXqO5auA3LSb8vzxw-1; Wed, 22 Apr 2020 11:21:44 -0400
X-MC-Unique: NCbOrNXqO5auA3LSb8vzxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC8D14E5;
 Wed, 22 Apr 2020 15:21:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-212.ams2.redhat.com
 [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88617600D2;
 Wed, 22 Apr 2020 15:21:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 3/9] block-backend: Add flags to blk_truncate()
Date: Wed, 22 Apr 2020 17:21:23 +0200
Message-Id: <20200422152129.167074-4-kwolf@redhat.com>
In-Reply-To: <20200422152129.167074-1-kwolf@redhat.com>
References: <20200422152129.167074-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that node level interface bdrv_truncate() supports passing request
flags to the block driver, expose this on the BlockBackend level, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/sysemu/block-backend.h | 2 +-
 block.c                        | 3 ++-
 block/block-backend.c          | 4 ++--
 block/commit.c                 | 4 ++--
 block/crypto.c                 | 2 +-
 block/mirror.c                 | 2 +-
 block/qcow2.c                  | 4 ++--
 block/qed.c                    | 2 +-
 block/vdi.c                    | 2 +-
 block/vhdx.c                   | 4 ++--
 block/vmdk.c                   | 6 +++---
 block/vpc.c                    | 2 +-
 blockdev.c                     | 2 +-
 qemu-img.c                     | 2 +-
 qemu-io-cmds.c                 | 2 +-
 15 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 9bbdbd63d7..34de7faa81 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -237,7 +237,7 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk=
, int64_t offset,
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *b=
uf,
                           int bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
-                 PreallocMode prealloc, Error **errp);
+                 PreallocMode prealloc, BdrvRequestFlags flags, Error **er=
rp);
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block.c b/block.c
index 2e3905c99e..03cc5813a2 100644
--- a/block.c
+++ b/block.c
@@ -548,7 +548,8 @@ static int64_t create_file_fallback_truncate(BlockBacke=
nd *blk,
     int64_t size;
     int ret;
=20
-    ret =3D blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, &loc=
al_err);
+    ret =3D blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, 0,
+                       &local_err);
     if (ret < 0 && ret !=3D -ENOTSUP) {
         error_propagate(errp, local_err);
         return ret;
diff --git a/block/block-backend.c b/block/block-backend.c
index 8be20060d3..17ed6d8c5b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2137,14 +2137,14 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_=
t offset, const void *buf,
 }
=20
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
-                 PreallocMode prealloc, Error **errp)
+                 PreallocMode prealloc, BdrvRequestFlags flags, Error **er=
rp)
 {
     if (!blk_is_available(blk)) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
=20
-    return bdrv_truncate(blk->root, offset, exact, prealloc, 0, errp);
+    return bdrv_truncate(blk->root, offset, exact, prealloc, flags, errp);
 }
=20
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
diff --git a/block/commit.c b/block/commit.c
index 8e672799af..87f6096d90 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -133,7 +133,7 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
     }
=20
     if (base_len < len) {
-        ret =3D blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, NULL)=
;
+        ret =3D blk_truncate(s->base, len, false, PREALLOC_MODE_OFF, 0, NU=
LL);
         if (ret) {
             goto out;
         }
@@ -458,7 +458,7 @@ int bdrv_commit(BlockDriverState *bs)
      * grow the backing file image if possible.  If not possible,
      * we must return an error */
     if (length > backing_length) {
-        ret =3D blk_truncate(backing, length, false, PREALLOC_MODE_OFF,
+        ret =3D blk_truncate(backing, length, false, PREALLOC_MODE_OFF, 0,
                            &local_err);
         if (ret < 0) {
             error_report_err(local_err);
diff --git a/block/crypto.c b/block/crypto.c
index ab33545c92..e02f343590 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -115,7 +115,7 @@ static ssize_t block_crypto_init_func(QCryptoBlock *blo=
ck,
      * which will be used by the crypto header
      */
     return blk_truncate(data->blk, data->size + headerlen, false,
-                        data->prealloc, errp);
+                        data->prealloc, 0, errp);
 }
=20
=20
diff --git a/block/mirror.c b/block/mirror.c
index c26fd9260d..aca95c9bc9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -900,7 +900,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
=20
         if (s->bdev_length > base_length) {
             ret =3D blk_truncate(s->target, s->bdev_length, false,
-                               PREALLOC_MODE_OFF, NULL);
+                               PREALLOC_MODE_OFF, 0, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
diff --git a/block/qcow2.c b/block/qcow2.c
index c5b0711357..9cfbdfc939 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3511,7 +3511,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
=20
     /* Okay, now that we have a valid image, let's give it the right size =
*/
     ret =3D blk_truncate(blk, qcow2_opts->size, false, qcow2_opts->preallo=
cation,
-                       errp);
+                       0, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
@@ -5374,7 +5374,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
          * Amending image options should ensure that the image has
          * exactly the given new values, so pass exact=3Dtrue here.
          */
-        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, errp)=
;
+        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, 0, er=
rp);
         blk_unref(blk);
         if (ret < 0) {
             return ret;
diff --git a/block/qed.c b/block/qed.c
index fb6100bd20..b0fdb8f565 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -677,7 +677,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCrea=
teOptions *opts,
      * The QED format associates file length with allocation status,
      * so a new file (which is empty) must have a length of 0.
      */
-    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, 0, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/block/vdi.c b/block/vdi.c
index e1a11f2aa0..0c7835ae70 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -875,7 +875,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreate=
Options *create_options,
=20
     if (image_type =3D=3D VDI_TYPE_STATIC) {
         ret =3D blk_truncate(blk, offset + blocks * block_size, false,
-                           PREALLOC_MODE_OFF, errp);
+                           PREALLOC_MODE_OFF, 0, errp);
         if (ret < 0) {
             error_prepend(errp, "Failed to statically allocate file");
             goto exit;
diff --git a/block/vhdx.c b/block/vhdx.c
index 5dfbb2029a..21497f7318 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1703,13 +1703,13 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVV=
HDXState *s,
         /* All zeroes, so we can just extend the file - the end of the BAT
          * is the furthest thing we have written yet */
         ret =3D blk_truncate(blk, data_file_offset, false, PREALLOC_MODE_O=
FF,
-                           errp);
+                           0, errp);
         if (ret < 0) {
             goto exit;
         }
     } else if (type =3D=3D VHDX_TYPE_FIXED) {
         ret =3D blk_truncate(blk, data_file_offset + image_size, false,
-                           PREALLOC_MODE_OFF, errp);
+                           PREALLOC_MODE_OFF, 0, errp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vmdk.c b/block/vmdk.c
index 5de99fe813..8ec18f35a5 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2118,7 +2118,7 @@ static int vmdk_init_extent(BlockBackend *blk,
     int gd_buf_size;
=20
     if (flat) {
-        ret =3D blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, errp=
);
+        ret =3D blk_truncate(blk, filesize, false, PREALLOC_MODE_OFF, 0, e=
rrp);
         goto exit;
     }
     magic =3D cpu_to_be32(VMDK4_MAGIC);
@@ -2182,7 +2182,7 @@ static int vmdk_init_extent(BlockBackend *blk,
     }
=20
     ret =3D blk_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false=
,
-                       PREALLOC_MODE_OFF, errp);
+                       PREALLOC_MODE_OFF, 0, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -2523,7 +2523,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t siz=
e,
     /* bdrv_pwrite write padding zeros to align to sector, we don't need t=
hat
      * for description file */
     if (desc_offset =3D=3D 0) {
-        ret =3D blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, errp=
);
+        ret =3D blk_truncate(blk, desc_len, false, PREALLOC_MODE_OFF, 0, e=
rrp);
         if (ret < 0) {
             goto exit;
         }
diff --git a/block/vpc.c b/block/vpc.c
index d8141b52da..2d1eade146 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -898,7 +898,7 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t=
 *buf,
     /* Add footer to total size */
     total_size +=3D HEADER_SIZE;
=20
-    ret =3D blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, total_size, false, PREALLOC_MODE_OFF, 0, err=
p);
     if (ret < 0) {
         return ret;
     }
diff --git a/blockdev.c b/blockdev.c
index 5faddaa705..fbe3a06dbf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2741,7 +2741,7 @@ void qmp_block_resize(bool has_device, const char *de=
vice,
     }
=20
     bdrv_drained_begin(bs);
-    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
     bdrv_drained_end(bs);
=20
 out:
diff --git a/qemu-img.c b/qemu-img.c
index 821cbf610e..7f52742ef2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3866,7 +3866,7 @@ static int img_resize(int argc, char **argv)
      * resizing, so pass @exact=3Dtrue.  It is of no use to report
      * success when the image has not actually been resized.
      */
-    ret =3D blk_truncate(blk, total_size, true, prealloc, &err);
+    ret =3D blk_truncate(blk, total_size, true, prealloc, 0, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
     } else {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 1b7e700020..851f07e8f8 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1715,7 +1715,7 @@ static int truncate_f(BlockBackend *blk, int argc, ch=
ar **argv)
      * exact=3Dtrue.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, &local_err)=
;
+    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, 0, &local_e=
rr);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
--=20
2.25.3


