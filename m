Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2320EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F90208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F90208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi8S-0001Rf-9q
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:51:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhpN-0002bS-AO
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhpM-0002sp-2Z
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhpH-0000ic-1X; Tue, 28 May 2019 15:31:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D8FE307E040;
	Tue, 28 May 2019 19:29:22 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D825C1001DD7;
	Tue, 28 May 2019 19:29:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:38 +0200
Message-Id: <20190528192847.2730-13-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:29:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/21] block/backup: unify different modes code
 path
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Do full, top and incremental mode copying all in one place. This
unifies the code path and helps further improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-5-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 78f1b79354..5b3fc9d123 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -384,15 +384,23 @@ static bool bdrv_is_unallocated_range(BlockDriverSt=
ate *bs,
     return offset >=3D end;
 }
=20
-static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
+static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
     int64_t offset;
     HBitmapIter hbi;
+    BlockDriverState *bs =3D blk_bs(job->common.blk);
=20
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
+        if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
+            bdrv_is_unallocated_range(bs, offset, job->cluster_size))
+        {
+            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            continue;
+        }
+
         do {
             if (yield_and_check(job)) {
                 return 0;
@@ -437,7 +445,6 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs =3D blk_bs(s->common.blk);
-    int64_t offset;
     int ret =3D 0;
=20
     QLIST_INIT(&s->inflight_reqs);
@@ -462,38 +469,8 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
              * notify callback service CoW requests. */
             job_yield(job);
         }
-    } else if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
-        ret =3D backup_run_incremental(s);
     } else {
-        /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset =3D 0; offset < s->len;
-             offset +=3D s->cluster_size) {
-            bool error_is_read;
-
-            if (yield_and_check(s)) {
-                break;
-            }
-
-            if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
-                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
-            {
-                continue;
-            }
-
-            ret =3D backup_do_cow(s, offset, s->cluster_size,
-                                &error_is_read, false);
-            if (ret < 0) {
-                /* Depending on error action, fail now or retry cluster =
*/
-                BlockErrorAction action =3D
-                    backup_error_action(s, error_is_read, -ret);
-                if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
-                    break;
-                } else {
-                    offset -=3D s->cluster_size;
-                    continue;
-                }
-            }
-        }
+        ret =3D backup_loop(s);
     }
=20
     notifier_with_return_remove(&s->before_write);
--=20
2.21.0


