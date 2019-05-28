Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE0C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E03208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E03208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi0Q-0003bj-Jm
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:43:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoA-0001dT-W1
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVho6-00023u-E4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhns-0000Po-Ml; Tue, 28 May 2019 15:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B8F59FDE7;
	Tue, 28 May 2019 19:29:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 248B560C47;
	Tue, 28 May 2019 19:29:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:35 +0200
Message-Id: <20190528192847.2730-10-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 28 May 2019 19:29:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/21] block/backup: simplify
 backup_incremental_init_copy_bitmap
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

Simplify backup_incremental_init_copy_bitmap using the function
bdrv_dirty_bitmap_next_dirty_area.

Note: move to job->len instead of bitmap size: it should not matter but
less code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 916817d8b1..db83b09a0b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -394,43 +394,27 @@ static int coroutine_fn backup_run_incremental(Back=
upBlockJob *job)
 /* init copy_bitmap from sync_bitmap */
 static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 {
-    BdrvDirtyBitmapIter *dbi;
-    int64_t offset;
-    int64_t end =3D DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap=
),
-                               job->cluster_size);
-
-    dbi =3D bdrv_dirty_iter_new(job->sync_bitmap);
-    while ((offset =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
-        int64_t cluster =3D offset / job->cluster_size;
-        int64_t next_cluster;
-
-        offset +=3D bdrv_dirty_bitmap_granularity(job->sync_bitmap);
-        if (offset >=3D bdrv_dirty_bitmap_size(job->sync_bitmap)) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    uint64_t offset =3D 0;
+    uint64_t bytes =3D job->len;
=20
-        offset =3D bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset,
-                                             UINT64_MAX);
-        if (offset =3D=3D -1) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
+                                             &offset, &bytes))
+    {
+        uint64_t cluster =3D offset / job->cluster_size;
+        uint64_t end_cluster =3D DIV_ROUND_UP(offset + bytes, job->clust=
er_size);
=20
-        next_cluster =3D DIV_ROUND_UP(offset, job->cluster_size);
-        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster);
-        if (next_cluster >=3D end) {
+        hbitmap_set(job->copy_bitmap, cluster, end_cluster - cluster);
+
+        offset =3D end_cluster * job->cluster_size;
+        if (offset >=3D job->len) {
             break;
         }
-
-        bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
+        bytes =3D job->len - offset;
     }
=20
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
         job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
-
-    bdrv_dirty_iter_free(dbi);
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
--=20
2.21.0


