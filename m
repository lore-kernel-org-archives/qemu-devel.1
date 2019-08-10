Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3418C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AACC208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AACC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwX79-0002m1-Tg
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 15:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5z-0000Jv-AN
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5x-0007CH-TQ
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:48780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5s-000772-FA; Sat, 10 Aug 2019 15:32:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5o-0000nK-UQ; Sat, 10 Aug 2019 22:31:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Sat, 10 Aug 2019 22:31:50 +0300
Message-Id: <20190810193155.58637-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190810193155.58637-1-vsementsov@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 2/7] block/backup: refactor write_flags
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

write flags are constant, let's store it in BackupBlockJob instead of
recalculating. It also makes two boolean fields to be unused, so,
drop them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d815436455..c6a3b2b7bb 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -50,14 +50,13 @@ typedef struct BackupBlockJob {
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
-    bool compress;
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
     bool use_copy_range;
     int64_t copy_range_size;
 
-    bool serialize_target_writes;
+    BdrvRequestFlags write_flags;
     bool initializing_bitmap;
 } BackupBlockJob;
 
@@ -113,10 +112,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags =
-            (job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0) |
-            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
-
 
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
@@ -135,7 +130,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     }
 
     ret = blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
-                        write_flags);
+                        job->write_flags);
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
         if (error_is_read) {
@@ -163,7 +158,6 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
@@ -172,7 +166,7 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
                             job->cluster_size * nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, write_flags);
+                            read_flags, job->write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
         bdrv_set_dirty_bitmap(job->copy_bitmap, start,
@@ -748,10 +742,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->sync_mode = sync_mode;
     job->sync_bitmap = sync_bitmap;
     job->bitmap_mode = bitmap_mode;
-    job->compress = compress;
 
-    /* Detect image-fleecing (and similar) schemes */
-    job->serialize_target_writes = bdrv_chain_contains(target, bs);
+    /*
+     * Set write flags:
+     *  1. Detect image-fleecing (and similar) schemes
+     *  2. Handle compression
+     */
+    job->write_flags =
+            (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
+            (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+
     job->cluster_size = cluster_size;
     job->copy_bitmap = copy_bitmap;
     copy_bitmap = NULL;
-- 
2.18.0


