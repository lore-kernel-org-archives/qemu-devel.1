Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67375C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C608217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C608217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPDSD-0003CP-21
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:53:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPDRG-0002lS-Iq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPDRF-0000fs-H0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hPDRD-0000d7-AH; Fri, 10 May 2019 17:52:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 761F63DDBE;
	Fri, 10 May 2019 21:52:18 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD575D962;
	Fri, 10 May 2019 21:52:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 17:52:12 -0400
Message-Id: <20190510215212.8413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 10 May 2019 21:52:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] blockdev: fix missed target unref for
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
Cc: Kevin Wolf <kwolf@redhat.com>, aihua liang <aliang@redhat.com>,
	John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the bitmap can't be used for whatever reason, we skip putting down
the reference. Fix that.

In practice, this means that if you attempt to gracefully exit QEMU
after a backup command being rejected, bdrv_close_all will fail and
tell you some unpleasant things via assert().

Reported-by: aihua liang <aliang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1703916
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..278ecdd122 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3525,8 +3525,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
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
@@ -3534,11 +3533,10 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
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
@@ -3552,12 +3550,12 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_e=
rror,
                             job_flags, NULL, NULL, txn, &local_err);
-    bdrv_unref(target_bs);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
-        goto out;
     }
=20
+unref:
+    bdrv_unref(target_bs);
 out:
     aio_context_release(aio_context);
     return job;
--=20
2.20.1


