Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A13AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0358B278E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0358B278E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36315 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoXh-0002S0-5w
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:06:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUW-0000M2-J8
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUV-0006rX-4v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUS-0006XB-Hn; Mon, 03 Jun 2019 11:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13920223891;
	Mon,  3 Jun 2019 15:03:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC4A067279;
	Mon,  3 Jun 2019 15:02:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:08 +0200
Message-Id: <20190603150233.6614-4-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 03 Jun 2019 15:03:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/28] blockdev: fix missed target unref for
 drive-backup
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

From: John Snow <jsnow@redhat.com>

If the bitmap can't be used for whatever reason, we skip putting down
the reference. Fix that.

In practice, this means that if you attempt to gracefully exit QEMU
after a backup command being rejected, bdrv_close_all will fail and
tell you some unpleasant things via assert().

Reported-by: aihua liang <aliang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1703916
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 17c2d801d7..d88dc115f2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3546,8 +3546,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     if (set_backing_hd) {
         bdrv_set_backing_hd(target_bs, source, &local_err);
         if (local_err) {
-            bdrv_unref(target_bs);
-            goto out;
+            goto unref;
         }
     }
=20
@@ -3555,11 +3554,10 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
         bmap =3D bdrv_find_dirty_bitmap(bs, backup->bitmap);
         if (!bmap) {
             error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
-            bdrv_unref(target_bs);
-            goto out;
+            goto unref;
         }
         if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
-            goto out;
+            goto unref;
         }
     }
     if (!backup->auto_finalize) {
@@ -3573,12 +3571,13 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_e=
rror,
                             job_flags, NULL, NULL, txn, &local_err);
-    bdrv_unref(target_bs);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
-        goto out;
+        goto unref;
     }
=20
+unref:
+    bdrv_unref(target_bs);
 out:
     aio_context_release(aio_context);
     return job;
--=20
2.20.1


