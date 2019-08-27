Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F9C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE862184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE862184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hyt-0003Ma-JS
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hub-0006Qq-1H
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huZ-0000uS-N7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huW-0000t4-UM; Tue, 27 Aug 2019 16:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39ACF307D8E3;
 Tue, 27 Aug 2019 20:17:48 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6275196AE;
 Tue, 27 Aug 2019 20:17:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:35 +0100
Message-Id: <20190827201639.30368-9-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 27 Aug 2019 20:17:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/12] block/io: bdrv_aligned_pwritev: use and
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

Use and support new API in bdrv_aligned_pwritev.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-9-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-9-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index f191a3fa1e..237d7f40f5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1872,7 +1872,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t =
offset, uint64_t bytes,
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
-    int64_t align, QEMUIOVector *qiov, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
@@ -1892,7 +1892,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvCh=
ild *child,
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) =3D=3D 0);
     assert((bytes & (align - 1)) =3D=3D 0);
-    assert(!qiov || bytes =3D=3D qiov->size);
+    assert(!qiov || qiov_offset + bytes <=3D qiov->size);
     max_transfer =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, I=
NT_MAX),
                                    align);
=20
@@ -1900,7 +1900,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvCh=
ild *child,
=20
     if (!ret && bs->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OF=
F &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov, 0, qiov->size)) {
+        qemu_iovec_is_zero(qiov, qiov_offset, bytes)) {
         flags |=3D BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes =3D=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMA=
P) {
             flags |=3D BDRV_REQ_MAY_UNMAP;
@@ -1913,15 +1913,15 @@ static int coroutine_fn bdrv_aligned_pwritev(Bdrv=
Child *child,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret =3D bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
     } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
-        ret =3D bdrv_driver_pwritev_compressed(bs, offset, bytes, qiov, =
0);
+        ret =3D bdrv_driver_pwritev_compressed(bs, offset, bytes,
+                                             qiov, qiov_offset);
     } else if (bytes <=3D max_transfer) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
-        ret =3D bdrv_driver_pwritev(bs, offset, bytes, qiov, 0, flags);
+        ret =3D bdrv_driver_pwritev(bs, offset, bytes, qiov, qiov_offset=
, flags);
     } else {
         bdrv_debug_event(bs, BLKDBG_PWRITEV);
         while (bytes_remaining) {
             int num =3D MIN(bytes_remaining, max_transfer);
-            QEMUIOVector local_qiov;
             int local_flags =3D flags;
=20
             assert(num);
@@ -1931,12 +1931,10 @@ static int coroutine_fn bdrv_aligned_pwritev(Bdrv=
Child *child,
                  * need to flush on the last iteration */
                 local_flags &=3D ~BDRV_REQ_FUA;
             }
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, bytes - bytes_remaining=
, num);
=20
             ret =3D bdrv_driver_pwritev(bs, offset + bytes - bytes_remai=
ning,
-                                      num, &local_qiov, 0, local_flags);
-            qemu_iovec_destroy(&local_qiov);
+                                      num, qiov, bytes - bytes_remaining=
,
+                                      local_flags);
             if (ret < 0) {
                 break;
             }
@@ -1979,7 +1977,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bdr=
vChild *child,
=20
             qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
             ret =3D bdrv_aligned_pwritev(child, req, aligned_offset, wri=
te_bytes,
-                                       align, &local_qiov,
+                                       align, &local_qiov, 0,
                                        flags & ~BDRV_REQ_ZERO_WRITE);
             if (ret < 0 || pad.merge_reads) {
                 /* Error or all work is done */
@@ -1995,7 +1993,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bdr=
vChild *child,
         /* Write the aligned part in the middle. */
         uint64_t aligned_bytes =3D bytes & ~(align - 1);
         ret =3D bdrv_aligned_pwritev(child, req, offset, aligned_bytes, =
align,
-                                   NULL, flags);
+                                   NULL, 0, flags);
         if (ret < 0) {
             goto out;
         }
@@ -2009,7 +2007,8 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bdr=
vChild *child,
=20
         qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
         ret =3D bdrv_aligned_pwritev(child, req, offset, align, align,
-                                   &local_qiov, flags & ~BDRV_REQ_ZERO_W=
RITE);
+                                   &local_qiov, 0,
+                                   flags & ~BDRV_REQ_ZERO_WRITE);
     }
=20
 out:
@@ -2062,7 +2061,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     }
=20
     ret =3D bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               qiov, flags);
+                               qiov, 0, flags);
=20
     bdrv_padding_destroy(&pad);
=20
--=20
2.21.0


