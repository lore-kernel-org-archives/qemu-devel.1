Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A9C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43335214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43335214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7hU-0007Zu-C0
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57429)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xw-00034O-25
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xu-0004T1-PA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Xs-0004R6-46; Fri, 09 Aug 2019 12:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69F1B30A00E6;
 Fri,  9 Aug 2019 16:15:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2B0A60BF7;
 Fri,  9 Aug 2019 16:15:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:51 +0200
Message-Id: <20190809161407.11920-27-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 16:15:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 26/42] backup: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c |  9 +++++----
 blockdev.c     | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ecadb61af3..7854d7575b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -611,6 +611,7 @@ static int64_t backup_calculate_cluster_size(BlockDri=
verState *target,
 {
     int ret;
     BlockDriverInfo bdi;
+    bool target_does_cow =3D bdrv_backing_chain_next(target);
=20
     /*
      * If there is no backing file on the target, we cannot rely on COW =
if our
@@ -618,7 +619,7 @@ static int64_t backup_calculate_cluster_size(BlockDri=
verState *target,
      * targets with a backing file, try to avoid COW if possible.
      */
     ret =3D bdrv_get_info(target, &bdi);
-    if (ret =3D=3D -ENOTSUP && !target->backing) {
+    if (ret =3D=3D -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
         warn_report("The target block device doesn't provide "
                     "information about the block size and it doesn't hav=
e a "
@@ -627,14 +628,14 @@ static int64_t backup_calculate_cluster_size(BlockD=
riverState *target,
                     "this default, the backup may be unusable",
                     BACKUP_CLUSTER_SIZE_DEFAULT);
         return BACKUP_CLUSTER_SIZE_DEFAULT;
-    } else if (ret < 0 && !target->backing) {
+    } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
         error_append_hint(errp,
             "Aborting, since this may create an unusable destination ima=
ge\n");
         return ret;
-    } else if (ret < 0 && target->backing) {
+    } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
         return BACKUP_CLUSTER_SIZE_DEFAULT;
     }
@@ -683,7 +684,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         return NULL;
     }
=20
-    if (compress && target->drv->bdrv_co_pwritev_compressed =3D=3D NULL)=
 {
+    if (compress && !bdrv_supports_compressed_writes(target)) {
         error_setg(errp, "Compression is not supported for this drive %s=
",
                    bdrv_get_device_name(target));
         return NULL;
diff --git a/blockdev.c b/blockdev.c
index c451f553f7..c6f79b4e0e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3656,7 +3656,13 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     /* See if we have a backing HD we can use to create our new image
      * on top of. */
     if (backup->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
-        source =3D backing_bs(bs);
+        /*
+         * Backup will not replace the source by the target, so none
+         * of the filters skipped here will be removed (in contrast to
+         * mirror).  Therefore, we can skip all of them when looking
+         * for the first COW relationship.
+         */
+        source =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs));
         if (!source) {
             backup->sync =3D MIRROR_SYNC_MODE_FULL;
         }
@@ -3676,9 +3682,14 @@ static BlockJob *do_drive_backup(DriveBackup *back=
up, JobTxn *txn,
     if (backup->mode !=3D NEW_IMAGE_MODE_EXISTING) {
         assert(backup->format);
         if (source) {
-            bdrv_refresh_filename(source);
-            bdrv_img_create(backup->target, backup->format, source->file=
name,
-                            source->drv->format_name, NULL,
+            /* Implicit filters should not appear in the filename */
+            BlockDriverState *explicit_backing =3D
+                bdrv_skip_implicit_filters(source);
+
+            bdrv_refresh_filename(explicit_backing);
+            bdrv_img_create(backup->target, backup->format,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name, NULL,
                             size, flags, false, &local_err);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, =
NULL,
--=20
2.21.0


