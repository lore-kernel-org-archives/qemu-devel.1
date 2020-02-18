Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3600A20722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L73UJ6Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3600A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43Yi-0000OB-EK
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xe-0006pK-Pw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xd-0001OA-Gh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49489
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xd-0001Nz-DI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoHRYn0ddHGPZPzr3V33ur7osgG+95vDlfAmZvJ+gaU=;
 b=L73UJ6Ze6/nrLJleL3CC42BVubpEoMc/nMVtHpLgDu2lNCKNOjjKT5MJu98myXMgwvB9Dt
 g+YbW0rCuVC6IBK1u+g3AmIdtj0k+U3GYmnIhVcK88GRKs/3OJebhdXllLUqdtpZ6veW0s
 +4Drq2zTKnA/e/l4pzLj55V268ChMzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-hWnM10f4MoKHb5DMA2s0Fg-1; Tue, 18 Feb 2020 09:07:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44008801A2B;
 Tue, 18 Feb 2020 14:07:57 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 433D88B740;
 Tue, 18 Feb 2020 14:07:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/36] block/vvfat: Do not unref qcow on closing backing bdrv
Date: Tue, 18 Feb 2020 15:06:50 +0100
Message-Id: <20200218140722.23876-5-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hWnM10f4MoKHb5DMA2s0Fg-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hikaru Nishida <hikarupsp@gmail.com>

Before this commit, BDRVVVFATState.qcow is unrefed in write_target_close
on closing backing bdrv of vvfat. However, qcow bdrv is opend as a child
of vvfat in enable_write_target() so it will be also unrefed on closing
vvfat itself. This causes use-after-free of qcow on freeing vvfat which
has backing bdrv and qcow bdrv as children in this order because
bdrv_close(vvfat) tries to free qcow bdrv after freeing backing bdrv
as QLIST_FOREACH_SAFE() loop keeps next pointer, but BdrvChild of qcow
is already freed in bdrv_close(backing bdrv).

Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
Message-Id: <20200209175156.85748-1-hikarupsp@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 019b8f1341..ab800c4887 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3124,17 +3124,10 @@ write_target_commit(BlockDriverState *bs, uint64_t =
offset, uint64_t bytes,
     return ret;
 }
=20
-static void write_target_close(BlockDriverState *bs) {
-    BDRVVVFATState* s =3D *((BDRVVVFATState**) bs->opaque);
-    bdrv_unref_child(s->bs, s->qcow);
-    g_free(s->qcow_filename);
-}
-
 static BlockDriver vvfat_write_target =3D {
     .format_name        =3D "vvfat_write_target",
     .instance_size      =3D sizeof(void*),
     .bdrv_co_pwritev    =3D write_target_commit,
-    .bdrv_close         =3D write_target_close,
 };
=20
 static void vvfat_qcow_options(int *child_flags, QDict *child_options,
--=20
2.20.1


