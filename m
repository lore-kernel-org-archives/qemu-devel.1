Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A2C3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF130217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF130217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i3y-0001iQ-5U
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hua-0006Pq-6M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huY-0000u7-Rb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huW-0000sH-2L; Tue, 27 Aug 2019 16:17:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62D6AC05686D;
 Tue, 27 Aug 2019 20:17:46 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E22D196AE;
 Tue, 27 Aug 2019 20:17:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:34 +0100
Message-Id: <20190827201639.30368-8-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 27 Aug 2019 20:17:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/12] block/io: bdrv_aligned_preadv: use and
 support qiov_offset
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use and support new API in bdrv_co_do_copy_on_readv.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-8-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-8-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4c7a7ac7b1..f191a3fa1e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1376,7 +1376,7 @@ err:
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
-    int64_t align, QEMUIOVector *qiov, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
     int64_t total_bytes, max_bytes;
@@ -1387,7 +1387,6 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) =3D=3D 0);
     assert((bytes & (align - 1)) =3D=3D 0);
-    assert(!qiov || bytes =3D=3D qiov->size);
     assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
     max_transfer =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, I=
NT_MAX),
                                    align);
@@ -1425,7 +1424,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
         }
=20
         if (!ret || pnum !=3D bytes) {
-            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov,=
 0, flags);
+            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes,
+                                           qiov, qiov_offset, flags);
             goto out;
         } else if (flags & BDRV_REQ_PREFETCH) {
             goto out;
@@ -1441,7 +1441,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
=20
     max_bytes =3D ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <=3D max_bytes && bytes <=3D max_transfer) {
-        ret =3D bdrv_driver_preadv(bs, offset, bytes, qiov, 0, 0);
+        ret =3D bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,=
 0);
         goto out;
     }
=20
@@ -1449,17 +1449,12 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvC=
hild *child,
         int num;
=20
         if (max_bytes) {
-            QEMUIOVector local_qiov;
-
             num =3D MIN(bytes_remaining, MIN(max_bytes, max_transfer));
             assert(num);
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining=
, num);
=20
             ret =3D bdrv_driver_preadv(bs, offset + bytes - bytes_remain=
ing,
-                                     num, &local_qiov, 0, 0);
+                                     num, qiov, bytes - bytes_remaining,=
 0);
             max_bytes -=3D num;
-            qemu_iovec_destroy(&local_qiov);
         } else {
             num =3D bytes_remaining;
             ret =3D qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
@@ -1561,7 +1556,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
             bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         }
         ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, byt=
es,
-                                  align, &local_qiov, 0);
+                                  align, &local_qiov, 0, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1584,7 +1579,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
         ret =3D bdrv_aligned_preadv(
                 child, req,
                 req->overlap_offset + req->overlap_bytes - align,
-                align, align, &local_qiov, 0);
+                align, align, &local_qiov, 0, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1665,7 +1660,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
     ret =3D bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
-                              qiov, flags);
+                              qiov, 0, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
=20
--=20
2.21.0


