Received: from eggs.gnu.org ([2001:4830:134:3::10]:60072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSz-00080K-QG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSy-000148-Ub
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfSy-00013y-PI
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B9727D84D
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:44 +0100
Message-Id: <20180612091948.14367-4-dgilbert@redhat.com>
In-Reply-To: <20180612091948.14367-1-dgilbert@redhat.com>
References: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/7] hmp: Restrict auto-complete in preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Don't show the commands that aren't available.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 monitor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 8ff0e2fcc7..9ea23828ef 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3951,12 +3951,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
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
