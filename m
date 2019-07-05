Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F9C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6702133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6702133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUg7-0007NJ-N5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUda-00056i-6C
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUdY-0006kH-4a
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUdU-0006fz-7Q; Fri, 05 Jul 2019 16:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83D60C049589;
 Fri,  5 Jul 2019 20:16:47 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3DD3867FF;
 Fri,  5 Jul 2019 20:16:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:16 -0400
Message-Id: <20190705201631.26266-4-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 20:16:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 03/18] blockdev-backup: utilize
 do_backup_common
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 65 +++++-------------------------------------------------
 1 file changed, 6 insertions(+), 59 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5bc8ecd087..77365d8166 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3624,78 +3624,25 @@ BlockJob *do_blockdev_backup(BlockdevBackup *back=
up, JobTxn *txn,
 {
     BlockDriverState *bs;
     BlockDriverState *target_bs;
-    Error *local_err =3D NULL;
-    BdrvDirtyBitmap *bmap =3D NULL;
     AioContext *aio_context;
-    BlockJob *job =3D NULL;
-    int job_flags =3D JOB_DEFAULT;
-    int ret;
-
-    if (!backup->has_speed) {
-        backup->speed =3D 0;
-    }
-    if (!backup->has_on_source_error) {
-        backup->on_source_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
-    if (!backup->has_on_target_error) {
-        backup->on_target_error =3D BLOCKDEV_ON_ERROR_REPORT;
-    }
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
+    BlockJob *job;
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
=20
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
     if (!target_bs) {
-        goto out;
+        return NULL;
     }
=20
-    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
-    if (ret < 0) {
-        goto out;
-    }
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
=20
-    if (backup->has_bitmap) {
-        bmap =3D bdrv_find_dirty_bitmap(bs, backup->bitmap);
-        if (!bmap) {
-            error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
-            goto out;
-        }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
-            goto out;
-        }
-    }
+    job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
+                           bs, target_bs, aio_context, txn, errp);
=20
-    if (!backup->auto_finalize) {
-        job_flags |=3D JOB_MANUAL_FINALIZE;
-    }
-    if (!backup->auto_dismiss) {
-        job_flags |=3D JOB_MANUAL_DISMISS;
-    }
-    job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
-                            backup->sync, bmap, backup->compress,
-                            backup->on_source_error, backup->on_target_e=
rror,
-                            job_flags, NULL, NULL, txn, &local_err);
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-    }
-out:
     aio_context_release(aio_context);
     return job;
 }
--=20
2.21.0


