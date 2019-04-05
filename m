Received: from eggs.gnu.org ([209.51.188.92]:58788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCNHb-00060t-CC
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCNHa-0005TG-G1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:45:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  5 Apr 2019 13:45:13 +0200
Message-Id: <20190405114513.3141-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0] hmp: Fix drive_add ... format=help
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

drive_new() returns null without setting an error when it provided
help.  add_init_drive() assumes null means failure, and crashes trying
to report a null error.

Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 device-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index 6090d5f1e9..6153259d71 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
 
     mc = MACHINE_GET_CLASS(current_machine);
     dinfo = drive_new(opts, mc->block_default_type, &err);
-    if (!dinfo) {
+    if (err) {
         error_report_err(err);
         qemu_opts_del(opts);
         return NULL;
-- 
2.17.2
