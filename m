Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878BC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C78A2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C78A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylp2-00074O-5J
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylQ3-000764-1V
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylQ1-0006MQ-6m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPx-0006Hy-Tg; Fri, 16 Aug 2019 19:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 246813090FEE;
 Fri, 16 Aug 2019 23:13:54 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9C710512;
 Fri, 16 Aug 2019 23:13:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:16 -0400
Message-Id: <20190816231318.8650-35-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 16 Aug 2019 23:13:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 34/36] block/backup: deal with zero detection
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We have detect_zeroes option, so at least for blockdev-backup user
should define it if zero-detection is needed. For drive-backup leave
detection enabled by default but do it through existing option instead
of open-coding.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190730163251.755248-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 15 ++++++---------
 blockdev.c     |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a9be07258c1..083fc189af9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -113,7 +113,10 @@ static int coroutine_fn backup_cow_with_bounce_buffe=
r(BackupBlockJob *job,
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIALIS=
ING : 0;
+    int write_flags =3D
+            (job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0) |
+            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+
=20
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
@@ -131,14 +134,8 @@ static int coroutine_fn backup_cow_with_bounce_buffe=
r(BackupBlockJob *job,
         goto fail;
     }
=20
-    if (buffer_is_zero(*bounce_buffer, nbytes)) {
-        ret =3D blk_co_pwrite_zeroes(job->target, start,
-                                   nbytes, write_flags | BDRV_REQ_MAY_UN=
MAP);
-    } else {
-        ret =3D blk_co_pwrite(job->target, start,
-                            nbytes, *bounce_buffer, write_flags |
-                            (job->compress ? BDRV_REQ_WRITE_COMPRESSED :=
 0));
-    }
+    ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
+                        write_flags);
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
         if (error_is_read) {
diff --git a/blockdev.c b/blockdev.c
index 64d06d1f672..2e536dde3e9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3615,7 +3615,7 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     BlockDriverState *source =3D NULL;
     BlockJob *job =3D NULL;
     AioContext *aio_context;
-    QDict *options =3D NULL;
+    QDict *options;
     Error *local_err =3D NULL;
     int flags;
     int64_t size;
@@ -3688,10 +3688,10 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
         goto out;
     }
=20
+    options =3D qdict_new();
+    qdict_put_str(options, "discard", "unmap");
+    qdict_put_str(options, "detect-zeroes", "unmap");
     if (backup->format) {
-        if (!options) {
-            options =3D qdict_new();
-        }
         qdict_put_str(options, "driver", backup->format);
     }
=20
--=20
2.21.0


