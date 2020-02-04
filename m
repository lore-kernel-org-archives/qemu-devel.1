Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0264BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29FF2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgjwxohV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29FF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1sK-0005ys-Tw
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hd-0003OM-2K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hc-0002wa-0h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hb-0002vx-TO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eelgb8QhSeOzwFOV2urvJyMnBp3c6VeZO/9axa71O1g=;
 b=LgjwxohVxo/ZT36KeoyjHmq4qaE+9kOk/LwJZmzVZAROdumw3m2UUb185WRVfTLf0ul5Yn
 J+oQI+naehlNI2YK45C4aLBiiIyfRBmKkNxFv6O5jNQEbGaR1xPREUjA5pj1+iGFvzJwju
 0b6GdWHcCT63z1wAV6ZwcfgStajc6CA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-2bXEJKgzPX6k4Iz69nbulw-1; Tue, 04 Feb 2020 12:09:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E0FDBA5;
 Tue,  4 Feb 2020 17:09:26 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4837F1BC6D;
 Tue,  4 Feb 2020 17:09:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 12/33] block: Unify bdrv_child_cb_detach()
Date: Tue,  4 Feb 2020 18:08:27 +0100
Message-Id: <20200204170848.614480-13-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2bXEJKgzPX6k4Iz69nbulw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
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
index 4af81547f3..46fc08e227 100644
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
@@ -1182,7 +1188,14 @@ static void bdrv_backing_detach(BdrvChild *c)
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
@@ -1230,7 +1243,7 @@ const BdrvChildClass child_backing =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .attach          =3D bdrv_child_cb_attach_backing,
-    .detach          =3D bdrv_backing_detach,
+    .detach          =3D bdrv_child_cb_detach_backing,
     .inherit_options =3D bdrv_backing_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
     .drained_poll    =3D bdrv_child_cb_drained_poll,
--=20
2.24.1


