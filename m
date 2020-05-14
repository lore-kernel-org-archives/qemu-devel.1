Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31048C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F237E20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeFcpXdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F237E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ4tO-0001DB-Vh
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 23:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sM-0008Hf-74
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sL-0008Os-54
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589428175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DakAMMTOM/Cl2KoiyY6elE7hq/Egw2UX8VearchFniw=;
 b=SeFcpXdZU/g3LN+z3j/S0KKGVM29ZRMvdik5FtOsPcx3jvbBjYfZuSkJNZ7lawB4TeisRX
 kmEaAXd5oQou/8Mrby2Ak0cjFDpuwsx/CA+BOHGCiY1EHsPpkYkg8ZcDnF19AXOexXj6QE
 R0ubxbgiXx6MXFvHITqcEdfyVFFzuuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-TaSIYb0ZNUak08Q3LKuexA-1; Wed, 13 May 2020 23:49:33 -0400
X-MC-Unique: TaSIYb0ZNUak08Q3LKuexA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA52F464;
 Thu, 14 May 2020 03:49:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93E07529E;
 Thu, 14 May 2020 03:49:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 1/5] block: add bitmap-populate job
Date: Wed, 13 May 2020 23:49:18 -0400
Message-Id: <20200514034922.24834-2-jsnow@redhat.com>
In-Reply-To: <20200514034922.24834-1-jsnow@redhat.com>
References: <20200514034922.24834-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This job copies the allocation map into a bitmap. It's a job because
there's no guarantee that allocation interrogation will be quick (or
won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.

It was designed with different possible population patterns in mind,
but only top layer allocation was implemented for now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json      |  48 +++++++++
 qapi/job.json             |   2 +-
 include/block/block_int.h |  21 ++++
 block/bitmap-alloc.c      | 207 ++++++++++++++++++++++++++++++++++++++
 blockjob.c                |   3 +-
 block/Makefile.objs       |   1 +
 6 files changed, 280 insertions(+), 2 deletions(-)
 create mode 100644 block/bitmap-alloc.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a..0fb527a9a1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2202,6 +2202,54 @@
       { 'command': 'block-dirty-bitmap-merge',
         'data': 'BlockDirtyBitmapMerge' }
 
+##
+# @BitmapPattern:
+#
+# An enumeration of possible patterns that can be written into a bitmap.
+#
+# @allocation-top: The allocation status of the top layer
+#                  of the attached storage node.
+#
+# Since: 5.0
+##
+{ 'enum': 'BitmapPattern',
+  'data': ['allocation-top'] }
+
+##
+# @BlockDirtyBitmapPopulate:
+#
+# @job-id: identifier for the newly-created block job.
+#
+# @pattern: What pattern should be written into the bitmap?
+#
+# @on-error: the action to take if an error is encountered on a bitmap's
+#            attached node, default 'report'.
+#            'stop' and 'enospc' can only be used if the block device supports
+#            io-status (see BlockInfo).
+#
+# @auto-finalize: When false, this job will wait in a PENDING state after it has
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
+#                 Defaults to true.
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
+#                has completely ceased all work, and awaits @block-job-dismiss.
+#                When true, this job will automatically disappear from the query
+#                list without user intervention.
+#                Defaults to true.
+#
+# Since: 5.0
+##
+{ 'struct': 'BlockDirtyBitmapPopulate',
+  'base': 'BlockDirtyBitmap',
+  'data': { 'job-id': 'str',
+            'pattern': 'BitmapPattern',
+            '*on-error': 'BlockdevOnError',
+            '*auto-finalize': 'bool',
+            '*auto-dismiss': 'bool' } }
+
 ##
 # @BlockDirtyBitmapSha256:
 #
diff --git a/qapi/job.json b/qapi/job.json
index 5e658281f5..5f496d4630 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -22,7 +22,7 @@
 # Since: 1.7
 ##
 { 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
+  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'bitmap-populate'] }
 
 ##
 # @JobStatus:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index df6d0273d6..eb68a5639a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1222,6 +1222,27 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
 
+/*
+ * bitpop_job_create: Create a new bitmap population job.
+ *
+ * @job_id: The id of the newly-created job.
+ * @bs: Block device associated with the @target_bitmap.
+ * @target_bitmap: The bitmap to populate.
+ * @on_error: What to do if an error on @bs is encountered.
+ * @creation_flags: Flags that control the behavior of the Job lifetime.
+ *                  See @BlockJobCreateFlags
+ * @cb: Completion function for the job.
+ * @opaque: Opaque pointer value passed to @cb.
+ * @txn: Transaction that this job is part of (may be NULL).
+ */
+BlockJob *bitpop_job_create(const char *job_id, BlockDriverState *bs,
+                            BdrvDirtyBitmap *target_bitmap,
+                            BitmapPattern pattern,
+                            BlockdevOnError on_error,
+                            int creation_flags,
+                            BlockCompletionFunc *cb, void *opaque,
+                            JobTxn *txn, Error **errp);
+
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
diff --git a/block/bitmap-alloc.c b/block/bitmap-alloc.c
new file mode 100644
index 0000000000..47d542dc12
--- /dev/null
+++ b/block/bitmap-alloc.c
@@ -0,0 +1,207 @@
+/*
+ * Async Dirty Bitmap Populator
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  John Snow <jsnow@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace.h"
+#include "block/block.h"
+#include "block/block_int.h"
+#include "block/blockjob_int.h"
+#include "block/block_backup.h"
+#include "block/block-copy.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/ratelimit.h"
+#include "qemu/cutils.h"
+#include "sysemu/block-backend.h"
+#include "qemu/bitmap.h"
+#include "qemu/error-report.h"
+
+typedef struct BitpopBlockJob {
+    BlockJob common;
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *target_bitmap;
+    BdrvDirtyBitmap *new_bitmap;
+    BlockdevOnError on_error;
+    uint64_t len;
+} BitpopBlockJob;
+
+static const BlockJobDriver bitpop_job_driver;
+
+static void bitpop_commit(Job *job)
+{
+    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
+
+    bdrv_dirty_bitmap_merge_internal(s->target_bitmap, s->new_bitmap,
+                                     NULL, true);
+}
+
+/* no abort needed; just clean without committing. */
+
+static void bitpop_clean(Job *job)
+{
+    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
+
+    bdrv_release_dirty_bitmap(s->new_bitmap);
+    bdrv_dirty_bitmap_set_busy(s->target_bitmap, false);
+}
+
+static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int error)
+{
+    return block_job_error_action(&job->common, job->on_error, true, error);
+}
+
+static bool coroutine_fn yield_and_check(Job *job)
+{
+    if (job_is_cancelled(job)) {
+        return true;
+    }
+
+    job_sleep_ns(job, 0);
+
+    if (job_is_cancelled(job)) {
+        return true;
+    }
+
+    return false;
+}
+
+static int coroutine_fn bitpop_run(Job *job, Error **errp)
+{
+    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
+    int ret = 0;
+    int64_t offset;
+    int64_t count;
+    int64_t bytes;
+
+    for (offset = 0; offset < s->len; ) {
+        if (yield_and_check(job)) {
+            ret = -ECANCELED;
+            break;
+        }
+
+        bytes = s->len - offset;
+        ret = bdrv_is_allocated(s->bs, offset, bytes, &count);
+        if (ret < 0) {
+            if (bitpop_error_action(s, -ret) == BLOCK_ERROR_ACTION_REPORT) {
+                break;
+            }
+            continue;
+        }
+
+        if (!count) {
+            ret = 0;
+            break;
+        }
+
+        if (ret) {
+            bdrv_set_dirty_bitmap(s->new_bitmap, offset, count);
+            ret = 0;
+        }
+
+        job_progress_update(job, count);
+        offset += count;
+    }
+
+    return ret;
+}
+
+static const BlockJobDriver bitpop_job_driver = {
+    .job_driver = {
+        .instance_size          = sizeof(BitpopBlockJob),
+        .job_type               = JOB_TYPE_BITMAP_POPULATE,
+        .free                   = block_job_free,
+        .user_resume            = block_job_user_resume,
+        .run                    = bitpop_run,
+        .commit                 = bitpop_commit,
+        .clean                  = bitpop_clean,
+    }
+};
+
+
+BlockJob *bitpop_job_create(
+    const char *job_id,
+    BlockDriverState *bs,
+    BdrvDirtyBitmap *target_bitmap,
+    BitmapPattern pattern,
+    BlockdevOnError on_error,
+    int creation_flags,
+    BlockCompletionFunc *cb,
+    void *opaque,
+    JobTxn *txn,
+    Error **errp)
+{
+    int64_t len;
+    BitpopBlockJob *job = NULL;
+    int64_t cluster_size;
+    BdrvDirtyBitmap *new_bitmap = NULL;
+
+    assert(bs);
+    assert(target_bitmap);
+
+    if (!bdrv_is_inserted(bs)) {
+        error_setg(errp, "Device is not inserted: %s",
+                   bdrv_get_device_name(bs));
+        return NULL;
+    }
+
+    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
+        return NULL;
+    }
+
+    if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+        return NULL;
+    }
+
+    if (pattern != BITMAP_PATTERN_ALLOCATION_TOP) {
+        error_setg(errp, "Unrecognized bitmap pattern");
+        return NULL;
+    }
+
+    len = bdrv_getlength(bs);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "unable to get length for '%s'",
+                         bdrv_get_device_name(bs));
+        return NULL;
+    }
+
+    /* NB: new bitmap is anonymous and enabled */
+    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
+    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
+    if (!new_bitmap) {
+        return NULL;
+    }
+
+    /* Take ownership; we reserve the right to write into this on-commit. */
+    bdrv_dirty_bitmap_set_busy(target_bitmap, true);
+
+    job = block_job_create(job_id, &bitpop_job_driver, txn, bs,
+                           BLK_PERM_CONSISTENT_READ,
+                           BLK_PERM_ALL & ~BLK_PERM_RESIZE,
+                           0, creation_flags,
+                           cb, opaque, errp);
+    if (!job) {
+        bdrv_dirty_bitmap_set_busy(target_bitmap, false);
+        bdrv_release_dirty_bitmap(new_bitmap);
+        return NULL;
+    }
+
+    job->bs = bs;
+    job->on_error = on_error;
+    job->target_bitmap = target_bitmap;
+    job->new_bitmap = new_bitmap;
+    job->len = len;
+    job_progress_set_remaining(&job->common.job, job->len);
+
+    return &job->common;
+}
diff --git a/blockjob.c b/blockjob.c
index 2affa1844d..991d9167a2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
     return job_type(job) == JOB_TYPE_BACKUP ||
            job_type(job) == JOB_TYPE_COMMIT ||
            job_type(job) == JOB_TYPE_MIRROR ||
-           job_type(job) == JOB_TYPE_STREAM;
+           job_type(job) == JOB_TYPE_STREAM ||
+           job_type(job) == JOB_TYPE_BITMAP_POPULATE;
 }
 
 BlockJob *block_job_next(BlockJob *bjob)
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..87357529f3 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) += ssh.o
 block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
+block-obj-y += bitmap-alloc.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 block-obj-y += throttle.o copy-on-read.o
 block-obj-y += block-copy.o
-- 
2.21.1


