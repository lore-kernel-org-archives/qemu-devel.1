Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99EFC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F91208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPU0ax3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F91208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC20u-0006nj-Is
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nO-00056v-FC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nM-00038I-MG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nM-00037e-IC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fTMGy0HlugooGNV8hUaMH3C1OSddma3wpKlfqZ3UhI=;
 b=HPU0ax3DSuJGnAMMY9sV5fypP79xDTLBI/Epx1w3c5oN0vN4B1NqPNuAufNrTVSOFacyJa
 /Wt3ZaRwvEqhtxtZLRrnIahBmdatj9Drn/cB+I8Ah7Wd9eHEQ4sxp2ZAvwLsHzGEcV1ck0
 GZaFXfhiravtgyFhYHsFBq23KJIt61c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Bouu3kwuM7eKZi8341B7dQ-1; Wed, 11 Mar 2020 09:53:06 -0400
X-MC-Unique: Bouu3kwuM7eKZi8341B7dQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF2C1137840;
 Wed, 11 Mar 2020 13:53:05 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A33D5C13D;
 Wed, 11 Mar 2020 13:53:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/19] block/block-copy: refactor interfaces to use bytes
 instead of end
Date: Wed, 11 Mar 2020 14:52:10 +0100
Message-Id: <20200311135213.1242028-17-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

We have a lot of "chunk_end - start" invocations, let's switch to
bytes/cur_bytes scheme instead.

While being here, improve check on block_copy_do_copy parameters to not
overflow when calculating nbytes and use int64_t for bytes in
block_copy for consistency.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-7-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c         | 78 ++++++++++++++++++++------------------
 include/block/block-copy.h |  6 +--
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 251d415a2c..4c947e548b 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -26,12 +26,12 @@
=20
 static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
                                                            int64_t start,
-                                                           int64_t end)
+                                                           int64_t bytes)
 {
     BlockCopyInFlightReq *req;
=20
     QLIST_FOREACH(req, &s->inflight_reqs, list) {
-        if (end > req->start_byte && start < req->end_byte) {
+        if (start + bytes > req->start && start < req->start + req->bytes)=
 {
             return req;
         }
     }
@@ -41,21 +41,21 @@ static BlockCopyInFlightReq *find_conflicting_inflight_=
req(BlockCopyState *s,
=20
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
-                                                       int64_t end)
+                                                       int64_t bytes)
 {
     BlockCopyInFlightReq *req;
=20
-    while ((req =3D find_conflicting_inflight_req(s, start, end))) {
+    while ((req =3D find_conflicting_inflight_req(s, start, bytes))) {
         qemu_co_queue_wait(&req->wait_queue, NULL);
     }
 }
=20
 static void block_copy_inflight_req_begin(BlockCopyState *s,
                                           BlockCopyInFlightReq *req,
-                                          int64_t start, int64_t end)
+                                          int64_t start, int64_t bytes)
 {
-    req->start_byte =3D start;
-    req->end_byte =3D end;
+    req->start =3D start;
+    req->bytes =3D bytes;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
 }
@@ -153,24 +153,28 @@ void block_copy_set_progress_meter(BlockCopyState *s,=
 ProgressMeter *pm)
 /*
  * block_copy_do_copy
  *
- * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len only =
to
- * cover last cluster when s->len is not aligned to clusters.
+ * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
+ * s->len only to cover last cluster when s->len is not aligned to cluster=
s.
  *
  * No sync here: nor bitmap neighter intersecting requests handling, only =
copy.
  *
  * Returns 0 on success.
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
-                                           int64_t start, int64_t end,
+                                           int64_t start, int64_t bytes,
                                            bool zeroes, bool *error_is_rea=
d)
 {
     int ret;
-    int nbytes =3D MIN(end, s->len) - start;
+    int64_t nbytes =3D MIN(start + bytes, s->len) - start;
     void *bounce_buffer =3D NULL;
=20
+    assert(start >=3D 0 && bytes > 0 && INT64_MAX - start >=3D bytes);
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
-    assert(end < s->len || end =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_siz=
e));
+    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
+    assert(start < s->len);
+    assert(start + bytes <=3D s->len ||
+           start + bytes =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_size));
+    assert(nbytes < INT_MAX);
=20
     if (zeroes) {
         ret =3D bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_f=
lags &
@@ -354,11 +358,10 @@ int64_t block_copy_reset_unallocated(BlockCopyState *=
s,
 }
=20
 int coroutine_fn block_copy(BlockCopyState *s,
-                            int64_t start, uint64_t bytes,
+                            int64_t start, int64_t bytes,
                             bool *error_is_read)
 {
     int ret =3D 0;
-    int64_t end =3D bytes + start; /* bytes */
     BlockCopyInFlightReq req;
=20
     /*
@@ -369,32 +372,32 @@ int coroutine_fn block_copy(BlockCopyState *s,
            bdrv_get_aio_context(s->target->bs));
=20
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
     block_copy_wait_inflight_reqs(s, start, bytes);
-    block_copy_inflight_req_begin(s, &req, start, end);
+    block_copy_inflight_req_begin(s, &req, start, bytes);
=20
-    while (start < end) {
-        int64_t next_zero, chunk_end, status_bytes;
+    while (bytes) {
+        int64_t next_zero, cur_bytes, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
             start +=3D s->cluster_size;
+            bytes -=3D s->cluster_size;
             continue; /* already copied */
         }
=20
-        chunk_end =3D MIN(end, start + s->copy_size);
+        cur_bytes =3D MIN(bytes, s->copy_size);
=20
         next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                chunk_end - start);
+                                                cur_bytes);
         if (next_zero >=3D 0) {
             assert(next_zero > start); /* start is dirty */
-            assert(next_zero < chunk_end); /* no need to do MIN() */
-            chunk_end =3D next_zero;
+            assert(next_zero < start + cur_bytes); /* no need to do MIN() =
*/
+            cur_bytes =3D next_zero - start;
         }
=20
-        ret =3D block_copy_block_status(s, start, chunk_end - start,
-                                      &status_bytes);
+        ret =3D block_copy_block_status(s, start, cur_bytes, &status_bytes=
);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
             progress_set_remaining(s->progress,
@@ -402,30 +405,31 @@ int coroutine_fn block_copy(BlockCopyState *s,
                                    s->in_flight_bytes);
             trace_block_copy_skip_range(s, start, status_bytes);
             start +=3D status_bytes;
+            bytes -=3D status_bytes;
             continue;
         }
=20
-        chunk_end =3D MIN(chunk_end, start + status_bytes);
+        cur_bytes =3D MIN(cur_bytes, status_bytes);
=20
         trace_block_copy_process(s, start);
=20
-        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
-        s->in_flight_bytes +=3D chunk_end - start;
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
+        s->in_flight_bytes +=3D cur_bytes;
=20
-        co_get_from_shres(s->mem, chunk_end - start);
-        ret =3D block_copy_do_copy(s, start, chunk_end, ret & BDRV_BLOCK_Z=
ERO,
+        co_get_from_shres(s->mem, cur_bytes);
+        ret =3D block_copy_do_copy(s, start, cur_bytes, ret & BDRV_BLOCK_Z=
ERO,
                                  error_is_read);
-        co_put_to_shres(s->mem, chunk_end - start);
-        s->in_flight_bytes -=3D chunk_end - start;
+        co_put_to_shres(s->mem, cur_bytes);
+        s->in_flight_bytes -=3D cur_bytes;
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start=
);
+            bdrv_set_dirty_bitmap(s->copy_bitmap, start, cur_bytes);
             break;
         }
=20
-        progress_work_done(s->progress, chunk_end - start);
-        s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
-        start =3D chunk_end;
-        ret =3D 0;
+        progress_work_done(s->progress, cur_bytes);
+        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
+        start +=3D cur_bytes;
+        bytes -=3D cur_bytes;
     }
=20
     block_copy_inflight_req_end(&req);
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 9def00068c..7fd36e528b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,8 +19,8 @@
 #include "qemu/co-shared-resource.h"
=20
 typedef struct BlockCopyInFlightReq {
-    int64_t start_byte;
-    int64_t end_byte;
+    int64_t start;
+    int64_t bytes;
     QLIST_ENTRY(BlockCopyInFlightReq) list;
     CoQueue wait_queue; /* coroutines blocked on this request */
 } BlockCopyInFlightReq;
@@ -85,7 +85,7 @@ void block_copy_state_free(BlockCopyState *s);
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
                                      int64_t offset, int64_t *count);
=20
-int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t byt=
es,
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t byte=
s,
                             bool *error_is_read);
=20
 #endif /* BLOCK_COPY_H */
--=20
2.24.1


