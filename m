Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C24C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E88320652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E88320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVEu-0008GY-Ie
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:04:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-00086l-E8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUus-00029A-HP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUun-00022M-8n; Tue, 30 Apr 2019 11:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 634028046F;
	Tue, 30 Apr 2019 15:43:28 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91F884C7;
	Tue, 30 Apr 2019 15:43:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:34 +0200
Message-Id: <20190430154244.30083-18-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 30 Apr 2019 15:43:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/27] block/qcow2: use buffer-based io
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
Message-ID: <20190430154234.9qnh5IBqnt56Vx7Z4WkqRolSTgQD1CsxCk6Hkt6oT6o@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c5c17734d7..a520d116ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4094,7 +4094,6 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    QEMUIOVector hd_qiov;
     int ret;
     ssize_t out_len;
     uint8_t *buf, *out_buf;
@@ -4161,10 +4160,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, =
uint64_t offset,
         goto fail;
     }
=20
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
-
     BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
-    ret =3D bdrv_co_pwritev(s->data_file, cluster_offset, out_len, &hd_q=
iov, 0);
+    ret =3D bdrv_co_pwrite(s->data_file, cluster_offset, out_len, out_bu=
f, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -4187,7 +4184,6 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     int ret =3D 0, csize, nb_csectors;
     uint64_t coffset;
     uint8_t *buf, *out_buf;
-    QEMUIOVector local_qiov;
     int offset_in_cluster =3D offset_into_cluster(s, offset);
=20
     coffset =3D file_cluster_offset & s->cluster_offset_mask;
@@ -4198,12 +4194,11 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
     if (!buf) {
         return -ENOMEM;
     }
-    qemu_iovec_init_buf(&local_qiov, buf, csize);
=20
     out_buf =3D qemu_blockalign(bs, s->cluster_size);
=20
     BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-    ret =3D bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    ret =3D bdrv_co_pread(bs->file, coffset, csize, buf, 0);
     if (ret < 0) {
         goto fail;
     }
--=20
2.20.1


