Received: from eggs.gnu.org ([2001:4830:134:3::10]:33531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVfD9-0006y2-FO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVfD7-0003k6-9I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVfD7-0003jf-4H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAB7D407A6E4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 15:39:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 20 Jun 2018 16:39:42 +0100
Message-Id: <20180620153947.30834-3-dgilbert@redhat.com>
In-Reply-To: <20180620153947.30834-1-dgilbert@redhat.com>
References: <20180620153947.30834-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/7] hmp: Allow help on preconfig commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow the 'help' command in preconfig state but
make it only list the preconfig commands.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hmp-commands.hx | 1 +
 monitor.c       | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0de7c4c29e..3094294e5b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -15,6 +15,7 @@ ETEXI
         .params     = "[cmd]",
         .help       = "show the help",
         .cmd        = do_help_cmd,
+        .flags      = "p",
     },
 
 STEXI
diff --git a/monitor.c b/monitor.c
index 8dc86c0c3c..6fc20c4889 100644
--- a/monitor.c
+++ b/monitor.c
@@ -979,6 +979,10 @@ static void help_cmd_dump_one(Monitor *mon,
 {
     int i;
 
+    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
+        return;
+    }
+
     for (i = 0; i < prefix_args_nb; i++) {
         monitor_printf(mon, "%s ", prefix_args[i]);
     }
@@ -1001,7 +1005,9 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
 
     /* Find one entry to dump */
     for (cmd = cmds; cmd->name != NULL; cmd++) {
-        if (compare_cmd(args[arg_index], cmd->name)) {
+        if (compare_cmd(args[arg_index], cmd->name) &&
+            ((!runstate_check(RUN_STATE_PRECONFIG) ||
+                cmd_can_preconfig(cmd)))) {
             if (cmd->sub_table) {
                 /* continue with next arg */
                 help_cmd_dump(mon, cmd->sub_table,
-- 
2.17.1
