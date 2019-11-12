Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81409C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507D321783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov2fEOrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507D321783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUR4-0008UZ-JH
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUOU-0006as-3z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUOP-00011a-36
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUOO-00011P-G1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gb1RH33aSR0RM4IoeQcShNydzzy0Bqn3bnB1YpWv//o=;
 b=Ov2fEOrYobjWyM5iV9x4FgcXQexyMPTkxTBGEqbe1gQCtMru8bvu+sK3bGKIQhQomf59Iz
 OKX+cm5eape6ERuaWTfFSKe1zSQK5cjVd8T/HCY8u0QU/EFkLSspNptskP/a9QVuMdm1cI
 LfLRyz0T9ILKC/kusEvRraf2uTRu2Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-cW7v-wWnOP6HWPzoekkNUA-1; Tue, 12 Nov 2019 06:30:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 624FD800C61;
 Tue, 12 Nov 2019 11:30:19 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFB3A60D5C;
 Tue, 12 Nov 2019 11:30:17 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] blockdev: merge drive_backup_prepare with
 do_drive_backup
Date: Tue, 12 Nov 2019 12:30:05 +0100
Message-Id: <20191112113012.71136-2-slp@redhat.com>
In-Reply-To: <20191112113012.71136-1-slp@redhat.com>
References: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cW7v-wWnOP6HWPzoekkNUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Consolidate drive_backup_prepare() with do_drive_backup() as a first
step towards streamlining all functionality through transactions.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 58 +++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 8e029e9c01..5d30aff1e5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1764,40 +1764,6 @@ typedef struct DriveBackupState {
 static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
                             Error **errp);
=20
-static void drive_backup_prepare(BlkActionState *common, Error **errp)
-{
-    DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
-    BlockDriverState *bs;
-    DriveBackup *backup;
-    AioContext *aio_context;
-    Error *local_err =3D NULL;
-
-    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
-    backup =3D common->action->u.drive_backup.data;
-
-    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
-    if (!bs) {
-        return;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    /* Paired with .clean() */
-    bdrv_drained_begin(bs);
-
-    state->bs =3D bs;
-
-    state->job =3D do_drive_backup(backup, common->block_job_txn, &local_e=
rr);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
-    }
-
-out:
-    aio_context_release(aio_context);
-}
-
 static void drive_backup_commit(BlkActionState *common)
 {
     DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
@@ -3587,13 +3553,13 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
     return job;
 }
=20
-static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
-                                 Error **errp)
+static void drive_backup_prepare(BlkActionState *common, Error **errp)
 {
+    DriveBackupState *state =3D DO_UPCAST(DriveBackupState, common, common=
);
+    DriveBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     BlockDriverState *source =3D NULL;
-    BlockJob *job =3D NULL;
     AioContext *aio_context;
     QDict *options;
     Error *local_err =3D NULL;
@@ -3601,23 +3567,29 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     int64_t size;
     bool set_backing_hd =3D false;
=20
+    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
+    backup =3D common->action->u.drive_backup.data;
+
     if (!backup->has_mode) {
         backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     }
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
-        return NULL;
+        return;
     }
=20
     if (!bs->drv) {
         error_setg(errp, "Device has no medium");
-        return NULL;
+        return;
     }
=20
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
+    /* Paired with .clean() */
+    bdrv_drained_begin(bs);
+
     if (!backup->has_format) {
         backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
                          NULL : (char*) bs->drv->format_name;
@@ -3687,14 +3659,16 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
         }
     }
=20
-    job =3D do_backup_common(qapi_DriveBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
+    state->bs =3D bs;
+
+    state->job =3D do_backup_common(qapi_DriveBackup_base(backup),
+                                  bs, target_bs, aio_context,
+                                  common->block_job_txn, errp);
=20
 unref:
     bdrv_unref(target_bs);
 out:
     aio_context_release(aio_context);
-    return job;
 }
=20
 void qmp_drive_backup(DriveBackup *arg, Error **errp)
--=20
2.23.0


