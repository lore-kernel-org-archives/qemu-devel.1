Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC34CA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BD320873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObSjtJl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BD320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4ag-0007ij-Nm
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wl-0002dK-Pz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wg-0001r4-6Z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wg-0001qh-1n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2JO2BghQIoNSQXVsfHG4EPUO/umTOL8x7M1bb2GdOs=;
 b=ObSjtJl2l8GMsWnE6BVftWDzWpAEtMW9AStX3tPGRAyB+vGMcm5153gzbuKhHSB3q5gpzp
 dbMOaU4fUOcNIiNsBTZs1XxDwhg0e6x9+9l2DbyEQDpHwD1H7/KQsutVvrqYIE8eSKWFKG
 eAb0cAil8DsmnZdjItS9dWwiK6qn6jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-FGE-2gvoPz27jgK9cvbpew-1; Mon, 28 Oct 2019 08:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 001FF80183E;
 Mon, 28 Oct 2019 12:16:21 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F3315D6BB;
 Mon, 28 Oct 2019 12:16:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 38/69] block/block-copy: refactor copying
Date: Mon, 28 Oct 2019 13:14:30 +0100
Message-Id: <20191028121501.15279-39-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FGE-2gvoPz27jgK9cvbpew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Merge copying code into one function block_copy_do_copy, which only
calls bdrv_ io functions and don't do any synchronization (like dirty
bitmap set/reset).

Refactor block_copy() function so that it takes full decision about
size of chunk to be copied and does all the synchronization (checking
intersecting requests, set/reset dirty bitmaps).

It will help:
 - introduce parallel processing of block_copy iterations: we need to
   calculate chunk size, start async chunk copying and go to the next
   iteration
 - simplify synchronization improvement (like memory limiting in
   further commit and reducing critical section (now we lock the whole
   requested range, when actually we need to lock only dirty region
   which we handle at the moment))

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191022111805.3432-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 118 ++++++++++++++++++++-------------------------
 block/trace-events |   6 +--
 2 files changed, 54 insertions(+), 70 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index cd45b373a9..845b2423dc 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -126,79 +126,64 @@ void block_copy_set_callbacks(
 }
=20
 /*
- * Copy range to target with a bounce buffer and return the bytes copied. =
If
- * error occurred, return a negative error number
+ * block_copy_do_copy
+ *
+ * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len only =
to
+ * cover last cluster when s->len is not aligned to clusters.
+ *
+ * No sync here: nor bitmap neighter intersecting requests handling, only =
copy.
+ *
+ * Returns 0 on success.
  */
-static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
-                                                      int64_t start,
-                                                      int64_t end,
-                                                      bool *error_is_read)
+static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
+                                           int64_t start, int64_t end,
+                                           bool *error_is_read)
 {
     int ret;
-    int nbytes;
-    void *bounce_buffer =3D qemu_blockalign(s->source->bs, s->cluster_size=
);
+    int nbytes =3D MIN(end, s->len) - start;
+    void *bounce_buffer =3D NULL;
=20
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
-    nbytes =3D MIN(s->cluster_size, s->len - start);
+    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
+    assert(end < s->len || end =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_siz=
e));
+
+    if (s->use_copy_range) {
+        ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nby=
tes,
+                                 0, s->write_flags);
+        if (ret < 0) {
+            trace_block_copy_copy_range_fail(s, start, ret);
+            s->use_copy_range =3D false;
+            /* Fallback to read+write with allocated buffer */
+        } else {
+            goto out;
+        }
+    }
+
+    bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
=20
     ret =3D bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
     if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
+        trace_block_copy_read_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read =3D true;
         }
-        goto fail;
+        goto out;
     }
=20
     ret =3D bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
-        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
+        trace_block_copy_write_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read =3D false;
         }
-        goto fail;
+        goto out;
     }
=20
+out:
     qemu_vfree(bounce_buffer);
=20
-    return nbytes;
-fail:
-    qemu_vfree(bounce_buffer);
-    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
-
-}
-
-/*
- * Copy range to target and return the bytes copied. If error occurred, re=
turn a
- * negative error number.
- */
-static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
-                                                int64_t start,
-                                                int64_t end)
-{
-    int ret;
-    int nr_clusters;
-    int nbytes;
-
-    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
-    nbytes =3D MIN(s->copy_range_size, MIN(end, s->len) - start);
-    nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
-    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
-                            s->cluster_size * nr_clusters);
-    ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nbytes,
-                             0, s->write_flags);
-    if (ret < 0) {
-        trace_block_copy_with_offload_fail(s, start, ret);
-        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
-                              s->cluster_size * nr_clusters);
-        return ret;
-    }
-
-    return nbytes;
 }
=20
 /*
@@ -294,7 +279,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     block_copy_inflight_req_begin(s, &req, start, end);
=20
     while (start < end) {
-        int64_t dirty_end;
+        int64_t next_zero, chunk_end;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
@@ -302,10 +287,15 @@ int coroutine_fn block_copy(BlockCopyState *s,
             continue; /* already copied */
         }
=20
-        dirty_end =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
-                                                (end - start));
-        if (dirty_end < 0) {
-            dirty_end =3D end;
+        chunk_end =3D MIN(end, start + (s->use_copy_range ?
+                                      s->copy_range_size : s->cluster_size=
));
+
+        next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
+                                                chunk_end - start);
+        if (next_zero >=3D 0) {
+            assert(next_zero > start); /* start is dirty */
+            assert(next_zero < chunk_end); /* no need to do MIN() */
+            chunk_end =3D next_zero;
         }
=20
         if (s->skip_unallocated) {
@@ -316,27 +306,21 @@ int coroutine_fn block_copy(BlockCopyState *s,
                 continue;
             }
             /* Clamp to known allocated region */
-            dirty_end =3D MIN(dirty_end, start + status_bytes);
+            chunk_end =3D MIN(chunk_end, start + status_bytes);
         }
=20
         trace_block_copy_process(s, start);
=20
-        if (s->use_copy_range) {
-            ret =3D block_copy_with_offload(s, start, dirty_end);
-            if (ret < 0) {
-                s->use_copy_range =3D false;
-            }
-        }
-        if (!s->use_copy_range) {
-            ret =3D block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                error_is_read);
-        }
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+
+        ret =3D block_copy_do_copy(s, start, chunk_end, error_is_read);
         if (ret < 0) {
+            bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start=
);
             break;
         }
=20
-        start +=3D ret;
-        s->progress_bytes_callback(ret, s->progress_opaque);
+        s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
+        start =3D chunk_end;
         ret =3D 0;
     }
=20
diff --git a/block/trace-events b/block/trace-events
index b8d70f5242..ccde15a14c 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -45,9 +45,9 @@ backup_do_cow_return(void *job, int64_t offset, uint64_t =
bytes, int ret) "job %p
 block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
 block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p st=
art %"PRId64" bytes %"PRId64
 block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
-block_copy_with_bounce_buffer_read_fail(void *bcs, int64_t start, int ret)=
 "bcs %p start %"PRId64" ret %d"
-block_copy_with_bounce_buffer_write_fail(void *bcs, int64_t start, int ret=
) "bcs %p start %"PRId64" ret %d"
-block_copy_with_offload_fail(void *bcs, int64_t start, int ret) "bcs %p st=
art %"PRId64" ret %d"
+block_copy_copy_range_fail(void *bcs, int64_t start, int ret) "bcs %p star=
t %"PRId64" ret %d"
+block_copy_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PR=
Id64" ret %d"
+block_copy_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"P=
RId64" ret %d"
=20
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
--=20
2.21.0


