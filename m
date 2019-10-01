Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A7C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466B92133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466B92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTM5-0000ds-Ee
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0001tN-Dl
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsJ-0002MQ-MU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsJ-0001q0-7g; Tue, 01 Oct 2019 19:48:11 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlMkk193517; Tue, 1 Oct 2019 19:47:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:45 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NliBU194129;
 Tue, 1 Oct 2019 19:47:45 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:44 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njl1G006380;
 Tue, 1 Oct 2019 23:47:44 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04wdc.us.ibm.com with ESMTP id 2v9y57ye8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:44 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nli2653674454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECE6828058;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C781F28059;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:43 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/97] block/backup: move to copy_bitmap with granularity
Date: Tue,  1 Oct 2019 18:45:38 -0500
Message-Id: <20191001234616.7825-60-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
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
(cherry picked from commit a8389e315ef71913ae99cf8f3b1f89e84631f599)
*prereq for 4a5b91ca
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d9f5db18ac..510fc54f98 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -113,7 +113,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
     nbytes = MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
@@ -147,7 +148,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
 
     return nbytes;
 fail:
-    hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+    hbitmap_set(job->copy_bitmap, start, job->cluster_size);
     return ret;
 
 }
@@ -167,16 +168,15 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     nbytes = MIN(job->copy_range_size, end - start);
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
-                  nr_clusters);
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
                             read_flags, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
-        hbitmap_set(job->copy_bitmap, start / job->cluster_size,
-                    nr_clusters);
+        hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clusters);
         return ret;
     }
 
@@ -204,7 +204,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     while (start < end) {
-        if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
+        if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start += job->cluster_size;
             continue; /* already copied */
@@ -300,6 +300,11 @@ static void backup_clean(Job *job)
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
+
+    if (s->copy_bitmap) {
+        hbitmap_free(s->copy_bitmap);
+        s->copy_bitmap = NULL;
+    }
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
@@ -312,7 +317,6 @@ static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
-    int64_t len;
 
     assert(block_job_driver(job) == &backup_job_driver);
 
@@ -322,8 +326,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    len = DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
-    hbitmap_set(backup_job->copy_bitmap, 0, len);
+    hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
 }
 
 static void backup_drain(BlockJob *job)
@@ -378,16 +381,16 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
-    int64_t cluster;
+    int64_t offset;
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+    while ((offset = hbitmap_iter_next(&hbi)) != -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
             }
-            ret = backup_do_cow(job, cluster * job->cluster_size,
+            ret = backup_do_cow(job, offset,
                                 job->cluster_size, &error_is_read, false);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
@@ -409,12 +412,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
                                              &offset, &bytes))
     {
-        uint64_t cluster = offset / job->cluster_size;
-        uint64_t end_cluster = DIV_ROUND_UP(offset + bytes, job->cluster_size);
+        hbitmap_set(job->copy_bitmap, offset, bytes);
 
-        hbitmap_set(job->copy_bitmap, cluster, end_cluster - cluster);
-
-        offset = end_cluster * job->cluster_size;
+        offset += bytes;
         if (offset >= job->len) {
             break;
         }
@@ -423,30 +423,27 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
-        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
+        job->len - hbitmap_count(job->copy_bitmap));
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset, nb_clusters;
+    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
 
-    nb_clusters = DIV_ROUND_UP(s->len, s->cluster_size);
     job_progress_set_remaining(job, s->len);
 
-    s->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
     if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(s->copy_bitmap, 0, nb_clusters);
+        hbitmap_set(s->copy_bitmap, 0, s->len);
     }
 
-
     s->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
 
@@ -527,7 +524,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
     qemu_co_rwlock_unlock(&s->flush_rwlock);
-    hbitmap_free(s->copy_bitmap);
 
     return ret;
 }
@@ -678,6 +674,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
+
+    job->copy_bitmap = hbitmap_alloc(len, ctz32(job->cluster_size));
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
-- 
2.17.1


