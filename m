Received: from eggs.gnu.org ([2001:4830:134:3::10]:54308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdwTH-0006bs-9c
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdwTG-0001jl-1A
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:05:59 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Feb 2017 11:05:45 +0100
Message-Id: <1487153147-11530-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487153147-11530-1-git-send-email-armbru@redhat.com>
References: <1487153147-11530-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] blockdev: Improve message for orphaned
 -drive
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

We warn when a -drive isn't supported by the machine type (commit
a66c9dc):

    $ qemu-system-x86_64 -S -display none -drive if=mtd
    Warning: Orphaned drive without device: id=mtd0,file=,if=mtd,bus=0,unit=0

Improve this to point to the offending bit of configuration:

    qemu-system-x86_64: -drive if=mtd: warning: machine type does not support if=mtd,bus=0,unit=0

Especially nice when it's hidden behind -readconfig foo.cfg:

    qemu-system-x86_64:foo.cfg:140: warning: machine type does not support if=mtd,bus=0,unit=0

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index db82ac9..eb75f35 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -231,6 +231,7 @@ bool drive_check_orphaned(void)
 {
     BlockBackend *blk;
     DriveInfo *dinfo;
+    Location loc;
     bool rs = false;
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
@@ -239,10 +240,12 @@ bool drive_check_orphaned(void)
         /* Unless this is a default drive, this may be an oversight. */
         if (!blk_get_attached_dev(blk) && !dinfo->is_default &&
             dinfo->type != IF_NONE) {
-            fprintf(stderr, "Warning: Orphaned drive without device: "
-                    "id=%s,file=%s,if=%s,bus=%d,unit=%d\n",
-                    blk_name(blk), blk_bs(blk) ? blk_bs(blk)->filename : "",
-                    if_name[dinfo->type], dinfo->bus, dinfo->unit);
+            loc_push_none(&loc);
+            qemu_opts_loc_restore(dinfo->opts);
+            error_report("warning: machine type does not support"
+                         " if=%s,bus=%d,unit=%d",
+                         if_name[dinfo->type], dinfo->bus, dinfo->unit);
+            loc_pop(&loc);
             rs = true;
         }
     }
-- 
2.7.4
