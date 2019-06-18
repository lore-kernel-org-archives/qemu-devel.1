Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276BC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37A20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGdu-0002yj-PT
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxV-000822-4H
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxR-0000gV-6G
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxJ-0000N4-SW; Tue, 18 Jun 2019 11:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AAEB31628E4;
 Tue, 18 Jun 2019 15:23:26 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9398D5BBD2;
 Tue, 18 Jun 2019 15:23:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:07 +0200
Message-Id: <20190618152318.24953-4-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 15:23:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/14] block/block-backend: blk_iostatus_reset:
 drop usage of bs->job
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to remove bs->job pointer. Drop it's usage in
blk_iostatus_reset.

blk_iostatus_reset() has only two callers:

1. blk_attach_dev(). This doesn't have anything to do with jobs and
    attaching a new guest device won't solve any problem the job
    encountered, so no reason to reset the iostatus for the job.

2. qmp_cont(). This resets the iostatus for everything. We can just
    call block_job_iostatus_reset() for all block jobs instead of going
    through BlockBackend.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 4 ----
 monitor/qmp-cmds.c    | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f5d9407d20..a8d160fd5d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1073,11 +1073,7 @@ void blk_iostatus_disable(BlockBackend *blk)
 void blk_iostatus_reset(BlockBackend *blk)
 {
     if (blk_iostatus_is_enabled(blk)) {
-        BlockDriverState *bs =3D blk_bs(blk);
         blk->iostatus =3D BLOCK_DEVICE_IO_STATUS_OK;
-        if (bs && bs->job) {
-            block_job_iostatus_reset(bs->job);
-        }
     }
 }
=20
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f1b1e4f08b..01ce77e129 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -143,6 +143,7 @@ void qmp_x_exit_preconfig(Error **errp)
 void qmp_cont(Error **errp)
 {
     BlockBackend *blk;
+    BlockJob *job;
     Error *local_err =3D NULL;
=20
     /* if there is a dump in background, we should wait until the dump
@@ -166,6 +167,10 @@ void qmp_cont(Error **errp)
         blk_iostatus_reset(blk);
     }
=20
+    for (job =3D block_job_next(NULL); job; job =3D block_job_next(job))=
 {
+        block_job_iostatus_reset(job);
+    }
+
     /* Continuing after completed migration. Images have been inactivate=
d to
      * allow the destination to take control. Need to get control back n=
ow.
      *
--=20
2.20.1


