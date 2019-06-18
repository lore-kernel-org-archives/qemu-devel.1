Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC669C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50DD2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50DD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGvl-0005LS-3j
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxY-00083i-VV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxW-0000lv-69
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxL-0000RL-2R; Tue, 18 Jun 2019 11:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E32C33078AAC;
 Tue, 18 Jun 2019 15:23:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4A9D5BBD2;
 Tue, 18 Jun 2019 15:23:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:08 +0200
Message-Id: <20190618152318.24953-5-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
References: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 18 Jun 2019 15:23:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/14] blockdev: blockdev_mark_auto_del: drop
 usage of bs->job
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
blockdev_mark_auto_del: instead of looking at bs->job let's check all
jobs for references to bs.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  9 +++++++++
 blockdev.c               | 17 ++++++++---------
 blockjob.c               | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index ede0bd8dcb..35faa3aa26 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -121,6 +121,15 @@ int block_job_add_bdrv(BlockJob *job, const char *na=
me, BlockDriverState *bs,
  */
 void block_job_remove_all_bdrv(BlockJob *job);
=20
+/**
+ * block_job_has_bdrv:
+ * @job: The block job
+ *
+ * Searches for @bs in the list of nodes that are involved in the
+ * job.
+ */
+bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
+
 /**
  * block_job_set_speed:
  * @job: The job to set the speed for.
diff --git a/blockdev.c b/blockdev.c
index b5c0fd3c49..a9dd73eafc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -140,22 +140,21 @@ void override_max_devs(BlockInterfaceType type, int=
 max_devs)
 void blockdev_mark_auto_del(BlockBackend *blk)
 {
     DriveInfo *dinfo =3D blk_legacy_dinfo(blk);
-    BlockDriverState *bs =3D blk_bs(blk);
-    AioContext *aio_context;
+    BlockJob *job;
=20
     if (!dinfo) {
         return;
     }
=20
-    if (bs) {
-        aio_context =3D bdrv_get_aio_context(bs);
-        aio_context_acquire(aio_context);
+    for (job =3D block_job_next(NULL); job; job =3D block_job_next(job))=
 {
+        if (block_job_has_bdrv(job, blk_bs(blk))) {
+            AioContext *aio_context =3D job->job.aio_context;
+            aio_context_acquire(aio_context);
=20
-        if (bs->job) {
-            job_cancel(&bs->job->job, false);
-        }
+            job_cancel(&job->job, false);
=20
-        aio_context_release(aio_context);
+            aio_context_release(aio_context);
+        }
     }
=20
     dinfo->auto_del =3D 1;
diff --git a/blockjob.c b/blockjob.c
index 1fac6bb8a7..c3620ec544 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,6 +198,20 @@ void block_job_remove_all_bdrv(BlockJob *job)
     job->nodes =3D NULL;
 }
=20
+bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
+{
+    GSList *el;
+
+    for (el =3D job->nodes; el; el =3D el->next) {
+        BdrvChild *c =3D el->data;
+        if (c->bs =3D=3D bs) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState=
 *bs,
                        uint64_t perm, uint64_t shared_perm, Error **errp=
)
 {
--=20
2.20.1


