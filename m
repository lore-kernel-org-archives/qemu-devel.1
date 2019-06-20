Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C08C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6523F215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6523F215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdlhb-0004MI-5n
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40419)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdle3-000235-M8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlV5-00053z-HA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUy-0004wZ-PK; Wed, 19 Jun 2019 21:04:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E9F23004426;
 Thu, 20 Jun 2019 01:04:18 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 561B01001E67;
 Thu, 20 Jun 2019 01:04:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:56 -0400
Message-Id: <20190620010356.19164-13-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-1-jsnow@redhat.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 20 Jun 2019 01:04:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/12] block/backup: loosen restriction on
 readonly bitmaps
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the "never" sync policy, we actually can utilize readonly bitmaps
now. Loosen the check at the QMP level, and tighten it based on
provided arguments down at the job creation level instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 6 ++++++
 blockdev.c     | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index beb2078696..ead9a049e2 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -614,6 +614,12 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
             return NULL;
         }
=20
+        /* If we need to write to this bitmap, check that we can: */
+        if (bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER &&
+            bdrv_dirty_bitmap_check(sync_bitmap, BDRV_BITMAP_DEFAULT, er=
rp)) {
+            return NULL;
+        }
+
         /* Create a new bitmap, and freeze/disable this one. */
         if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) < =
0) {
             return NULL;
diff --git a/blockdev.c b/blockdev.c
index 7abbd6bbf2..173a6b85c6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3560,7 +3560,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
             goto unref;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto unref;
         }
     }
@@ -3667,7 +3667,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup=
, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto out;
         }
     }
--=20
2.21.0


