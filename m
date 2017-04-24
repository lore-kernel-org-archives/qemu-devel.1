Received: from eggs.gnu.org ([2001:4830:134:3::10]:53627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zT-14
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOn-0006wH-VA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOn-0006vW-MP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B001F23E6CC
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:51 +0200
Message-Id: <1493018820-23445-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] block: Make errp the last parameter of
 bdrv_img_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-6-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                  |  4 ++--
 blockdev.c               | 10 +++++-----
 include/block/block.h    |  2 +-
 qemu-img.c               |  2 +-
 tests/test-replication.c |  8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 1fbbb8d..7eda9a4 100644
--- a/block.c
+++ b/block.c
@@ -4161,8 +4161,8 @@ bool bdrv_op_blocker_is_empty(BlockDriverState *bs)
 
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
-                     char *options, uint64_t img_size, int flags,
-                     Error **errp, bool quiet)
+                     char *options, uint64_t img_size, int flags, bool quiet,
+                     Error **errp)
 {
     QemuOptsList *create_opts = NULL;
     QemuOpts *opts = NULL;
diff --git a/blockdev.c b/blockdev.c
index 4927914..94726ed 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1728,7 +1728,7 @@ static void external_snapshot_prepare(BlkActionState *common,
             bdrv_img_create(new_image_file, format,
                             state->old_bs->filename,
                             state->old_bs->drv->format_name,
-                            NULL, size, flags, &local_err, false);
+                            NULL, size, flags, false, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return;
@@ -3237,10 +3237,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         if (source) {
             bdrv_img_create(backup->target, backup->format, source->filename,
                             source->drv->format_name, NULL,
-                            size, flags, &local_err, false);
+                            size, flags, false, &local_err);
         } else {
             bdrv_img_create(backup->target, backup->format, NULL, NULL, NULL,
-                            size, flags, &local_err, false);
+                            size, flags, false, &local_err);
         }
     }
 
@@ -3531,7 +3531,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         /* create new image w/o backing file */
         assert(format);
         bdrv_img_create(arg->target, format,
-                        NULL, NULL, NULL, size, flags, &local_err, false);
+                        NULL, NULL, NULL, size, flags, false, &local_err);
     } else {
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
@@ -3541,7 +3541,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
             bdrv_img_create(arg->target, format,
                             source->filename,
                             source->drv->format_name,
-                            NULL, size, flags, &local_err, false);
+                            NULL, size, flags, false, &local_err);
             break;
         default:
             abort();
diff --git a/include/block/block.h b/include/block/block.h
index 5ddc0cf..466de49 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -509,7 +509,7 @@ int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
                      char *options, uint64_t img_size, int flags,
-                     Error **errp, bool quiet);
+                     bool quiet, Error **errp);
 
 /* Returns the alignment in bytes that is required so that no bounce buffer
  * is required throughout the stack */
diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..2c09053 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -516,7 +516,7 @@ static int img_create(int argc, char **argv)
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
-                    options, img_size, 0, &local_err, quiet);
+                    options, img_size, 0, quiet, &local_err);
     if (local_err) {
         error_reportf_err(local_err, "%s: ", filename);
         goto fail;
diff --git a/tests/test-replication.c b/tests/test-replication.c
index fac2da3..3016c6f 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -144,18 +144,18 @@ static void prepare_imgs(void)
 
     /* Primary */
     bdrv_img_create(p_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, &local_err, true);
+                    BDRV_O_RDWR, true, &local_err);
     g_assert(!local_err);
 
     /* Secondary */
     bdrv_img_create(s_local_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, &local_err, true);
+                    BDRV_O_RDWR, true, &local_err);
     g_assert(!local_err);
     bdrv_img_create(s_active_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, &local_err, true);
+                    BDRV_O_RDWR, true, &local_err);
     g_assert(!local_err);
     bdrv_img_create(s_hidden_disk, "qcow2", NULL, NULL, NULL, IMG_SIZE,
-                    BDRV_O_RDWR, &local_err, true);
+                    BDRV_O_RDWR, true, &local_err);
     g_assert(!local_err);
 }
 
-- 
2.7.4
