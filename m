Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC1C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D8621882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D8621882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinPQ-00013P-Qz
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hinEQ-00055O-53
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hinEO-0003hp-TN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hinEM-0003fh-5A; Wed, 03 Jul 2019 17:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7110C308330D;
 Wed,  3 Jul 2019 21:55:57 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-117.rdu2.redhat.com [10.10.123.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3860A52737;
 Wed,  3 Jul 2019 21:55:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:55:26 -0400
Message-Id: <20190703215542.16123-3-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-1-jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 21:55:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/18] drive-backup: create do_backup_common
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a common core that comprises the actual meat of what the backup AP=
I
boundary needs to do, and then switch drive-backup to use it.

Questions:
 - do_drive_backup now acquires and releases the aio_context in addition
   to do_backup_common doing the same. Can I drop this from drive_backup?
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 138 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 55 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..5fd663a7e5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3425,6 +3425,86 @@ out:
     aio_context_release(aio_context);
 }
=20
+static BlockJob *do_backup_common(BackupCommon *backup,
+                                  BlockDriverState *target_bs,
+                                  JobTxn *txn, Error **errp)
+{
+    BlockDriverState *bs;
+    BlockJob *job =3D NULL;
+    BdrvDirtyBitmap *bmap =3D NULL;
+    AioContext *aio_context;
+    Error *local_err =3D NULL;
+    int job_flags =3D JOB_DEFAULT;
+    int ret;
+
+    if (!backup->has_speed) {
+        backup->speed =3D 0;
+    }
+    if (!backup->has_on_source_error) {
+        backup->on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
+    }
+    if (!backup->has_on_target_error) {
+        backup->on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
+    }
+    if (!backup->has_job_id) {
+        backup->job_id =3D NULL;
+    }
+    if (!backup->has_auto_finalize) {
+        backup->auto_finalize =3D true;
+    }
+    if (!backup->has_auto_dismiss) {
+        backup->auto_dismiss =3D true;
+    }
+    if (!backup->has_compress) {
+        backup->compress =3D false;
+    }
+
+    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
+    if (!bs) {
+        return NULL;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        bdrv_unref(target_bs);
+        goto out;
+    }
+
+    if (backup->has_bitmap) {
+        bmap =3D bdrv_find_dirty_bitmap(bs, backup->bitmap);
+        if (!bmap) {
+            error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
+            goto out;
+        }
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
+            goto out;
+        }
+    }
+
+    if (!backup->auto_finalize) {
+        job_flags |=3D JOB_MANUAL_FINALIZE;
+    }
+    if (!backup->auto_dismiss) {
+        job_flags |=3D JOB_MANUAL_DISMISS;
+    }
+
+    job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
+                            backup->sync, bmap, backup->compress,
+                            backup->on_source_error, backup->on_target_e=
rror,
+                            job_flags, NULL, NULL, txn, &local_err);
+    if (local_err !=3D NULL) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+out:
+    aio_context_release(aio_context);
+    return job;
+}
+
 static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
                                  Error **errp)
 {
@@ -3432,39 +3512,16 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
     BlockDriverState *target_bs;
     BlockDriverState *source =3D NULL;
     BlockJob *job =3D NULL;
-    BdrvDirtyBitmap *bmap =3D NULL;
     AioContext *aio_context;
     QDict *options =3D NULL;
     Error *local_err =3D NULL;
-    int flags, job_flags =3D JOB_DEFAULT;
+    int flags;
     int64_t size;
     bool set_backing_hd =3D false;
-    int ret;
=20
-    if (!backup->has_speed) {
-        backup->speed =3D 0;
-    }
-    if (!backup->has_on_source_error) {
-        backup->on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!backup->has_on_target_error) {
-        backup->on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
     if (!backup->has_mode) {
         backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     }
-    if (!backup->has_job_id) {
-        backup->job_id =3D NULL;
-    }
-    if (!backup->has_auto_finalize) {
-        backup->auto_finalize =3D true;
-    }
-    if (!backup->has_auto_dismiss) {
-        backup->auto_dismiss =3D true;
-    }
-    if (!backup->has_compress) {
-        backup->compress =3D false;
-    }
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
@@ -3541,12 +3598,6 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
         goto out;
     }
=20
-    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
-    if (ret < 0) {
-        bdrv_unref(target_bs);
-        goto out;
-    }
-
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
         if (local_err) {
@@ -3554,31 +3605,8 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
         }
     }
=20
-    if (backup->has_bitmap) {
-        bmap =3D bdrv_find_dirty_bitmap(bs, backup->bitmap);
-        if (!bmap) {
-            error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
-            goto unref;
-        }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
-            goto unref;
-        }
-    }
-    if (!backup->auto_finalize) {
-        job_flags |=3D JOB_MANUAL_FINALIZE;
-    }
-    if (!backup->auto_dismiss) {
-        job_flags |=3D JOB_MANUAL_DISMISS;
-    }
-
-    job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
-                            backup->sync, bmap, backup->compress,
-                            backup->on_source_error, backup->on_target_e=
rror,
-                            job_flags, NULL, NULL, txn, &local_err);
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-        goto unref;
-    }
+    job =3D do_backup_common(qapi_DriveBackup_base(backup),
+                           target_bs, txn, errp);
=20
 unref:
     bdrv_unref(target_bs);
--=20
2.21.0


