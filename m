Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA784C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9244C208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9244C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBhw-0004XR-Rf
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBS7-0007Yk-3g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBS5-0007gd-Ue
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBS2-0007dD-GQ; Wed, 12 Jun 2019 18:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD17EC18B2F3;
 Wed, 12 Jun 2019 22:10:37 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DF8A5C236;
 Wed, 12 Jun 2019 22:10:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:34 +0200
Message-Id: <20190612221004.2317-13-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 12 Jun 2019 22:10:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 12/42] block: Use bdrv_filtered_rw* where
 obvious
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

Places that use patterns like

    if (bs->drv->is_filter && bs->file) {
        ... something about bs->file->bs ...
    }

should be

    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
    if (filtered) {
        ... something about @filtered ...
    }

instead.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c    | 23 +++++++++++++++--------
 block/io.c |  5 +++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 97774b7b06..11f37983d9 100644
--- a/block.c
+++ b/block.c
@@ -556,11 +556,12 @@ int bdrv_create_file(const char *filename, QemuOpts=
 *opts, Error **errp)
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
=20
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_blocksizes(bs->file->bs, bsz);
+    } else if (filtered) {
+        return bdrv_probe_blocksizes(filtered, bsz);
     }
=20
     return -ENOTSUP;
@@ -575,11 +576,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, Blo=
ckSizes *bsz)
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
=20
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
-    } else if (drv && drv->is_filter && bs->file) {
-        return bdrv_probe_geometry(bs->file->bs, geo);
+    } else if (filtered) {
+        return bdrv_probe_geometry(filtered, geo);
     }
=20
     return -ENOTSUP;
@@ -4972,6 +4974,8 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
=20
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
@@ -4984,8 +4988,10 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
-    if (bs->file && bs->drv->is_filter) {
-        return bdrv_has_zero_init(bs->file->bs);
+
+    filtered =3D bdrv_filtered_rw_bs(bs);
+    if (filtered) {
+        return bdrv_has_zero_init(filtered);
     }
=20
     /* safe default */
@@ -5030,8 +5036,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriver=
Info *bdi)
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_get_info) {
-        if (bs->file && drv->is_filter) {
-            return bdrv_get_info(bs->file->bs, bdi);
+        BlockDriverState *filtered =3D bdrv_filtered_rw_bs(bs);
+        if (filtered) {
+            return bdrv_get_info(filtered, bdi);
         }
         return -ENOTSUP;
     }
diff --git a/block/io.c b/block/io.c
index 2408abffd9..73ade04834 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3147,8 +3147,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset,
     }
=20
     if (!drv->bdrv_co_truncate) {
-        if (bs->file && drv->is_filter) {
-            ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
+        BdrvChild *filtered =3D bdrv_filtered_rw_child(bs);
+        if (filtered) {
+            ret =3D bdrv_co_truncate(filtered, offset, prealloc, errp);
             goto out;
         }
         error_setg(errp, "Image format driver does not support resize");
--=20
2.21.0


