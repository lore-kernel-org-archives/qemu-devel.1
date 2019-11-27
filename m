Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DCC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FFC2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnqoTRgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FFC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxHw-0007zO-8U
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBn-0003yc-1n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006f0-EY
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006ax-8e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGOXsd+E3FewkM3QPIu4PE6yuF6hfjhFmEvlj0bkr0E=;
 b=MnqoTRgt3REfzwHCyX0FP7fAGJsL/4rbVkMDFBgFIrDt95VUKd4sJ3KdzCmKsrA+LhrSzv
 doV9OIiddrAEsHIRVXFxKCLPIvv8ZvKmtb+cqO0NnViut7Ch8hv72QR04vClP8261OdRMv
 cJJrAKP7ctr+OJGENKHJxP5CoGkoASQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ChFZIMvpNb6DlF_wLSKyog-1; Wed, 27 Nov 2019 08:16:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF9B5EF787;
 Wed, 27 Nov 2019 13:16:53 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E815D6A7;
 Wed, 27 Nov 2019 13:16:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 11/31] block: Add child_of_bds
Date: Wed, 27 Nov 2019 14:16:04 +0100
Message-Id: <20191127131624.1062403-12-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ChFZIMvpNb6DlF_wLSKyog-1
X-Mimecast-Spam-Score: 0
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
---
 block.c                   | 27 +++++++++++++++++++++++++++
 include/block/block_int.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/block.c b/block.c
index 89214efa36..8542768d35 100644
--- a/block.c
+++ b/block.c
@@ -1050,6 +1050,33 @@ static void bdrv_inherited_options(BdrvChildRole rol=
e,
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
index 7553faa5cf..f2f8d770c6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -729,6 +729,7 @@ struct BdrvChildClass {
     void (*set_aio_ctx)(BdrvChild *child, AioContext *ctx, GSList **ignore=
);
 };
=20
+extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
 extern const BdrvChildClass child_format;
 extern const BdrvChildClass child_backing;
--=20
2.23.0


