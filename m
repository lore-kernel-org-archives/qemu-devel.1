Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBAC3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC7221582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxg26nY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC7221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1vl-0005DP-P2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1i9-0004Hd-Gf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1i8-0004NR-8m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1i8-0004Ky-5J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGguZIr50nMPjwjxbm18gSw5AKmnPnDwhkQTi2bid/c=;
 b=Oxg26nY6EUaxBYGIvO5GcHA2+g+kS7xgPnXAifYj0SLQEWN3YgoB+KyMw3eBI6apLAM219
 dwEN8M4KXLEXUyHl0cGi1vEIxfyP7srNpJW0FjSAjFrV38k+aXsh0JMZc4X24tzXuXP0aM
 34eJY46iklLiUntXr1p26BfdIXmLT0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-v6rTzTTRMGyfjoxOOFQ6Vw-1; Tue, 04 Feb 2020 12:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D41801F74;
 Tue,  4 Feb 2020 17:09:58 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5734F5D9E2;
 Tue,  4 Feb 2020 17:09:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 23/33] block: Drop child_backing
Date: Tue,  4 Feb 2020 18:08:38 +0100
Message-Id: <20200204170848.614480-24-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: v6rTzTTRMGyfjoxOOFQ6Vw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 62 +++------------------------------------
 include/block/block_int.h |  1 -
 2 files changed, 4 insertions(+), 59 deletions(-)

diff --git a/block.c b/block.c
index 6b705ee23a..e245b5d8d9 100644
--- a/block.c
+++ b/block.c
@@ -1169,15 +1169,6 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
 }
=20
-/* XXX: Will be removed along with child_backing */
-static void bdrv_child_cb_attach_backing(BdrvChild *c)
-{
-    if (!(c->role & BDRV_CHILD_COW)) {
-        bdrv_backing_attach(c);
-    }
-    bdrv_child_cb_attach(c);
-}
-
 static void bdrv_backing_detach(BdrvChild *c)
 {
     BlockDriverState *parent =3D c->opaque;
@@ -1188,28 +1179,6 @@ static void bdrv_backing_detach(BdrvChild *c)
     parent->backing_blocker =3D NULL;
 }
=20
-/* XXX: Will be removed along with child_backing */
-static void bdrv_child_cb_detach_backing(BdrvChild *c)
-{
-    if (!(c->role & BDRV_CHILD_COW)) {
-        bdrv_backing_detach(c);
-    }
-    bdrv_child_cb_detach(c);
-}
-
-/*
- * Returns the options and flags that bs->backing should get, based on the
- * given options and flags for the parent BDS
- */
-static void bdrv_backing_options(BdrvChildRole role, bool parent_is_format=
,
-                                 int *child_flags, QDict *child_options,
-                                 int parent_flags, QDict *parent_options)
-{
-    bdrv_inherited_options(BDRV_CHILD_COW, true,
-                           child_flags, child_options,
-                           parent_flags, parent_options);
-}
-
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *ba=
se,
                                         const char *filename, Error **errp=
)
 {
@@ -1237,21 +1206,6 @@ static int bdrv_backing_update_filename(BdrvChild *c=
, BlockDriverState *base,
     return ret;
 }
=20
-const BdrvChildClass child_backing =3D {
-    .parent_is_bds   =3D true,
-    .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .attach          =3D bdrv_child_cb_attach_backing,
-    .detach          =3D bdrv_child_cb_detach_backing,
-    .inherit_options =3D bdrv_backing_options,
-    .drained_begin   =3D bdrv_child_cb_drained_begin,
-    .drained_poll    =3D bdrv_child_cb_drained_poll,
-    .drained_end     =3D bdrv_child_cb_drained_end,
-    .inactivate      =3D bdrv_child_cb_inactivate,
-    .update_filename =3D bdrv_backing_update_filename,
-    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
-    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
-};
-
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
 {
     int open_flags =3D flags;
@@ -2258,8 +2212,7 @@ static void bdrv_default_perms_for_backing(BlockDrive=
rState *bs, BdrvChild *c,
                                            uint64_t perm, uint64_t shared,
                                            uint64_t *nperm, uint64_t *nsha=
red)
 {
-    assert(child_class =3D=3D &child_backing ||
-           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW)));
+    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW));
=20
     /*
      * We want consistent read from backing files if the parent needs it.
@@ -2371,23 +2324,16 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
-    bool backing =3D (child_class =3D=3D &child_backing);
-
     if (child_class =3D=3D &child_of_bds) {
         bdrv_default_perms(bs, c, child_class, role, reopen_queue,
                            perm, shared, nperm, nshared);
         return;
     }
=20
-    assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
+    assert(child_class =3D=3D &child_file);
=20
-    if (!backing) {
-        bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_q=
ueue,
-                                        perm, shared, nperm, nshared);
-    } else {
-        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
-                                       perm, shared, nperm, nshared);
-    }
+    bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_queue=
,
+                                    perm, shared, nperm, nshared);
 }
=20
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 21ece88d41..7b51866678 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -742,7 +742,6 @@ struct BdrvChildClass {
=20
 extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
-extern const BdrvChildClass child_backing;
=20
 struct BdrvChild {
     BlockDriverState *bs;
--=20
2.24.1


