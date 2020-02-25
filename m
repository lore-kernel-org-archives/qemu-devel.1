Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B84C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0C120838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEZz3vpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0C120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OZi-0006XM-O9
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWp-00023t-Vj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007n2-6m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007kJ-2L
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQpawlHWZj8fgnURexlifL0mL4tgU/O1hJjXHfeC4Vk=;
 b=AEZz3vpU/B1FurBPefhVC8AHpuAw6Z7mLXWyAD7PN5/i5CyrmE4WU4OXkBObag8lt7vYen
 7IG+kZNB5zjHISkrkQVAWGEKdlr19pFztSHfGIjkw0H/KygNoWQo+8y2nbXfYTP/vFpDR4
 jfkq6kOojbKwbcdM3p5QzvxHzk8ubIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-2PM4ifuYPqiLesVt0jISZw-1; Mon, 24 Feb 2020 19:56:45 -0500
X-MC-Unique: 2PM4ifuYPqiLesVt0jISZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E7C107ACC4;
 Tue, 25 Feb 2020 00:56:44 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD6A1CB;
 Tue, 25 Feb 2020 00:56:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] block: add bitmap-populate job
Date: Mon, 24 Feb 2020 19:56:36 -0500
Message-Id: <20200225005641.5478-2-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
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
index 85e27bb61f..df1797681a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2245,6 +2245,54 @@
       { 'command': 'block-dirty-bitmap-merge',
         'data': 'BlockDirtyBitmapMerge' }
=20
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
+#            'stop' and 'enospc' can only be used if the block device supp=
orts
+#            io-status (see BlockInfo).
+#
+# @auto-finalize: When false, this job will wait in a PENDING state after =
it has
+#                 finished its work, waiting for @block-job-finalize befor=
e
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
+#                 Defaults to true.
+#
+# @auto-dismiss: When false, this job will wait in a CONCLUDED state after=
 it
+#                has completely ceased all work, and awaits @block-job-dis=
miss.
+#                When true, this job will automatically disappear from the=
 query
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
+  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'bitmap-popul=
ate'] }
=20
 ##
 # @JobStatus:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6f9fd5e20e..a5884b597e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1215,6 +1215,27 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
=20
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
 void hmp_drive_add_node(Monitor *mon, const char *optstr);
=20
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
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
+    BitpopBlockJob *s =3D container_of(job, BitpopBlockJob, common.job);
+
+    bdrv_dirty_bitmap_merge_internal(s->target_bitmap, s->new_bitmap,
+                                     NULL, true);
+}
+
+/* no abort needed; just clean without committing. */
+
+static void bitpop_clean(Job *job)
+{
+    BitpopBlockJob *s =3D container_of(job, BitpopBlockJob, common.job);
+
+    bdrv_release_dirty_bitmap(s->new_bitmap);
+    bdrv_dirty_bitmap_set_busy(s->target_bitmap, false);
+}
+
+static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int error=
)
+{
+    return block_job_error_action(&job->common, job->on_error, true, error=
);
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
+    BitpopBlockJob *s =3D container_of(job, BitpopBlockJob, common.job);
+    int ret =3D 0;
+    int64_t offset;
+    int64_t count;
+    int64_t bytes;
+
+    for (offset =3D 0; offset < s->len; ) {
+        if (yield_and_check(job)) {
+            ret =3D -ECANCELED;
+            break;
+        }
+
+        bytes =3D s->len - offset;
+        ret =3D bdrv_is_allocated(s->bs, offset, bytes, &count);
+        if (ret < 0) {
+            if (bitpop_error_action(s, -ret) =3D=3D BLOCK_ERROR_ACTION_REP=
ORT) {
+                break;
+            }
+            continue;
+        }
+
+        if (!count) {
+            ret =3D 0;
+            break;
+        }
+
+        if (ret) {
+            bdrv_set_dirty_bitmap(s->new_bitmap, offset, count);
+            ret =3D 0;
+        }
+
+        job_progress_update(job, count);
+        offset +=3D count;
+    }
+
+    return ret;
+}
+
+static const BlockJobDriver bitpop_job_driver =3D {
+    .job_driver =3D {
+        .instance_size          =3D sizeof(BitpopBlockJob),
+        .job_type               =3D JOB_TYPE_BITMAP_POPULATE,
+        .free                   =3D block_job_free,
+        .user_resume            =3D block_job_user_resume,
+        .run                    =3D bitpop_run,
+        .commit                 =3D bitpop_commit,
+        .clean                  =3D bitpop_clean,
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
+    BitpopBlockJob *job =3D NULL;
+    int64_t cluster_size;
+    BdrvDirtyBitmap *new_bitmap =3D NULL;
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
+    if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BITMAP_DEFAULT, errp))=
 {
+        return NULL;
+    }
+
+    if (pattern !=3D BITMAP_PATTERN_ALLOCATION_TOP) {
+        error_setg(errp, "Unrecognized bitmap pattern");
+        return NULL;
+    }
+
+    len =3D bdrv_getlength(bs);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "unable to get length for '%s'",
+                         bdrv_get_device_name(bs));
+        return NULL;
+    }
+
+    /* NB: new bitmap is anonymous and enabled */
+    cluster_size =3D bdrv_dirty_bitmap_granularity(target_bitmap);
+    new_bitmap =3D bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
+    if (!new_bitmap) {
+        return NULL;
+    }
+
+    /* Take ownership; we reserve the right to write into this on-commit. =
*/
+    bdrv_dirty_bitmap_set_busy(target_bitmap, true);
+
+    job =3D block_job_create(job_id, &bitpop_job_driver, txn, bs,
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
+    job->bs =3D bs;
+    job->on_error =3D on_error;
+    job->target_bitmap =3D target_bitmap;
+    job->new_bitmap =3D new_bitmap;
+    job->len =3D len;
+    job_progress_set_remaining(&job->common.job, job->len);
+
+    return &job->common;
+}
diff --git a/blockjob.c b/blockjob.c
index 5d63b1e89d..7e450372bd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
     return job_type(job) =3D=3D JOB_TYPE_BACKUP ||
            job_type(job) =3D=3D JOB_TYPE_COMMIT ||
            job_type(job) =3D=3D JOB_TYPE_MIRROR ||
-           job_type(job) =3D=3D JOB_TYPE_STREAM;
+           job_type(job) =3D=3D JOB_TYPE_STREAM ||
+           job_type(job) =3D=3D JOB_TYPE_BITMAP_POPULATE;
 }
=20
 BlockJob *block_job_next(BlockJob *bjob)
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3bcb35c81d..f3cfc89d90 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) +=3D ssh.o
 block-obj-y +=3D accounting.o dirty-bitmap.o
 block-obj-y +=3D write-threshold.o
 block-obj-y +=3D backup.o
+block-obj-y +=3D bitmap-alloc.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
 block-obj-y +=3D throttle.o copy-on-read.o
 block-obj-y +=3D block-copy.o
--=20
2.21.1


