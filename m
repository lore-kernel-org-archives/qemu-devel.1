Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B6C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF7C20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF7C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nVC-0000zk-Ig
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i8nSS-0006u8-GV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i8nSQ-0003WU-D4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>)
 id 1i8nSM-0003Sz-Fx; Fri, 13 Sep 2019 11:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9F9A315C007;
 Fri, 13 Sep 2019 15:25:53 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A36F1001938;
 Fri, 13 Sep 2019 15:25:51 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 13 Sep 2019 17:25:08 +0200
Message-Id: <20190913152507.56197-3-slp@redhat.com>
In-Reply-To: <20190913152507.56197-1-slp@redhat.com>
References: <20190913152507.56197-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 15:25:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] blockdev: honor
 bdrv_try_set_aio_context() context requirements
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_try_set_aio_context() requires that the old context is held, and
the new context is not held. Fix all the ocurrences where it's not
done this way.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 121 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 46 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3927fdab80..2534fef389 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1536,6 +1536,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
                              DO_UPCAST(ExternalSnapshotState, common, co=
mmon);
     TransactionAction *action =3D common->action;
     AioContext *aio_context;
+    AioContext *old_context;
     int ret;
=20
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
@@ -1575,30 +1576,30 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
=20
     aio_context =3D bdrv_get_aio_context(state->old_bs);
     aio_context_acquire(aio_context);
-
     /* Paired with .clean() */
     bdrv_drained_begin(state->old_bs);
+    aio_context_release(aio_context);
=20
     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
-        goto out;
+        return;
     }
=20
     if (bdrv_op_is_blocked(state->old_bs,
                            BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT, errp)) {
-        goto out;
+        return;
     }
=20
     if (!bdrv_is_read_only(state->old_bs)) {
         if (bdrv_flush(state->old_bs)) {
             error_setg(errp, QERR_IO_ERROR);
-            goto out;
+            return;
         }
     }
=20
     if (!bdrv_is_first_non_filter(state->old_bs)) {
         error_setg(errp, QERR_FEATURE_DISABLED, "snapshot");
-        goto out;
+        return;
     }
=20
     if (action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SY=
NC) {
@@ -1610,13 +1611,13 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
=20
         if (node_name && !snapshot_node_name) {
             error_setg(errp, "New overlay node name missing");
-            goto out;
+            return;
         }
=20
         if (snapshot_node_name &&
             bdrv_lookup_bs(snapshot_node_name, snapshot_node_name, NULL)=
) {
             error_setg(errp, "New overlay node name already in use");
-            goto out;
+            return;
         }
=20
         flags =3D state->old_bs->open_flags;
@@ -1629,7 +1630,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
             int64_t size =3D bdrv_getlength(state->old_bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
-                goto out;
+                return;
             }
             bdrv_refresh_filename(state->old_bs);
             bdrv_img_create(new_image_file, format,
@@ -1638,7 +1639,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
                             NULL, size, flags, false, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
-                goto out;
+                return;
             }
         }
=20
@@ -1653,34 +1654,41 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
                               errp);
     /* We will manually add the backing_hd field to the bs later */
     if (!state->new_bs) {
-        goto out;
+        return;
     }
=20
     if (bdrv_has_blk(state->new_bs)) {
         error_setg(errp, "The overlay is already in use");
-        goto out;
+        return;
     }
=20
     if (bdrv_op_is_blocked(state->new_bs, BLOCK_OP_TYPE_EXTERNAL_SNAPSHO=
T,
                            errp)) {
-        goto out;
+        return;
     }
=20
     if (state->new_bs->backing !=3D NULL) {
         error_setg(errp, "The overlay already has a backing image");
-        goto out;
+        return;
     }
=20
     if (!state->new_bs->drv->supports_backing) {
         error_setg(errp, "The overlay does not support backing images");
-        goto out;
+        return;
     }
=20
+    old_context =3D bdrv_get_aio_context(state->new_bs);
+    aio_context_acquire(old_context);
+
     ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
     if (ret < 0) {
-        goto out;
+        aio_context_release(old_context);
+        return;
     }
=20
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     /* This removes our old bs and adds the new bs. This is an operation=
 that
      * can fail, so we need to do it in .prepare; undoing it for abort i=
s
      * always possible. */
@@ -1688,11 +1696,10 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
     bdrv_append(state->new_bs, state->old_bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+    } else {
+        state->overlay_appended =3D true;
     }
-    state->overlay_appended =3D true;
=20
-out:
     aio_context_release(aio_context);
 }
=20
@@ -3490,13 +3497,11 @@ out:
 static BlockJob *do_backup_common(BackupCommon *backup,
                                   BlockDriverState *bs,
                                   BlockDriverState *target_bs,
-                                  AioContext *aio_context,
                                   JobTxn *txn, Error **errp)
 {
     BlockJob *job =3D NULL;
     BdrvDirtyBitmap *bmap =3D NULL;
     int job_flags =3D JOB_DEFAULT;
-    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3520,11 +3525,6 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
         backup->compress =3D false;
     }
=20
-    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
-    if (ret < 0) {
-        return NULL;
-    }
-
     if ((backup->sync =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
         (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL)) {
         /* done before desugaring 'incremental' to print the right messa=
ge */
@@ -3611,11 +3611,13 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
     BlockDriverState *source =3D NULL;
     BlockJob *job =3D NULL;
     AioContext *aio_context;
+    AioContext *old_context;
     QDict *options;
     Error *local_err =3D NULL;
     int flags;
     int64_t size;
     bool set_backing_hd =3D false;
+    int ret;
=20
     if (!backup->has_mode) {
         backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
@@ -3631,9 +3633,6 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
         return NULL;
     }
=20
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (!backup->has_format) {
         backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
                          NULL : (char*) bs->drv->format_name;
@@ -3641,7 +3640,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
=20
     /* Early check to avoid creating target */
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
-        goto out;
+        return NULL;
     }
=20
     flags =3D bs->open_flags | BDRV_O_RDWR;
@@ -3663,7 +3662,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     size =3D bdrv_getlength(bs);
     if (size < 0) {
         error_setg_errno(errp, -size, "bdrv_getlength failed");
-        goto out;
+        return NULL;
     }
=20
     if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
@@ -3681,7 +3680,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
=20
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+        return NULL;
     }
=20
     options =3D qdict_new();
@@ -3693,22 +3692,34 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
=20
     target_bs =3D bdrv_open(backup->target, NULL, options, flags, errp);
     if (!target_bs) {
-        goto out;
+        return NULL;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_acquire(old_context);
+
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        aio_context_release(old_context);
+        return NULL;
     }
=20
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
         if (local_err) {
-            goto unref;
+            goto out;
         }
     }
=20
     job =3D do_backup_common(qapi_DriveBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
+                           bs, target_bs, txn, errp);
=20
-unref:
-    bdrv_unref(target_bs);
 out:
+    bdrv_unref(target_bs);
     aio_context_release(aio_context);
     return job;
 }
@@ -3739,7 +3750,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup=
, JobTxn *txn,
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
+    AioContext *old_context;
     BlockJob *job;
+    int ret;
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -3752,10 +3765,20 @@ BlockJob *do_blockdev_backup(BlockdevBackup *back=
up, JobTxn *txn,
     }
=20
     aio_context =3D bdrv_get_aio_context(bs);
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_acquire(old_context);
+
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        aio_context_release(old_context);
+        return NULL;
+    }
+
+    aio_context_release(old_context);
     aio_context_acquire(aio_context);
=20
     job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
+                           bs, target_bs, txn, errp);
=20
     aio_context_release(aio_context);
     return job;
@@ -3897,6 +3920,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     BlockDriverState *bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
+    AioContext *old_context;
     BlockMirrorBackingMode backing_mode;
     Error *local_err =3D NULL;
     QDict *options =3D NULL;
@@ -3916,9 +3940,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
         return;
     }
=20
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (!arg->has_mode) {
         arg->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     }
@@ -3940,14 +3961,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
     size =3D bdrv_getlength(bs);
     if (size < 0) {
         error_setg_errno(errp, -size, "bdrv_getlength failed");
-        goto out;
+        return;
     }
=20
     if (arg->has_replaces) {
         if (!arg->has_node_name) {
             error_setg(errp, "a node-name must be provided when replacin=
g a"
                              " named node of the graph");
-            goto out;
+            return;
         }
     }
=20
@@ -3986,7 +4007,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
=20
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+        return;
     }
=20
     options =3D qdict_new();
@@ -4002,19 +4023,27 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
      */
     target_bs =3D bdrv_open(arg->target, NULL, options, flags, errp);
     if (!target_bs) {
-        goto out;
+        return;
     }
=20
     zero_target =3D (arg->sync =3D=3D MIRROR_SYNC_MODE_FULL &&
                    (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
                     !bdrv_has_zero_init(target_bs)));
=20
+    aio_context =3D bdrv_get_aio_context(bs);
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_acquire(old_context);
+
     ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
     if (ret < 0) {
         bdrv_unref(target_bs);
-        goto out;
+        aio_context_release(old_context);
+        return;
     }
=20
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
                            backing_mode, zero_target,
@@ -4031,7 +4060,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
                            &local_err);
     bdrv_unref(target_bs);
     error_propagate(errp, local_err);
-out:
+
     aio_context_release(aio_context);
 }
=20
--=20
2.21.0


