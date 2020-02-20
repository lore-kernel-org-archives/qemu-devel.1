Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9259AC11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626EA20658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrQ4eTWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626EA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oS4-0003Ec-Ie
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oQH-0000Za-Dt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oQG-0007CV-74
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oQG-0007CK-2I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zqzb1tFd/mwGWRwOtwMePqgul2Q2QiYxo3u298Fw+l0=;
 b=VrQ4eTWngsIv9sHI5v1Fo8RJJ3VutdzM8A6sLWjSU82I2FtzCuCb/HG0+JUr4gq7MjBG+g
 Fgt7os8UCjLuDl/WrNldYjRww/moTtmvU0qM+6w8YznQIQPwi/gqlNXXo7XSw1ZSC49AI8
 P8WsHM9QGysVeQZekxaa2Z74pnLEs98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-smsJNc8cOXyiy4Cp9k9moQ-1; Thu, 20 Feb 2020 11:11:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F325100550E;
 Thu, 20 Feb 2020 16:11:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E8460BE1;
 Thu, 20 Feb 2020 16:11:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/18] file-posix: Drop hdev_co_create_opts()
Date: Thu, 20 Feb 2020 17:07:04 +0100
Message-Id: <20200220160710.533297-13-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: smsJNc8cOXyiy4Cp9k9moQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic fallback implementation effectively does the same.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200122164532.178040-4-mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 67 ----------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ab82ee1a67..6345477112 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3477,67 +3477,6 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockD=
riverState *bs,
     return raw_do_pwrite_zeroes(bs, offset, bytes, flags, true);
 }
=20
-static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOpts=
 *opts,
-                                            Error **errp)
-{
-    int fd;
-    int ret =3D 0;
-    struct stat stat_buf;
-    int64_t total_size =3D 0;
-    bool has_prefix;
-
-    /* This function is used by both protocol block drivers and therefore =
either
-     * of these prefixes may be given.
-     * The return value has to be stored somewhere, otherwise this is an e=
rror
-     * due to -Werror=3Dunused-value. */
-    has_prefix =3D
-        strstart(filename, "host_device:", &filename) ||
-        strstart(filename, "host_cdrom:" , &filename);
-
-    (void)has_prefix;
-
-    ret =3D raw_normalize_devicepath(&filename, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* Read out options */
-    total_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0)=
,
-                          BDRV_SECTOR_SIZE);
-
-    fd =3D qemu_open(filename, O_WRONLY | O_BINARY);
-    if (fd < 0) {
-        ret =3D -errno;
-        error_setg_errno(errp, -ret, "Could not open device");
-        return ret;
-    }
-
-    if (fstat(fd, &stat_buf) < 0) {
-        ret =3D -errno;
-        error_setg_errno(errp, -ret, "Could not stat device");
-    } else if (!S_ISBLK(stat_buf.st_mode) && !S_ISCHR(stat_buf.st_mode)) {
-        error_setg(errp,
-                   "The given file is neither a block nor a character devi=
ce");
-        ret =3D -ENODEV;
-    } else if (lseek(fd, 0, SEEK_END) < total_size) {
-        error_setg(errp, "Device is too small");
-        ret =3D -ENOSPC;
-    }
-
-    if (!ret && total_size) {
-        uint8_t buf[BDRV_SECTOR_SIZE] =3D { 0 };
-        int64_t zero_size =3D MIN(BDRV_SECTOR_SIZE, total_size);
-        if (lseek(fd, 0, SEEK_SET) =3D=3D -1) {
-            ret =3D -errno;
-        } else {
-            ret =3D qemu_write_full(fd, buf, zero_size);
-            ret =3D ret =3D=3D zero_size ? 0 : -errno;
-        }
-    }
-    qemu_close(fd);
-    return ret;
-}
-
 static BlockDriver bdrv_host_device =3D {
     .format_name        =3D "host_device",
     .protocol_name        =3D "host_device",
@@ -3550,8 +3489,6 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts         =3D &raw_create_opts,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D hdev_co_pwrite_zeroes,
@@ -3678,8 +3615,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts         =3D &raw_create_opts,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
=20
@@ -3812,8 +3747,6 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
-    .bdrv_co_create_opts =3D hdev_co_create_opts,
-    .create_opts        =3D &raw_create_opts,
     .mutable_opts       =3D mutable_opts,
=20
     .bdrv_co_preadv         =3D raw_co_preadv,
--=20
2.24.1


