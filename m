Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90BC072B1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7B820B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7B820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhvt-0007WD-Up
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:38:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoH-0001kx-Tr
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoA-000272-J6
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhny-0001Lf-OI; Tue, 28 May 2019 15:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BBA67E426;
	Tue, 28 May 2019 19:29:51 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 94560189A2;
	Tue, 28 May 2019 19:29:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:47 +0200
Message-Id: <20190528192847.2730-22-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 28 May 2019 19:29:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/21] blockdev: loosen restrictions on
 drive-backup source node
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

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
Message-id: 20190521210053.8864-1-jsnow@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c             | 7 ++++++-
 tests/qemu-iotests/056 | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..bc339d7818 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3450,11 +3450,16 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
         backup->compress =3D false;
     }
=20
-    bs =3D qmp_get_root_bs(backup->device, errp);
+    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
         return NULL;
     }
=20
+    if (!bs->drv) {
+        error_setg(errp, "Device has no medium");
+        return NULL;
+    }
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
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
2.21.0


