Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592EC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65582077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65582077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyljm-0007wt-Dx
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPy-0006xh-JO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPw-0006HW-RK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPs-0006Aw-Dw; Fri, 16 Aug 2019 19:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E8C6190C022;
 Fri, 16 Aug 2019 23:13:50 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB0119C6A;
 Fri, 16 Aug 2019 23:13:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:12 -0400
Message-Id: <20190816231318.8650-31-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 16 Aug 2019 23:13:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 30/36] block/backup: teach TOP to never copy
 unallocated regions
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Presently, If sync=3DTOP is selected, we mark the entire bitmap as dirty.
In the write notifier handler, we dutifully copy out such regions.

Fix this in three parts:

1. Mark the bitmap as being initialized before the first yield.
2. After the first yield but before the backup loop, interrogate the
allocation status asynchronously and initialize the bitmap.
3. Teach the write notifier to interrogate allocation status if it is
invoked during bitmap initialization.

As an effect of this patch, the job progress for TOP backups
now behaves like this:

- total progress starts at bdrv_length.
- As allocation status is interrogated, total progress decreases.
- As blocks are copied, current progress increases.

Taken together, the floor and ceiling move to meet each other.


Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190716000117.25219-10-jsnow@redhat.com
[Remove ret =3D -ECANCELED change. --js]
[Squash in conflict resolution based on Max's patch --js]
Message-id: c8b0ab36-79c8-0b4b-3193-4e12ed8c848b@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c     | 79 ++++++++++++++++++++++++++++++++++++++++------
 block/trace-events |  1 +
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f6bf32c9438..9e1382ec5c6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -58,6 +58,7 @@ typedef struct BackupBlockJob {
     int64_t copy_range_size;
=20
     bool serialize_target_writes;
+    bool initializing_bitmap;
 } BackupBlockJob;
=20
 static const BlockJobDriver backup_job_driver;
@@ -227,6 +228,35 @@ static int backup_is_cluster_allocated(BackupBlockJo=
b *s, int64_t offset,
     }
 }
=20
+/**
+ * Reset bits in copy_bitmap starting at offset if they represent unallo=
cated
+ * data in the image. May reset subsequent contiguous bits.
+ * @return 0 when the cluster at @offset was unallocated,
+ *         1 otherwise, and -ret on error.
+ */
+static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
+                                               int64_t offset, int64_t *=
count)
+{
+    int ret;
+    int64_t clusters, bytes, estimate;
+
+    ret =3D backup_is_cluster_allocated(s, offset, &clusters);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bytes =3D clusters * s->cluster_size;
+
+    if (!ret) {
+        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
+        estimate =3D bdrv_get_dirty_count(s->copy_bitmap);
+        job_progress_set_remaining(&s->common.job, estimate);
+    }
+
+    *count =3D bytes;
+    return ret;
+}
+
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
                                       bool *error_is_read,
@@ -236,6 +266,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob =
*job,
     int ret =3D 0;
     int64_t start, end; /* bytes */
     void *bounce_buffer =3D NULL;
+    int64_t status_bytes;
=20
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
=20
@@ -262,6 +293,17 @@ static int coroutine_fn backup_do_cow(BackupBlockJob=
 *job,
             dirty_end =3D end;
         }
=20
+        if (job->initializing_bitmap) {
+            ret =3D backup_bitmap_reset_unallocated(job, start, &status_=
bytes);
+            if (ret =3D=3D 0) {
+                trace_backup_do_cow_skip_range(job, start, status_bytes)=
;
+                start +=3D status_bytes;
+                continue;
+            }
+            /* Clamp to known allocated region */
+            dirty_end =3D MIN(dirty_end, start + status_bytes);
+        }
+
         trace_backup_do_cow_process(job, start);
=20
         if (job->use_copy_range) {
@@ -446,18 +488,9 @@ static int coroutine_fn backup_loop(BackupBlockJob *=
job)
     int64_t offset;
     BdrvDirtyBitmapIter *bdbi;
     int ret =3D 0;
-    int64_t dummy;
=20
     bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
     while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
-        if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
-            !backup_is_cluster_allocated(job, offset, &dummy))
-        {
-            bdrv_reset_dirty_bitmap(job->copy_bitmap, offset,
-                                    job->cluster_size);
-            continue;
-        }
-
         do {
             if (yield_and_check(job)) {
                 goto out;
@@ -488,6 +521,13 @@ static void backup_init_copy_bitmap(BackupBlockJob *=
job)
                                                NULL, true);
         assert(ret);
     } else {
+        if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
+            /*
+             * We can't hog the coroutine to initialize this thoroughly.
+             * Set a flag and resume work when we are able to yield safe=
ly.
+             */
+            job->initializing_bitmap =3D true;
+        }
         bdrv_set_dirty_bitmap(job->copy_bitmap, 0, job->len);
     }
=20
@@ -509,6 +549,26 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
     s->before_write.notify =3D backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
=20
+    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
+        int64_t offset =3D 0;
+        int64_t count;
+
+        for (offset =3D 0; offset < s->len; ) {
+            if (yield_and_check(s)) {
+                ret =3D -ECANCELED;
+                goto out;
+            }
+
+            ret =3D backup_bitmap_reset_unallocated(s, offset, &count);
+            if (ret < 0) {
+                goto out;
+            }
+
+            offset +=3D count;
+        }
+        s->initializing_bitmap =3D false;
+    }
+
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
         /* All bits are set in copy_bitmap to allow any cluster to be co=
pied.
          * This does not actually require them to be copied. */
@@ -521,6 +581,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
         ret =3D backup_loop(s);
     }
=20
+ out:
     notifier_with_return_remove(&s->before_write);
=20
     /* wait until pending backup_do_cow() calls have completed */
diff --git a/block/trace-events b/block/trace-events
index d724df0117d..04209f058d4 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -41,6 +41,7 @@ mirror_yield_in_flight(void *s, int64_t offset, int in_=
flight) "s %p offset %" P
 backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t b=
ytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
 backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret)=
 "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
+backup_do_cow_skip_range(void *job, int64_t start, uint64_t bytes) "job =
%p start %"PRId64" bytes %"PRId64
 backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start=
 %"PRId64" ret %d"
 backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p star=
t %"PRId64" ret %d"
--=20
2.21.0


