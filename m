Received: from eggs.gnu.org ([2001:4830:134:3::10]:60064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSz-00080I-FA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSy-000138-0S
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfSx-00012U-Rp
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FE9E4005F82
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:43 +0100
Message-Id: <20180612091948.14367-3-dgilbert@redhat.com>
In-Reply-To: <20180612091948.14367-1-dgilbert@redhat.com>
References: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/7] hmp: Allow help on preconfig commands
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
index 0734fea931..8bf590ae4b 100644
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
index 2d7bfb8a2c..8ff0e2fcc7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -957,6 +957,10 @@ static void help_cmd_dump_one(Monitor *mon,
 {
     int i;
 
+    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
+        return;
+    }
+
     for (i = 0; i < prefix_args_nb; i++) {
         monitor_printf(mon, "%s ", prefix_args[i]);
     }
@@ -979,7 +983,9 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
 
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
