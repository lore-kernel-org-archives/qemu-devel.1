Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1332084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1332084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdluJ-0007mF-8H
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdleD-0002Fb-Jw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlUm-0004mz-Nk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUk-0004k4-JS; Wed, 19 Jun 2019 21:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D181111549;
 Thu, 20 Jun 2019 01:04:05 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0C551001E67;
 Thu, 20 Jun 2019 01:04:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:46 -0400
Message-Id: <20190620010356.19164-3-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-1-jsnow@redhat.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 20 Jun 2019 01:04:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/12] block/backup: Add mirror sync mode
 'bitmap'
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

We don't need or want a new sync mode for simple differences in
semantics.  Create a new mode simply named "BITMAP" that is designed to
make use of the new Bitmap Sync Mode field.

Because the only bitmap mode is 'conditional', this adds no new
functionality to the backup job (yet). The old incremental backup mode
is maintained as a syntactic sugar for sync=3Dbitmap, mode=3Dconditional.

Add all of the plumbing necessary to support this new instruction.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json      | 30 ++++++++++++++++++++++--------
 include/block/block_int.h |  6 +++++-
 block/backup.c            | 35 ++++++++++++++++++++++++++++-------
 block/mirror.c            |  6 ++++--
 block/replication.c       |  2 +-
 blockdev.c                |  8 ++++++--
 6 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index caf28a71a0..6d05ad8f47 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1127,12 +1127,15 @@
 #
 # @none: only copy data written from now on
 #
-# @incremental: only copy data described by the dirty bitmap. Since: 2.4
+# @incremental: only copy data described by the dirty bitmap. (since: 2.=
4)
+#
+# @bitmap: only copy data described by the dirty bitmap. (since: 4.1)
+#          Behavior on completion is determined by the BitmapSyncMode.
 #
 # Since: 1.3
 ##
 { 'enum': 'MirrorSyncMode',
-  'data': ['top', 'full', 'none', 'incremental'] }
+  'data': ['top', 'full', 'none', 'incremental', 'bitmap'] }
=20
 ##
 # @BitmapSyncMode:
@@ -1352,10 +1355,14 @@
 #
 # @speed: the maximum speed, in bytes per second
 #
-# @bitmap: the name of dirty bitmap if sync is "incremental".
-#          Must be present if sync is "incremental", must NOT be present
+# @bitmap: the name of dirty bitmap if sync is "bitmap".
+#          Must be present if sync is "bitmap", must NOT be present
 #          otherwise. (Since 2.4)
 #
+# @bitmap-mode: Specifies the type of data the bitmap should contain aft=
er
+#               the operation concludes. Must be present if sync is "bit=
map".
+#               Must NOT be present otherwise. (Since 4.1)
+#
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
@@ -1390,7 +1397,8 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', 'sync': 'MirrorSyncMode',
             '*mode': 'NewImageMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
+            '*bitmap': 'str', '*bitmap-mode': 'BitmapSyncMode',
+            '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
@@ -1412,10 +1420,14 @@
 # @speed: the maximum speed, in bytes per second. The default is 0,
 #         for unlimited.
 #
-# @bitmap: the name of dirty bitmap if sync is "incremental".
-#          Must be present if sync is "incremental", must NOT be present
+# @bitmap: the name of dirty bitmap if sync is "bitmap".
+#          Must be present if sync is "bitmap", must NOT be present
 #          otherwise. (Since 3.1)
 #
+# @bitmap-mode: Specifies the type of data the bitmap should contain aft=
er
+#               the operation concludes. Must be present if sync is "bit=
map".
+#               Must NOT be present otherwise. (Since 4.1)
+#
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
@@ -1449,7 +1461,9 @@
 { 'struct': 'BlockdevBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             'sync': 'MirrorSyncMode', '*speed': 'int',
-            '*bitmap': 'str', '*compress': 'bool',
+            '*bitmap': 'str',
+            '*bitmap-mode': 'BitmapSyncMode',
+            '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d6415b53c1..89370c1b9b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1132,7 +1132,9 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
  * @target: Block device to write to.
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @sync_mode: What parts of the disk image should be copied to the dest=
ination.
- * @sync_bitmap: The dirty bitmap if sync_mode is MIRROR_SYNC_MODE_INCRE=
MENTAL.
+ * @sync_bitmap: The dirty bitmap if sync_mode is 'bitmap' or 'increment=
al'
+ * @has_bitmap_mode: true if @bitmap_sync carries a meaningful value.
+ * @bitmap_mode: The bitmap synchronization policy to use.
  * @on_source_error: The action to take upon error reading from the sour=
ce.
  * @on_target_error: The action to take upon error writing to the target=
.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
@@ -1148,6 +1150,8 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
                             BlockDriverState *target, int64_t speed,
                             MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
+                            bool has_bitmap_mode,
+                            BitmapSyncMode bitmap_mode,
                             bool compress,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
diff --git a/block/backup.c b/block/backup.c
index 715e1d3be8..c4f83d4ef7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -38,9 +38,9 @@ typedef struct CowRequest {
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockBackend *target;
-    /* bitmap for sync=3Dincremental */
     BdrvDirtyBitmap *sync_bitmap;
     MirrorSyncMode sync_mode;
+    BitmapSyncMode bitmap_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     CoRwlock flush_rwlock;
@@ -452,7 +452,7 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
=20
     job_progress_set_remaining(job, s->len);
=20
-    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
+    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
         backup_incremental_init_copy_bitmap(s);
     } else {
         hbitmap_set(s->copy_bitmap, 0, s->len);
@@ -536,6 +536,7 @@ static int64_t backup_calculate_cluster_size(BlockDri=
verState *target,
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap=
,
+                  bool has_bitmap_mode, BitmapSyncMode bitmap_mode,
                   bool compress,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
@@ -548,6 +549,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     int ret;
     int64_t cluster_size;
     HBitmap *copy_bitmap =3D NULL;
+    MirrorSyncMode effective_mode =3D sync_mode;
=20
     assert(bs);
     assert(target);
@@ -584,9 +586,28 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
     }
=20
     if (sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
+        if (has_bitmap_mode &&
+            bitmap_mode !=3D BITMAP_SYNC_MODE_CONDITIONAL) {
+            error_setg(errp, "Bitmap sync mode must be 'conditional' "
+                       "when using sync mode '%s'",
+                       MirrorSyncMode_str(sync_mode));
+            return NULL;
+        }
+        has_bitmap_mode =3D true;
+        bitmap_mode =3D BITMAP_SYNC_MODE_CONDITIONAL;
+        effective_mode =3D MIRROR_SYNC_MODE_BITMAP;
+    }
+
+    if (effective_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
         if (!sync_bitmap) {
             error_setg(errp, "must provide a valid bitmap name for "
-                             "\"incremental\" sync mode");
+                       "'%s' sync mode", MirrorSyncMode_str(sync_mode));
+            return NULL;
+        }
+
+        if (!has_bitmap_mode) {
+            error_setg(errp, "must provide a valid bitmap mode for "
+                       "'%s' sync mode", MirrorSyncMode_str(sync_mode));
             return NULL;
         }
=20
@@ -596,8 +617,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         }
     } else if (sync_bitmap) {
         error_setg(errp,
-                   "a sync_bitmap was provided to backup_run, "
-                   "but received an incompatible sync_mode (%s)",
+                   "a bitmap was given to backup_job_create, "
+                   "but it received an incompatible sync_mode (%s)",
                    MirrorSyncMode_str(sync_mode));
         return NULL;
     }
@@ -639,8 +660,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
     job->on_source_error =3D on_source_error;
     job->on_target_error =3D on_target_error;
     job->sync_mode =3D sync_mode;
-    job->sync_bitmap =3D sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL ?
-                       sync_bitmap : NULL;
+    job->sync_bitmap =3D sync_bitmap;
+    job->bitmap_mode =3D bitmap_mode;
     job->compress =3D compress;
=20
     /* Detect image-fleecing (and similar) schemes */
diff --git a/block/mirror.c b/block/mirror.c
index d17be4cdbc..42b3d9acd0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1717,8 +1717,10 @@ void mirror_start(const char *job_id, BlockDriverS=
tate *bs,
     bool is_none_mode;
     BlockDriverState *base;
=20
-    if (mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode 'incremental' not supported");
+    if ((mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) ||
+        (mode =3D=3D MIRROR_SYNC_MODE_BITMAP)) {
+        error_setg(errp, "Sync mode '%s' not supported",
+                   MirrorSyncMode_str(mode));
         return;
     }
     is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
diff --git a/block/replication.c b/block/replication.c
index b41bc507c0..a62aaeb879 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -543,7 +543,7 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
=20
         s->backup_job =3D backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_d=
isk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, false,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, false, 0=
, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_e=
rr);
diff --git a/blockdev.c b/blockdev.c
index 5d6a13dea9..7abbd6bbf2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3572,7 +3572,9 @@ static BlockJob *do_drive_backup(DriveBackup *backu=
p, JobTxn *txn,
     }
=20
     job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
-                            backup->sync, bmap, backup->compress,
+                            backup->sync, bmap,
+                            backup->has_bitmap_mode, backup->bitmap_mode=
,
+                            backup->compress,
                             backup->on_source_error, backup->on_target_e=
rror,
                             job_flags, NULL, NULL, txn, &local_err);
     if (local_err !=3D NULL) {
@@ -3677,7 +3679,9 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup=
, JobTxn *txn,
         job_flags |=3D JOB_MANUAL_DISMISS;
     }
     job =3D backup_job_create(backup->job_id, bs, target_bs, backup->spe=
ed,
-                            backup->sync, bmap, backup->compress,
+                            backup->sync, bmap,
+                            backup->has_bitmap_mode, backup->bitmap_mode=
,
+                            backup->compress,
                             backup->on_source_error, backup->on_target_e=
rror,
                             job_flags, NULL, NULL, txn, &local_err);
     if (local_err !=3D NULL) {
--=20
2.21.0


