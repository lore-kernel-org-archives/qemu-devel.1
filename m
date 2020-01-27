Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1108020CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5loOvfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1108020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8e0-0004Xo-5b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cY-0002EX-C5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cS-0002p8-PB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cS-0002oJ-KP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1KnApslL9RQ06AWCJZWT09Y8cmrVADIaoAlEGGo0eA=;
 b=L5loOvfCnvEZRu0AckXnAFxytfliv/MqoGkYCp4WiwMo/Bx2eeCaozXFCS+gO2UXh2oZWD
 Kfuv9zarWuPn7aKPxRTE5Om4eiMNe0JV2B1cigJCwcklfhtaBJgD7RcJVHfPC5S50JLxdL
 LEiaNsemUVbjnbfZPTMULf7IOgkm3+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-BrnSvcz0NMGTkflbkKsqdA-1; Mon, 27 Jan 2020 12:56:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B780D100726D;
 Mon, 27 Jan 2020 17:56:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C60A811FA;
 Mon, 27 Jan 2020 17:56:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/13] blockdev: unify qmp_drive_backup and drive-backup
 transaction paths
Date: Mon, 27 Jan 2020 18:55:50 +0100
Message-Id: <20200127175559.18173-5-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BrnSvcz0NMGTkflbkKsqdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Issuing a drive-backup from qmp_drive_backup takes a slightly
different path than when it's issued from a transaction. In the code,
this is manifested as some redundancy between do_drive_backup() and
drive_backup_prepare().

This change unifies both paths, merging do_drive_backup() and
drive_backup_prepare(), and changing qmp_drive_backup() to create a
transaction instead of calling do_backup_common() direcly.

As a side-effect, now qmp_drive_backup() is executed inside a drained
section, as it happens when creating a drive-backup transaction. This
change is visible from the user's perspective, as the job gets paused
and immediately resumed before starting the actual work.

Also fix tests 141, 185 and 219 to cope with the extra
JOB_STATUS_CHANGE lines.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c                 | 224 +++++++++++++++++--------------------
 tests/qemu-iotests/141.out |   2 +
 tests/qemu-iotests/185.out |   2 +
 tests/qemu-iotests/219     |   7 +-
 tests/qemu-iotests/219.out |   8 ++
 5 files changed, 117 insertions(+), 126 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 553e315972..5e85fc042e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1761,39 +1761,128 @@ typedef struct DriveBackupState {
     BlockJob *job;
 } DriveBackupState;
=20
-static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
-                            Error **errp);
+static BlockJob *do_backup_common(BackupCommon *backup,
+                                  BlockDriverState *bs,
+                                  BlockDriverState *target_bs,
+                                  AioContext *aio_context,
+                                  JobTxn *txn, Error **errp);
=20
 static void drive_backup_prepare(BlkActionState *common, Error **errp)
 {
     DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
-    BlockDriverState *bs;
     DriveBackup *backup;
+    BlockDriverState *bs;
+    BlockDriverState *target_bs;
+    BlockDriverState *source =3D NULL;
     AioContext *aio_context;
+    QDict *options;
     Error *local_err =3D NULL;
+    int flags;
+    int64_t size;
+    bool set_backing_hd =3D false;
=20
     assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
     backup =3D common->action->u.drive_backup.data;
=20
+    if (!backup->has_mode) {
+        backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
+    }
+
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return;
     }
=20
+    if (!bs->drv) {
+        error_setg(errp, "Device has no medium");
+        return;
+    }
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
     /* Paired with .clean() */
     bdrv_drained_begin(bs);
=20
-    state->bs =3D bs;
+    if (!backup->has_format) {
+        backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
+                         NULL : (char *) bs->drv->format_name;
+    }
+
+    /* Early check to avoid creating target */
+    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
+        goto out;
+    }
+
+    flags =3D bs->open_flags | BDRV_O_RDWR;
+
+    /*
+     * See if we have a backing HD we can use to create our new image
+     * on top of.
+     */
+    if (backup->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
+        source =3D backing_bs(bs);
+        if (!source) {
+            backup->sync =3D MIRROR_SYNC_MODE_FULL;
+        }
+    }
+    if (backup->sync =3D=3D MIRROR_SYNC_MODE_NONE) {
+        source =3D bs;
+        flags |=3D BDRV_O_NO_BACKING;
+        set_backing_hd =3D true;
+    }
+
+    size =3D bdrv_getlength(bs);
+    if (size < 0) {
+        error_setg_errno(errp, -size, "bdrv_getlength failed");
+        goto out;
+    }
+
+    if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
+        assert(backup->format);
+        if (source) {
+            bdrv_refresh_filename(source);
+            bdrv_img_create(backup->target, backup->format, source->filena=
me,
+                            source->drv->format_name, NULL,
+                            size, flags, false, &local_err);
+        } else {
+            bdrv_img_create(backup->target, backup->format, NULL, NULL, NU=
LL,
+                            size, flags, false, &local_err);
+        }
+    }
=20
-    state->job =3D do_drive_backup(backup, common->block_job_txn, &local_e=
rr);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
     }
=20
+    options =3D qdict_new();
+    qdict_put_str(options, "discard", "unmap");
+    qdict_put_str(options, "detect-zeroes", "unmap");
+    if (backup->format) {
+        qdict_put_str(options, "driver", backup->format);
+    }
+
+    target_bs =3D bdrv_open(backup->target, NULL, options, flags, errp);
+    if (!target_bs) {
+        goto out;
+    }
+
+    if (set_backing_hd) {
+        bdrv_set_backing_hd(target_bs, source, &local_err);
+        if (local_err) {
+            goto unref;
+        }
+    }
+
+    state->bs =3D bs;
+
+    state->job =3D do_backup_common(qapi_DriveBackup_base(backup),
+                                  bs, target_bs, aio_context,
+                                  common->block_job_txn, errp);
+
+unref:
+    bdrv_unref(target_bs);
 out:
     aio_context_release(aio_context);
 }
@@ -3587,126 +3676,13 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
     return job;
 }
=20
-static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
-                                 Error **errp)
-{
-    BlockDriverState *bs;
-    BlockDriverState *target_bs;
-    BlockDriverState *source =3D NULL;
-    BlockJob *job =3D NULL;
-    AioContext *aio_context;
-    QDict *options;
-    Error *local_err =3D NULL;
-    int flags;
-    int64_t size;
-    bool set_backing_hd =3D false;
-
-    if (!backup->has_mode) {
-        backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
-    }
-
-    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
-    if (!bs) {
-        return NULL;
-    }
-
-    if (!bs->drv) {
-        error_setg(errp, "Device has no medium");
-        return NULL;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    if (!backup->has_format) {
-        backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
-                         NULL : (char *) bs->drv->format_name;
-    }
-
-    /* Early check to avoid creating target */
-    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
-        goto out;
-    }
-
-    flags =3D bs->open_flags | BDRV_O_RDWR;
-
-    /*
-     * See if we have a backing HD we can use to create our new image
-     * on top of.
-     */
-    if (backup->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
-        source =3D backing_bs(bs);
-        if (!source) {
-            backup->sync =3D MIRROR_SYNC_MODE_FULL;
-        }
-    }
-    if (backup->sync =3D=3D MIRROR_SYNC_MODE_NONE) {
-        source =3D bs;
-        flags |=3D BDRV_O_NO_BACKING;
-        set_backing_hd =3D true;
-    }
-
-    size =3D bdrv_getlength(bs);
-    if (size < 0) {
-        error_setg_errno(errp, -size, "bdrv_getlength failed");
-        goto out;
-    }
-
-    if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
-        assert(backup->format);
-        if (source) {
-            bdrv_refresh_filename(source);
-            bdrv_img_create(backup->target, backup->format, source->filena=
me,
-                            source->drv->format_name, NULL,
-                            size, flags, false, &local_err);
-        } else {
-            bdrv_img_create(backup->target, backup->format, NULL, NULL, NU=
LL,
-                            size, flags, false, &local_err);
-        }
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
-    }
-
-    options =3D qdict_new();
-    qdict_put_str(options, "discard", "unmap");
-    qdict_put_str(options, "detect-zeroes", "unmap");
-    if (backup->format) {
-        qdict_put_str(options, "driver", backup->format);
-    }
-
-    target_bs =3D bdrv_open(backup->target, NULL, options, flags, errp);
-    if (!target_bs) {
-        goto out;
-    }
-
-    if (set_backing_hd) {
-        bdrv_set_backing_hd(target_bs, source, &local_err);
-        if (local_err) {
-            goto unref;
-        }
-    }
-
-    job =3D do_backup_common(qapi_DriveBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
-
-unref:
-    bdrv_unref(target_bs);
-out:
-    aio_context_release(aio_context);
-    return job;
-}
-
-void qmp_drive_backup(DriveBackup *arg, Error **errp)
+void qmp_drive_backup(DriveBackup *backup, Error **errp)
 {
-
-    BlockJob *job;
-    job =3D do_drive_backup(arg, NULL, errp);
-    if (job) {
-        job_start(&job->job);
-    }
+    TransactionAction action =3D {
+        .type =3D TRANSACTION_ACTION_KIND_DRIVE_BACKUP,
+        .u.drive_backup.data =3D backup,
+    };
+    blockdev_do_action(&action, errp);
 }
=20
 BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 3645675ce8..263b680bdf 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -13,6 +13,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/m.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is =
used as backing hd of 'NODE_NAME'"}}
 {'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 8379ac5854..9a3b65782b 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -65,6 +65,8 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67=
108864 cluster_size=3D65536 l
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "disk"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
 { 'execute': 'quit' }
 {"return": {}}
diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index e0c51662c0..655f54d881 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -63,7 +63,7 @@ def test_pause_resume(vm):
                 # logged immediately
                 iotests.log(vm.qmp('query-jobs'))
=20
-def test_job_lifecycle(vm, job, job_args, has_ready=3DFalse):
+def test_job_lifecycle(vm, job, job_args, has_ready=3DFalse, is_mirror=3DF=
alse):
     global img_size
=20
     iotests.log('')
@@ -135,6 +135,9 @@ def test_job_lifecycle(vm, job, job_args, has_ready=3DF=
alse):
     iotests.log('Waiting for PENDING state...')
     iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANGE'=
)))
     iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHANGE'=
)))
+    if is_mirror:
+        iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHA=
NGE')))
+        iotests.log(iotests.filter_qmp_event(vm.event_wait('JOB_STATUS_CHA=
NGE')))
=20
     if not job_args.get('auto-finalize', True):
         # PENDING state:
@@ -218,7 +221,7 @@ with iotests.FilePath('disk.img') as disk_path, \
=20
     for auto_finalize in [True, False]:
         for auto_dismiss in [True, False]:
-            test_job_lifecycle(vm, 'drive-backup', job_args=3D{
+            test_job_lifecycle(vm, 'drive-backup', is_mirror=3DTrue, job_a=
rgs=3D{
                 'device': 'drive0-node',
                 'target': copy_path,
                 'sync': 'full',
diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
index 8ebd3fee60..0ea5d0b9d5 100644
--- a/tests/qemu-iotests/219.out
+++ b/tests/qemu-iotests/219.out
@@ -135,6 +135,8 @@ Pause/resume in RUNNING
 {"return": {}}
=20
 Waiting for PENDING state...
+{"data": {"id": "job0", "status": "paused"}, "event": "JOB_STATUS_CHANGE",=
 "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "job0", "status": "running"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "waiting"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "pending"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "concluded"}, "event": "JOB_STATUS_CHANG=
E", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -186,6 +188,8 @@ Pause/resume in RUNNING
 {"return": {}}
=20
 Waiting for PENDING state...
+{"data": {"id": "job0", "status": "paused"}, "event": "JOB_STATUS_CHANGE",=
 "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "job0", "status": "running"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "waiting"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "pending"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "concluded"}, "event": "JOB_STATUS_CHANG=
E", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -245,6 +249,8 @@ Pause/resume in RUNNING
 {"return": {}}
=20
 Waiting for PENDING state...
+{"data": {"id": "job0", "status": "paused"}, "event": "JOB_STATUS_CHANGE",=
 "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "job0", "status": "running"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "waiting"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "pending"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"return": [{"current-progress": 4194304, "id": "job0", "status": "pending=
", "total-progress": 4194304, "type": "backup"}]}
@@ -304,6 +310,8 @@ Pause/resume in RUNNING
 {"return": {}}
=20
 Waiting for PENDING state...
+{"data": {"id": "job0", "status": "paused"}, "event": "JOB_STATUS_CHANGE",=
 "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "job0", "status": "running"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "waiting"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"id": "job0", "status": "pending"}, "event": "JOB_STATUS_CHANGE"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"return": [{"current-progress": 4194304, "id": "job0", "status": "pending=
", "total-progress": 4194304, "type": "backup"}]}
--=20
2.20.1


