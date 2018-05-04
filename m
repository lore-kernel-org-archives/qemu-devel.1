Received: from eggs.gnu.org ([2001:4830:134:3::10]:36965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fEc2L-00028G-1Y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fEc2H-0006L7-Ux
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fEc2H-0006Jm-Ls
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:50:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w44Eo75k075438
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 10:50:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hrqemeejw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 10:50:10 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 4 May 2018 10:50:09 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	w44Eo5Af49479866
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 14:50:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0410112040
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 10:49:53 -0400 (EDT)
Received: from collin-ThinkPad-W541.ibm.com (unknown [9.80.203.234])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id C3521112034
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 10:49:53 -0400 (EDT)
From: Collin Walling <walling@linux.ibm.com>
Date: Fri,  4 May 2018 10:49:14 -0400
Message-Id: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] monitor: report entirety of hmp command on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When a user incorrectly provides an hmp command, an error response will be 
printed that prompts the user to try "help <command name>". However, when
the command contains multiple parts e.g. "info skeys", only the last 
whitespace delimited string will be reported (in this example "info" will 
be dropped and the message will read "Try "help skeys" for more information",
which is incorrect).

Let's correct this by capturing the full name of the command as we recurse 
through the function monitor_parse_command.

Reported-by: Mikhail Fokin <fokin@de.ibm.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 39f8ee1..d4844b4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2964,7 +2964,8 @@ static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_table,
 static const mon_cmd_t *monitor_parse_command(Monitor *mon,
                                               const char *cmdp_start,
                                               const char **cmdp,
-                                              mon_cmd_t *table)
+                                              mon_cmd_t *table,
+                                              char *fullname)
 {
     const char *p;
     const mon_cmd_t *cmd;
@@ -2987,10 +2988,14 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
         p++;
     }
 
+    strncat(fullname, cmdname, strlen(cmdname));
+
     *cmdp = p;
     /* search sub command */
     if (cmd->sub_table != NULL && *p != '\0') {
-        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table);
+        strncat(fullname, " ", 1);
+        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table,
+                                     fullname);
     }
 
     return cmd;
@@ -3371,10 +3376,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 {
     QDict *qdict;
     const mon_cmd_t *cmd;
+    char fullname[256];
 
     trace_handle_hmp_command(mon, cmdline);
 
-    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
+    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table,
+                                fullname);
     if (!cmd) {
         return;
     }
@@ -3382,7 +3389,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
     qdict = monitor_parse_arguments(mon, &cmdline, cmd);
     if (!qdict) {
         monitor_printf(mon, "Try \"help %s\" for more information\n",
-                       cmd->name);
+                       fullname);
         return;
     }
 
-- 
2.7.4
