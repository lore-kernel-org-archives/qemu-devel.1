Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6DC20650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6DC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXHA-000333-Vy
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWqh-0006E7-EV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqf-00084J-Pn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqc-00082N-As; Thu, 10 Oct 2019 07:43:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AE22307D88C;
 Thu, 10 Oct 2019 11:43:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D9E5D6A5;
 Thu, 10 Oct 2019 11:43:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/36] block/qcow2: refactor qcow2_co_preadv_part
Date: Thu, 10 Oct 2019 13:42:27 +0200
Message-Id: <20191010114300.7746-4-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 10 Oct 2019 11:43:09 +0000 (UTC)
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

Further patch will run partial requests of iterations of
qcow2_co_preadv in parallel for performance reasons. To prepare for
this, separate part which may be parallelized into separate function
(qcow2_co_preadv_task).

While being here, also separate encrypted clusters reading to own
function, like it is done for compressed reading.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190916175324.18478-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 209 +++++++++++++++++++++++++++-----------------------
 1 file changed, 113 insertions(+), 96 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4d16393e61..6feb169f7c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1972,17 +1972,117 @@ out:
     return ret;
 }
=20
+static coroutine_fn int
+qcow2_co_preadv_encrypted(BlockDriverState *bs,
+                           uint64_t file_cluster_offset,
+                           uint64_t offset,
+                           uint64_t bytes,
+                           QEMUIOVector *qiov,
+                           uint64_t qiov_offset)
+{
+    int ret;
+    BDRVQcow2State *s =3D bs->opaque;
+    uint8_t *buf;
+
+    assert(bs->encrypted && s->crypto);
+    assert(bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+
+    /*
+     * For encrypted images, read everything into a temporary
+     * contiguous buffer on which the AES functions can work.
+     * Also, decryption in a separate buffer is better as it
+     * prevents the guest from learning information about the
+     * encrypted nature of the virtual disk.
+     */
+
+    buf =3D qemu_try_blockalign(s->data_file->bs, bytes);
+    if (buf =3D=3D NULL) {
+        return -ENOMEM;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+    ret =3D bdrv_co_pread(s->data_file,
+                        file_cluster_offset + offset_into_cluster(s, off=
set),
+                        bytes, buf, 0);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+    if (qcow2_co_decrypt(bs,
+                         file_cluster_offset + offset_into_cluster(s, of=
fset),
+                         offset, buf, bytes) < 0)
+    {
+        ret =3D -EIO;
+        goto fail;
+    }
+    qemu_iovec_from_buf(qiov, qiov_offset, buf, bytes);
+
+fail:
+    qemu_vfree(buf);
+
+    return ret;
+}
+
+static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
+                                             QCow2ClusterType cluster_ty=
pe,
+                                             uint64_t file_cluster_offse=
t,
+                                             uint64_t offset, uint64_t b=
ytes,
+                                             QEMUIOVector *qiov,
+                                             size_t qiov_offset)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int offset_in_cluster =3D offset_into_cluster(s, offset);
+
+    switch (cluster_type) {
+    case QCOW2_CLUSTER_ZERO_PLAIN:
+    case QCOW2_CLUSTER_ZERO_ALLOC:
+        /* Both zero types are handled in qcow2_co_preadv_part */
+        g_assert_not_reached();
+
+    case QCOW2_CLUSTER_UNALLOCATED:
+        assert(bs->backing); /* otherwise handled in qcow2_co_preadv_par=
t */
+
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+        return bdrv_co_preadv_part(bs->backing, offset, bytes,
+                                   qiov, qiov_offset, 0);
+
+    case QCOW2_CLUSTER_COMPRESSED:
+        return qcow2_co_preadv_compressed(bs, file_cluster_offset,
+                                          offset, bytes, qiov, qiov_offs=
et);
+
+    case QCOW2_CLUSTER_NORMAL:
+        if ((file_cluster_offset & 511) !=3D 0) {
+            return -EIO;
+        }
+
+        if (bs->encrypted) {
+            return qcow2_co_preadv_encrypted(bs, file_cluster_offset,
+                                             offset, bytes, qiov, qiov_o=
ffset);
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        return bdrv_co_preadv_part(s->data_file,
+                                   file_cluster_offset + offset_in_clust=
er,
+                                   bytes, qiov, qiov_offset, 0);
+
+    default:
+        g_assert_not_reached();
+    }
+
+    g_assert_not_reached();
+}
+
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
                                              uint64_t offset, uint64_t b=
ytes,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset, int fla=
gs)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset =3D 0;
-    uint8_t *cluster_data =3D NULL;
=20
     while (bytes !=3D 0) {
=20
@@ -1997,112 +2097,29 @@ static coroutine_fn int qcow2_co_preadv_part(Blo=
ckDriverState *bs,
         ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluste=
r_offset);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
-            goto fail;
+            return ret;
         }
=20
-        offset_in_cluster =3D offset_into_cluster(s, offset);
-
-        switch (ret) {
-        case QCOW2_CLUSTER_UNALLOCATED:
-
-            if (bs->backing) {
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret =3D bdrv_co_preadv_part(bs->backing, offset, cur_byt=
es,
-                                          qiov, qiov_offset, 0);
-                if (ret < 0) {
-                    goto fail;
-                }
-            } else {
-                /* Note: in this case, no need to wait */
-                qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
-            }
-            break;
-
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_ZERO_ALLOC:
+        if (ret =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
+            ret =3D=3D QCOW2_CLUSTER_ZERO_ALLOC ||
+            (ret =3D=3D QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
-            break;
-
-        case QCOW2_CLUSTER_COMPRESSED:
-            ret =3D qcow2_co_preadv_compressed(bs, cluster_offset,
-                                             offset, cur_bytes,
-                                             qiov, qiov_offset);
+        } else {
+            ret =3D qcow2_co_preadv_task(bs, ret,
+                                       cluster_offset, offset, cur_bytes=
,
+                                       qiov, qiov_offset);
             if (ret < 0) {
-                goto fail;
-            }
-
-            break;
-
-        case QCOW2_CLUSTER_NORMAL:
-            if ((cluster_offset & 511) !=3D 0) {
-                ret =3D -EIO;
-                goto fail;
-            }
-
-            if (bs->encrypted) {
-                assert(s->crypto);
-
-                /*
-                 * For encrypted images, read everything into a temporar=
y
-                 * contiguous buffer on which the AES functions can work=
.
-                 */
-                if (!cluster_data) {
-                    cluster_data =3D
-                        qemu_try_blockalign(s->data_file->bs,
-                                            QCOW_MAX_CRYPT_CLUSTERS
-                                            * s->cluster_size);
-                    if (cluster_data =3D=3D NULL) {
-                        ret =3D -ENOMEM;
-                        goto fail;
-                    }
-                }
-
-                assert(cur_bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->clust=
er_size);
-
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret =3D bdrv_co_pread(s->data_file,
-                                    cluster_offset + offset_in_cluster,
-                                    cur_bytes, cluster_data, 0);
-                if (ret < 0) {
-                    goto fail;
-                }
-
-                assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-                assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
-                if (qcow2_co_decrypt(bs, cluster_offset + offset_in_clus=
ter,
-                                     offset,
-                                     cluster_data, cur_bytes) < 0) {
-                    ret =3D -EIO;
-                    goto fail;
-                }
-                qemu_iovec_from_buf(qiov, qiov_offset, cluster_data, cur=
_bytes);
-            } else {
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret =3D bdrv_co_preadv_part(s->data_file,
-                                          cluster_offset + offset_in_clu=
ster,
-                                          cur_bytes, qiov, qiov_offset, =
0);
-                if (ret < 0) {
-                    goto fail;
-                }
+                return ret;
             }
-            break;
-
-        default:
-            g_assert_not_reached();
-            ret =3D -EIO;
-            goto fail;
         }
=20
         bytes -=3D cur_bytes;
         offset +=3D cur_bytes;
         qiov_offset +=3D cur_bytes;
     }
-    ret =3D 0;
-
-fail:
-    qemu_vfree(cluster_data);
=20
-    return ret;
+    return 0;
 }
=20
 /* Check if it's possible to merge a write request with the writing of
--=20
2.21.0


