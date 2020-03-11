Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E7EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EC620726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERJG/wPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EC620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC233-0003yK-Cf
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nD-0004kV-S2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nC-0002rU-9p
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nC-0002qq-4U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLI4CO0lYmsE3HMfdKwXPXoJGri25UffaJPnJtC3324=;
 b=ERJG/wPUQdCnno4eqB7ASMtKPOg9nZaeO8IlsBv5U124amk3qTHc0jSIZbxMtqzeJysOe/
 eLpi3fEf3VeU4VyJCNjwdjYKwmj3r8GjRoBBJzHgaidvHMROcmPdYvYxg+TZ3Gj78ZF9UE
 /TDWB4NS1qyhg95q5g7uZ9rkM9oFeao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-nKzPK9ABP3-Sj6r77mz_lw-1; Wed, 11 Mar 2020 09:52:59 -0400
X-MC-Unique: nKzPK9ABP3-Sj6r77mz_lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D583B1005510;
 Wed, 11 Mar 2020 13:52:58 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5091F91D9B;
 Wed, 11 Mar 2020 13:52:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/19] block/block-copy: use block_status
Date: Wed, 11 Mar 2020 14:52:08 +0100
Message-Id: <20200311135213.1242028-15-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Use bdrv_block_status_above to chose effective chunk size and to handle
zeroes effectively.

This substitutes checking for just being allocated or not, and drops
old code path for it. Assistance by backup job is dropped too, as
caching block-status information is more difficult than just caching
is-allocated information in our dirty bitmap, and backup job is not
good place for this caching anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-5-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 73 +++++++++++++++++++++++++++++++++++++---------
 block/trace-events |  1 +
 2 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index ddd61c1652..b075dba206 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -155,7 +155,7 @@ void block_copy_set_progress_meter(BlockCopyState *s, P=
rogressMeter *pm)
  */
 static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
                                            int64_t start, int64_t end,
-                                           bool *error_is_read)
+                                           bool zeroes, bool *error_is_rea=
d)
 {
     int ret;
     int nbytes =3D MIN(end, s->len) - start;
@@ -165,6 +165,18 @@ static int coroutine_fn block_copy_do_copy(BlockCopySt=
ate *s,
     assert(QEMU_IS_ALIGNED(end, s->cluster_size));
     assert(end < s->len || end =3D=3D QEMU_ALIGN_UP(s->len, s->cluster_siz=
e));
=20
+    if (zeroes) {
+        ret =3D bdrv_co_pwrite_zeroes(s->target, start, nbytes, s->write_f=
lags &
+                                    ~BDRV_REQ_WRITE_COMPRESSED);
+        if (ret < 0) {
+            trace_block_copy_write_zeroes_fail(s, start, ret);
+            if (error_is_read) {
+                *error_is_read =3D false;
+            }
+        }
+        return ret;
+    }
+
     if (s->use_copy_range) {
         ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nby=
tes,
                                  0, s->write_flags);
@@ -230,6 +242,38 @@ out:
     return ret;
 }
=20
+static int block_copy_block_status(BlockCopyState *s, int64_t offset,
+                                   int64_t bytes, int64_t *pnum)
+{
+    int64_t num;
+    BlockDriverState *base;
+    int ret;
+
+    if (s->skip_unallocated && s->source->bs->backing) {
+        base =3D s->source->bs->backing->bs;
+    } else {
+        base =3D NULL;
+    }
+
+    ret =3D bdrv_block_status_above(s->source->bs, base, offset, bytes, &n=
um,
+                                  NULL, NULL);
+    if (ret < 0 || num < s->cluster_size) {
+        /*
+         * On error or if failed to obtain large enough chunk just fallbac=
k to
+         * copy one cluster.
+         */
+        num =3D s->cluster_size;
+        ret =3D BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_DATA;
+    } else if (offset + num =3D=3D s->len) {
+        num =3D QEMU_ALIGN_UP(num, s->cluster_size);
+    } else {
+        num =3D QEMU_ALIGN_DOWN(num, s->cluster_size);
+    }
+
+    *pnum =3D num;
+    return ret;
+}
+
 /*
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this allocati=
on.
@@ -308,7 +352,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
 {
     int ret =3D 0;
     int64_t end =3D bytes + start; /* bytes */
-    int64_t status_bytes;
     BlockCopyInFlightReq req;
=20
     /*
@@ -325,7 +368,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
     block_copy_inflight_req_begin(s, &req, start, end);
=20
     while (start < end) {
-        int64_t next_zero, chunk_end;
+        int64_t next_zero, chunk_end, status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
             trace_block_copy_skip(s, start);
@@ -343,24 +386,28 @@ int coroutine_fn block_copy(BlockCopyState *s,
             chunk_end =3D next_zero;
         }
=20
-        if (s->skip_unallocated) {
-            ret =3D block_copy_reset_unallocated(s, start, &status_bytes);
-            if (ret =3D=3D 0) {
-                trace_block_copy_skip_range(s, start, status_bytes);
-                start +=3D status_bytes;
-                continue;
-            }
-            /* Clamp to known allocated region */
-            chunk_end =3D MIN(chunk_end, start + status_bytes);
+        ret =3D block_copy_block_status(s, start, chunk_end - start,
+                                      &status_bytes);
+        if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
+            bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes);
+            progress_set_remaining(s->progress,
+                                   bdrv_get_dirty_count(s->copy_bitmap) +
+                                   s->in_flight_bytes);
+            trace_block_copy_skip_range(s, start, status_bytes);
+            start +=3D status_bytes;
+            continue;
         }
=20
+        chunk_end =3D MIN(chunk_end, start + status_bytes);
+
         trace_block_copy_process(s, start);
=20
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
         s->in_flight_bytes +=3D chunk_end - start;
=20
         co_get_from_shres(s->mem, chunk_end - start);
-        ret =3D block_copy_do_copy(s, start, chunk_end, error_is_read);
+        ret =3D block_copy_do_copy(s, start, chunk_end, ret & BDRV_BLOCK_Z=
ERO,
+                                 error_is_read);
         co_put_to_shres(s->mem, chunk_end - start);
         s->in_flight_bytes -=3D chunk_end - start;
         if (ret < 0) {
diff --git a/block/trace-events b/block/trace-events
index 1a7329b736..29dff8881c 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -48,6 +48,7 @@ block_copy_process(void *bcs, int64_t start) "bcs %p star=
t %"PRId64
 block_copy_copy_range_fail(void *bcs, int64_t start, int ret) "bcs %p star=
t %"PRId64" ret %d"
 block_copy_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PR=
Id64" ret %d"
 block_copy_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"P=
RId64" ret %d"
+block_copy_write_zeroes_fail(void *bcs, int64_t start, int ret) "bcs %p st=
art %"PRId64" ret %d"
=20
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
--=20
2.24.1


