Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3E8C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F152087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evXyZUYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F152087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz20B-0007dB-Nf
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1iZ-000579-OV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1iY-0005tF-IT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1iY-0005sB-EI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRKp4a/UG4qkqX9Fe56DL26T20lwviaJsj2t8tW+SOE=;
 b=evXyZUYWgonIEE+q6k/00P5J66Fw5Y/0qXqQ919goluFIl5smgbRXwcwJsVw9BNBwtVmt8
 9kUAsOUH+G5VKJMfZXAwUrAq2hMqI3EnmSKFo+l82f6g7U8OQZ4qrUvP8YUmifIkZWj7jR
 isvLydcAhLA3IMV3hciAOgMZcetjC3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-3vRrH6B7O1u284xSQLFsEA-1; Tue, 04 Feb 2020 12:10:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9F218010EF;
 Tue,  4 Feb 2020 17:10:26 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CE1660BF3;
 Tue,  4 Feb 2020 17:10:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 32/33] block: Pass BdrvChildRole in remaining cases
Date: Tue,  4 Feb 2020 18:08:47 +0100
Message-Id: <20200204170848.614480-33-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3vRrH6B7O1u284xSQLFsEA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These calls have no real use for the child role yet, but it will not
harm to give one.

Notably, the bdrv_root_attach_child() call in blockjob.c is left
unmodified because there is not much the generic BlockJob object wants
from its children.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 11 +++++++----
 block/vvfat.c         |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9e0078bfb5..e655e15675 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -401,8 +401,9 @@ BlockBackend *blk_new_open(const char *filename, const =
char *reference,
         return NULL;
     }
=20
-    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root, 0, blk->=
ctx,
-                                       perm, BLK_PERM_ALL, blk, errp);
+    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
+                                       BDRV_CHILD_FILTERED | BDRV_CHILD_PR=
IMARY,
+                                       blk->ctx, perm, BLK_PERM_ALL, blk, =
errp);
     if (!blk->root) {
         blk_unref(blk);
         return NULL;
@@ -812,8 +813,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState =
*bs, Error **errp)
 {
     ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
     bdrv_ref(bs);
-    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root, 0, blk->=
ctx,
-                                       blk->perm, blk->shared_perm, blk, e=
rrp);
+    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
+                                       BDRV_CHILD_FILTERED | BDRV_CHILD_PR=
IMARY,
+                                       blk->ctx, blk->perm, blk->shared_pe=
rm,
+                                       blk, errp);
     if (blk->root =3D=3D NULL) {
         return -EPERM;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index 2bc5812dc5..96d7c6eca8 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3193,7 +3193,7 @@ static int enable_write_target(BlockDriverState *bs, =
Error **errp)
     options =3D qdict_new();
     qdict_put_str(options, "write-target.driver", "qcow");
     s->qcow =3D bdrv_open_child(s->qcow_filename, options, "write-target",=
 bs,
-                              &child_vvfat_qcow, 0, false, errp);
+                              &child_vvfat_qcow, BDRV_CHILD_DATA, false, e=
rrp);
     qobject_unref(options);
     if (!s->qcow) {
         ret =3D -EINVAL;
--=20
2.24.1


