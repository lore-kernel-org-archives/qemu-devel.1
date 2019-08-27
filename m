Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C809C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7CA2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7CA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hze-0003vj-DE
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2huh-0006Z1-SG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2hug-0000x0-LR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2hud-0000vn-SE; Tue, 27 Aug 2019 16:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3613310F23E8;
 Tue, 27 Aug 2019 20:17:55 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5DD600D1;
 Tue, 27 Aug 2019 20:17:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:36 +0100
Message-Id: <20190827201639.30368-10-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 27 Aug 2019 20:17:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/12] block/io: introduce bdrv_co_p{read,
 write}v_part
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

Introduce extended variants of bdrv_co_preadv and bdrv_co_pwritev
with qiov_offset parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-10-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-10-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h |  6 ++++++
 block/io.c                | 29 +++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 79a1fdb258..0422acdf1c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -959,9 +959,15 @@ extern BlockDriver bdrv_qcow2;
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
=20
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
     int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flag=
s)
diff --git a/block/io.c b/block/io.c
index 237d7f40f5..0fa10831ed 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1614,7 +1614,8 @@ static void bdrv_padding_destroy(BdrvRequestPadding=
 *pad)
  *
  * Function always succeeds.
  */
-static bool bdrv_pad_request(BlockDriverState *bs, QEMUIOVector **qiov,
+static bool bdrv_pad_request(BlockDriverState *bs,
+                             QEMUIOVector **qiov, size_t *qiov_offset,
                              int64_t *offset, unsigned int *bytes,
                              BdrvRequestPadding *pad)
 {
@@ -1623,11 +1624,12 @@ static bool bdrv_pad_request(BlockDriverState *bs=
, QEMUIOVector **qiov,
     }
=20
     qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
-                             *qiov, 0, *bytes,
+                             *qiov, *qiov_offset, *bytes,
                              pad->buf + pad->buf_len - pad->tail, pad->t=
ail);
     *bytes +=3D pad->head + pad->tail;
     *offset -=3D pad->head;
     *qiov =3D &pad->local_qiov;
+    *qiov_offset =3D 0;
=20
     return true;
 }
@@ -1635,6 +1637,14 @@ static bool bdrv_pad_request(BlockDriverState *bs,=
 QEMUIOVector **qiov,
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
+{
+    return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
+}
+
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
 {
     BlockDriverState *bs =3D child->bs;
     BdrvTrackedRequest req;
@@ -1655,12 +1665,12 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
         flags |=3D BDRV_REQ_COPY_ON_READ;
     }
=20
-    bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad);
+    bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad);
=20
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
     ret =3D bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
-                              qiov, 0, flags);
+                              qiov, qiov_offset, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
=20
@@ -2023,6 +2033,13 @@ out:
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
+{
+    return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
+}
+
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_=
offset,
+    BdrvRequestFlags flags)
 {
     BlockDriverState *bs =3D child->bs;
     BdrvTrackedRequest req;
@@ -2054,14 +2071,14 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
         goto out;
     }
=20
-    if (bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad)) {
+    if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)=
) {
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
=20
     ret =3D bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               qiov, 0, flags);
+                               qiov, qiov_offset, flags);
=20
     bdrv_padding_destroy(&pad);
=20
--=20
2.21.0


