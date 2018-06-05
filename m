Received: from eggs.gnu.org ([2001:4830:134:3::10]:42009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB33-0003nu-5Y
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB31-0005G7-KX
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQB31-0005FF-DT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B9FA4023834
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 12:26:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 13:26:33 +0100
Message-Id: <20180605122636.33654-4-dgilbert@redhat.com>
In-Reply-To: <20180605122636.33654-1-dgilbert@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] hmp: Restrict auto-complete in preconfig
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
---
 monitor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7d1709c225..9b29787a52 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3950,12 +3950,17 @@ static void monitor_find_completion_by_table(Monitor *mon,
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
2.17.0
