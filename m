Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9BF20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9BF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhwu-0008L8-4G
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:39:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnj-0001LL-9L
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhnY-0001Vm-2c
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhnR-0000vM-Uj; Tue, 28 May 2019 15:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F5981E1D;
	Tue, 28 May 2019 19:29:24 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4670D5C8A3;
	Tue, 28 May 2019 19:29:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:39 +0200
Message-Id: <20190528192847.2730-14-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 28 May 2019 19:29:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/21] block/backup: refactor: split out
 backup_calculate_cluster_size
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

Split out cluster_size calculation. Move copy-bitmap creation above
block-job creation, as we are going to share it with upcoming
backup-top filter, which also should be created before actual block job
creation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190429090842.57910-6-vsementsov@virtuozzo.com
[mreitz: Dropped a paragraph from the commit message that was left over
         from a previous version]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 82 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5b3fc9d123..00f4f8af53 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -497,6 +497,42 @@ static const BlockJobDriver backup_job_driver =3D {
     .drain                  =3D backup_drain,
 };
=20
+static int64_t backup_calculate_cluster_size(BlockDriverState *target,
+                                             Error **errp)
+{
+    int ret;
+    BlockDriverInfo bdi;
+
+    /*
+     * If there is no backing file on the target, we cannot rely on COW =
if our
+     * backup cluster size is smaller than the target cluster size. Even=
 for
+     * targets with a backing file, try to avoid COW if possible.
+     */
+    ret =3D bdrv_get_info(target, &bdi);
+    if (ret =3D=3D -ENOTSUP && !target->backing) {
+        /* Cluster size is not defined */
+        warn_report("The target block device doesn't provide "
+                    "information about the block size and it doesn't hav=
e a "
+                    "backing file. The default block size of %u bytes is=
 "
+                    "used. If the actual block size of the target exceed=
s "
+                    "this default, the backup may be unusable",
+                    BACKUP_CLUSTER_SIZE_DEFAULT);
+        return BACKUP_CLUSTER_SIZE_DEFAULT;
+    } else if (ret < 0 && !target->backing) {
+        error_setg_errno(errp, -ret,
+            "Couldn't determine the cluster size of the target image, "
+            "which has no backing file");
+        error_append_hint(errp,
+            "Aborting, since this may create an unusable destination ima=
ge\n");
+        return ret;
+    } else if (ret < 0 && target->backing) {
+        /* Not fatal; just trudge on ahead. */
+        return BACKUP_CLUSTER_SIZE_DEFAULT;
+    }
+
+    return MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+}
+
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap=
,
@@ -508,9 +544,10 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
                   JobTxn *txn, Error **errp)
 {
     int64_t len;
-    BlockDriverInfo bdi;
     BackupBlockJob *job =3D NULL;
     int ret;
+    int64_t cluster_size;
+    HBitmap *copy_bitmap =3D NULL;
=20
     assert(bs);
     assert(target);
@@ -572,6 +609,13 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
         goto error;
     }
=20
+    cluster_size =3D backup_calculate_cluster_size(target, errp);
+    if (cluster_size < 0) {
+        goto error;
+    }
+
+    copy_bitmap =3D hbitmap_alloc(len, ctz32(cluster_size));
+
     /* job->len is fixed, so we can't allow resize */
     job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
                            BLK_PERM_CONSISTENT_READ,
@@ -600,35 +644,9 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
=20
     /* Detect image-fleecing (and similar) schemes */
     job->serialize_target_writes =3D bdrv_chain_contains(target, bs);
-
-    /* If there is no backing file on the target, we cannot rely on COW =
if our
-     * backup cluster size is smaller than the target cluster size. Even=
 for
-     * targets with a backing file, try to avoid COW if possible. */
-    ret =3D bdrv_get_info(target, &bdi);
-    if (ret =3D=3D -ENOTSUP && !target->backing) {
-        /* Cluster size is not defined */
-        warn_report("The target block device doesn't provide "
-                    "information about the block size and it doesn't hav=
e a "
-                    "backing file. The default block size of %u bytes is=
 "
-                    "used. If the actual block size of the target exceed=
s "
-                    "this default, the backup may be unusable",
-                    BACKUP_CLUSTER_SIZE_DEFAULT);
-        job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
-        error_setg_errno(errp, -ret,
-            "Couldn't determine the cluster size of the target image, "
-            "which has no backing file");
-        error_append_hint(errp,
-            "Aborting, since this may create an unusable destination ima=
ge\n");
-        goto error;
-    } else if (ret < 0 && target->backing) {
-        /* Not fatal; just trudge on ahead. */
-        job->cluster_size =3D BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else {
-        job->cluster_size =3D MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.clust=
er_size);
-    }
-
-    job->copy_bitmap =3D hbitmap_alloc(len, ctz32(job->cluster_size));
+    job->cluster_size =3D cluster_size;
+    job->copy_bitmap =3D copy_bitmap;
+    copy_bitmap =3D NULL;
     job->use_copy_range =3D true;
     job->copy_range_size =3D MIN_NON_ZERO(blk_get_max_transfer(job->comm=
on.blk),
                                         blk_get_max_transfer(job->target=
));
@@ -644,6 +662,10 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
     return &job->common;
=20
  error:
+    if (copy_bitmap) {
+        assert(!job || !job->copy_bitmap);
+        hbitmap_free(copy_bitmap);
+    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
--=20
2.21.0


