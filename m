Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F7EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A0E206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0oyLrTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaUZ-0001df-IX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLj-00038N-OS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLg-0004bi-OF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLg-0004aH-Gi
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZotFooN7bPDhLT6K4q2mFBHquGbMfqpaB4DciS50rM=;
 b=B0oyLrTtR2OcBexazd6vi2ggJXrfYUTX83594fCH6IzGXk5MyvzawwywRY4bFB3YBBe49M
 vjPJNZiZCRUHIhtjjSYevcTTuMn+FXl7+K76mymXvCEgFQO++k2yiCsm5SmSIgbpN56Udk
 6BTP8P6cXhJvxZLv+0BHSwuYMUPuZLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-kBELA9_wMjS6MkzhPjSqJw-1; Fri, 31 Jan 2020 12:44:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A240F800D48;
 Fri, 31 Jan 2020 17:44:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 453CE863AD;
 Fri, 31 Jan 2020 17:44:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
Date: Fri, 31 Jan 2020 11:44:28 -0600
Message-Id: <20200131174436.2961874-10-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kBELA9_wMjS6MkzhPjSqJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 mreitz@redhat.com, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, Jason Dillaman <dillaman@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having two slightly-different function names for related purposes is
unwieldy, especially since I envision adding yet another notion of
zero support in an upcoming patch.  It doesn't help that
bdrv_has_zero_init() is a misleading name (I originally thought that a
driver could only return 1 when opening an already-existing image
known to be all zeroes; but in reality many drivers always return 1
because it only applies to a just-created image).  Refactor all uses
to instead have a single function that returns multiple bits of
information, with better naming and documentation.

No semantic change, although some of the changes (such as to qcow2.c)
require a careful reading to see how it remains the same.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c                    | 49 ++++++++++++++------------------------
 block/file-posix.c         |  3 +--
 block/file-win32.c         |  3 +--
 block/nfs.c                |  7 +++---
 block/parallels.c          |  4 ++--
 block/qcow.c               |  2 +-
 block/qcow2.c              | 10 ++++----
 block/qed.c                |  3 +--
 block/raw-format.c         | 12 +++-------
 block/rbd.c                |  3 +--
 block/sheepdog.c           |  9 +++----
 block/ssh.c                |  7 +++---
 block/vdi.c                |  8 +++----
 block/vhdx.c               | 16 ++++++-------
 block/vmdk.c               |  9 +++----
 block/vpc.c                |  8 +++----
 blockdev.c                 |  2 +-
 include/block/block.h      | 28 +++++++++++++++++++---
 include/block/block_int.h  | 15 ++----------
 qemu-img.c                 |  3 ++-
 tests/qemu-iotests/122     |  2 +-
 tests/qemu-iotests/188     |  2 +-
 tests/qemu-iotests/188.out |  2 +-
 23 files changed, 96 insertions(+), 111 deletions(-)

diff --git a/block.c b/block.c
index d132662f3103..fac0813140aa 100644
--- a/block.c
+++ b/block.c
@@ -5066,38 +5066,20 @@ int bdrv_get_flags(BlockDriverState *bs)
     return bs->open_flags;
 }

-int bdrv_has_zero_init_1(BlockDriverState *bs)
+int bdrv_known_zeroes_create(BlockDriverState *bs)
 {
-    return 1;
+    return BDRV_ZERO_CREATE;
 }

-int bdrv_has_zero_init(BlockDriverState *bs)
+int bdrv_known_zeroes_truncate(BlockDriverState *bs)
 {
-    if (!bs->drv) {
-        return 0;
-    }
-
-    /*
-     * If BS is a copy on write image, it is initialized to the
-     * contents of the base image, which may not be zeroes.  Likewise,
-     * encrypted images do not read as zero.
-     */
-    if (bs->backing || bs->encrypted) {
-        return 0;
-    }
-    if (bs->drv->bdrv_has_zero_init) {
-        return bs->drv->bdrv_has_zero_init(bs);
-    }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init(bs->file->bs);
-    }
-
-    /* safe default */
-    return 0;
+    return BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
 }

-int bdrv_has_zero_init_truncate(BlockDriverState *bs)
+int bdrv_known_zeroes(BlockDriverState *bs)
 {
+    int mask =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
+
     if (!bs->drv) {
         return 0;
     }
@@ -5113,9 +5095,12 @@ int bdrv_has_zero_init_truncate(BlockDriverState *bs=
)
     }

     /*
-     * If the current layer is smaller than the backing layer,
-     * truncation may expose backing data; treat failure to query size
-     * in the same manner. Otherwise, we can trust the driver.
+     * If BS is a copy on write image, it is initialized to the
+     * contents of the base image, which may not be zeroes, so
+     * ZERO_CREATE is not viable.  If the current layer is smaller
+     * than the backing layer, truncation may expose backing data,
+     * restricting ZERO_TRUNCATE; treat failure to query size in the
+     * same manner.  Otherwise, we can trust the driver.
      */

     if (bs->backing) {
@@ -5125,12 +5110,14 @@ int bdrv_has_zero_init_truncate(BlockDriverState *b=
s)
         if (back < 0 || curr < back) {
             return 0;
         }
+        mask =3D BDRV_ZERO_TRUNCATE;
     }
-    if (bs->drv->bdrv_has_zero_init_truncate) {
-        return bs->drv->bdrv_has_zero_init_truncate(bs);
+
+    if (bs->drv->bdrv_known_zeroes) {
+        return bs->drv->bdrv_known_zeroes(bs) & mask;
     }
     if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init_truncate(bs->file->bs);
+        return bdrv_known_zeroes(bs->file->bs) & mask;
     }

     /* safe default */
diff --git a/block/file-posix.c b/block/file-posix.c
index ab82ee1a6718..ff9e39ab882f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3071,8 +3071,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_close =3D raw_close,
     .bdrv_co_create =3D raw_co_create,
     .bdrv_co_create_opts =3D raw_co_create_opts,
-    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes =3D bdrv_known_zeroes_truncate,
     .bdrv_co_block_status =3D raw_co_block_status,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D raw_co_pwrite_zeroes,
diff --git a/block/file-win32.c b/block/file-win32.c
index 77e8ff7b68ae..e9b8f3b2370b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -635,8 +635,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_refresh_limits =3D raw_probe_alignment,
     .bdrv_close         =3D raw_close,
     .bdrv_co_create_opts =3D raw_co_create_opts,
-    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes  =3D bdrv_known_zeroes_truncate,

     .bdrv_aio_preadv    =3D raw_aio_preadv,
     .bdrv_aio_pwritev   =3D raw_aio_pwritev,
diff --git a/block/nfs.c b/block/nfs.c
index 9a6311e27066..34ebe91d5b39 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -702,10 +702,10 @@ out:
     return ret;
 }

-static int nfs_has_zero_init(BlockDriverState *bs)
+static int nfs_known_zeroes(BlockDriverState *bs)
 {
     NFSClient *client =3D bs->opaque;
-    return client->has_zero_init;
+    return client->has_zero_init ? BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE :=
 0;
 }

 /* Called (via nfs_service) with QemuMutex held.  */
@@ -869,8 +869,7 @@ static BlockDriver bdrv_nfs =3D {
     .bdrv_parse_filename            =3D nfs_parse_filename,
     .create_opts                    =3D &nfs_create_opts,

-    .bdrv_has_zero_init             =3D nfs_has_zero_init,
-    .bdrv_has_zero_init_truncate    =3D nfs_has_zero_init,
+    .bdrv_known_zeroes              =3D nfs_known_zeroes,
     .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
     .bdrv_co_truncate               =3D nfs_file_co_truncate,

diff --git a/block/parallels.c b/block/parallels.c
index 7a01997659b0..dad6389c8481 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -835,7 +835,7 @@ static int parallels_open(BlockDriverState *bs, QDict *=
options, int flags,
         goto fail_options;
     }

-    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
+    if (!(bdrv_known_zeroes(bs->file->bs) & BDRV_ZERO_TRUNCATE)) {
         s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
     }

@@ -906,7 +906,7 @@ static BlockDriver bdrv_parallels =3D {
     .bdrv_close=09=09=3D parallels_close,
     .bdrv_child_perm          =3D bdrv_format_default_perms,
     .bdrv_co_block_status     =3D parallels_co_block_status,
-    .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes        =3D bdrv_known_zeroes_create,
     .bdrv_co_flush_to_os      =3D parallels_co_flush_to_os,
     .bdrv_co_readv  =3D parallels_co_readv,
     .bdrv_co_writev =3D parallels_co_writev,
diff --git a/block/qcow.c b/block/qcow.c
index fce89898681f..b0c9e212fdb1 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1183,7 +1183,7 @@ static BlockDriver bdrv_qcow =3D {
     .bdrv_reopen_prepare    =3D qcow_reopen_prepare,
     .bdrv_co_create         =3D qcow_co_create,
     .bdrv_co_create_opts    =3D qcow_co_create_opts,
-    .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes      =3D bdrv_known_zeroes_create,
     .supports_backing       =3D true,
     .bdrv_refresh_limits    =3D qcow_refresh_limits,

diff --git a/block/qcow2.c b/block/qcow2.c
index 40aa751d1de7..9f2371925737 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4914,10 +4914,11 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs,
     return spec_info;
 }

-static int qcow2_has_zero_init(BlockDriverState *bs)
+static int qcow2_known_zeroes(BlockDriverState *bs)
 {
     BDRVQcow2State *s =3D bs->opaque;
     bool preallocated;
+    int r =3D BDRV_ZERO_TRUNCATE;

     if (qemu_in_coroutine()) {
         qemu_co_mutex_lock(&s->lock);
@@ -4933,9 +4934,9 @@ static int qcow2_has_zero_init(BlockDriverState *bs)
     }

     if (!preallocated) {
-        return 1;
+        return r | BDRV_ZERO_CREATE;
     } else {
-        return bdrv_has_zero_init(s->data_file->bs);
+        return r | bdrv_known_zeroes(s->data_file->bs);
     }
 }

@@ -5559,8 +5560,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_child_perm      =3D bdrv_format_default_perms,
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
-    .bdrv_has_zero_init   =3D qcow2_has_zero_init,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes    =3D qcow2_known_zeroes,
     .bdrv_co_block_status =3D qcow2_co_block_status,

     .bdrv_co_preadv_part    =3D qcow2_co_preadv_part,
diff --git a/block/qed.c b/block/qed.c
index d8c4e5fb1e85..b00cef2035b3 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1672,8 +1672,7 @@ static BlockDriver bdrv_qed =3D {
     .bdrv_child_perm          =3D bdrv_format_default_perms,
     .bdrv_co_create           =3D bdrv_qed_co_create,
     .bdrv_co_create_opts      =3D bdrv_qed_co_create_opts,
-    .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes        =3D bdrv_known_zeroes_truncate,
     .bdrv_co_block_status     =3D bdrv_qed_co_block_status,
     .bdrv_co_readv            =3D bdrv_qed_co_readv,
     .bdrv_co_writev           =3D bdrv_qed_co_writev,
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a76ec7dd21b..1334a7a2c224 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -409,14 +409,9 @@ static int raw_co_ioctl(BlockDriverState *bs, unsigned=
 long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }

-static int raw_has_zero_init(BlockDriverState *bs)
+static int raw_known_zeroes(BlockDriverState *bs)
 {
-    return bdrv_has_zero_init(bs->file->bs);
-}
-
-static int raw_has_zero_init_truncate(BlockDriverState *bs)
-{
-    return bdrv_has_zero_init_truncate(bs->file->bs);
+    return bdrv_known_zeroes(bs->file->bs);
 }

 static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts =
*opts,
@@ -577,8 +572,7 @@ BlockDriver bdrv_raw =3D {
     .bdrv_lock_medium     =3D &raw_lock_medium,
     .bdrv_co_ioctl        =3D &raw_co_ioctl,
     .create_opts          =3D &raw_create_opts,
-    .bdrv_has_zero_init   =3D &raw_has_zero_init,
-    .bdrv_has_zero_init_truncate =3D &raw_has_zero_init_truncate,
+    .bdrv_known_zeroes    =3D &raw_known_zeroes,
     .strong_runtime_opts  =3D raw_strong_runtime_opts,
     .mutable_opts         =3D mutable_opts,
 };
diff --git a/block/rbd.c b/block/rbd.c
index 027cbcc69520..6cd8e86bccec 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1289,8 +1289,7 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_reopen_prepare    =3D qemu_rbd_reopen_prepare,
     .bdrv_co_create         =3D qemu_rbd_co_create,
     .bdrv_co_create_opts    =3D qemu_rbd_co_create_opts,
-    .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes      =3D bdrv_known_zeroes_truncate,
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 522c16a93676..916e64abdd74 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3229,8 +3229,7 @@ static BlockDriver bdrv_sheepdog =3D {
     .bdrv_close                   =3D sd_close,
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
-    .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes            =3D bdrv_known_zeroes_truncate,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3268,8 +3267,7 @@ static BlockDriver bdrv_sheepdog_tcp =3D {
     .bdrv_close                   =3D sd_close,
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
-    .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes            =3D bdrv_known_zeroes_truncate,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3307,8 +3305,7 @@ static BlockDriver bdrv_sheepdog_unix =3D {
     .bdrv_close                   =3D sd_close,
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
-    .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
-    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
+    .bdrv_known_zeroes            =3D bdrv_known_zeroes_truncate,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
diff --git a/block/ssh.c b/block/ssh.c
index b4375cf7d2e5..e89dae39800c 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1007,14 +1007,14 @@ static void ssh_close(BlockDriverState *bs)
     ssh_state_free(s);
 }

-static int ssh_has_zero_init(BlockDriverState *bs)
+static int ssh_known_zeroes(BlockDriverState *bs)
 {
     BDRVSSHState *s =3D bs->opaque;
     /* Assume false, unless we can positively prove it's true. */
     int has_zero_init =3D 0;

     if (s->attrs->type =3D=3D SSH_FILEXFER_TYPE_REGULAR) {
-        has_zero_init =3D 1;
+        has_zero_init =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
     }

     return has_zero_init;
@@ -1390,8 +1390,7 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_co_create               =3D ssh_co_create,
     .bdrv_co_create_opts          =3D ssh_co_create_opts,
     .bdrv_close                   =3D ssh_close,
-    .bdrv_has_zero_init           =3D ssh_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D ssh_has_zero_init,
+    .bdrv_known_zeroes            =3D ssh_known_zeroes,
     .bdrv_co_readv                =3D ssh_co_readv,
     .bdrv_co_writev               =3D ssh_co_writev,
     .bdrv_getlength               =3D ssh_getlength,
diff --git a/block/vdi.c b/block/vdi.c
index 0142da723315..df8f62624ccf 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -989,14 +989,14 @@ static void vdi_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }

-static int vdi_has_zero_init(BlockDriverState *bs)
+static int vdi_known_zeroes(BlockDriverState *bs)
 {
     BDRVVdiState *s =3D bs->opaque;

     if (s->header.image_type =3D=3D VDI_TYPE_STATIC) {
-        return bdrv_has_zero_init(bs->file->bs);
+        return bdrv_known_zeroes(bs->file->bs) & BDRV_ZERO_CREATE;
     } else {
-        return 1;
+        return BDRV_ZERO_CREATE;
     }
 }

@@ -1040,7 +1040,7 @@ static BlockDriver bdrv_vdi =3D {
     .bdrv_child_perm          =3D bdrv_format_default_perms,
     .bdrv_co_create      =3D vdi_co_create,
     .bdrv_co_create_opts =3D vdi_co_create_opts,
-    .bdrv_has_zero_init  =3D vdi_has_zero_init,
+    .bdrv_known_zeroes   =3D vdi_known_zeroes,
     .bdrv_co_block_status =3D vdi_co_block_status,
     .bdrv_make_empty =3D vdi_make_empty,

diff --git a/block/vhdx.c b/block/vhdx.c
index f02d2611bef8..4e8320c1b855 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1365,7 +1365,7 @@ static coroutine_fn int vhdx_co_writev(BlockDriverSta=
te *bs, int64_t sector_num,
                 /* Queue another write of zero buffers if the underlying f=
ile
                  * does not zero-fill on file extension */

-                if (bdrv_has_zero_init_truncate(bs->file->bs) =3D=3D 0) {
+                if (!(bdrv_known_zeroes(bs->file->bs) & BDRV_ZERO_TRUNCATE=
)) {
                     use_zero_buffers =3D true;

                     /* zero fill the front, if any */
@@ -1720,8 +1720,8 @@ static int vhdx_create_bat(BlockBackend *blk, BDRVVHD=
XState *s,
     }

     if (type =3D=3D VHDX_TYPE_FIXED ||
-                use_zero_blocks ||
-                bdrv_has_zero_init(blk_bs(blk)) =3D=3D 0) {
+        use_zero_blocks ||
+        !(bdrv_known_zeroes(blk_bs(blk)) & BDRV_ZERO_CREATE)) {
         /* for a fixed file, the default BAT entry is not zero */
         s->bat =3D g_try_malloc0(length);
         if (length && s->bat =3D=3D NULL) {
@@ -2162,7 +2162,7 @@ static int coroutine_fn vhdx_co_check(BlockDriverStat=
e *bs,
     return 0;
 }

-static int vhdx_has_zero_init(BlockDriverState *bs)
+static int vhdx_known_zeroes(BlockDriverState *bs)
 {
     BDRVVHDXState *s =3D bs->opaque;
     int state;
@@ -2173,17 +2173,17 @@ static int vhdx_has_zero_init(BlockDriverState *bs)
      * therefore enough to check the first BAT entry.
      */
     if (!s->bat_entries) {
-        return 1;
+        return BDRV_ZERO_CREATE;
     }

     state =3D s->bat[0] & VHDX_BAT_STATE_BIT_MASK;
     if (state =3D=3D PAYLOAD_BLOCK_FULLY_PRESENT) {
         /* Fixed subformat */
-        return bdrv_has_zero_init(bs->file->bs);
+        return bdrv_known_zeroes(bs->file->bs) & BDRV_ZERO_CREATE;
     }

     /* Dynamic subformat */
-    return 1;
+    return BDRV_ZERO_CREATE;
 }

 static QemuOptsList vhdx_create_opts =3D {
@@ -2239,7 +2239,7 @@ static BlockDriver bdrv_vhdx =3D {
     .bdrv_co_create_opts    =3D vhdx_co_create_opts,
     .bdrv_get_info          =3D vhdx_get_info,
     .bdrv_co_check          =3D vhdx_co_check,
-    .bdrv_has_zero_init     =3D vhdx_has_zero_init,
+    .bdrv_known_zeroes      =3D vhdx_known_zeroes,

     .create_opts            =3D &vhdx_create_opts,
 };
diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d99794..ca59f50413d2 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2815,7 +2815,7 @@ static int64_t vmdk_get_allocated_file_size(BlockDriv=
erState *bs)
     return ret;
 }

-static int vmdk_has_zero_init(BlockDriverState *bs)
+static int vmdk_known_zeroes(BlockDriverState *bs)
 {
     int i;
     BDRVVmdkState *s =3D bs->opaque;
@@ -2824,12 +2824,13 @@ static int vmdk_has_zero_init(BlockDriverState *bs)
      * return 0. */
     for (i =3D 0; i < s->num_extents; i++) {
         if (s->extents[i].flat) {
-            if (!bdrv_has_zero_init(s->extents[i].file->bs)) {
+            if (!(bdrv_known_zeroes(s->extents[i].file->bs) &
+                  BDRV_ZERO_CREATE)) {
                 return 0;
             }
         }
     }
-    return 1;
+    return BDRV_ZERO_CREATE;
 }

 static ImageInfo *vmdk_get_extent_info(VmdkExtent *extent)
@@ -3052,7 +3053,7 @@ static BlockDriver bdrv_vmdk =3D {
     .bdrv_co_flush_to_disk        =3D vmdk_co_flush,
     .bdrv_co_block_status         =3D vmdk_co_block_status,
     .bdrv_get_allocated_file_size =3D vmdk_get_allocated_file_size,
-    .bdrv_has_zero_init           =3D vmdk_has_zero_init,
+    .bdrv_known_zeroes            =3D vmdk_known_zeroes,
     .bdrv_get_specific_info       =3D vmdk_get_specific_info,
     .bdrv_refresh_limits          =3D vmdk_refresh_limits,
     .bdrv_get_info                =3D vmdk_get_info,
diff --git a/block/vpc.c b/block/vpc.c
index a65550298e19..f4741e07bfb2 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1173,15 +1173,15 @@ fail:
 }


-static int vpc_has_zero_init(BlockDriverState *bs)
+static int vpc_known_zeroes(BlockDriverState *bs)
 {
     BDRVVPCState *s =3D bs->opaque;
     VHDFooter *footer =3D  (VHDFooter *) s->footer_buf;

     if (be32_to_cpu(footer->type) =3D=3D VHD_FIXED) {
-        return bdrv_has_zero_init(bs->file->bs);
+        return bdrv_known_zeroes(bs->file->bs) & BDRV_ZERO_CREATE;
     } else {
-        return 1;
+        return BDRV_ZERO_CREATE;
     }
 }

@@ -1249,7 +1249,7 @@ static BlockDriver bdrv_vpc =3D {
     .bdrv_get_info          =3D vpc_get_info,

     .create_opts            =3D &vpc_create_opts,
-    .bdrv_has_zero_init     =3D vpc_has_zero_init,
+    .bdrv_known_zeroes      =3D vpc_known_zeroes,
     .strong_runtime_opts    =3D vpc_strong_runtime_opts,
 };

diff --git a/blockdev.c b/blockdev.c
index c6a727cca99d..90a17e7f7bce 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4001,7 +4001,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)

     zero_target =3D (arg->sync =3D=3D MIRROR_SYNC_MODE_FULL &&
                    (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
-                    !bdrv_has_zero_init(target_bs)));
+                    !(bdrv_known_zeroes(target_bs) & BDRV_ZERO_CREATE)));


     /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
diff --git a/include/block/block.h b/include/block/block.h
index 6cd566324d95..a6a227f50678 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -85,6 +85,28 @@ typedef enum {
     BDRV_REQ_MASK               =3D 0x3ff,
 } BdrvRequestFlags;

+typedef enum {
+    /*
+     * bdrv_known_zeroes() should include this bit if the contents of
+     * a freshly-created image with no backing file reads as all
+     * zeroes without any additional effort.  If .bdrv_co_truncate is
+     * set, then this must be clear if BDRV_ZERO_TRUNCATE is clear.
+     * Since this bit is only reliable at image creation, a driver may
+     * return this bit even for existing images that do not currently
+     * read as zero.
+     */
+    BDRV_ZERO_CREATE        =3D 0x1,
+
+    /*
+     * bdrv_known_zeroes() should include this bit if growing an image
+     * with PREALLOC_MODE_OFF (either with no backing file, or beyond
+     * the size of the backing file) will read the new data as all
+     * zeroes without any additional effort.  This bit only matters
+     * for drivers that set .bdrv_co_truncate.
+     */
+    BDRV_ZERO_TRUNCATE      =3D 0x2,
+} BdrvZeroFlags;
+
 typedef struct BlockSizes {
     uint32_t phys;
     uint32_t log;
@@ -430,9 +452,9 @@ void bdrv_drain_all(void);

 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
-int bdrv_has_zero_init_1(BlockDriverState *bs);
-int bdrv_has_zero_init(BlockDriverState *bs);
-int bdrv_has_zero_init_truncate(BlockDriverState *bs);
+int bdrv_known_zeroes_create(BlockDriverState *bs);
+int bdrv_known_zeroes_truncate(BlockDriverState *bs);
+int bdrv_known_zeroes(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 77ab45dc87cf..47b34860bf95 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -441,19 +441,8 @@ struct BlockDriver {

     void (*bdrv_refresh_limits)(BlockDriverState *bs, Error **errp);

-    /*
-     * Returns 1 if newly created images are guaranteed to contain only
-     * zeros, 0 otherwise.
-     * Must return 0 if .bdrv_co_truncate is set and
-     * .bdrv_has_zero_init_truncate() returns 0.
-     */
-    int (*bdrv_has_zero_init)(BlockDriverState *bs);
-
-    /*
-     * Returns 1 if new areas added by growing the image with
-     * PREALLOC_MODE_OFF contain only zeros, 0 otherwise.
-     */
-    int (*bdrv_has_zero_init_truncate)(BlockDriverState *bs);
+    /* Returns bitwise-OR of BdrvZeroFlags. */
+    int (*bdrv_known_zeroes)(BlockDriverState *bs);

     /* Remove fd handlers, timers, and other event loop callbacks so the e=
vent
      * loop is no longer in use.  Called with no in-flight requests and in
diff --git a/qemu-img.c b/qemu-img.c
index e0bfc33ef4f6..e60217e6c382 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1987,7 +1987,8 @@ static int convert_do_copy(ImgConvertState *s)
     /* Check whether we have zero initialisation or can get it efficiently=
 */
     if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
         !s->target_has_backing) {
-        s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
+        s->has_zero_init =3D !!(bdrv_known_zeroes(blk_bs(s->target)) &
+                              BDRV_ZERO_CREATE);
     }

     if (!s->has_zero_init && !s->target_has_backing &&
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index dfa350936fe6..7cb09309948f 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -267,7 +267,7 @@ echo
 # Keep source zero
 _make_test_img 64M

-# Output is not zero, but has bdrv_has_zero_init() =3D=3D 1
+# Output is not zero, but has bdrv_known_zeroes() including BDRV_ZERO_CREA=
TE
 TEST_IMG=3D"$TEST_IMG".orig _make_test_img 64M
 $QEMU_IO -c "write -P 42 0 64k" "$TEST_IMG".orig | _filter_qemu_io

diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index afca44df5427..9656969fef4a 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -71,7 +71,7 @@ $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --i=
mage-opts $IMGSPEC | _f
 _cleanup_test_img

 echo
-echo "=3D=3D verify that has_zero_init returns false when preallocating =
=3D=3D"
+echo "=3D=3D verify that known_zeroes returns 0 when preallocating =3D=3D"

 # Empty source file
 if [ -n "$TEST_IMG_FILE" ]; then
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef370145..f7da30440c65 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -16,7 +16,7 @@ read 16777216/16777216 bytes at offset 0
 =3D=3D verify open failure with wrong password =3D=3D
 qemu-io: can't open: Invalid password, cannot unlock any keyslot

-=3D=3D verify that has_zero_init returns false when preallocating =3D=3D
+=3D=3D verify that known_zeroes returns 0 when preallocating =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D16777216
 Images are identical.
 *** done
--=20
2.24.1


