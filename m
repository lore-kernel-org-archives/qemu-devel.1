Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F169C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F24208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F24208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhwa-00085x-GU
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:39:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoB-0001dm-6y
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVho6-000243-E1
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnr-0000ZG-Ty; Tue, 28 May 2019 15:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ABFD8764B;
	Tue, 28 May 2019 19:29:14 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89EBD60C47;
	Tue, 28 May 2019 19:29:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:36 +0200
Message-Id: <20190528192847.2730-11-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 28 May 2019 19:29:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/21] block/backup: move to copy_bitmap with
 granularity
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

We are going to share this bitmap between backup and backup-top filter
driver, so let's share something more meaningful. It also simplifies
some calculations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index db83b09a0b..98a2d2b070 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -112,7 +112,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIALIS=
ING : 0;
=20
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
     nbytes =3D MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
@@ -145,7 +146,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
=20
     return nbytes;
 fail:
-    hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+    hbitmap_set(job->copy_bitmap, start, job->cluster_size);
     return ret;
=20
 }
@@ -165,16 +166,15 @@ static int coroutine_fn backup_cow_with_offload(Bac=
kupBlockJob *job,
     int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIALIS=
ING : 0;
=20
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     nbytes =3D MIN(job->copy_range_size, end - start);
     nr_clusters =3D DIV_ROUND_UP(nbytes, job->cluster_size);
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
-                  nr_clusters);
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_cluste=
rs);
     ret =3D blk_co_copy_range(blk, start, job->target, start, nbytes,
                             read_flags, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
-        hbitmap_set(job->copy_bitmap, start / job->cluster_size,
-                    nr_clusters);
+        hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clus=
ters);
         return ret;
     }
=20
@@ -202,7 +202,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob =
*job,
     cow_request_begin(&cow_request, job, start, end);
=20
     while (start < end) {
-        if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
+        if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start +=3D job->cluster_size;
             continue; /* already copied */
@@ -298,12 +298,16 @@ static void backup_clean(Job *job)
     assert(s->target);
     blk_unref(s->target);
     s->target =3D NULL;
+
+    if (s->copy_bitmap) {
+        hbitmap_free(s->copy_bitmap);
+        s->copy_bitmap =3D NULL;
+    }
 }
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job =3D container_of(job, BackupBlockJob, com=
mon);
-    int64_t len;
=20
     assert(block_job_driver(job) =3D=3D &backup_job_driver);
=20
@@ -313,8 +317,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp=
)
         return;
     }
=20
-    len =3D DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
-    hbitmap_set(backup_job->copy_bitmap, 0, len);
+    hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
 }
=20
 static void backup_drain(BlockJob *job)
@@ -369,16 +372,16 @@ static int coroutine_fn backup_run_incremental(Back=
upBlockJob *job)
 {
     int ret;
     bool error_is_read;
-    int64_t cluster;
+    int64_t offset;
     HBitmapIter hbi;
=20
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster =3D hbitmap_iter_next(&hbi)) !=3D -1) {
+    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
             }
-            ret =3D backup_do_cow(job, cluster * job->cluster_size,
+            ret =3D backup_do_cow(job, offset,
                                 job->cluster_size, &error_is_read, false=
);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret)=
 =3D=3D
                            BLOCK_ERROR_ACTION_REPORT)
@@ -400,12 +403,9 @@ static void backup_incremental_init_copy_bitmap(Back=
upBlockJob *job)
     while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
                                              &offset, &bytes))
     {
-        uint64_t cluster =3D offset / job->cluster_size;
-        uint64_t end_cluster =3D DIV_ROUND_UP(offset + bytes, job->clust=
er_size);
+        hbitmap_set(job->copy_bitmap, offset, bytes);
=20
-        hbitmap_set(job->copy_bitmap, cluster, end_cluster - cluster);
-
-        offset =3D end_cluster * job->cluster_size;
+        offset +=3D bytes;
         if (offset >=3D job->len) {
             break;
         }
@@ -414,30 +414,27 @@ static void backup_incremental_init_copy_bitmap(Bac=
kupBlockJob *job)
=20
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
-        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
+        job->len - hbitmap_count(job->copy_bitmap));
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs =3D blk_bs(s->common.blk);
-    int64_t offset, nb_clusters;
+    int64_t offset;
     int ret =3D 0;
=20
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
=20
-    nb_clusters =3D DIV_ROUND_UP(s->len, s->cluster_size);
     job_progress_set_remaining(job, s->len);
=20
-    s->copy_bitmap =3D hbitmap_alloc(nb_clusters, 0);
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
         backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(s->copy_bitmap, 0, nb_clusters);
+        hbitmap_set(s->copy_bitmap, 0, s->len);
     }
=20
-
     s->before_write.notify =3D backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
=20
@@ -518,7 +515,6 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
     qemu_co_rwlock_unlock(&s->flush_rwlock);
-    hbitmap_free(s->copy_bitmap);
=20
     return ret;
 }
@@ -668,6 +664,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     } else {
         job->cluster_size =3D MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.clust=
er_size);
     }
+
+    job->copy_bitmap =3D hbitmap_alloc(len, ctz32(job->cluster_size));
     job->use_copy_range =3D true;
     job->copy_range_size =3D MIN_NON_ZERO(blk_get_max_transfer(job->comm=
on.blk),
                                         blk_get_max_transfer(job->target=
));
--=20
2.21.0


