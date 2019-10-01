Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A53ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E9521906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E9521906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFI3t-0000Bd-AG
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFHyz-0004de-3q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFHyw-0006Nu-TY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:14:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:60988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFHyr-0006DA-9f; Tue, 01 Oct 2019 09:14:19 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFHyk-00040D-H4; Tue, 01 Oct 2019 16:14:10 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v15 2/5] block/backup: move write_flags calculation inside
 backup_job_create
Date: Tue,  1 Oct 2019 16:14:06 +0300
Message-Id: <20191001131409.14202-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001131409.14202-1-vsementsov@virtuozzo.com>
References: <20191001131409.14202-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is logic-less refactoring, which simplifies further patch, as
we'll need write_flags for backup-top filter creation and backup-top
should be created before block job creation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d918836f1d..b5b7939356 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -446,20 +446,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    /* job->len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK_PERM_ALL,
-                           speed, creation_flags, cb, opaque, errp);
-    if (!job) {
-        goto error;
-    }
-
-    job->source_bs = bs;
-    job->on_source_error = on_source_error;
-    job->on_target_error = on_target_error;
-    job->sync_mode = sync_mode;
-    job->sync_bitmap = sync_bitmap;
-    job->bitmap_mode = bitmap_mode;
-
     /*
      * If source is in backing chain of target assume that target is going to be
      * used for "image fleecing", i.e. it should represent a kind of snapshot of
@@ -477,6 +463,20 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     write_flags = (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
                   (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
 
+    /* job->len is fixed, so we can't allow resize */
+    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK_PERM_ALL,
+                           speed, creation_flags, cb, opaque, errp);
+    if (!job) {
+        goto error;
+    }
+
+    job->source_bs = bs;
+    job->on_source_error = on_source_error;
+    job->on_target_error = on_target_error;
+    job->sync_mode = sync_mode;
+    job->sync_bitmap = sync_bitmap;
+    job->bitmap_mode = bitmap_mode;
+
     job->bcs = block_copy_state_new(bs, target, cluster_size, write_flags,
                                     backup_progress_bytes_callback,
                                     backup_progress_reset_callback, job, errp);
@@ -485,11 +485,11 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     job->cluster_size = cluster_size;
+    job->len = len;
 
     /* Required permissions are already taken by block-copy-state target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
-    job->len = len;
 
     return &job->common;
 
-- 
2.21.0


