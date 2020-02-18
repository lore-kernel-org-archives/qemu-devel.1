Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BEC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7911320659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABNgfoFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7911320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42NI-0004Um-LZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Du-000534-Vj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Ds-0001Je-U1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Ds-0001JN-Pl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J36EkZpRpBwpEnrHyZidJi7IGEtjwqVFpcpr1/dCcPc=;
 b=ABNgfoFRGLev+bQ2Cr9nVLDTt81oV2SMyjTSxyaMEkND4PvKz6Jd+k+g3EG+ByAfO202nq
 X1dItwjtxO9wxYLhpY4eEUzy5K9vBQGXbgGBfAwABK1DDOHOXG/6XPFYtGieP7M8ex6R02
 nGFCgd9jVD3jA4Ak8Jamvy5Xn6AMmiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-yzGo9SO0McaKlrxSZI2lCQ-1; Tue, 18 Feb 2020 07:43:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D0681005512;
 Tue, 18 Feb 2020 12:43:28 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4341001281;
 Tue, 18 Feb 2020 12:43:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 13/33] block: Add child_of_bds
Date: Tue, 18 Feb 2020 13:42:22 +0100
Message-Id: <20200218124242.584644-14-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yzGo9SO0McaKlrxSZI2lCQ-1
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

Any current user of child_file, child_format, and child_backing can and
should use this generic BdrvChildClass instead, as it can handle all of
these cases.  However, to be able to do so, the users must pass the
appropriate BdrvChildRole when the child is created/attached.  (The
following commits will take care of that.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 27 +++++++++++++++++++++++++++
 include/block/block_int.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/block.c b/block.c
index 0f24546863..1d33f58ff8 100644
--- a/block.c
+++ b/block.c
@@ -1094,6 +1094,33 @@ static void bdrv_inherited_options(BdrvChildRole rol=
e, bool parent_is_format,
     *child_flags =3D flags;
 }
=20
+static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *ba=
se,
+                                        const char *filename, Error **errp=
);
+
+static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *b=
ase,
+                                         const char *filename, Error **err=
p)
+{
+    if (c->role & BDRV_CHILD_COW) {
+        return bdrv_backing_update_filename(c, base, filename, errp);
+    }
+    return 0;
+}
+
+const BdrvChildClass child_of_bds =3D {
+    .parent_is_bds   =3D true,
+    .get_parent_desc =3D bdrv_child_get_parent_desc,
+    .inherit_options =3D bdrv_inherited_options,
+    .drained_begin   =3D bdrv_child_cb_drained_begin,
+    .drained_poll    =3D bdrv_child_cb_drained_poll,
+    .drained_end     =3D bdrv_child_cb_drained_end,
+    .attach          =3D bdrv_child_cb_attach,
+    .detach          =3D bdrv_child_cb_detach,
+    .inactivate      =3D bdrv_child_cb_inactivate,
+    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
+    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
+    .update_filename =3D bdrv_child_cb_update_filename,
+};
+
 /*
  * Returns the options and flags that bs->file should get if a protocol dr=
iver
  * is expected, based on the given options and flags for the parent BDS
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1f8a818f76..dd7ccea35e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -740,6 +740,7 @@ struct BdrvChildClass {
     void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **ignore=
);
 };
=20
+extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
 extern const BdrvChildClass child_format;
 extern const BdrvChildClass child_backing;
--=20
2.24.1


