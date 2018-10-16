Received: from eggs.gnu.org ([2001:4830:134:3::10]:45960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCJ3I-0001eq-Me
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCJ3H-00088W-AY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:42:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 08:41:41 +0200
Message-Id: <20181016064141.32167-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] block: Clean up bdrv_img_create()'s error
 reporting
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

bdrv_img_create() takes an Error ** argument and used it in the
conventional way, except for one place: when qemu_opts_do_parse()
fails, it first reports its error to stderr or the HMP monitor with
error_report_err(), then error_setg()'s a generic error.  When the
caller reports that second error similarly, this produces two
consecutive error messages on stderr or the HMP monitor.  When the
caller does something else with it, such as send it via QMP, the first
error still goes to stderr or the HMP monitor.  Not good.

Turn the first message into a prefix for the second.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---

This is RFC because I didn't check whether "caller does something else
with it" can actually happen with current code, and I'm not sure the
prefix is wanted.  I hope we'll answer both questions during review.

 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 5d51419d21..08aafc20a2 100644
--- a/block.c
+++ b/block.c
@@ -4803,9 +4803,9 @@ void bdrv_img_create(const char *filename, const char *fmt,
     if (options) {
         qemu_opts_do_parse(opts, options, NULL, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            error_setg(errp, "Invalid options for file format '%s'", fmt);
+            error_propagate_prepend(errp, local_err,
+                                    "Invalid options for file format '%s'",
+                                    fmt);
             goto out;
         }
     }
-- 
2.17.1
