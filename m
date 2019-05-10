Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F1EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0152D20896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0152D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCpe-0004Vz-6r
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:13:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPCnf-0003S8-Pj
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPCne-0001nR-NE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hPCnb-0001iE-VQ; Fri, 10 May 2019 17:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DDB93082A4C;
	Fri, 10 May 2019 21:11:22 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86DEB19491;
	Fri, 10 May 2019 21:11:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 17:11:19 -0400
Message-Id: <20190510211119.29376-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 10 May 2019 21:11:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] blockdev: loosen restrictions on drive-backup
 source node
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We mandate that the source node must be a root node; but there's no reaso=
n
I am aware of that it needs to be restricted to such. In some cases, we n=
eed
to make sure that there's a medium present, but in the general case we ca=
n
allow the backup job itself to do the graph checking.

This patch helps improve the error message when you try to backup from
the same node more than once, which is reflected in the change to test
056.

For backups with bitmaps, it will also show a better error message that
the bitmap is in use instead of giving you something cryptic like "need
a root node."

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707303
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c             | 6 +++++-
 tests/qemu-iotests/056 | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..27cb72f7aa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3450,7 +3450,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
         backup->compress =3D false;
     }
=20
-    bs =3D qmp_get_root_bs(backup->device, errp);
+    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
@@ -3459,6 +3459,10 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     aio_context_acquire(aio_context);
=20
     if (!backup->has_format) {
+        if (!bs->drv) {
+            error_setg(errp, "Device has no medium");
+            return NULL;
+        }
         backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
                          NULL : (char*) bs->drv->format_name;
     }
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 3df323984d..f40fc11a09 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -214,7 +214,7 @@ class BackupTest(iotests.QMPTestCase):
         res =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'concluded')
         # Leave zombie job un-dismissed, observe a failure:
-        res =3D self.qmp_backup_and_wait(serror=3D'Need a root block nod=
e',
+        res =3D self.qmp_backup_and_wait(serror=3D"Node 'drive0' is busy=
: block device is in use by block job: backup",
                                        device=3D'drive0', format=3Diotes=
ts.imgfmt,
                                        sync=3D'full', target=3Dself.dest=
_img,
                                        auto_dismiss=3DFalse)
--=20
2.20.1


