Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64CC11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD8420659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiJ3OhKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD8420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oYI-0005ds-VC
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oQW-0000ez-42
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oQU-0007Ep-7K
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oQU-0007DF-2x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUx1jkzn2LXx673KdYZrWkQgEj1mTKxfCWKAh53agL8=;
 b=iiJ3OhKs/O7XE9oWSfzq+F1sdhAPA+DMv/+Z4jBulBAFjO/KyU6KiyCwD24+F0CA6jFVtT
 rmU4/GOlKAmg227cKrG62TIH/GNqneUYtL0d2X03y3/rvUjqRGptE+UbJFuRiPPZjy9R17
 IbrHkQBI8EstY+hWI66bmFBgttpbfu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-TKwBCt8NOOuT1vOKRkTYkg-1; Thu, 20 Feb 2020 11:11:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3BD7802700;
 Thu, 20 Feb 2020 16:11:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C03F5DA7B;
 Thu, 20 Feb 2020 16:11:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/18] iscsi: Drop iscsi_co_create_opts()
Date: Thu, 20 Feb 2020 17:07:05 +0100
Message-Id: <20200220160710.533297-14-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TKwBCt8NOOuT1vOKRkTYkg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic fallback implementation effectively does the same.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200122164532.178040-5-mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/iscsi.c | 56 ---------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index c8feaa2f0e..682abd8e09 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2164,58 +2164,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDrive=
rState *bs, int64_t offset,
     return 0;
 }
=20
-static int coroutine_fn iscsi_co_create_opts(const char *filename, QemuOpt=
s *opts,
-                                             Error **errp)
-{
-    int ret =3D 0;
-    int64_t total_size =3D 0;
-    BlockDriverState *bs;
-    IscsiLun *iscsilun =3D NULL;
-    QDict *bs_options;
-    Error *local_err =3D NULL;
-
-    bs =3D bdrv_new();
-
-    /* Read out options */
-    total_size =3D DIV_ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),
-                              BDRV_SECTOR_SIZE);
-    bs->opaque =3D g_new0(struct IscsiLun, 1);
-    iscsilun =3D bs->opaque;
-
-    bs_options =3D qdict_new();
-    iscsi_parse_filename(filename, bs_options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret =3D -EINVAL;
-    } else {
-        ret =3D iscsi_open(bs, bs_options, 0, NULL);
-    }
-    qobject_unref(bs_options);
-
-    if (ret !=3D 0) {
-        goto out;
-    }
-    iscsi_detach_aio_context(bs);
-    if (iscsilun->type !=3D TYPE_DISK) {
-        ret =3D -ENODEV;
-        goto out;
-    }
-    if (bs->total_sectors < total_size) {
-        ret =3D -ENOSPC;
-        goto out;
-    }
-
-    ret =3D 0;
-out:
-    if (iscsilun->iscsi !=3D NULL) {
-        iscsi_destroy_context(iscsilun->iscsi);
-    }
-    g_free(bs->opaque);
-    bs->opaque =3D NULL;
-    bdrv_unref(bs);
-    return ret;
-}
-
 static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun =3D bs->opaque;
@@ -2486,8 +2434,6 @@ static BlockDriver bdrv_iscsi =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
-    .bdrv_co_create_opts    =3D iscsi_co_create_opts,
-    .create_opts            =3D &iscsi_create_opts,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache =3D iscsi_co_invalidate_cache,
@@ -2525,8 +2471,6 @@ static BlockDriver bdrv_iser =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
-    .bdrv_co_create_opts    =3D iscsi_co_create_opts,
-    .create_opts            =3D &iscsi_create_opts,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache  =3D iscsi_co_invalidate_cache,
--=20
2.24.1


