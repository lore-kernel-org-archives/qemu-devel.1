Received: from eggs.gnu.org ([2001:4830:134:3::10]:48412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eZ-0007ee-9s
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eV-00083F-W1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg9eV-00082q-QA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:43 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 026A97FB67
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2E965410
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 13:34:34 +0100
Message-Id: <1487680479-15132-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487680479-15132-1-git-send-email-armbru@redhat.com>
References: <1487680479-15132-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] blockdev: Improve message for orphaned
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

We warn when a -drive isn't supported by the machine type (commit
a66c9dc):

    $ qemu-system-x86_64 -S -display none -drive if=mtd
    Warning: Orphaned drive without device: id=mtd0,file=,if=mtd,bus=0,unit=0

Improve this to point to the offending bit of configuration:

    qemu-system-x86_64: -drive if=mtd: warning: machine type does not support if=mtd,bus=0,unit=0

Especially nice when it's hidden behind -readconfig foo.cfg:

    qemu-system-x86_64:foo.cfg:140: warning: machine type does not support if=mtd,bus=0,unit=0

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487153147-11530-7-git-send-email-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
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
