Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8FCC742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBAC208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBAC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44981 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlfDm-0006UT-FP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlfDP-0005Zq-F4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlfDO-00015w-8m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlfCw-0000pD-HJ; Thu, 11 Jul 2019 15:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D9FE308FFB1;
 Thu, 11 Jul 2019 19:58:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 200CE600D1;
 Thu, 11 Jul 2019 19:58:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 11 Jul 2019 21:58:02 +0200
Message-Id: <20190711195804.30703-4-mreitz@redhat.com>
In-Reply-To: <20190711195804.30703-1-mreitz@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 11 Jul 2019 19:58:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 3/5] block: Fall back to fallback truncate
 function
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

file-posix does not need to basically duplicate our fallback truncate
implementation; and sheepdog can fall back to it for "shrinking" files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 21 +--------------------
 block/sheepdog.c   |  2 +-
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab05b51a66..bcddfc7fbe 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2031,23 +2031,7 @@ static int coroutine_fn raw_co_truncate(BlockDrive=
rState *bs, int64_t offset,
         return raw_regular_truncate(bs, s->fd, offset, prealloc, errp);
     }
=20
-    if (prealloc !=3D PREALLOC_MODE_OFF) {
-        error_setg(errp, "Preallocation mode '%s' unsupported for this "
-                   "non-regular file", PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
-
-    if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
-        if (offset > raw_getlength(bs)) {
-            error_setg(errp, "Cannot grow device files");
-            return -EINVAL;
-        }
-    } else {
-        error_setg(errp, "Resizing this file is not supported");
-        return -ENOTSUP;
-    }
-
-    return 0;
+    return -ENOTSUP;
 }
=20
 #ifdef __OpenBSD__
@@ -3413,7 +3397,6 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
-    .bdrv_co_truncate       =3D raw_co_truncate,
     .bdrv_getlength	=3D raw_getlength,
     .bdrv_get_info =3D raw_get_info,
     .bdrv_get_allocated_file_size
@@ -3537,7 +3520,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
-    .bdrv_co_truncate    =3D raw_co_truncate,
     .bdrv_getlength      =3D raw_getlength,
     .has_variable_length =3D true,
     .bdrv_get_allocated_file_size
@@ -3669,7 +3651,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
=20
-    .bdrv_co_truncate    =3D raw_co_truncate,
     .bdrv_getlength      =3D raw_getlength,
     .has_variable_length =3D true,
     .bdrv_get_allocated_file_size
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 6f402e5d4d..4af4961cb7 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2301,7 +2301,7 @@ static int coroutine_fn sd_co_truncate(BlockDriverS=
tate *bs, int64_t offset,
     max_vdi_size =3D (UINT64_C(1) << s->inode.block_size_shift) * MAX_DA=
TA_OBJS;
     if (offset < old_size) {
         error_setg(errp, "shrinking is not supported");
-        return -EINVAL;
+        return -ENOTSUP;
     } else if (offset > max_vdi_size) {
         error_setg(errp, "too big image size");
         return -EINVAL;
--=20
2.21.0


