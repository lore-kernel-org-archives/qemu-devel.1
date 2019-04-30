Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CAC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E2820835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E2820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVIa-00031g-4o
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:08:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-000899-6c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002AY-Do
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuo-00024d-TX; Tue, 30 Apr 2019 11:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EE133087940;
	Tue, 30 Apr 2019 15:43:30 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B06564C7;
	Tue, 30 Apr 2019 15:43:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:35 +0200
Message-Id: <20190430154244.30083-19-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 30 Apr 2019 15:43:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/27] block/qcow: use buffer-based io
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
Message-ID: <20190430154235.sT6-q2580qWk5a8pgU63DsgMgiAOPIx1ll2BPyaNvO8@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 10d2cf14b3..1bb8fd05e2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -631,7 +631,6 @@ static coroutine_fn int qcow_co_preadv(BlockDriverSta=
te *bs, uint64_t offset,
     int offset_in_cluster;
     int ret =3D 0, n;
     uint64_t cluster_offset;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
=20
@@ -663,11 +662,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverS=
tate *bs, uint64_t offset,
         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
-                qemu_iovec_init_buf(&hd_qiov, buf, n);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing *=
/
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret =3D bdrv_co_preadv(bs->backing, offset, n, &hd_qiov,=
 0);
+                ret =3D bdrv_co_pread(bs->backing, offset, n, buf, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     break;
@@ -688,11 +686,10 @@ static coroutine_fn int qcow_co_preadv(BlockDriverS=
tate *bs, uint64_t offset,
                 ret =3D -EIO;
                 break;
             }
-            qemu_iovec_init_buf(&hd_qiov, buf, n);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret =3D bdrv_co_preadv(bs->file, cluster_offset + offset_in_=
cluster,
-                                 n, &hd_qiov, 0);
+            ret =3D bdrv_co_pread(bs->file, cluster_offset + offset_in_c=
luster,
+                                n, buf, 0);
             qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 break;
@@ -731,7 +728,6 @@ static coroutine_fn int qcow_co_pwritev(BlockDriverSt=
ate *bs, uint64_t offset,
     int offset_in_cluster;
     uint64_t cluster_offset;
     int ret =3D 0, n;
-    QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
=20
@@ -776,11 +772,10 @@ static coroutine_fn int qcow_co_pwritev(BlockDriver=
State *bs, uint64_t offset,
             }
         }
=20
-        qemu_iovec_init_buf(&hd_qiov, buf, n);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        ret =3D bdrv_co_pwritev(bs->file, cluster_offset + offset_in_clu=
ster,
-                              n, &hd_qiov, 0);
+        ret =3D bdrv_co_pwrite(bs->file, cluster_offset + offset_in_clus=
ter,
+                             n, buf, 0);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             break;
@@ -1056,7 +1051,6 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
                            uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVQcowState *s =3D bs->opaque;
-    QEMUIOVector hd_qiov;
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
@@ -1122,9 +1116,8 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, ui=
nt64_t offset,
     }
     cluster_offset &=3D s->cluster_offset_mask;
=20
-    qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
-    ret =3D bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov,=
 0);
+    ret =3D bdrv_co_pwrite(bs->file, cluster_offset, out_len, out_buf, 0=
);
     if (ret < 0) {
         goto fail;
     }
--=20
2.20.1


