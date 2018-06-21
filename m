Received: from eggs.gnu.org ([2001:4830:134:3::10]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kB-0003zz-5B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kA-0003gd-At
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2kA-0003gI-73
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:34 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:22 +0100
Message-Id: <20180621164727.36626-5-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] hmp: Allow help on preconfig commands
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

Allow the 'help' command in preconfig state but
make it only list the preconfig commands.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20180620153947.30834-3-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 1 +
 monitor.c       | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 754620e411..7ce991f4dd 100644
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
index ff26d863db..18c2207e6d 100644
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
