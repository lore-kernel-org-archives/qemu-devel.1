Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E787C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E73277A4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E73277A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36563 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXom8-0006ks-9U
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:21:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVv-0001Rt-L5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVu-0001D0-64
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoVk-0000R3-Jr; Mon, 03 Jun 2019 11:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B491B30860AF;
	Mon,  3 Jun 2019 15:04:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51D1D6727B;
	Mon,  3 Jun 2019 15:04:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:25 +0200
Message-Id: <20190603150233.6614-21-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 03 Jun 2019 15:04:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/28] blockdev: Use bdrv_try_set_aio_context()
 for monitor commands
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Monitor commands can handle errors, so they can easily be converted to
using the safer bdrv_try_set_aio_context() function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 80dad6d117..a138ca9dbe 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1535,6 +1535,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
                              DO_UPCAST(ExternalSnapshotState, common, co=
mmon);
     TransactionAction *action =3D common->action;
     AioContext *aio_context;
+    int ret;
=20
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
      * purpose but a different set of parameters */
@@ -1674,7 +1675,10 @@ static void external_snapshot_prepare(BlkActionSta=
te *common,
         goto out;
     }
=20
-    bdrv_set_aio_context(state->new_bs, aio_context);
+    ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
+    if (ret < 0) {
+        goto out;
+    }
=20
     /* This removes our old bs and adds the new bs. This is an operation=
 that
      * can fail, so we need to do it in .prepare; undoing it for abort i=
s
@@ -3440,6 +3444,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     int flags, job_flags =3D JOB_DEFAULT;
     int64_t size;
     bool set_backing_hd =3D false;
+    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3541,7 +3546,11 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
         goto out;
     }
=20
-    bdrv_set_aio_context(target_bs, aio_context);
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        bdrv_unref(target_bs);
+        goto out;
+    }
=20
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
@@ -3613,6 +3622,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup=
, JobTxn *txn,
     AioContext *aio_context;
     BlockJob *job =3D NULL;
     int job_flags =3D JOB_DEFAULT;
+    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3649,16 +3659,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backu=
p, JobTxn *txn,
         goto out;
     }
=20
-    if (bdrv_get_aio_context(target_bs) !=3D aio_context) {
-        if (!bdrv_has_blk(target_bs)) {
-            /* The target BDS is not attached, we can safely move it to =
another
-             * AioContext. */
-            bdrv_set_aio_context(target_bs, aio_context);
-        } else {
-            error_setg(errp, "Target is attached to a different thread f=
rom "
-                             "source.");
-            goto out;
-        }
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        goto out;
     }
=20
     if (backup->has_bitmap) {
@@ -3831,6 +3834,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
     if (!bs) {
@@ -3931,7 +3935,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
         goto out;
     }
=20
-    bdrv_set_aio_context(target_bs, aio_context);
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        bdrv_unref(target_bs);
+        goto out;
+    }
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
@@ -3975,6 +3983,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
     Error *local_err =3D NULL;
+    int ret;
=20
     bs =3D qmp_get_root_bs(device, errp);
     if (!bs) {
@@ -3989,7 +3998,10 @@ void qmp_blockdev_mirror(bool has_job_id, const ch=
ar *job_id,
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
-    bdrv_set_aio_context(target_bs, aio_context);
+    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
+    if (ret < 0) {
+        goto out;
+    }
=20
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
@@ -4005,7 +4017,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
                            has_auto_dismiss, auto_dismiss,
                            &local_err);
     error_propagate(errp, local_err);
-
+out:
     aio_context_release(aio_context);
 }
=20
@@ -4495,7 +4507,7 @@ void qmp_x_blockdev_set_iothread(const char *node_n=
ame, StrOrNull *iothread,
     old_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(old_context);
=20
-    bdrv_set_aio_context(bs, new_context);
+    bdrv_try_set_aio_context(bs, new_context, errp);
=20
     aio_context_release(old_context);
 }
--=20
2.20.1


