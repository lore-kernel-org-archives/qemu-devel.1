Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC52020659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtapTHcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Mn-0003oq-PT
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42EH-00065E-Qt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42EG-0001dJ-N7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42EG-0001d4-K5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9R9D82BvGJtOvztaohbyH9D3AYAi5Fj2oz0KyoS6kYw=;
 b=RtapTHcDOLNGlshRtC7bIwRESGFeZi/Wo2t9BQXYIq4u0p7Xr7M+3vpqwb+M49nhs2F1kM
 022QONwgQGAbRkH0Zce15Fh/AZsihUCKhp/sLSpJkWHRALadqsHAylPbw/7aY26jsLIU7R
 JrcI19BEEsnldUAb+HAkQ3hvDX7cu1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-0V3k4Bf9PJS7pjWScHOfIQ-1; Tue, 18 Feb 2020 07:43:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D03E8010E5;
 Tue, 18 Feb 2020 12:43:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0892060C80;
 Tue, 18 Feb 2020 12:43:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 21/33] block: Drop child_format
Date: Tue, 18 Feb 2020 13:42:30 +0100
Message-Id: <20200218124242.584644-22-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0V3k4Bf9PJS7pjWScHOfIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 29 -----------------------------
 include/block/block_int.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/block.c b/block.c
index 3e5b0bc345..43df38ca30 100644
--- a/block.c
+++ b/block.c
@@ -1148,35 +1148,6 @@ const BdrvChildClass child_file =3D {
     .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
 };
=20
-/*
- * Returns the options and flags that bs->file should get if the use of fo=
rmats
- * (and not only protocols) is permitted for it, based on the given option=
s and
- * flags for the parent BDS
- */
-static void bdrv_inherited_fmt_options(BdrvChildRole role,
-                                       bool parent_is_format,
-                                       int *child_flags, QDict *child_opti=
ons,
-                                       int parent_flags, QDict *parent_opt=
ions)
-{
-    bdrv_inherited_options(BDRV_CHILD_DATA, false,
-                           child_flags, child_options,
-                           parent_flags, parent_options);
-}
-
-const BdrvChildClass child_format =3D {
-    .parent_is_bds   =3D true,
-    .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .inherit_options =3D bdrv_inherited_fmt_options,
-    .drained_begin   =3D bdrv_child_cb_drained_begin,
-    .drained_poll    =3D bdrv_child_cb_drained_poll,
-    .drained_end     =3D bdrv_child_cb_drained_end,
-    .attach          =3D bdrv_child_cb_attach,
-    .detach          =3D bdrv_child_cb_detach,
-    .inactivate      =3D bdrv_child_cb_inactivate,
-    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
-    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
-};
-
 static void bdrv_backing_attach(BdrvChild *c)
 {
     BlockDriverState *parent =3D c->opaque;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d1d1af2a5c..75139a95ae 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -742,7 +742,6 @@ struct BdrvChildClass {
=20
 extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
-extern const BdrvChildClass child_format;
 extern const BdrvChildClass child_backing;
=20
 struct BdrvChild {
--=20
2.24.1


