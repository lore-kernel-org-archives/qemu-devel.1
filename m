Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B0C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5074420726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9IMUqwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5074420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC24Y-0001Oj-Fz
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nR-0005Di-Lz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nO-0003AA-Re
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nO-00039R-MM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/uZDSPpfVWIiFgnW/C64syiVb6nwo8HlWQkJRVxJAk=;
 b=K9IMUqwvHSuj9gqe1aeCQMiPyvCxMd0h8i8Lq6Qx/nMedukPDvLPrhfcWlOQ5KZq8yk2eE
 WkJMV0b9qElSmRfEndM9NEQSXUDNM25ENvYfF8KltHrZQSUcNbiyxXsQS2B2jzi+L2yras
 +qZlRPRBaO5CTV3k/krFomZklqXiMk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-PL-rxqLxMfmJMjKttC46uw-1; Wed, 11 Mar 2020 09:53:12 -0400
X-MC-Unique: PL-rxqLxMfmJMjKttC46uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC8A8010EA;
 Wed, 11 Mar 2020 13:53:11 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F505C13D;
 Wed, 11 Mar 2020 13:53:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/19] block/block-copy: reduce intersecting request lock
Date: Wed, 11 Mar 2020 14:52:12 +0100
Message-Id: <20200311135213.1242028-19-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Currently, block_copy operation lock the whole requested region. But
there is no reason to lock clusters, which are already copied, it will
disturb other parallel block_copy requests for no reason.

Let's instead do the following:

Lock only sub-region, which we are going to operate on. Then, after
copying all dirty sub-regions, we should wait for intersecting
requests block-copy, if they failed, we should retry these new dirty
clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200311103004.7649-9-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 129 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 105 insertions(+), 24 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 8b91fa0b06..44a64a94c8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -39,29 +39,72 @@ static BlockCopyInFlightReq *find_conflicting_inflight_=
req(BlockCopyState *s,
     return NULL;
 }
=20
-static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
-                                                       int64_t offset,
-                                                       int64_t bytes)
+/*
+ * If there are no intersecting requests return false. Otherwise, wait for=
 the
+ * first found intersecting request to finish and return true.
+ */
+static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t of=
fset,
+                                             int64_t bytes)
 {
-    BlockCopyInFlightReq *req;
+    BlockCopyInFlightReq *req =3D find_conflicting_inflight_req(s, offset,=
 bytes);
=20
-    while ((req =3D find_conflicting_inflight_req(s, offset, bytes))) {
-        qemu_co_queue_wait(&req->wait_queue, NULL);
+    if (!req) {
+        return false;
     }
+
+    qemu_co_queue_wait(&req->wait_queue, NULL);
+
+    return true;
 }
=20
+/* Called only on full-dirty region */
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
                                           int64_t offset, int64_t bytes)
 {
+    assert(!find_conflicting_inflight_req(s, offset, bytes));
+
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+    s->in_flight_bytes +=3D bytes;
+
     req->offset =3D offset;
     req->bytes =3D bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
 }
=20
-static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightReq =
*req)
+/*
+ * block_copy_inflight_req_shrink
+ *
+ * Drop the tail of the request to be handled later. Set dirty bits back a=
nd
+ * wake up all requests waiting for us (may be some of them are not inters=
ecting
+ * with shrunk request)
+ */
+static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
+        BlockCopyInFlightReq *req, int64_t new_bytes)
 {
+    if (new_bytes =3D=3D req->bytes) {
+        return;
+    }
+
+    assert(new_bytes > 0 && new_bytes < req->bytes);
+
+    s->in_flight_bytes -=3D req->bytes - new_bytes;
+    bdrv_set_dirty_bitmap(s->copy_bitmap,
+                          req->offset + new_bytes, req->bytes - new_bytes)=
;
+
+    req->bytes =3D new_bytes;
+    qemu_co_queue_restart_all(&req->wait_queue);
+}
+
+static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
+                                                     BlockCopyInFlightReq =
*req,
+                                                     int ret)
+{
+    s->in_flight_bytes -=3D req->bytes;
+    if (ret < 0) {
+        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
+    }
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
 }
@@ -357,12 +400,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState *=
s,
     return ret;
 }
=20
-int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t offset, int64_t bytes,
-                            bool *error_is_read)
+/*
+ * block_copy_dirty_clusters
+ *
+ * Copy dirty clusters in @offset/@bytes range.
+ * Returns 1 if dirty clusters found and successfully copied, 0 if no dirt=
y
+ * clusters found and -errno on failure.
+ */
+static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
+                                                  int64_t offset, int64_t =
bytes,
+                                                  bool *error_is_read)
 {
     int ret =3D 0;
-    BlockCopyInFlightReq req;
+    bool found_dirty =3D false;
=20
     /*
      * block_copy() user is responsible for keeping source and target in s=
ame
@@ -374,10 +424,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
-    block_copy_wait_inflight_reqs(s, offset, bytes);
-    block_copy_inflight_req_begin(s, &req, offset, bytes);
-
     while (bytes) {
+        BlockCopyInFlightReq req;
         int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -387,6 +435,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
=20
+        found_dirty =3D true;
+
         cur_bytes =3D MIN(bytes, s->copy_size);
=20
         next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
@@ -396,10 +446,14 @@ int coroutine_fn block_copy(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
             cur_bytes =3D next_zero - offset;
         }
+        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
=20
         ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
+        assert(ret >=3D 0); /* never fail */
+        cur_bytes =3D MIN(cur_bytes, status_bytes);
+        block_copy_inflight_req_shrink(s, &req, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
+            block_copy_inflight_req_end(s, &req, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -409,21 +463,15 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue;
         }
=20
-        cur_bytes =3D MIN(cur_bytes, status_bytes);
-
         trace_block_copy_process(s, offset);
=20
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-        s->in_flight_bytes +=3D cur_bytes;
-
         co_get_from_shres(s->mem, cur_bytes);
         ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        s->in_flight_bytes -=3D cur_bytes;
+        block_copy_inflight_req_end(s, &req, ret);
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
-            break;
+            return ret;
         }
=20
         progress_work_done(s->progress, cur_bytes);
@@ -432,7 +480,40 @@ int coroutine_fn block_copy(BlockCopyState *s,
         bytes -=3D cur_bytes;
     }
=20
-    block_copy_inflight_req_end(&req);
+    return found_dirty;
+}
+
+/*
+ * block_copy
+ *
+ * Copy requested region, accordingly to dirty bitmap.
+ * Collaborate with parallel block_copy requests: if they succeed it will =
help
+ * us. If they fail, we will retry not-copied regions. So, if we return er=
ror,
+ * it means that some I/O operation failed in context of _this_ block_copy=
 call,
+ * not some parallel operation.
+ */
+int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t byt=
es,
+                            bool *error_is_read)
+{
+    int ret;
+
+    do {
+        ret =3D block_copy_dirty_clusters(s, offset, bytes, error_is_read)=
;
+
+        if (ret =3D=3D 0) {
+            ret =3D block_copy_wait_one(s, offset, bytes);
+        }
+
+        /*
+         * We retry in two cases:
+         * 1. Some progress done
+         *    Something was copied, which means that there were yield poin=
ts
+         *    and some new dirty bits may have appeared (due to failed par=
allel
+         *    block-copy requests).
+         * 2. We have waited for some intersecting block-copy request
+         *    It may have failed and produced new dirty bits.
+         */
+    } while (ret > 0);
=20
     return ret;
 }
--=20
2.24.1


