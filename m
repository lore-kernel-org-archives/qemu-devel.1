Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kC-00041P-Bc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kB-0003hR-HY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2kB-0003h9-DK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:23 +0100
Message-Id: <20180621164727.36626-6-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] hmp: Restrict auto-complete in preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Don't show the commands that aren't available.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20180620153947.30834-4-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 18c2207e6d..068c094a9a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4020,12 +4020,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
             cmdname = args[0];
         readline_set_completion_index(mon->rs, strlen(cmdname));
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
-            cmd_completion(mon, cmdname, cmd->name);
+            if (!runstate_check(RUN_STATE_PRECONFIG) ||
+                 cmd_can_preconfig(cmd)) {
+                cmd_completion(mon, cmdname, cmd->name);
+            }
         }
     } else {
         /* find the command */
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
-            if (compare_cmd(args[0], cmd->name)) {
+            if (compare_cmd(args[0], cmd->name) &&
+                (!runstate_check(RUN_STATE_PRECONFIG) ||
+                 cmd_can_preconfig(cmd))) {
                 break;
             }
         }
-- 
2.17.1
