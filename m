Received: from eggs.gnu.org ([2001:4830:134:3::10]:44945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k8-0003yJ-Sc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2k6-0003di-Pe
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2k6-0003dR-Kk
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:30 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:19 +0100
Message-Id: <20180621164727.36626-2-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] monitor: report entirety of hmp command on
 error
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

From: Collin Walling <walling@linux.ibm.com>

When a user incorrectly provides an hmp command, an error response will be
printed that prompts the user to try "help <command name>". However, when
the command contains multiple parts e.g. "info uuid xyz", only the last
whitespace delimited string will be reported (in this example "info" will
be dropped and the message will read "Try "help uuid" for more information",
which is incorrect).

Let's correct this by capturing the entirety of the command from the command
line -- excluding any extraneous characters.

Reported-by: Mikhail Fokin <fokin@de.ibm.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Message-Id: <ee680f5e-ac9a-479d-f65e-9f8ae9cfe5d4@linux.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 885e000f9b..2a8187f5d7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3431,6 +3431,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 {
     QDict *qdict;
     const mon_cmd_t *cmd;
+    const char *cmd_start = cmdline;
 
     trace_handle_hmp_command(mon, cmdline);
 
@@ -3447,8 +3448,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     qdict = monitor_parse_arguments(mon, &cmdline, cmd);
     if (!qdict) {
-        monitor_printf(mon, "Try \"help %s\" for more information\n",
-                       cmd->name);
+        while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
+            cmdline--;
+        }
+        monitor_printf(mon, "Try \"help %.*s\" for more information\n",
+                       (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-- 
2.17.1
