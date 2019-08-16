Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1755FC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD47F205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD47F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylik-00069k-9G
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPn-0006cm-Sb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPm-00062u-En
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPj-0005wP-5P; Fri, 16 Aug 2019 19:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DD002CD811;
 Fri, 16 Aug 2019 23:13:41 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3245A19C6A;
 Fri, 16 Aug 2019 23:13:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:01 -0400
Message-Id: <20190816231318.8650-20-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 16 Aug 2019 23:13:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/36] blockdev: reduce aio_context locked
 sections in bitmap add/remove
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Commit 0a6c86d024c52 returned these locks back to add/remove
functionality, to protect from intersection of persistent bitmap
related IO with other IO. But other bitmap-related functions called
here are unrelated to the problem, and there are no needs to keep these
calls inside critical sections.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190708220502.12977-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a44ab1f709e..bcd766a1a24 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2813,7 +2813,6 @@ void qmp_block_dirty_bitmap_add(const char *node, c=
onst char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context =3D NULL;
=20
     if (!name || name[0] =3D=3D '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2849,16 +2848,20 @@ void qmp_block_dirty_bitmap_add(const char *node,=
 const char *name,
     }
=20
     if (persistent) {
-        aio_context =3D bdrv_get_aio_context(bs);
+        AioContext *aio_context =3D bdrv_get_aio_context(bs);
+        bool ok;
+
         aio_context_acquire(aio_context);
-        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp=
)) {
-            goto out;
+        ok =3D bdrv_can_store_new_dirty_bitmap(bs, name, granularity, er=
rp);
+        aio_context_release(aio_context);
+        if (!ok) {
+            return;
         }
     }
=20
     bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
     if (bitmap =3D=3D NULL) {
-        goto out;
+        return;
     }
=20
     if (disabled) {
@@ -2866,10 +2869,6 @@ void qmp_block_dirty_bitmap_add(const char *node, =
const char *name,
     }
=20
     bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
- out:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
 }
=20
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
@@ -2877,8 +2876,6 @@ void qmp_block_dirty_bitmap_remove(const char *node=
, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-    Error *local_err =3D NULL;
-    AioContext *aio_context =3D NULL;
=20
     bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
@@ -2891,20 +2888,19 @@ void qmp_block_dirty_bitmap_remove(const char *no=
de, const char *name,
     }
=20
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-        aio_context =3D bdrv_get_aio_context(bs);
+        AioContext *aio_context =3D bdrv_get_aio_context(bs);
+        Error *local_err =3D NULL;
+
         aio_context_acquire(aio_context);
         bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        aio_context_release(aio_context);
         if (local_err !=3D NULL) {
             error_propagate(errp, local_err);
-            goto out;
+            return;
         }
     }
=20
     bdrv_release_dirty_bitmap(bs, bitmap);
- out:
-    if (aio_context) {
-        aio_context_release(aio_context);
-    }
 }
=20
 /**
--=20
2.21.0


