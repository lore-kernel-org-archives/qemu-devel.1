Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88451CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528F020717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1KFU3pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528F020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP47C-0008IQ-W9
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vp-0001S2-Tj
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vo-0001L2-BS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vo-0001Kc-7X
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TE96eOaW6aiFCYl3gxB+X0JZqjsnCz0s2Kz/h/5Cz9A=;
 b=V1KFU3pH9pHt2tnThGgVgNmhj6FpfBzoZ1uEtw9Bxg9FUfPW9vb96PDARoE1WFA1DYsHNv
 mvozz8evXfGH0FEWLYIOr4Z+ztj5f3mHtI3IRPPDQrD3yfRRPm3FeRGDZ6LmarQuDS1P7C
 ZnCKoI9DDpBK4BpxGrQ06lNwOVx5vDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-rQJv7L6eNgiDWFeqWjFTTQ-1; Mon, 28 Oct 2019 08:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB8A6107AD29;
 Mon, 28 Oct 2019 12:15:28 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 523C11001B03;
 Mon, 28 Oct 2019 12:15:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/69] Revert "mirror: Only mirror granularity-aligned chunks"
Date: Mon, 28 Oct 2019 13:14:04 +0100
Message-Id: <20191028121501.15279-13-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rQJv7L6eNgiDWFeqWjFTTQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This reverts commit 9adc1cb49af8d4e54f57980b1eed5c0a4b2dafa6.
    "mirror: Only mirror granularity-aligned chunks"

Since previous commit unaligned chunks are supported by
do_sync_target_write.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191011090711.19940-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 11d4d66f43..454365ce00 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1488,15 +1488,6 @@ static void bdrv_mirror_top_child_perm(BlockDriverSt=
ate *bs, BdrvChild *c,
     *nshared =3D BLK_PERM_ALL;
 }
=20
-static void bdrv_mirror_top_refresh_limits(BlockDriverState *bs, Error **e=
rrp)
-{
-    MirrorBDSOpaque *s =3D bs->opaque;
-
-    if (s && s->job && s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_BLO=
CKING) {
-        bs->bl.request_alignment =3D s->job->granularity;
-    }
-}
-
 /* Dummy node that provides consistent read to its users without requiring=
 it
  * from its backing file and that allows writes on the backing file chain.=
 */
 static BlockDriver bdrv_mirror_top =3D {
@@ -1509,7 +1500,6 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
-    .bdrv_refresh_limits        =3D bdrv_mirror_top_refresh_limits,
 };
=20
 static BlockJob *mirror_start_job(
@@ -1657,25 +1647,6 @@ static BlockJob *mirror_start_job(
         s->should_complete =3D true;
     }
=20
-    /*
-     * Must be called before we start tracking writes, but after
-     *
-     *     ((MirrorBlockJob *)
-     *         ((MirrorBDSOpaque *)
-     *             mirror_top_bs->opaque
-     *         )->job
-     *     )->copy_mode
-     *
-     * has the correct value.
-     * (We start tracking writes as of the following
-     * bdrv_create_dirty_bitmap() call.)
-     */
-    bdrv_refresh_limits(mirror_top_bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
     s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, NULL, er=
rp);
     if (!s->dirty_bitmap) {
         goto fail;
--=20
2.21.0


