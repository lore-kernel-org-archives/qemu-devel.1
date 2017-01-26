Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgT-0006Wm-Ck
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgS-0004rD-94
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:09:57 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:09:47 +0100
Message-Id: <1485443388-27253-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1485443388-27253-1-git-send-email-armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/8] blockdev: Make orphaned -drive fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Block backends defined with "-drive if=T" with T other than "none" are
meant to be picked up by machine initialization code: a suitable
frontend gets created and wired up automatically.

If machine initialization code doesn't comply, the block backend
remains unused.  This triggers a warning since commit a66c9dc, v2.2.0.
Drives created by default are excempted; use -nodefaults to get rid of
them.

Turn this warning into an error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c                | 14 +++++++-------
 include/sysemu/blockdev.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a597a66..ec9c114 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -227,28 +227,28 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit)
     return NULL;
 }
 
-bool drive_check_orphaned(void)
+void drive_check_orphaned(void)
 {
     BlockBackend *blk;
     DriveInfo *dinfo;
     Location loc;
-    bool rs = false;
+    bool orphans = false;
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
         dinfo = blk_legacy_dinfo(blk);
-        /* If dinfo->bdrv->dev is NULL, it has no device attached. */
-        /* Unless this is a default drive, this may be an oversight. */
         if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
             dinfo->type != IF_NONE) {
             loc_push_none(&loc);
             qemu_opts_loc_restore(dinfo->opts);
-            error_report("warning: machine type does not support this drive");
+            error_report("machine type does not support this drive");
             loc_pop(&loc);
-            rs = true;
+            orphans = true;
         }
     }
 
-    return rs;
+    if (orphans) {
+        exit(1);
+    }
 }
 
 DriveInfo *drive_get_by_index(BlockInterfaceType type, int index)
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index 351a039..ac22f2a 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -48,7 +48,7 @@ BlockBackend *blk_by_legacy_dinfo(DriveInfo *dinfo);
 void override_max_devs(BlockInterfaceType type, int max_devs);
 
 DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit);
-bool drive_check_orphaned(void);
+void drive_check_orphaned(void);
 DriveInfo *drive_get_by_index(BlockInterfaceType type, int index);
 int drive_get_max_bus(BlockInterfaceType type);
 int drive_get_max_devs(BlockInterfaceType type);
-- 
2.7.4
