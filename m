Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EACC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182321783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU/cGuOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182321783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUXq-0007a2-1C
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUP9-0007Hy-8h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUP2-0001BO-4u
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUP0-00018I-0L
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XrXr/+SNgujjOhRg7OiEQAfxJshPf36cCDpafuAMPIY=;
 b=eU/cGuOFOHAe47Jac3DDNW10+7Je5YDrCbOJ6B1KX/tLOzg8o0sGG0F2PTBqVnnFZoteYI
 P4luRe1CeL+qD+hD7bChLTc6epf9Uc9SimAHyZbfbjf4pp+JarZNxzKywrJM/HWrsIrONZ
 jBvvoB7FMpaVLiGmENwjoRjuIXnOiFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-uiLl8FzrM8aprZmLn920DQ-1; Tue, 12 Nov 2019 06:30:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B125107ACC5;
 Tue, 12 Nov 2019 11:30:23 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B79C46091D;
 Tue, 12 Nov 2019 11:30:21 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] blockdev: place drive_backup_prepare with the other
 related transaction functions
Date: Tue, 12 Nov 2019 12:30:07 +0100
Message-Id: <20191112113012.71136-4-slp@redhat.com>
In-Reply-To: <20191112113012.71136-1-slp@redhat.com>
References: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uiLl8FzrM8aprZmLn920DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move drive_backup_prepare() to be side by side with the other
related transaction helper functions.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 247 +++++++++++++++++++++++++++--------------------------
 1 file changed, 125 insertions(+), 122 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e8b673c5f3..b32855f702 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1761,8 +1761,131 @@ typedef struct DriveBackupState {
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
+
+static void drive_backup_prepare(BlkActionState *common, Error **errp)
+{
+    DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
+    DriveBackup *backup;
+    BlockDriverState *bs;
+    BlockDriverState *target_bs;
+    BlockDriverState *source =3D NULL;
+    AioContext *aio_context;
+    QDict *options;
+    Error *local_err =3D NULL;
+    int flags;
+    int64_t size;
+    bool set_backing_hd =3D false;
+
+    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
+    backup =3D common->action->u.drive_backup.data;
+
+    if (!backup->has_mode) {
+        backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
+    }
+
+    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
+    if (!bs) {
+        return;
+    }
+
+    if (!bs->drv) {
+        error_setg(errp, "Device has no medium");
+        return;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    /* Paired with .clean() */
+    bdrv_drained_begin(bs);
+
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
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
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
+out:
+    aio_context_release(aio_context);
+}
=20
 static void drive_backup_commit(BlkActionState *common)
 {
@@ -3553,126 +3676,6 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
     return job;
 }
=20
-static void drive_backup_prepare(BlkActionState *common, Error **errp)
-{
-    DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
-    DriveBackup *backup;
-    BlockDriverState *bs;
-    BlockDriverState *target_bs;
-    BlockDriverState *source =3D NULL;
-    AioContext *aio_context;
-    QDict *options;
-    Error *local_err =3D NULL;
-    int flags;
-    int64_t size;
-    bool set_backing_hd =3D false;
-
-    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
-    backup =3D common->action->u.drive_backup.data;
-
-    if (!backup->has_mode) {
-        backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
-    }
-
-    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
-    if (!bs) {
-        return;
-    }
-
-    if (!bs->drv) {
-        error_setg(errp, "Device has no medium");
-        return;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    /* Paired with .clean() */
-    bdrv_drained_begin(bs);
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
-    state->bs =3D bs;
-
-    state->job =3D do_backup_common(qapi_DriveBackup_base(backup),
-                                  bs, target_bs, aio_context,
-                                  common->block_job_txn, errp);
-
-unref:
-    bdrv_unref(target_bs);
-out:
-    aio_context_release(aio_context);
-}
-
 void qmp_drive_backup(DriveBackup *arg, Error **errp)
 {
=20
--=20
2.23.0


