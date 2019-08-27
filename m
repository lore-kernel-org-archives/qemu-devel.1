Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099132077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099132077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i2z-0000OF-3t
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hv3-0006z2-Uy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2hv2-0001Bd-8M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2huy-0001AD-56; Tue, 27 Aug 2019 16:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 753873DE04;
 Tue, 27 Aug 2019 20:18:15 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E5E260600;
 Tue, 27 Aug 2019 20:18:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:39 +0100
Message-Id: <20190827201639.30368-13-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 27 Aug 2019 20:18:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/12] block/qcow2: implement
 .bdrv_co_pwritev(_compressed)_part
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
Message-id: 20190604161514.262241-13-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-13-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.h         |  1 +
 include/qemu/iov.h    |  1 +
 block/qcow2-cluster.c |  9 ++++---
 block/qcow2.c         | 60 +++++++++++++++++++++----------------------
 util/iov.c            | 10 ++++++++
 5 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fc1b0d3c1e..998bcdaef1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -420,6 +420,7 @@ typedef struct QCowL2Meta
      * from @cow_start and @cow_end into one single write operation.
      */
     QEMUIOVector *data_qiov;
+    size_t data_qiov_offset;
=20
     /** Pointer to next L2Meta of the same write request */
     struct QCowL2Meta *next;
diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 29957c8a72..bffc151282 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -206,6 +206,7 @@ void qemu_iovec_init_extended(
         void *tail_buf, size_t tail_len);
 void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
                            size_t offset, size_t len);
+int qemu_iovec_subvec_niov(QEMUIOVector *qiov, size_t offset, size_t len=
);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
 void qemu_iovec_concat(QEMUIOVector *dst,
                        QEMUIOVector *src, size_t soffset, size_t sbytes)=
;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0e4524d450..f09cc992af 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -829,7 +829,6 @@ static int perform_cow(BlockDriverState *bs, QCowL2Me=
ta *m)
     assert(start->nb_bytes <=3D UINT_MAX - end->nb_bytes);
     assert(start->nb_bytes + end->nb_bytes <=3D UINT_MAX - data_bytes);
     assert(start->offset + start->nb_bytes <=3D end->offset);
-    assert(!m->data_qiov || m->data_qiov->size =3D=3D data_bytes);
=20
     if ((start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) || m->skip_=
cow) {
         return 0;
@@ -861,7 +860,11 @@ static int perform_cow(BlockDriverState *bs, QCowL2M=
eta *m)
     /* The part of the buffer where the end region is located */
     end_buffer =3D start_buffer + buffer_size - end->nb_bytes;
=20
-    qemu_iovec_init(&qiov, 2 + (m->data_qiov ? m->data_qiov->niov : 0));
+    qemu_iovec_init(&qiov, 2 + (m->data_qiov ?
+                                qemu_iovec_subvec_niov(m->data_qiov,
+                                                       m->data_qiov_offs=
et,
+                                                       data_bytes)
+                                : 0));
=20
     qemu_co_mutex_unlock(&s->lock);
     /* First we read the existing data from both COW regions. We
@@ -904,7 +907,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Me=
ta *m)
         if (start->nb_bytes) {
             qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
         }
-        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
+        qemu_iovec_concat(&qiov, m->data_qiov, m->data_qiov_offset, data=
_bytes);
         if (end->nb_bytes) {
             qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index ec1fff9dd1..0882ff6e92 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2103,7 +2103,8 @@ fail:
 /* Check if it's possible to merge a write request with the writing of
  * the data from the COW regions */
 static bool merge_cow(uint64_t offset, unsigned bytes,
-                      QEMUIOVector *hd_qiov, QCowL2Meta *l2meta)
+                      QEMUIOVector *qiov, size_t qiov_offset,
+                      QCowL2Meta *l2meta)
 {
     QCowL2Meta *m;
=20
@@ -2132,11 +2133,12 @@ static bool merge_cow(uint64_t offset, unsigned b=
ytes,
=20
         /* Make sure that adding both COW regions to the QEMUIOVector
          * does not exceed IOV_MAX */
-        if (hd_qiov->niov > IOV_MAX - 2) {
+        if (qemu_iovec_subvec_niov(qiov, qiov_offset, bytes) > IOV_MAX -=
 2) {
             continue;
         }
=20
-        m->data_qiov =3D hd_qiov;
+        m->data_qiov =3D qiov;
+        m->data_qiov_offset =3D qiov_offset;
         return true;
     }
=20
@@ -2218,24 +2220,22 @@ static int handle_alloc_space(BlockDriverState *b=
s, QCowL2Meta *l2meta)
     return 0;
 }
=20
-static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t =
offset,
-                                         uint64_t bytes, QEMUIOVector *q=
iov,
-                                         int flags)
+static coroutine_fn int qcow2_co_pwritev_part(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    QEMUIOVector hd_qiov;
+    QEMUIOVector encrypted_qiov;
     uint64_t bytes_done =3D 0;
     uint8_t *cluster_data =3D NULL;
     QCowL2Meta *l2meta =3D NULL;
=20
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
=20
-    qemu_iovec_init(&hd_qiov, qiov->niov);
-
     qemu_co_mutex_lock(&s->lock);
=20
     while (bytes !=3D 0) {
@@ -2268,9 +2268,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
=20
         qemu_co_mutex_unlock(&s->lock);
=20
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
-
         if (bs->encrypted) {
             assert(s->crypto);
             if (!cluster_data) {
@@ -2283,9 +2280,9 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
                 }
             }
=20
-            assert(hd_qiov.size <=3D
-                   QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-            qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
+            assert(cur_bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_s=
ize);
+            qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
+                              cluster_data, cur_bytes);
=20
             if (qcow2_co_encrypt(bs, cluster_offset, offset,
                                  cluster_data, cur_bytes) < 0) {
@@ -2293,8 +2290,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
                 goto out_unlocked;
             }
=20
-            qemu_iovec_reset(&hd_qiov);
-            qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
+            qemu_iovec_init_buf(&encrypted_qiov, cluster_data, cur_bytes=
);
         }
=20
         /* Try to efficiently initialize the physical space with zeroes =
*/
@@ -2307,13 +2303,17 @@ static coroutine_fn int qcow2_co_pwritev(BlockDri=
verState *bs, uint64_t offset,
          * writing of the guest data together with that of the COW regio=
ns.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
-        if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
+        if (!merge_cow(offset, cur_bytes,
+                       bs->encrypted ? &encrypted_qiov : qiov,
+                       bs->encrypted ? 0 : qiov_offset + bytes_done, l2m=
eta))
+        {
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
-            ret =3D bdrv_co_pwritev(s->data_file,
-                                  cluster_offset + offset_in_cluster,
-                                  cur_bytes, &hd_qiov, 0);
+            ret =3D bdrv_co_pwritev_part(
+                    s->data_file, cluster_offset + offset_in_cluster, cu=
r_bytes,
+                    bs->encrypted ? &encrypted_qiov : qiov,
+                    bs->encrypted ? 0 : qiov_offset + bytes_done, 0);
             if (ret < 0) {
                 goto out_unlocked;
             }
@@ -2342,7 +2342,6 @@ out_locked:
=20
     qemu_co_mutex_unlock(&s->lock);
=20
-    qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
=20
@@ -4007,8 +4006,9 @@ fail:
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                            uint64_t bytes, QEMUIOVector *qiov)
+qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, size_t qiov_offset)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int ret;
@@ -4045,7 +4045,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
     }
-    qemu_iovec_to_buf(qiov, 0, buf, bytes);
+    qemu_iovec_to_buf(qiov, qiov_offset, buf, bytes);
=20
     out_buf =3D g_malloc(s->cluster_size);
=20
@@ -4053,7 +4053,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
                                 buf, s->cluster_size);
     if (out_len =3D=3D -ENOMEM) {
         /* could not compress: write normal cluster */
-        ret =3D qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
+        ret =3D qcow2_co_pwritev_part(bs, offset, bytes, qiov, qiov_offs=
et, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -4664,8 +4664,8 @@ static int qcow2_save_vmstate(BlockDriverState *bs,=
 QEMUIOVector *qiov,
     BDRVQcow2State *s =3D bs->opaque;
=20
     BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
-    return bs->drv->bdrv_co_pwritev(bs, qcow2_vm_state_offset(s) + pos,
-                                    qiov->size, qiov, 0);
+    return bs->drv->bdrv_co_pwritev_part(bs, qcow2_vm_state_offset(s) + =
pos,
+                                         qiov->size, qiov, 0, 0);
 }
=20
 static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
@@ -5218,7 +5218,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
     .bdrv_co_preadv_part    =3D qcow2_co_preadv_part,
-    .bdrv_co_pwritev        =3D qcow2_co_pwritev,
+    .bdrv_co_pwritev_part   =3D qcow2_co_pwritev_part,
     .bdrv_co_flush_to_os    =3D qcow2_co_flush_to_os,
=20
     .bdrv_co_pwrite_zeroes  =3D qcow2_co_pwrite_zeroes,
@@ -5226,7 +5226,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_co_copy_range_from =3D qcow2_co_copy_range_from,
     .bdrv_co_copy_range_to  =3D qcow2_co_copy_range_to,
     .bdrv_co_truncate       =3D qcow2_co_truncate,
-    .bdrv_co_pwritev_compressed =3D qcow2_co_pwritev_compressed,
+    .bdrv_co_pwritev_compressed_part =3D qcow2_co_pwritev_compressed_par=
t,
     .bdrv_make_empty        =3D qcow2_make_empty,
=20
     .bdrv_snapshot_create   =3D qcow2_snapshot_create,
diff --git a/util/iov.c b/util/iov.c
index 9ac0261853..5059e10431 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -401,6 +401,16 @@ static struct iovec *qiov_slice(QEMUIOVector *qiov,
     return iov;
 }
=20
+int qemu_iovec_subvec_niov(QEMUIOVector *qiov, size_t offset, size_t len=
)
+{
+    size_t head, tail;
+    int niov;
+
+    qiov_slice(qiov, offset, len, &head, &tail, &niov);
+
+    return niov;
+}
+
 /*
  * Compile new iovec, combining @head_buf buffer, sub-qiov of @mid_qiov,
  * and @tail_buf buffer into new qiov.
--=20
2.21.0


