Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EBE20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EBE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqFJ-0008R3-0s
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:07:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAG-0004Pw-7m
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAE-00022Q-RM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTqA8-0001qI-CM; Thu, 23 May 2019 12:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 859A830821BF;
	Thu, 23 May 2019 16:01:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9271001F5B;
	Thu, 23 May 2019 16:01:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:00:59 +0200
Message-Id: <20190523160104.21258-11-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 23 May 2019 16:01:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/15] blockdev: Use bdrv_try_set_aio_context()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
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
index 04abbc61c7..624534a05d 100644
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
@@ -3424,6 +3428,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     int flags, job_flags =3D JOB_DEFAULT;
     int64_t size;
     bool set_backing_hd =3D false;
+    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3520,7 +3525,11 @@ static BlockJob *do_drive_backup(DriveBackup *back=
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
@@ -3592,6 +3601,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup=
, JobTxn *txn,
     AioContext *aio_context;
     BlockJob *job =3D NULL;
     int job_flags =3D JOB_DEFAULT;
+    int ret;
=20
     if (!backup->has_speed) {
         backup->speed =3D 0;
@@ -3628,16 +3638,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backu=
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
@@ -3810,6 +3813,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
     if (!bs) {
@@ -3910,7 +3914,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
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
@@ -3954,6 +3962,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
     Error *local_err =3D NULL;
+    int ret;
=20
     bs =3D qmp_get_root_bs(device, errp);
     if (!bs) {
@@ -3968,7 +3977,10 @@ void qmp_blockdev_mirror(bool has_job_id, const ch=
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
@@ -3984,7 +3996,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
                            has_auto_dismiss, auto_dismiss,
                            &local_err);
     error_propagate(errp, local_err);
-
+out:
     aio_context_release(aio_context);
 }
=20
@@ -4474,7 +4486,7 @@ void qmp_x_blockdev_set_iothread(const char *node_n=
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


