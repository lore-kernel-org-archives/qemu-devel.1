Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D9A21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WElqqkQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D9A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHJL-0005Xi-Bq
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iaHF6-0003Rl-OF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iaHF4-0006XH-2a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iaHF3-0006Tw-PB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574937705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5D/pkDJCK2cS43Bw1M9Bu1vuuXBxNgDOLQ+LuhjnYnQ=;
 b=WElqqkQEvC77OrILEkDw/7SvoHvZNccF1I5nKbiJPVHmIkJvDhTiVT5pfbLVNtQL13lE1Q
 SYt/c5S9b3Q8V9lD7Uz1SHnSywlrXIHJHFfxzrsztHKUFDQJuBByuHd31CGNIoWVIbQVmR
 NjVCv2rD+0OhJQC1zDGzrw+LvGLEVLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-LSB13DW3NACDaYCq0Zi-Zw-1; Thu, 28 Nov 2019 05:41:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28907800D41;
 Thu, 28 Nov 2019 10:41:43 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C73010013A7;
 Thu, 28 Nov 2019 10:41:41 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context() context
 requirements
Date: Thu, 28 Nov 2019 11:41:29 +0100
Message-Id: <20191128104129.250206-5-slp@redhat.com>
In-Reply-To: <20191128104129.250206-1-slp@redhat.com>
References: <20191128104129.250206-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LSB13DW3NACDaYCq0Zi-Zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

bdrv_try_set_aio_context() requires that the old context is held, and
the new context is not held. Fix all the occurrences where it's not
done this way.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 152a0f7454..e33abd7fd2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1535,6 +1535,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,
                              DO_UPCAST(ExternalSnapshotState, common, comm=
on);
     TransactionAction *action =3D common->action;
     AioContext *aio_context;
+    AioContext *old_context;
     int ret;
=20
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
@@ -1675,7 +1676,16 @@ static void external_snapshot_prepare(BlkActionState=
 *common,
         goto out;
     }
=20
+    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
+    old_context =3D bdrv_get_aio_context(state->new_bs);
+    aio_context_release(aio_context);
+    aio_context_acquire(old_context);
+
     ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
+
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     if (ret < 0) {
         goto out;
     }
@@ -1775,11 +1785,13 @@ static void drive_backup_prepare(BlkActionState *co=
mmon, Error **errp)
     BlockDriverState *target_bs;
     BlockDriverState *source =3D NULL;
     AioContext *aio_context;
+    AioContext *old_context;
     QDict *options;
     Error *local_err =3D NULL;
     int flags;
     int64_t size;
     bool set_backing_hd =3D false;
+    int ret;
=20
     assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BACKU=
P);
     backup =3D common->action->u.drive_backup.data;
@@ -1868,6 +1880,20 @@ static void drive_backup_prepare(BlkActionState *com=
mon, Error **errp)
         goto out;
     }
=20
+    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_release(aio_context);
+    aio_context_acquire(old_context);
+
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
+    if (ret < 0) {
+        goto out;
+    }
+
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
         if (local_err) {
@@ -1947,6 +1973,8 @@ static void blockdev_backup_prepare(BlkActionState *c=
ommon, Error **errp)
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
+    AioContext *old_context;
+    int ret;
=20
     assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_BA=
CKUP);
     backup =3D common->action->u.blockdev_backup.data;
@@ -1961,7 +1989,18 @@ static void blockdev_backup_prepare(BlkActionState *=
common, Error **errp)
         return;
     }
=20
+    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
     aio_context =3D bdrv_get_aio_context(bs);
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_acquire(old_context);
+
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        aio_context_release(old_context);
+        return;
+    }
+
+    aio_context_release(old_context);
     aio_context_acquire(aio_context);
     state->bs =3D bs;
=20
@@ -3562,7 +3601,6 @@ static BlockJob *do_backup_common(BackupCommon *backu=
p,
     BlockJob *job =3D NULL;
     BdrvDirtyBitmap *bmap =3D NULL;
     int job_flags =3D JOB_DEFAULT;
-    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3586,11 +3624,6 @@ static BlockJob *do_backup_common(BackupCommon *back=
up,
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
         /* done before desugaring 'incremental' to print the right message=
 */
@@ -3825,6 +3858,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     BlockDriverState *bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
+    AioContext *old_context;
     BlockMirrorBackingMode backing_mode;
     Error *local_err =3D NULL;
     QDict *options =3D NULL;
@@ -3937,10 +3971,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
                    (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
                     !bdrv_has_zero_init(target_bs)));
=20
+
+    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
+    old_context =3D bdrv_get_aio_context(target_bs);
+    aio_context_release(aio_context);
+    aio_context_acquire(old_context);
+
     ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     if (ret < 0) {
-        bdrv_unref(target_bs);
-        goto out;
+        goto unref;
     }
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, targe=
t_bs,
@@ -3957,8 +4000,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp=
)
                            arg->has_auto_finalize, arg->auto_finalize,
                            arg->has_auto_dismiss, arg->auto_dismiss,
                            &local_err);
-    bdrv_unref(target_bs);
     error_propagate(errp, local_err);
+
+unref:
+    bdrv_unref(target_bs);
 out:
     aio_context_release(aio_context);
 }
@@ -3984,6 +4029,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char =
*job_id,
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
+    AioContext *old_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
     Error *local_err =3D NULL;
     bool zero_target;
@@ -4001,10 +4047,16 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
=20
     zero_target =3D (sync =3D=3D MIRROR_SYNC_MODE_FULL);
=20
+    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
+    old_context =3D bdrv_get_aio_context(target_bs);
     aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
+    aio_context_acquire(old_context);
=20
     ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+
+    aio_context_release(old_context);
+    aio_context_acquire(aio_context);
+
     if (ret < 0) {
         goto out;
     }
--=20
2.23.0


