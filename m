Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D623C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB102086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Zn-0007J3-Eu
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XN-00018O-JS
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XM-00047A-I5
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XJ-00043G-Lw; Fri, 09 Aug 2019 12:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A1E630BA06F;
 Fri,  9 Aug 2019 16:14:37 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A73D10013A1;
 Fri,  9 Aug 2019 16:14:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:37 +0200
Message-Id: <20190809161407.11920-13-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 09 Aug 2019 16:14:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 12/42] block: Use bdrv_filtered_rw* where
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c    | 23 +++++++++++++++--------
 block/io.c |  5 +++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 029c809a8e..86b84bea21 100644
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
@@ -5084,6 +5086,8 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
=20
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
+    BlockDriverState *filtered;
+
     if (!bs->drv) {
         return 0;
     }
@@ -5096,8 +5100,10 @@ int bdrv_has_zero_init(BlockDriverState *bs)
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
@@ -5142,8 +5148,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriver=
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
index 06305c6ea6..4d6cf4b3c2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3186,8 +3186,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
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


