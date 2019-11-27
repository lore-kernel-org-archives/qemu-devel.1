Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181F820678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTnWn464"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181F820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38447 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxX8-0006o0-UJ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxC4-0004EF-ML
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxC2-0006v0-Ja
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxC2-0006rm-Bh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiabCUwDHeoK3taxHgdV7EGRLzYTUrPJRmF9qYbTQiE=;
 b=BTnWn464REXOR5oO9DM8pCIia6LZFTK4xtlJFsxbFdHxgrlo8TKPPDg91ttCxwWuR/LDlN
 GOgurQTMSZxwEhrYAahgKuLiB9+aL5R54NOLQPBoo0jlLAvWYO8Z/asAIh/hd/ZqGPXr4k
 T0N2A6qawkW7aVrxx4QVuC98zVgw6S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-EoRa1ZWnPQKN7aClfYBlKw-1; Wed, 27 Nov 2019 08:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13DAC8026A8;
 Wed, 27 Nov 2019 13:17:13 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6A867647;
 Wed, 27 Nov 2019 13:17:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 19/31] block: Drop child_format
Date: Wed, 27 Nov 2019 14:16:12 +0100
Message-Id: <20191127131624.1062403-20-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EoRa1ZWnPQKN7aClfYBlKw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 28 ----------------------------
 include/block/block_int.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/block.c b/block.c
index 5b38c7799a..4b8c33dccc 100644
--- a/block.c
+++ b/block.c
@@ -1104,34 +1104,6 @@ const BdrvChildClass child_file =3D {
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
-                                       int *child_flags, QDict *child_opti=
ons,
-                                       int parent_flags, QDict *parent_opt=
ions)
-{
-    bdrv_inherited_options(BDRV_CHILD_DATA | BDRV_CHILD_FORMAT,
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
index b9375ceb1c..fe6206b210 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -731,7 +731,6 @@ struct BdrvChildClass {
=20
 extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
-extern const BdrvChildClass child_format;
 extern const BdrvChildClass child_backing;
=20
 struct BdrvChild {
--=20
2.23.0


