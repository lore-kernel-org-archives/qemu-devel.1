Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB16C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFB820679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT+AHLAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmzx-0003PR-Hy
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iXmyM-0001u1-A2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iXmyK-0001HO-Io
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iXmyK-0001GU-FE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574344691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP5pEloe2SwYUxfhbFWqozdVGlE/7Oc6FBc0LOsq82Y=;
 b=fT+AHLAS2Ez7RAN1eWbZ34dJp1s5pd/loXi0OCpjO5thFI/WCy2H9g/jY/u9yqCNOw0SvA
 uiZh5IQZSWeTKqpFwQrOlle5Rk3dPpL7fqvY5jHYd44suoasN21pJb/uGlkuizlmnqLecS
 snfTce/BHOgMGOp+Pl8MTsb+v847s4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-2VJwUPCSOya7xUa1ltMf5w-1; Thu, 21 Nov 2019 08:58:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15804107ACC7;
 Thu, 21 Nov 2019 13:58:09 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75AE46CE76;
 Thu, 21 Nov 2019 13:58:07 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] blockdev: unify qmp_drive_backup and drive-backup
 transaction paths
Date: Thu, 21 Nov 2019 14:57:56 +0100
Message-Id: <20191121135759.101655-3-slp@redhat.com>
In-Reply-To: <20191121135759.101655-1-slp@redhat.com>
References: <20191121135759.101655-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2VJwUPCSOya7xUa1ltMf5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 224 ++++++++++++++++++++++++-----------------------------
 1 file changed, 100 insertions(+), 124 deletions(-)

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
--=20
2.23.0


