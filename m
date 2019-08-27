Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFBC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282532077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282532077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i1I-00061M-SF
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2huw-0006qw-Uy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2huv-000195-F6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2hus-000170-0v; Tue, 27 Aug 2019 16:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6C413B738;
 Tue, 27 Aug 2019 20:18:08 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCE3F5C207;
 Tue, 27 Aug 2019 20:18:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:38 +0100
Message-Id: <20190827201639.30368-12-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 27 Aug 2019 20:18:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/12] block/qcow2: implement
 .bdrv_co_preadv_part
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

Implement and use new interface to get rid of hd_qiov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-12-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-12-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2-cluster.c |  5 +++--
 block/qcow2.c         | 49 +++++++++++++++++++------------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cc5609e27a..0e4524d450 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -452,8 +452,9 @@ static int coroutine_fn do_perform_cow_read(BlockDriv=
erState *bs,
      * interface.  This avoids double I/O throttling and request trackin=
g,
      * which can lead to deadlock when block layer copy-on-read is enabl=
ed.
      */
-    ret =3D bs->drv->bdrv_co_preadv(bs, src_cluster_offset + offset_in_c=
luster,
-                                  qiov->size, qiov, 0);
+    ret =3D bs->drv->bdrv_co_preadv_part(bs,
+                                       src_cluster_offset + offset_in_cl=
uster,
+                                       qiov->size, qiov, 0, 0);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index b2b87d1a8d..ec1fff9dd1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -76,7 +76,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
                            uint64_t offset,
                            uint64_t bytes,
-                           QEMUIOVector *qiov);
+                           QEMUIOVector *qiov,
+                           size_t qiov_offset);
=20
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *fil=
ename)
 {
@@ -1967,21 +1968,18 @@ out:
     return ret;
 }
=20
-static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t o=
ffset,
-                                        uint64_t bytes, QEMUIOVector *qi=
ov,
-                                        int flags)
+static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
+                                             uint64_t offset, uint64_t b=
ytes,
+                                             QEMUIOVector *qiov,
+                                             size_t qiov_offset, int fla=
gs)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset =3D 0;
-    uint64_t bytes_done =3D 0;
-    QEMUIOVector hd_qiov;
     uint8_t *cluster_data =3D NULL;
=20
-    qemu_iovec_init(&hd_qiov, qiov->niov);
-
     while (bytes !=3D 0) {
=20
         /* prepare next request */
@@ -2000,34 +1998,31 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
=20
         offset_in_cluster =3D offset_into_cluster(s, offset);
=20
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
-
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
=20
             if (bs->backing) {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret =3D bdrv_co_preadv(bs->backing, offset, cur_bytes,
-                                     &hd_qiov, 0);
+                ret =3D bdrv_co_preadv_part(bs->backing, offset, cur_byt=
es,
+                                          qiov, qiov_offset, 0);
                 if (ret < 0) {
                     goto fail;
                 }
             } else {
                 /* Note: in this case, no need to wait */
-                qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+                qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
             }
             break;
=20
         case QCOW2_CLUSTER_ZERO_PLAIN:
         case QCOW2_CLUSTER_ZERO_ALLOC:
-            qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
+            qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
             break;
=20
         case QCOW2_CLUSTER_COMPRESSED:
             ret =3D qcow2_co_preadv_compressed(bs, cluster_offset,
                                              offset, cur_bytes,
-                                             &hd_qiov);
+                                             qiov, qiov_offset);
             if (ret < 0) {
                 goto fail;
             }
@@ -2075,12 +2070,12 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
                     ret =3D -EIO;
                     goto fail;
                 }
-                qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_=
bytes);
+                qemu_iovec_from_buf(qiov, qiov_offset, cluster_data, cur=
_bytes);
             } else {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret =3D bdrv_co_preadv(s->data_file,
-                                     cluster_offset + offset_in_cluster,
-                                     cur_bytes, &hd_qiov, 0);
+                ret =3D bdrv_co_preadv_part(s->data_file,
+                                          cluster_offset + offset_in_clu=
ster,
+                                          cur_bytes, qiov, qiov_offset, =
0);
                 if (ret < 0) {
                     goto fail;
                 }
@@ -2095,12 +2090,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
=20
         bytes -=3D cur_bytes;
         offset +=3D cur_bytes;
-        bytes_done +=3D cur_bytes;
+        qiov_offset +=3D cur_bytes;
     }
     ret =3D 0;
=20
 fail:
-    qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
=20
     return ret;
@@ -4101,7 +4095,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
                            uint64_t offset,
                            uint64_t bytes,
-                           QEMUIOVector *qiov)
+                           QEMUIOVector *qiov,
+                           size_t qiov_offset)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int ret =3D 0, csize, nb_csectors;
@@ -4132,7 +4127,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
         goto fail;
     }
=20
-    qemu_iovec_from_buf(qiov, 0, out_buf + offset_in_cluster, bytes);
+    qemu_iovec_from_buf(qiov, qiov_offset, out_buf + offset_in_cluster, =
bytes);
=20
 fail:
     qemu_vfree(out_buf);
@@ -4679,8 +4674,8 @@ static int qcow2_load_vmstate(BlockDriverState *bs,=
 QEMUIOVector *qiov,
     BDRVQcow2State *s =3D bs->opaque;
=20
     BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_LOAD);
-    return bs->drv->bdrv_co_preadv(bs, qcow2_vm_state_offset(s) + pos,
-                                   qiov->size, qiov, 0);
+    return bs->drv->bdrv_co_preadv_part(bs, qcow2_vm_state_offset(s) + p=
os,
+                                        qiov->size, qiov, 0, 0);
 }
=20
 /*
@@ -5222,7 +5217,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
-    .bdrv_co_preadv         =3D qcow2_co_preadv,
+    .bdrv_co_preadv_part    =3D qcow2_co_preadv_part,
     .bdrv_co_pwritev        =3D qcow2_co_pwritev,
     .bdrv_co_flush_to_os    =3D qcow2_co_flush_to_os,
=20
--=20
2.21.0


