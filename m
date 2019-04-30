Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C73C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C32217D4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C32217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVKA-0004SR-TC
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:09:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuv-00088Y-LT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002Ai-Ez
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuq-00026u-S9; Tue, 30 Apr 2019 11:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 099083097029;
	Tue, 30 Apr 2019 15:43:32 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21DA14D5;
	Tue, 30 Apr 2019 15:43:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:37 +0200
Message-Id: <20190430154244.30083-21-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 30 Apr 2019 15:43:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/27] block/parallels: use buffer-based io
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
Message-ID: <20190430154237.lD4iYH7u6Rx7bImoI9z1Q8HnX8E9nHReC04UKzobW-Q@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 15bc97b759..2747400577 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -220,20 +220,18 @@ static int64_t allocate_clusters(BlockDriverState *=
bs, int64_t sector_num,
     if (bs->backing) {
         int64_t nb_cow_sectors =3D to_allocate * s->tracks;
         int64_t nb_cow_bytes =3D nb_cow_sectors << BDRV_SECTOR_BITS;
-        QEMUIOVector qiov =3D
-            QEMU_IOVEC_INIT_BUF(qiov, qemu_blockalign(bs, nb_cow_bytes),
-                                nb_cow_bytes);
+        void *buf =3D qemu_blockalign(bs, nb_cow_bytes);
=20
-        ret =3D bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTO=
R_SIZE,
-                             nb_cow_bytes, &qiov, 0);
+        ret =3D bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR=
_SIZE,
+                            nb_cow_bytes, buf, 0);
         if (ret < 0) {
-            qemu_vfree(qemu_iovec_buf(&qiov));
+            qemu_vfree(buf);
             return ret;
         }
=20
         ret =3D bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE=
,
-                              nb_cow_bytes, &qiov, 0);
-        qemu_vfree(qemu_iovec_buf(&qiov));
+                              nb_cow_bytes, buf, 0);
+        qemu_vfree(buf);
         if (ret < 0) {
             return ret;
         }
--=20
2.20.1


