Received: from eggs.gnu.org ([2001:4830:134:3::10]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eZ-0007ec-97
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eV-00083H-W1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg9eV-00082s-Qv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:43 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BE373D95D
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1LCYgTv029938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:34:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 13:34:35 +0100
Message-Id: <1487680479-15132-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487680479-15132-1-git-send-email-armbru@redhat.com>
References: <1487680479-15132-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] blockdev: Make orphaned -drive fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Block backends defined with "-drive if=T" with T other than "none" are
meant to be picked up by machine initialization code: a suitable
frontend gets created and wired up automatically.

If machine initialization code doesn't comply, the block backend
remains unused.  This triggers a warning since commit a66c9dc, v2.2.0.
Drives created by default are exempted; use -nodefaults to get rid of
them.

Turn this warning into an error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487153147-11530-8-git-send-email-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 blockdev.c                | 14 +++++++-------
 include/sysemu/blockdev.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index eb75f35..bbf9d4d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -227,30 +227,30 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit)
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
-            error_report("warning: machine type does not support"
+            error_report("machine type does not support"
                          " if=%s,bus=%d,unit=%d",
                          if_name[dinfo->type], dinfo->bus, dinfo->unit);
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
