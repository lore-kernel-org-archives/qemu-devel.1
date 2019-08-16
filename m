Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A2C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0B72086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0B72086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylsr-0003bp-SB
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylQ4-00078e-9g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylQ2-0006OK-Nw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPz-0006Jq-7c; Fri, 16 Aug 2019 19:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73FE8796FF;
 Fri, 16 Aug 2019 23:13:51 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C15A119C6A;
 Fri, 16 Aug 2019 23:13:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:13 -0400
Message-Id: <20190816231318.8650-32-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 16 Aug 2019 23:13:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 31/36] block/backup: support bitmap sync modes
 for non-bitmap backups
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Accept bitmaps and sync policies for the other backup modes.
This allows us to do things like create a bitmap synced to a full backup
without a transaction, or start a resumable backup process.

Some combinations don't make sense, though:

- NEVER policy combined with any non-BITMAP mode doesn't do anything,
  because the bitmap isn't used for input or output.
  It's harmless, but is almost certainly never what the user wanted.

- sync=3DNONE is more questionable. It can't use on-success because this
  job never completes with success anyway, and the resulting artifact
  of 'always' is suspect: because we start with a full bitmap and only
  copy out segments that get written to, the final output bitmap will
  always be ... a fully set bitmap.

  Maybe there's contexts in which bitmaps make sense for sync=3Dnone,
  but not without more severe changes to the current job, and omitting
  it here doesn't prevent us from adding it later.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190716000117.25219-11-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c       |  8 +-------
 blockdev.c           | 22 ++++++++++++++++++++++
 qapi/block-core.json |  6 ++++--
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9e1382ec5c6..a9be07258c1 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -697,7 +697,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         return NULL;
     }
=20
-    if (sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
+    if (sync_bitmap) {
         /* If we need to write to this bitmap, check that we can: */
         if (bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER &&
             bdrv_dirty_bitmap_check(sync_bitmap, BDRV_BITMAP_DEFAULT, er=
rp)) {
@@ -708,12 +708,6 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
         if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) < =
0) {
             return NULL;
         }
-    } else if (sync_bitmap) {
-        error_setg(errp,
-                   "a bitmap was given to backup_job_create, "
-                   "but it received an incompatible sync_mode (%s)",
-                   MirrorSyncMode_str(sync_mode));
-        return NULL;
     }
=20
     len =3D bdrv_getlength(bs);
diff --git a/blockdev.c b/blockdev.c
index f889da0b427..64d06d1f672 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3567,6 +3567,28 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
         if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             return NULL;
         }
+
+        /* This does not produce a useful bitmap artifact: */
+        if (backup->sync =3D=3D MIRROR_SYNC_MODE_NONE) {
+            error_setg(errp, "sync mode '%s' does not produce meaningful=
 bitmap"
+                       " outputs", MirrorSyncMode_str(backup->sync));
+            return NULL;
+        }
+
+        /* If the bitmap isn't used for input or output, this is useless=
: */
+        if (backup->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER &&
+            backup->sync !=3D MIRROR_SYNC_MODE_BITMAP) {
+            error_setg(errp, "Bitmap sync mode '%s' has no meaningful ef=
fect"
+                       " when combined with sync mode '%s'",
+                       BitmapSyncMode_str(backup->bitmap_mode),
+                       MirrorSyncMode_str(backup->sync));
+            return NULL;
+        }
+    }
+
+    if (!backup->has_bitmap && backup->has_bitmap_mode) {
+        error_setg(errp, "Cannot specify bitmap sync mode without a bitm=
ap");
+        return NULL;
     }
=20
     if (!backup->auto_finalize) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8344fbe2030..d72cf5f354b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1352,13 +1352,15 @@
 # @speed: the maximum speed, in bytes per second. The default is 0,
 #         for unlimited.
 #
-# @bitmap: the name of a dirty bitmap if sync is "bitmap" or "incrementa=
l".
+# @bitmap: The name of a dirty bitmap to use.
 #          Must be present if sync is "bitmap" or "incremental".
+#          Can be present if sync is "full" or "top".
 #          Must not be present otherwise.
 #          (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain aft=
er
-#               the operation concludes. Must be present if sync is "bit=
map".
+#               the operation concludes.
+#               Must be present if a bitmap was provided,
 #               Must NOT be present otherwise. (Since 4.2)
 #
 # @compress: true to compress data, if the target format supports it.
--=20
2.21.0


