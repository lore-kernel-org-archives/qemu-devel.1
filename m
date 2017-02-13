Received: from eggs.gnu.org ([2001:4830:134:3::10]:59396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM0-0003IK-D7
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLy-0006AF-LR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:40 +0100
Message-Id: <1487006583-24350-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 18/41] block: Allow error return in
 BlockDevOps.change_media_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Some devices allow a media change between read-only and read-write
media. They need to adapt the permissions in their .change_media_cb()
implementation, which can fail. So add an Error parameter to the
function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c          | 12 +++++++++---
 blockdev.c                     | 19 +++++++++++++++----
 hw/block/fdc.c                 |  2 +-
 hw/ide/core.c                  |  2 +-
 hw/scsi/scsi-disk.c            |  2 +-
 hw/sd/sd.c                     |  2 +-
 include/block/block_int.h      |  2 +-
 include/sysemu/block-backend.h |  2 +-
 8 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index e10a278..0c23add 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -671,15 +671,21 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
  * Else, notify of media eject.
  * Also send DEVICE_TRAY_MOVED events as appropriate.
  */
-void blk_dev_change_media_cb(BlockBackend *blk, bool load)
+void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp)
 {
     if (blk->dev_ops && blk->dev_ops->change_media_cb) {
         bool tray_was_open, tray_is_open;
+        Error *local_err = NULL;
 
         assert(!blk->legacy_dev);
 
         tray_was_open = blk_dev_is_tray_open(blk);
-        blk->dev_ops->change_media_cb(blk->dev_opaque, load);
+        blk->dev_ops->change_media_cb(blk->dev_opaque, load, &local_err);
+        if (local_err) {
+            assert(load == true);
+            error_propagate(errp, local_err);
+            return;
+        }
         tray_is_open = blk_dev_is_tray_open(blk);
 
         if (tray_was_open != tray_is_open) {
@@ -693,7 +699,7 @@ void blk_dev_change_media_cb(BlockBackend *blk, bool load)
 
 static void blk_root_change_media(BdrvChild *child, bool load)
 {
-    blk_dev_change_media_cb(child->opaque, load);
+    blk_dev_change_media_cb(child->opaque, load, NULL);
 }
 
 /*
diff --git a/blockdev.c b/blockdev.c
index c590e67..8c30084 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2307,7 +2307,7 @@ static int do_open_tray(const char *blk_name, const char *qdev_id,
     }
 
     if (!locked || force) {
-        blk_dev_change_media_cb(blk, false);
+        blk_dev_change_media_cb(blk, false, &error_abort);
     }
 
     if (locked && !force) {
@@ -2345,6 +2345,7 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
                              Error **errp)
 {
     BlockBackend *blk;
+    Error *local_err = NULL;
 
     device = has_device ? device : NULL;
     id = has_id ? id : NULL;
@@ -2368,7 +2369,11 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
         return;
     }
 
-    blk_dev_change_media_cb(blk, true);
+    blk_dev_change_media_cb(blk, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 void qmp_x_blockdev_remove_medium(bool has_device, const char *device,
@@ -2421,7 +2426,7 @@ void qmp_x_blockdev_remove_medium(bool has_device, const char *device,
          * called at all); therefore, the medium needs to be ejected here.
          * Do it after blk_remove_bs() so blk_is_inserted(blk) returns the @load
          * value passed here (i.e. false). */
-        blk_dev_change_media_cb(blk, false);
+        blk_dev_change_media_cb(blk, false, &error_abort);
     }
 
 out:
@@ -2431,6 +2436,7 @@ out:
 static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
+    Error *local_err = NULL;
     bool has_device;
     int ret;
 
@@ -2463,7 +2469,12 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
          * slot here.
          * Do it after blk_insert_bs() so blk_is_inserted(blk) returns the @load
          * value passed here (i.e. true). */
-        blk_dev_change_media_cb(blk, true);
+        blk_dev_change_media_cb(blk, true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            blk_remove_bs(blk);
+            return;
+        }
     }
 }
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 74f3634..5f6c496 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -469,7 +469,7 @@ static void fd_revalidate(FDrive *drv)
     }
 }
 
-static void fd_change_cb(void *opaque, bool load)
+static void fd_change_cb(void *opaque, bool load, Error **errp)
 {
     FDrive *drive = opaque;
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 43709e5..f88b1e5 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1120,7 +1120,7 @@ static void ide_cfata_metadata_write(IDEState *s)
 }
 
 /* called when the inserted state of the media has changed */
-static void ide_cd_change_cb(void *opaque, bool load)
+static void ide_cd_change_cb(void *opaque, bool load, Error **errp)
 {
     IDEState *s = opaque;
     uint64_t nb_sectors;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 61c44a9..f3f20da 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2225,7 +2225,7 @@ static void scsi_disk_resize_cb(void *opaque)
     }
 }
 
-static void scsi_cd_change_media_cb(void *opaque, bool load)
+static void scsi_cd_change_media_cb(void *opaque, bool load, Error **errp)
 {
     SCSIDiskState *s = opaque;
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8e88e83..8e31491 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -458,7 +458,7 @@ static bool sd_get_readonly(SDState *sd)
     return sd->wp_switch;
 }
 
-static void sd_cardchange(void *opaque, bool load)
+static void sd_cardchange(void *opaque, bool load, Error **errp)
 {
     SDState *sd = opaque;
     DeviceState *dev = DEVICE(sd);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 46f51a6..7558f99 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -895,7 +895,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t *nperm, uint64_t *nshared);
 
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
-void blk_dev_change_media_cb(BlockBackend *blk, bool load);
+void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
 bool blk_dev_has_tray(BlockBackend *blk);
 void blk_dev_eject_request(BlockBackend *blk, bool force);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 6f21508..65bd081 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -34,7 +34,7 @@ typedef struct BlockDevOps {
      * changes.  Sure would be useful if it did.
      * Device models with removable media must implement this callback.
      */
-    void (*change_media_cb)(void *opaque, bool load);
+    void (*change_media_cb)(void *opaque, bool load, Error **errp);
     /*
      * Runs when an eject request is issued from the monitor, the tray
      * is closed, and the medium is locked.
-- 
1.8.3.1
