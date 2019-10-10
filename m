Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F25E20673
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F25E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXKH-0006qJ-31
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWqj-0006HN-Dh
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqh-00085F-S1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqe-00083b-Io; Thu, 10 Oct 2019 07:43:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6B18308FE8F;
 Thu, 10 Oct 2019 11:43:11 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41EC75DAAC;
 Thu, 10 Oct 2019 11:43:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/36] block/qcow2: refactor qcow2_co_pwritev_part
Date: Thu, 10 Oct 2019 13:42:28 +0200
Message-Id: <20191010114300.7746-5-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 11:43:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Similarly to previous commit, prepare for parallelizing write-loop
iterations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190916175324.18478-5-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 154 +++++++++++++++++++++++++++++---------------------
 1 file changed, 90 insertions(+), 64 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6feb169f7c..164b22e4a2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2242,6 +2242,88 @@ static int handle_alloc_space(BlockDriverState *bs=
, QCowL2Meta *l2meta)
     return 0;
 }
=20
+/*
+ * qcow2_co_pwritev_task
+ * Called with s->lock unlocked
+ * l2meta  - if not NULL, qcow2_co_pwritev_task() will consume it. Calle=
r must
+ *           not use it somehow after qcow2_co_pwritev_task() call
+ */
+static coroutine_fn int qcow2_co_pwritev_task(BlockDriverState *bs,
+                                              uint64_t file_cluster_offs=
et,
+                                              uint64_t offset, uint64_t =
bytes,
+                                              QEMUIOVector *qiov,
+                                              uint64_t qiov_offset,
+                                              QCowL2Meta *l2meta)
+{
+    int ret;
+    BDRVQcow2State *s =3D bs->opaque;
+    void *crypt_buf =3D NULL;
+    int offset_in_cluster =3D offset_into_cluster(s, offset);
+    QEMUIOVector encrypted_qiov;
+
+    if (bs->encrypted) {
+        assert(s->crypto);
+        assert(bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+        crypt_buf =3D qemu_try_blockalign(bs->file->bs, bytes);
+        if (crypt_buf =3D=3D NULL) {
+            ret =3D -ENOMEM;
+            goto out_unlocked;
+        }
+        qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
+
+        if (qcow2_co_encrypt(bs, file_cluster_offset + offset_in_cluster=
,
+                             offset, crypt_buf, bytes) < 0)
+        {
+            ret =3D -EIO;
+            goto out_unlocked;
+        }
+
+        qemu_iovec_init_buf(&encrypted_qiov, crypt_buf, bytes);
+        qiov =3D &encrypted_qiov;
+        qiov_offset =3D 0;
+    }
+
+    /* Try to efficiently initialize the physical space with zeroes */
+    ret =3D handle_alloc_space(bs, l2meta);
+    if (ret < 0) {
+        goto out_unlocked;
+    }
+
+    /*
+     * If we need to do COW, check if it's possible to merge the
+     * writing of the guest data together with that of the COW regions.
+     * If it's not possible (or not necessary) then write the
+     * guest data now.
+     */
+    if (!merge_cow(offset, bytes, qiov, qiov_offset, l2meta)) {
+        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        trace_qcow2_writev_data(qemu_coroutine_self(),
+                                file_cluster_offset + offset_in_cluster)=
;
+        ret =3D bdrv_co_pwritev_part(s->data_file,
+                                   file_cluster_offset + offset_in_clust=
er,
+                                   bytes, qiov, qiov_offset, 0);
+        if (ret < 0) {
+            goto out_unlocked;
+        }
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+
+    ret =3D qcow2_handle_l2meta(bs, &l2meta, true);
+    goto out_locked;
+
+out_unlocked:
+    qemu_co_mutex_lock(&s->lock);
+
+out_locked:
+    qcow2_handle_l2meta(bs, &l2meta, false);
+    qemu_co_mutex_unlock(&s->lock);
+
+    qemu_vfree(crypt_buf);
+
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_pwritev_part(
         BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
@@ -2251,15 +2333,10 @@ static coroutine_fn int qcow2_co_pwritev_part(
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    QEMUIOVector encrypted_qiov;
-    uint64_t bytes_done =3D 0;
-    uint8_t *cluster_data =3D NULL;
     QCowL2Meta *l2meta =3D NULL;
=20
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
=20
-    qemu_co_mutex_lock(&s->lock);
-
     while (bytes !=3D 0) {
=20
         l2meta =3D NULL;
@@ -2273,6 +2350,8 @@ static coroutine_fn int qcow2_co_pwritev_part(
                             - offset_in_cluster);
         }
=20
+        qemu_co_mutex_lock(&s->lock);
+
         ret =3D qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &cluster_offset, &l2meta);
         if (ret < 0) {
@@ -2290,73 +2369,20 @@ static coroutine_fn int qcow2_co_pwritev_part(
=20
         qemu_co_mutex_unlock(&s->lock);
=20
-        if (bs->encrypted) {
-            assert(s->crypto);
-            if (!cluster_data) {
-                cluster_data =3D qemu_try_blockalign(bs->file->bs,
-                                                   QCOW_MAX_CRYPT_CLUSTE=
RS
-                                                   * s->cluster_size);
-                if (cluster_data =3D=3D NULL) {
-                    ret =3D -ENOMEM;
-                    goto out_unlocked;
-                }
-            }
-
-            assert(cur_bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_s=
ize);
-            qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
-                              cluster_data, cur_bytes);
-
-            if (qcow2_co_encrypt(bs, cluster_offset + offset_in_cluster,=
 offset,
-                                 cluster_data, cur_bytes) < 0) {
-                ret =3D -EIO;
-                goto out_unlocked;
-            }
-
-            qemu_iovec_init_buf(&encrypted_qiov, cluster_data, cur_bytes=
);
-        }
-
-        /* Try to efficiently initialize the physical space with zeroes =
*/
-        ret =3D handle_alloc_space(bs, l2meta);
+        ret =3D qcow2_co_pwritev_task(bs, cluster_offset, offset, cur_by=
tes,
+                                    qiov, qiov_offset, l2meta);
+        l2meta =3D NULL; /* l2meta is consumed by qcow2_co_pwritev_task(=
) */
         if (ret < 0) {
-            goto out_unlocked;
-        }
-
-        /* If we need to do COW, check if it's possible to merge the
-         * writing of the guest data together with that of the COW regio=
ns.
-         * If it's not possible (or not necessary) then write the
-         * guest data now. */
-        if (!merge_cow(offset, cur_bytes,
-                       bs->encrypted ? &encrypted_qiov : qiov,
-                       bs->encrypted ? 0 : qiov_offset + bytes_done, l2m=
eta))
-        {
-            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-            trace_qcow2_writev_data(qemu_coroutine_self(),
-                                    cluster_offset + offset_in_cluster);
-            ret =3D bdrv_co_pwritev_part(
-                    s->data_file, cluster_offset + offset_in_cluster, cu=
r_bytes,
-                    bs->encrypted ? &encrypted_qiov : qiov,
-                    bs->encrypted ? 0 : qiov_offset + bytes_done, 0);
-            if (ret < 0) {
-                goto out_unlocked;
-            }
-        }
-
-        qemu_co_mutex_lock(&s->lock);
-
-        ret =3D qcow2_handle_l2meta(bs, &l2meta, true);
-        if (ret) {
-            goto out_locked;
+            goto fail_nometa;
         }
=20
         bytes -=3D cur_bytes;
         offset +=3D cur_bytes;
-        bytes_done +=3D cur_bytes;
+        qiov_offset +=3D cur_bytes;
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
     ret =3D 0;
-    goto out_locked;
=20
-out_unlocked:
     qemu_co_mutex_lock(&s->lock);
=20
 out_locked:
@@ -2364,7 +2390,7 @@ out_locked:
=20
     qemu_co_mutex_unlock(&s->lock);
=20
-    qemu_vfree(cluster_data);
+fail_nometa:
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
=20
     return ret;
--=20
2.21.0


