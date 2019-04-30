Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38190C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A1220652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A1220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVAJ-0004Dm-8g
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:59:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv1-0008Cw-98
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv0-0002F1-AQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUux-0002Cz-T9; Tue, 30 Apr 2019 11:43:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E309883AC;
	Tue, 30 Apr 2019 15:43:39 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47BF64D5;
	Tue, 30 Apr 2019 15:43:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:41 +0200
Message-Id: <20190430154244.30083-25-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 30 Apr 2019 15:43:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 24/27] qemu-img: use buffer-based io
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154241.txfRPTL0qNaLQ4L0C1wJXidqBiGVspewtCv1SYFERtQ@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ddd55ab291..e6ad5978e0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1680,7 +1680,6 @@ static int coroutine_fn convert_co_read(ImgConvertS=
tate *s, int64_t sector_num,
                                         int nb_sectors, uint8_t *buf)
 {
     int n, ret;
-    QEMUIOVector qiov;
=20
     assert(nb_sectors <=3D s->buf_sectors);
     while (nb_sectors > 0) {
@@ -1696,11 +1695,10 @@ static int coroutine_fn convert_co_read(ImgConver=
tState *s, int64_t sector_num,
         bs_sectors =3D s->src_sectors[src_cur];
=20
         n =3D MIN(nb_sectors, bs_sectors - (sector_num - src_cur_offset)=
);
-        qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
=20
-        ret =3D blk_co_preadv(
+        ret =3D blk_co_pread(
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
-                n << BDRV_SECTOR_BITS, &qiov, 0);
+                n << BDRV_SECTOR_BITS, buf, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1719,7 +1717,6 @@ static int coroutine_fn convert_co_write(ImgConvert=
State *s, int64_t sector_num,
                                          enum ImgConvertBlockStatus stat=
us)
 {
     int ret;
-    QEMUIOVector qiov;
=20
     while (nb_sectors > 0) {
         int n =3D nb_sectors;
@@ -1747,10 +1744,8 @@ static int coroutine_fn convert_co_write(ImgConver=
tState *s, int64_t sector_num,
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
-                qemu_iovec_init_buf(&qiov, buf, n << BDRV_SECTOR_BITS);
-
-                ret =3D blk_co_pwritev(s->target, sector_num << BDRV_SEC=
TOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, flags=
);
+                ret =3D blk_co_pwrite(s->target, sector_num << BDRV_SECT=
OR_BITS,
+                                    n << BDRV_SECTOR_BITS, buf, flags);
                 if (ret < 0) {
                     return ret;
                 }
--=20
2.20.1


