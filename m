Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E4C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31328206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31328206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylbO-0005ZR-P2
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPh-0006R4-Qr
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPe-0005sQ-DJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPY-0005iV-QL; Fri, 16 Aug 2019 19:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03B16308FE8D;
 Fri, 16 Aug 2019 23:13:32 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FAEB10512;
 Fri, 16 Aug 2019 23:13:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:53 -0400
Message-Id: <20190816231318.8650-12-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 16 Aug 2019 23:13:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/36] block/backup: upgrade copy_bitmap to
 BdrvDirtyBitmap
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

This simplifies some interface matters; namely the initialization and
(later) merging the manifest back into the sync_bitmap if it was
provided.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-12-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d07b838930f..474f8eeae29 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -38,7 +38,10 @@ typedef struct CowRequest {
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockBackend *target;
+
     BdrvDirtyBitmap *sync_bitmap;
+    BdrvDirtyBitmap *copy_bitmap;
+
     MirrorSyncMode sync_mode;
     BitmapSyncMode bitmap_mode;
     BlockdevOnError on_source_error;
@@ -51,7 +54,6 @@ typedef struct BackupBlockJob {
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
=20
-    HBitmap *copy_bitmap;
     bool use_copy_range;
     int64_t copy_range_size;
=20
@@ -113,7 +115,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIALIS=
ING : 0;
=20
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
     nbytes =3D MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
@@ -146,7 +148,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
=20
     return nbytes;
 fail:
-    hbitmap_set(job->copy_bitmap, start, job->cluster_size);
+    bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
     return ret;
=20
 }
@@ -169,12 +171,14 @@ static int coroutine_fn backup_cow_with_offload(Bac=
kupBlockJob *job,
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     nbytes =3D MIN(job->copy_range_size, end - start);
     nr_clusters =3D DIV_ROUND_UP(nbytes, job->cluster_size);
-    hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_cluste=
rs);
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
+                            job->cluster_size * nr_clusters);
     ret =3D blk_co_copy_range(blk, start, job->target, start, nbytes,
                             read_flags, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
-        hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clus=
ters);
+        bdrv_set_dirty_bitmap(job->copy_bitmap, start,
+                              job->cluster_size * nr_clusters);
         return ret;
     }
=20
@@ -204,13 +208,14 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b *job,
     while (start < end) {
         int64_t dirty_end;
=20
-        if (!hbitmap_get(job->copy_bitmap, start)) {
+        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start +=3D job->cluster_size;
             continue; /* already copied */
         }
=20
-        dirty_end =3D hbitmap_next_zero(job->copy_bitmap, start, (end - =
start));
+        dirty_end =3D bdrv_dirty_bitmap_next_zero(job->copy_bitmap, star=
t,
+                                                (end - start));
         if (dirty_end < 0) {
             dirty_end =3D end;
         }
@@ -307,14 +312,16 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
+    BlockDriverState *bs =3D blk_bs(s->common.blk);
+
+    if (s->copy_bitmap) {
+        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
+        s->copy_bitmap =3D NULL;
+    }
+
     assert(s->target);
     blk_unref(s->target);
     s->target =3D NULL;
-
-    if (s->copy_bitmap) {
-        hbitmap_free(s->copy_bitmap);
-        s->copy_bitmap =3D NULL;
-    }
 }
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -329,7 +336,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp=
)
         return;
     }
=20
-    hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
+    bdrv_set_dirty_bitmap(backup_job->copy_bitmap, 0, backup_job->len);
 }
=20
 static void backup_drain(BlockJob *job)
@@ -398,59 +405,52 @@ static bool bdrv_is_unallocated_range(BlockDriverSt=
ate *bs,
=20
 static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
-    int ret;
     bool error_is_read;
     int64_t offset;
-    HBitmapIter hbi;
+    BdrvDirtyBitmapIter *bdbi;
     BlockDriverState *bs =3D blk_bs(job->common.blk);
+    int ret =3D 0;
=20
-    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
+    bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
+    while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
         if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
             bdrv_is_unallocated_range(bs, offset, job->cluster_size))
         {
-            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            bdrv_reset_dirty_bitmap(job->copy_bitmap, offset,
+                                    job->cluster_size);
             continue;
         }
=20
         do {
             if (yield_and_check(job)) {
-                return 0;
+                goto out;
             }
             ret =3D backup_do_cow(job, offset,
                                 job->cluster_size, &error_is_read, false=
);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret)=
 =3D=3D
                            BLOCK_ERROR_ACTION_REPORT)
             {
-                return ret;
+                goto out;
             }
         } while (ret < 0);
     }
=20
-    return 0;
+ out:
+    bdrv_dirty_iter_free(bdbi);
+    return ret;
 }
=20
 /* init copy_bitmap from sync_bitmap */
 static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 {
-    uint64_t offset =3D 0;
-    uint64_t bytes =3D job->len;
-
-    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
-                                             &offset, &bytes))
-    {
-        hbitmap_set(job->copy_bitmap, offset, bytes);
-
-        offset +=3D bytes;
-        if (offset >=3D job->len) {
-            break;
-        }
-        bytes =3D job->len - offset;
-    }
+    bool ret =3D bdrv_dirty_bitmap_merge_internal(job->copy_bitmap,
+                                                job->sync_bitmap,
+                                                NULL, true);
+    assert(ret);
=20
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
-        job->len - hbitmap_count(job->copy_bitmap));
+                        job->len - bdrv_get_dirty_count(job->copy_bitmap=
));
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
@@ -467,7 +467,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
         backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(s->copy_bitmap, 0, s->len);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, 0, s->len);
     }
=20
     s->before_write.notify =3D backup_before_write_notify;
@@ -560,7 +560,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     BackupBlockJob *job =3D NULL;
     int ret;
     int64_t cluster_size;
-    HBitmap *copy_bitmap =3D NULL;
+    BdrvDirtyBitmap *copy_bitmap =3D NULL;
=20
     assert(bs);
     assert(target);
@@ -630,7 +630,11 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
         goto error;
     }
=20
-    copy_bitmap =3D hbitmap_alloc(len, ctz32(cluster_size));
+    copy_bitmap =3D bdrv_create_dirty_bitmap(bs, cluster_size, NULL, err=
p);
+    if (!copy_bitmap) {
+        goto error;
+    }
+    bdrv_disable_dirty_bitmap(copy_bitmap);
=20
     /* job->len is fixed, so we can't allow resize */
     job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
@@ -682,7 +686,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
  error:
     if (copy_bitmap) {
         assert(!job || !job->copy_bitmap);
-        hbitmap_free(copy_bitmap);
+        bdrv_release_dirty_bitmap(bs, copy_bitmap);
     }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
--=20
2.21.0


