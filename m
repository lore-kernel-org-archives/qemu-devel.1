Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80792C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484842084B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clSssEyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484842084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxaq-0003aY-L5
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBm-0003yL-Rf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006eb-8L
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBl-0006aZ-35
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65FYcCTXhKt/O8uUSr6GIPXQ7xK9wYozvq0GpXr+0Z4=;
 b=clSssEytn7PAJs7KX+U5qpXtqFBdzJ6edPJfcKEp6Wyt3bW9o1XQVpoKaPnhS0AqOIPSiJ
 twdjsNfZxEsykvytR2C/xemvZRrixO5cRuzgpJmC9SIIeK8UvsyVKAc0OONTv/INu2vQw2
 aHb1DhKYHMJl2km66Qcd/x4+Ehzmh+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-KnFbDWStN_C_0NeW0WgPkQ-1; Wed, 27 Nov 2019 08:16:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D4A80259D;
 Wed, 27 Nov 2019 13:16:51 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3665C219;
 Wed, 27 Nov 2019 13:16:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 10/31] block: Unify bdrv_child_cb_detach()
Date: Wed, 27 Nov 2019 14:16:03 +0100
Message-Id: <20191127131624.1062403-11-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KnFbDWStN_C_0NeW0WgPkQ-1
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

Make bdrv_child_cb_detach() call bdrv_backing_detach() for children with
a COW role (and drop the reverse call from bdrv_backing_detach()), so it
can be used for any child (with a proper role set).

Because so far no child has a proper role set, we need a temporary new
callback for child_backing.detach that ensures bdrv_backing_detach() is
called for all COW children that do not have their role set yet.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 24a8910047..89214efa36 100644
--- a/block.c
+++ b/block.c
@@ -921,6 +921,7 @@ static void bdrv_child_cb_drained_end(BdrvChild *child,
 }
=20
 static void bdrv_backing_attach(BdrvChild *c);
+static void bdrv_backing_detach(BdrvChild *c);
=20
 static void bdrv_child_cb_attach(BdrvChild *child)
 {
@@ -936,6 +937,11 @@ static void bdrv_child_cb_attach(BdrvChild *child)
 static void bdrv_child_cb_detach(BdrvChild *child)
 {
     BlockDriverState *bs =3D child->opaque;
+
+    if (child->role & BDRV_CHILD_COW) {
+        bdrv_backing_detach(child);
+    }
+
     bdrv_unapply_subtree_drain(child, bs);
 }
=20
@@ -1159,7 +1165,14 @@ static void bdrv_backing_detach(BdrvChild *c)
     bdrv_op_unblock_all(c->bs, parent->backing_blocker);
     error_free(parent->backing_blocker);
     parent->backing_blocker =3D NULL;
+}
=20
+/* XXX: Will be removed along with child_backing */
+static void bdrv_child_cb_detach_backing(BdrvChild *c)
+{
+    if (!(c->role & BDRV_CHILD_COW)) {
+        bdrv_backing_detach(c);
+    }
     bdrv_child_cb_detach(c);
 }
=20
@@ -1207,7 +1220,7 @@ const BdrvChildClass child_backing =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .attach          =3D bdrv_child_cb_attach_backing,
-    .detach          =3D bdrv_backing_detach,
+    .detach          =3D bdrv_child_cb_detach_backing,
     .inherit_options =3D bdrv_backing_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
     .drained_poll    =3D bdrv_child_cb_drained_poll,
--=20
2.23.0


