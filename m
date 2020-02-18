Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C7DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E5820659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBmFjK46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E5820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Ol-0007AF-2M
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Dn-0004jW-1V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Dl-0001Ed-Tj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Dl-0001EP-Pq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiwEtie4mG0tpZEOigS5yCgAGQoBI9oOsocQ+9eCakM=;
 b=DBmFjK46zAyq9g2GFeXjBjcKWc6EmJBj+nBX+jjaAj4Ll77GcsA+NwdioTc5aixms0KFvF
 8gl3Rt2PCwytROJyvL3722a1CMxsmftQYQJGcs1hQ4QTzVgAw0ttuGUuIG/siv038yAyhk
 IkSv5KAnYp9HfMowOwr7K6ZAXWDYyT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-xw-FVMkKM_y28_ZsDlhQkw-1; Tue, 18 Feb 2020 07:43:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55972800D50;
 Tue, 18 Feb 2020 12:43:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3786390;
 Tue, 18 Feb 2020 12:43:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 11/33] block: Unify bdrv_child_cb_attach()
Date: Tue, 18 Feb 2020 13:42:20 +0100
Message-Id: <20200218124242.584644-12-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xw-FVMkKM_y28_ZsDlhQkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index aa54d40e4f..3cf1293a7b 100644
--- a/block.c
+++ b/block.c
@@ -942,9 +942,16 @@ static void bdrv_child_cb_drained_end(BdrvChild *child=
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
@@ -1178,7 +1185,14 @@ static void bdrv_backing_attach(BdrvChild *c)
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
@@ -1237,7 +1251,7 @@ static int bdrv_backing_update_filename(BdrvChild *c,=
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
2.24.1


