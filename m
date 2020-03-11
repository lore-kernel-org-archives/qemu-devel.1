Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA8C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E0C20726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+OQ7cM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E0C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1zz-0004cb-TQ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1n9-0004aD-Ld
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1n7-0002n5-1M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1n6-0002mB-SD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWeGnapCLQS4U0a0RdOw4GDwSoqQejgdINLCDmAXr3U=;
 b=h+OQ7cM+ISpO64r0wVDsAadI6oEG888/RFH976q8HTzBfkaSrse8JsHPrkCHCzD1TUa5lw
 24EZ60fFSUs00pkNYUV8JU4irkOWAGEKG+Sdumf5ibQzNYUV1y6Rl6dyvq7yuTxjM8Z3sB
 PTBDQzKbDDVDjTaTaL+X9vLg3q96r28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-RFqpzlc1MceP1kpPpPHZ7w-1; Wed, 11 Mar 2020 09:52:53 -0400
X-MC-Unique: RFqpzlc1MceP1kpPpPHZ7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E088018A3;
 Wed, 11 Mar 2020 13:52:52 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D526127BD7;
 Wed, 11 Mar 2020 13:52:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/19] block/block-copy: fix progress calculation
Date: Wed, 11 Mar 2020 14:52:06 +0100
Message-Id: <20200311135213.1242028-13-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Assume we have two regions, A and B, and region B is in-flight now,
region A is not yet touched, but it is unallocated and should be
skipped.

Correspondingly, as progress we have

  total =3D A + B
  current =3D 0

If we reset unallocated region A and call progress_reset_callback,
it will calculate 0 bytes dirty in the bitmap and call
job_progress_set_remaining, which will set

   total =3D current + 0 =3D 0 + 0 =3D 0

So, B bytes are actually removed from total accounting. When job
finishes we'll have

   total =3D 0
   current =3D B

, which doesn't sound good.

This is because we didn't considered in-flight bytes, actually when
calculating remaining, we should have set (in_flight + dirty_bytes)
as remaining, not only dirty_bytes.

To fix it, let's refactor progress calculation, moving it to block-copy
itself instead of fixing callback. And, of course, track in_flight
bytes count.

We still have to keep one callback, to maintain backup job bytes_read
calculation, but it will go on soon, when we turn the whole backup
process into one block_copy call.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200311103004.7649-3-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c             | 13 ++-----------
 block/block-copy.c         | 16 ++++++++++++----
 include/block/block-copy.h | 15 +++++----------
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 1383e219f5..8694e0394b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -57,15 +57,6 @@ static void backup_progress_bytes_callback(int64_t bytes=
, void *opaque)
     BackupBlockJob *s =3D opaque;
=20
     s->bytes_read +=3D bytes;
-    job_progress_update(&s->common.job, bytes);
-}
-
-static void backup_progress_reset_callback(void *opaque)
-{
-    BackupBlockJob *s =3D opaque;
-    uint64_t estimate =3D bdrv_get_dirty_count(s->bcs->copy_bitmap);
-
-    job_progress_set_remaining(&s->common.job, estimate);
 }
=20
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
@@ -464,8 +455,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDr=
iverState *bs,
     job->cluster_size =3D cluster_size;
     job->len =3D len;
=20
-    block_copy_set_callbacks(bcs, backup_progress_bytes_callback,
-                             backup_progress_reset_callback, job);
+    block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, =
job);
+    block_copy_set_progress_meter(bcs, &job->common.job.progress);
=20
     /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/block-copy.c b/block/block-copy.c
index 79798a1567..e2d7b3b887 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -127,17 +127,20 @@ BlockCopyState *block_copy_state_new(BdrvChild *sourc=
e, BdrvChild *target,
     return s;
 }
=20
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque)
 {
     s->progress_bytes_callback =3D progress_bytes_callback;
-    s->progress_reset_callback =3D progress_reset_callback;
     s->progress_opaque =3D progress_opaque;
 }
=20
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
+{
+    s->progress =3D pm;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -269,7 +272,9 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
=20
     if (!ret) {
         bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        s->progress_reset_callback(s->progress_opaque);
+        progress_set_remaining(s->progress,
+                               bdrv_get_dirty_count(s->copy_bitmap) +
+                               s->in_flight_bytes);
     }
=20
     *count =3D bytes;
@@ -331,15 +336,18 @@ int coroutine_fn block_copy(BlockCopyState *s,
         trace_block_copy_process(s, start);
=20
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+        s->in_flight_bytes +=3D chunk_end - start;
=20
         co_get_from_shres(s->mem, chunk_end - start);
         ret =3D block_copy_do_copy(s, start, chunk_end, error_is_read);
         co_put_to_shres(s->mem, chunk_end - start);
+        s->in_flight_bytes -=3D chunk_end - start;
         if (ret < 0) {
             bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start=
);
             break;
         }
=20
+        progress_work_done(s->progress, chunk_end - start);
         s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
         start =3D chunk_end;
         ret =3D 0;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0a161724d7..9def00068c 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -26,7 +26,6 @@ typedef struct BlockCopyInFlightReq {
 } BlockCopyInFlightReq;
=20
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
-typedef void (*ProgressResetCallbackFunc)(void *opaque);
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -36,6 +35,7 @@ typedef struct BlockCopyState {
     BdrvChild *source;
     BdrvChild *target;
     BdrvDirtyBitmap *copy_bitmap;
+    int64_t in_flight_bytes;
     int64_t cluster_size;
     bool use_copy_range;
     int64_t copy_size;
@@ -60,15 +60,9 @@ typedef struct BlockCopyState {
      */
     bool skip_unallocated;
=20
+    ProgressMeter *progress;
     /* progress_bytes_callback: called when some copying progress is done.=
 */
     ProgressBytesCallbackFunc progress_bytes_callback;
-
-    /*
-     * progress_reset_callback: called when some bytes reset from copy_bit=
map
-     * (see @skip_unallocated above). The callee is assumed to recalculate=
 how
-     * many bytes remain based on the dirty bit count of copy_bitmap.
-     */
-    ProgressResetCallbackFunc progress_reset_callback;
     void *progress_opaque;
=20
     SharedResource *mem;
@@ -79,12 +73,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source,=
 BdrvChild *target,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
=20
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque);
=20
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
+
 void block_copy_state_free(BlockCopyState *s);
=20
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
--=20
2.24.1


