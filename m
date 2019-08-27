Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD1C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCE020679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCE020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hxK-0000pa-V2
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2huL-00069h-FD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huK-0000ov-Ct
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huH-0000nP-OP; Tue, 27 Aug 2019 16:17:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1141210F23E7;
 Tue, 27 Aug 2019 20:17:33 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A80E6E700;
 Tue, 27 Aug 2019 20:17:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:32 +0100
Message-Id: <20190827201639.30368-6-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 27 Aug 2019 20:17:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/12] block/io: bdrv_co_do_copy_on_readv: use
 and support qiov_offset
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

Use and support new API in bdrv_co_do_copy_on_readv. Note that in case
of allocated-in-top we need to shrink read size to MIN(..) by hand, as
pre-patch this was actually done implicitly by qemu_iovec_concat (and
we used local_qiov.size).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-6-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-6-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/io.c b/block/io.c
index fd2fc7d5ff..5817bb9405 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1227,7 +1227,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs=
, uint64_t offset,
=20
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
         int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
-        int flags)
+        size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
=20
@@ -1239,7 +1239,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
     void *bounce_buffer;
=20
     BlockDriver *drv =3D bs->drv;
-    QEMUIOVector local_qiov;
     int64_t cluster_offset;
     int64_t cluster_bytes;
     size_t skip_bytes;
@@ -1302,6 +1301,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
         assert(skip_bytes < pnum);
=20
         if (ret <=3D 0) {
+            QEMUIOVector local_qiov;
+
             /* Must copy-on-read; use the bounce buffer */
             pnum =3D MIN(pnum, MAX_BOUNCE_BUFFER);
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
@@ -1339,16 +1340,15 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(=
BdrvChild *child,
             }
=20
             if (!(flags & BDRV_REQ_PREFETCH)) {
-                qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip=
_bytes,
+                qemu_iovec_from_buf(qiov, qiov_offset + progress,
+                                    bounce_buffer + skip_bytes,
                                     pnum - skip_bytes);
             }
         } else if (!(flags & BDRV_REQ_PREFETCH)) {
             /* Read directly into the destination */
-            qemu_iovec_init(&local_qiov, qiov->niov);
-            qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_b=
ytes);
-            ret =3D bdrv_driver_preadv(bs, offset + progress, local_qiov=
.size,
-                                     &local_qiov, 0, 0);
-            qemu_iovec_destroy(&local_qiov);
+            ret =3D bdrv_driver_preadv(bs, offset + progress,
+                                     MIN(pnum - skip_bytes, bytes - prog=
ress),
+                                     qiov, qiov_offset + progress, 0);
             if (ret < 0) {
                 goto err;
             }
@@ -1422,7 +1422,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
         }
=20
         if (!ret || pnum !=3D bytes) {
-            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov,=
 flags);
+            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov,=
 0, flags);
             goto out;
         } else if (flags & BDRV_REQ_PREFETCH) {
             goto out;
--=20
2.21.0


