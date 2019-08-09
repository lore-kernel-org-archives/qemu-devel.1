Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA2320C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA2320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7cx-00064u-RK
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XY-0001jX-1b
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XX-0004DT-4o
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XV-0004CM-1E; Fri, 09 Aug 2019 12:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59FD4757C2;
 Fri,  9 Aug 2019 16:14:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA76D5C578;
 Fri,  9 Aug 2019 16:14:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:42 +0200
Message-Id: <20190809161407.11920-18-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 16:14:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 17/42] block: Use CAFs in
 bdrv_refresh_limits()
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index bcc770d336..dca4689b2f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -135,6 +135,8 @@ static void bdrv_merge_limits(BlockLimits *dst, const=
 BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
+    BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
     Error *local_err =3D NULL;
=20
     memset(&bs->bl, 0, sizeof(bs->bl));
@@ -148,13 +150,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Erro=
r **errp)
                                 drv->bdrv_aio_preadv) ? 1 : 512;
=20
     /* Take some limits from the children as a default */
-    if (bs->file) {
-        bdrv_refresh_limits(bs->file->bs, &local_err);
+    if (storage_bs) {
+        bdrv_refresh_limits(storage_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
+        bdrv_merge_limits(&bs->bl, &storage_bs->bl);
     } else {
         bs->bl.min_mem_alignment =3D 512;
         bs->bl.opt_mem_alignment =3D getpagesize();
@@ -163,13 +165,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Erro=
r **errp)
         bs->bl.max_iov =3D IOV_MAX;
     }
=20
-    if (bs->backing) {
-        bdrv_refresh_limits(bs->backing->bs, &local_err);
+    if (cow_bs) {
+        bdrv_refresh_limits(cow_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
+        bdrv_merge_limits(&bs->bl, &cow_bs->bl);
     }
=20
     /* Then let the driver override it */
--=20
2.21.0


