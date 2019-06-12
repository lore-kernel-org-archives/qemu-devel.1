Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0455C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B37208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B37208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBeG-000075-ST
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBS8-0007dc-O7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBS7-0007hh-Kc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBS5-0007fY-2p; Wed, 12 Jun 2019 18:10:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 398762EF170;
 Wed, 12 Jun 2019 22:10:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC0CD6014E;
 Wed, 12 Jun 2019 22:10:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:35 +0200
Message-Id: <20190612221004.2317-14-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 22:10:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 13/42] block: Use CAFs in block status
 functions
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

Use the child access functions in the block status inquiry functions as
appropriate.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index 73ade04834..53aabf86b5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2150,11 +2150,12 @@ static int coroutine_fn bdrv_co_block_status(Bloc=
kDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |=3D BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
+        BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
+
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |=3D BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
-            BlockDriverState *bs2 =3D bs->backing->bs;
-            int64_t size2 =3D bdrv_getlength(bs2);
+        } else if (cow_bs) {
+            int64_t size2 =3D bdrv_getlength(cow_bs);
=20
             if (size2 >=3D 0 && offset >=3D size2) {
                 ret |=3D BDRV_BLOCK_ZERO;
@@ -2220,7 +2221,7 @@ static int coroutine_fn bdrv_co_block_status_above(=
BlockDriverState *bs,
     bool first =3D true;
=20
     assert(bs !=3D base);
-    for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
+    for (p =3D bs; p !=3D base; p =3D bdrv_filtered_bs(p)) {
         ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pnum, =
map,
                                    file);
         if (ret < 0) {
@@ -2306,7 +2307,7 @@ int bdrv_block_status_above(BlockDriverState *bs, B=
lockDriverState *base,
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
                       int64_t *pnum, int64_t *map, BlockDriverState **fi=
le)
 {
-    return bdrv_block_status_above(bs, backing_bs(bs),
+    return bdrv_block_status_above(bs, bdrv_filtered_bs(bs),
                                    offset, bytes, pnum, map, file);
 }
=20
@@ -2316,9 +2317,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState=
 *bs, int64_t offset,
     int ret;
     int64_t dummy;
=20
-    ret =3D bdrv_common_block_status_above(bs, backing_bs(bs), false, of=
fset,
-                                         bytes, pnum ? pnum : &dummy, NU=
LL,
-                                         NULL);
+    ret =3D bdrv_common_block_status_above(bs, bdrv_filtered_bs(bs), fal=
se,
+                                         offset, bytes, pnum ? pnum : &d=
ummy,
+                                         NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2372,7 +2373,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n =3D pnum_inter;
         }
=20
-        intermediate =3D backing_bs(intermediate);
+        intermediate =3D bdrv_filtered_bs(intermediate);
     }
=20
     *pnum =3D n;
--=20
2.21.0


