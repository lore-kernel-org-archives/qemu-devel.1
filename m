Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DCC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892672054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892672054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXQg-00067X-HN
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWql-0006LR-Pw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqk-000866-7R
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqg-00084e-Rg; Thu, 10 Oct 2019 07:43:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16B756908B;
 Thu, 10 Oct 2019 11:43:14 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85A5B60A9F;
 Thu, 10 Oct 2019 11:43:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/36] block/qcow2: introduce parallel subrequest handling in
 read and write
Date: Thu, 10 Oct 2019 13:42:29 +0200
Message-Id: <20191010114300.7746-6-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 10 Oct 2019 11:43:14 +0000 (UTC)
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

It improves performance for fragmented qcow2 images.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190916175324.18478-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h      |   3 ++
 block/qcow2.c      | 125 ++++++++++++++++++++++++++++++++++++++++-----
 block/trace-events |   1 +
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a488d761ff..f51f478e34 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -65,6 +65,9 @@
 #define QCOW2_MAX_BITMAPS 65535
 #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
=20
+/* Maximum of parallel sub-request per guest request */
+#define QCOW2_MAX_WORKERS 8
+
 /* indicate that the refcount of the referenced cluster is exactly one. =
*/
 #define QCOW_OFLAG_COPIED     (1ULL << 63)
 /* indicate that the cluster is compressed (they never have the copied f=
lag) */
diff --git a/block/qcow2.c b/block/qcow2.c
index 164b22e4a2..7961c05783 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -41,6 +41,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto.h"
+#include "block/aio_task.h"
=20
 /*
   Differences with QCOW:
@@ -2025,6 +2026,60 @@ fail:
     return ret;
 }
=20
+typedef struct Qcow2AioTask {
+    AioTask task;
+
+    BlockDriverState *bs;
+    QCow2ClusterType cluster_type; /* only for read */
+    uint64_t file_cluster_offset;
+    uint64_t offset;
+    uint64_t bytes;
+    QEMUIOVector *qiov;
+    uint64_t qiov_offset;
+    QCowL2Meta *l2meta; /* only for write */
+} Qcow2AioTask;
+
+static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task);
+static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
+                                       AioTaskPool *pool,
+                                       AioTaskFunc func,
+                                       QCow2ClusterType cluster_type,
+                                       uint64_t file_cluster_offset,
+                                       uint64_t offset,
+                                       uint64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       size_t qiov_offset,
+                                       QCowL2Meta *l2meta)
+{
+    Qcow2AioTask local_task;
+    Qcow2AioTask *task =3D pool ? g_new(Qcow2AioTask, 1) : &local_task;
+
+    *task =3D (Qcow2AioTask) {
+        .task.func =3D func,
+        .bs =3D bs,
+        .cluster_type =3D cluster_type,
+        .qiov =3D qiov,
+        .file_cluster_offset =3D file_cluster_offset,
+        .offset =3D offset,
+        .bytes =3D bytes,
+        .qiov_offset =3D qiov_offset,
+        .l2meta =3D l2meta,
+    };
+
+    trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
+                         func =3D=3D qcow2_co_preadv_task_entry ? "read"=
 : "write",
+                         cluster_type, file_cluster_offset, offset, byte=
s,
+                         qiov, qiov_offset);
+
+    if (!pool) {
+        return func(&task->task);
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                              QCow2ClusterType cluster_ty=
pe,
                                              uint64_t file_cluster_offse=
t,
@@ -2074,18 +2129,28 @@ static coroutine_fn int qcow2_co_preadv_task(Bloc=
kDriverState *bs,
     g_assert_not_reached();
 }
=20
+static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t =3D container_of(task, Qcow2AioTask, task);
+
+    assert(!t->l2meta);
+
+    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_=
offset,
+                                t->offset, t->bytes, t->qiov, t->qiov_of=
fset);
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
-    int ret;
+    int ret =3D 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset =3D 0;
+    AioTaskPool *aio =3D NULL;
=20
-    while (bytes !=3D 0) {
-
+    while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {
         /* prepare next request */
         cur_bytes =3D MIN(bytes, INT_MAX);
         if (s->crypto) {
@@ -2097,7 +2162,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockD=
riverState *bs,
         ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluste=
r_offset);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
-            return ret;
+            goto out;
         }
=20
         if (ret =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
@@ -2106,11 +2171,14 @@ static coroutine_fn int qcow2_co_preadv_part(Bloc=
kDriverState *bs,
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
-            ret =3D qcow2_co_preadv_task(bs, ret,
-                                       cluster_offset, offset, cur_bytes=
,
-                                       qiov, qiov_offset);
+            if (!aio && cur_bytes !=3D bytes) {
+                aio =3D aio_task_pool_new(QCOW2_MAX_WORKERS);
+            }
+            ret =3D qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, =
ret,
+                                 cluster_offset, offset, cur_bytes,
+                                 qiov, qiov_offset, NULL);
             if (ret < 0) {
-                return ret;
+                goto out;
             }
         }
=20
@@ -2119,7 +2187,16 @@ static coroutine_fn int qcow2_co_preadv_part(Block=
DriverState *bs,
         qiov_offset +=3D cur_bytes;
     }
=20
-    return 0;
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret =3D=3D 0) {
+            ret =3D aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
+    return ret;
 }
=20
 /* Check if it's possible to merge a write request with the writing of
@@ -2324,6 +2401,17 @@ out_locked:
     return ret;
 }
=20
+static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
+{
+    Qcow2AioTask *t =3D container_of(task, Qcow2AioTask, task);
+
+    assert(!t->cluster_type);
+
+    return qcow2_co_pwritev_task(t->bs, t->file_cluster_offset,
+                                 t->offset, t->bytes, t->qiov, t->qiov_o=
ffset,
+                                 t->l2meta);
+}
+
 static coroutine_fn int qcow2_co_pwritev_part(
         BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
@@ -2334,10 +2422,11 @@ static coroutine_fn int qcow2_co_pwritev_part(
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
     QCowL2Meta *l2meta =3D NULL;
+    AioTaskPool *aio =3D NULL;
=20
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
=20
-    while (bytes !=3D 0) {
+    while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {
=20
         l2meta =3D NULL;
=20
@@ -2369,8 +2458,12 @@ static coroutine_fn int qcow2_co_pwritev_part(
=20
         qemu_co_mutex_unlock(&s->lock);
=20
-        ret =3D qcow2_co_pwritev_task(bs, cluster_offset, offset, cur_by=
tes,
-                                    qiov, qiov_offset, l2meta);
+        if (!aio && cur_bytes !=3D bytes) {
+            aio =3D aio_task_pool_new(QCOW2_MAX_WORKERS);
+        }
+        ret =3D qcow2_add_task(bs, aio, qcow2_co_pwritev_task_entry, 0,
+                             cluster_offset, offset, cur_bytes,
+                             qiov, qiov_offset, l2meta);
         l2meta =3D NULL; /* l2meta is consumed by qcow2_co_pwritev_task(=
) */
         if (ret < 0) {
             goto fail_nometa;
@@ -2391,6 +2484,14 @@ out_locked:
     qemu_co_mutex_unlock(&s->lock);
=20
 fail_nometa:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret =3D=3D 0) {
+            ret =3D aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
=20
     return ret;
diff --git a/block/trace-events b/block/trace-events
index 04209f058d..3aa27e6b1e 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -62,6 +62,7 @@ file_paio_submit(void *acb, void *opaque, int64_t offse=
t, int count, int type) "
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_=
t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset=
 %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId=
64
=20
 # qcow2.c
+qcow2_add_task(void *co, void *bs, void *pool, const char *action, int c=
luster_type, uint64_t file_cluster_offset, uint64_t offset, uint64_t byte=
s, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type=
 %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " =
qiov %p qiov_offset %zu"
 qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offse=
t 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
--=20
2.21.0


