Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B1C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEEC2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ1fk21b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEEC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxSx-0002Ip-N9
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBm-0003yP-UC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006fJ-HU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006YX-B4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sz8oATpGpNm4vqnllvfef+1NAha9YzGPfrrl9J7HGo8=;
 b=aJ1fk21bJEdAK4BN8hAmos9KSPPkct4MYaEpvK2LEe4+Zo5cI6YnCuEdcxluxis3zGa3pG
 WiJ/ZEtXOIX1jyCYr/bfjWwL6N8S6KmNJAdEGIo2clny1/T/XEDyDKaFXRXzyA5t0gVdpg
 jkUrSiMF8ANqbLZrMOKihe78e/frZqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-LNFPy0JyOu2i8s5xrwvObw-1; Wed, 27 Nov 2019 08:16:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 412A8802B9F;
 Wed, 27 Nov 2019 13:16:49 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDACD5C219;
 Wed, 27 Nov 2019 13:16:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 09/31] block: Unify bdrv_child_cb_attach()
Date: Wed, 27 Nov 2019 14:16:02 +0100
Message-Id: <20191127131624.1062403-10-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LNFPy0JyOu2i8s5xrwvObw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Make bdrv_child_cb_attach() call bdrv_backing_attach() for children with
a COW role (and drop the reverse call from bdrv_backing_attach()), so it
can be used for any child (with a proper role set).

Because so far no child has a proper role set, we need a temporary new
callback for child_backing.attach that ensures bdrv_backing_attach() is
called for all COW children that do not have their role set yet.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index b3decde6c5..24a8910047 100644
--- a/block.c
+++ b/block.c
@@ -920,9 +920,16 @@ static void bdrv_child_cb_drained_end(BdrvChild *child=
,
     bdrv_drained_end_no_poll(bs, drained_end_counter);
 }
=20
+static void bdrv_backing_attach(BdrvChild *c);
+
 static void bdrv_child_cb_attach(BdrvChild *child)
 {
     BlockDriverState *bs =3D child->opaque;
+
+    if (child->role & BDRV_CHILD_COW) {
+        bdrv_backing_attach(child);
+    }
+
     bdrv_apply_subtree_drain(child, bs);
 }
=20
@@ -1133,7 +1140,14 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
                     parent->backing_blocker);
+}
=20
+/* XXX: Will be removed along with child_backing */
+static void bdrv_child_cb_attach_backing(BdrvChild *c)
+{
+    if (!(c->role & BDRV_CHILD_COW)) {
+        bdrv_backing_attach(c);
+    }
     bdrv_child_cb_attach(c);
 }
=20
@@ -1192,7 +1206,7 @@ static int bdrv_backing_update_filename(BdrvChild *c,=
 BlockDriverState *base,
 const BdrvChildClass child_backing =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .attach          =3D bdrv_backing_attach,
+    .attach          =3D bdrv_child_cb_attach_backing,
     .detach          =3D bdrv_backing_detach,
     .inherit_options =3D bdrv_backing_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
--=20
2.23.0


