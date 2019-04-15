Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F8C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359D42075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359D42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2xn-0006sj-AK
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:52:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vo-0005Ud-V6
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vk-0005SF-15
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:49:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:48884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2vg-0005QT-Sw; Mon, 15 Apr 2019 10:49:54 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2ve-0002By-Rc; Mon, 15 Apr 2019 17:49:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:49:48 +0300
Message-Id: <20190415144948.78568-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415144948.78568-1-vsementsov@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
	jsnow@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415144948.cphRhL7AZzSQ7_SasI4ZM6i4Y_73sOvaFYSHSjP_BsQ@z>

Split out cluster_size calculation. Move copy-bitmap creation above
block-job creation, as we are going to share it with upcoming
backup-top filter, which also should be created before actual block job
creation.

Also, while being here, drop unnecessary "goto error" from
bdrv_getlength error path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 84 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index b54386b699..79db4fbb6d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -507,6 +507,42 @@ static const BlockJobDriver backup_job_driver = {
     .drain                  = backup_drain,
 };
 
+static int64_t backup_calculate_cluster_size(BlockDriverState *target,
+                                             Error **errp)
+{
+    int ret;
+    BlockDriverInfo bdi;
+
+    /*
+     * If there is no backing file on the target, we cannot rely on COW if our
+     * backup cluster size is smaller than the target cluster size. Even for
+     * targets with a backing file, try to avoid COW if possible.
+     */
+    ret = bdrv_get_info(target, &bdi);
+    if (ret == -ENOTSUP && !target->backing) {
+        /* Cluster size is not defined */
+        warn_report("The target block device doesn't provide "
+                    "information about the block size and it doesn't have a "
+                    "backing file. The default block size of %u bytes is "
+                    "used. If the actual block size of the target exceeds "
+                    "this default, the backup may be unusable",
+                    BACKUP_CLUSTER_SIZE_DEFAULT);
+        return BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else if (ret < 0 && !target->backing) {
+        error_setg_errno(errp, -ret,
+            "Couldn't determine the cluster size of the target image, "
+            "which has no backing file");
+        error_append_hint(errp,
+            "Aborting, since this may create an unusable destination image\n");
+        return ret;
+    } else if (ret < 0 && target->backing) {
+        /* Not fatal; just trudge on ahead. */
+        return BACKUP_CLUSTER_SIZE_DEFAULT;
+    }
+
+    return MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+}
+
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
@@ -518,9 +554,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   JobTxn *txn, Error **errp)
 {
     int64_t len;
-    BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
     int ret;
+    int64_t cluster_size;
+    HBitmap *copy_bitmap = NULL;
 
     assert(bs);
     assert(target);
@@ -579,9 +616,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     if (len < 0) {
         error_setg_errno(errp, -len, "unable to get length for '%s'",
                          bdrv_get_device_name(bs));
-        goto error;
+        return NULL;
+    }
+
+    cluster_size = backup_calculate_cluster_size(target, errp);
+    if (cluster_size < 0) {
+        return NULL;
     }
 
+    copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
+
     /* job->len is fixed, so we can't allow resize */
     job = block_job_create(job_id, &backup_job_driver, txn, bs,
                            BLK_PERM_CONSISTENT_READ,
@@ -610,35 +654,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     /* Detect image-fleecing (and similar) schemes */
     job->serialize_target_writes = bdrv_chain_contains(target, bs);
-
-    /* If there is no backing file on the target, we cannot rely on COW if our
-     * backup cluster size is smaller than the target cluster size. Even for
-     * targets with a backing file, try to avoid COW if possible. */
-    ret = bdrv_get_info(target, &bdi);
-    if (ret == -ENOTSUP && !target->backing) {
-        /* Cluster size is not defined */
-        warn_report("The target block device doesn't provide "
-                    "information about the block size and it doesn't have a "
-                    "backing file. The default block size of %u bytes is "
-                    "used. If the actual block size of the target exceeds "
-                    "this default, the backup may be unusable",
-                    BACKUP_CLUSTER_SIZE_DEFAULT);
-        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
-        error_setg_errno(errp, -ret,
-            "Couldn't determine the cluster size of the target image, "
-            "which has no backing file");
-        error_append_hint(errp,
-            "Aborting, since this may create an unusable destination image\n");
-        goto error;
-    } else if (ret < 0 && target->backing) {
-        /* Not fatal; just trudge on ahead. */
-        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else {
-        job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
-    }
-
-    job->copy_bitmap = hbitmap_alloc(len, ctz32(job->cluster_size));
+    job->cluster_size = cluster_size;
+    job->copy_bitmap = copy_bitmap;
+    copy_bitmap = NULL;
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
@@ -654,6 +672,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     return &job->common;
 
  error:
+    if (copy_bitmap) {
+        assert(!job || !job->copy_bitmap);
+        hbitmap_free(copy_bitmap);
+    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
-- 
2.18.0


