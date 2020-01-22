Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C465FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E77E21569
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxxeSyL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E77E21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJEe-0004Ls-OB
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8c-0007nQ-NS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8b-0000lY-I3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31923
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuJ8b-0000lG-EQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WG+3NIFI5iBLwsyY11oLZVmAnXt1xJP+awVDgFDPxRA=;
 b=YxxeSyL2cRR1znDBK0vckyGJdpT+aU/0tsMQfpckP3nTzaD5beqVsAtpy/+WWnhy3mWC7e
 ndkwqpGsWTtiuLF7RCYA1JvFrfJem5ms+HQSIkBGgbd4i3YGOwckInmzglOHheh5oYmkQ3
 YUGh1EPtyJ65feRmLgZ0Xoyh+u/GyIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-qM6cps8BPKm0NE1Qpbz7gg-1; Wed, 22 Jan 2020 11:45:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8BEB19057D1;
 Wed, 22 Jan 2020 16:45:47 +0000 (UTC)
Received: from localhost (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 334EC8BE31;
 Wed, 22 Jan 2020 16:45:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/5] iscsi: Drop iscsi_co_create_opts()
Date: Wed, 22 Jan 2020 17:45:31 +0100
Message-Id: <20200122164532.178040-5-mreitz@redhat.com>
In-Reply-To: <20200122164532.178040-1-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qM6cps8BPKm0NE1Qpbz7gg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic fallback implementation effectively does the same.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/iscsi.c | 56 ---------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2aea7e3f13..68562e108f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2163,58 +2163,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDrive=
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
@@ -2485,8 +2433,6 @@ static BlockDriver bdrv_iscsi =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
-    .bdrv_co_create_opts    =3D iscsi_co_create_opts,
-    .create_opts            =3D &iscsi_create_opts,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache =3D iscsi_co_invalidate_cache,
@@ -2524,8 +2470,6 @@ static BlockDriver bdrv_iser =3D {
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


