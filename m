Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgbIA-0005xo-BX
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgbI6-0003ra-Ei
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fgbI6-0003r7-4d
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:42:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6KJcZNJ108881
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:42:12 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kbjkbrcbf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:42:12 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 20 Jul 2018 15:42:11 -0400
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 20 Jul 2018 15:40:24 -0400
Message-Id: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, stzi@linux.ibm.com, eblake@redhat.com

When typing 'help' followed by an unknown command, QEMU will
not print anything to the command line to let the user know
they typed a bad command. Let's fix this by printing a message
to the monitor when this happens. For example:

    (qemu) help xyz
    unknown command: 'xyz'

Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 monitor.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 7af1f18..deeb41c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1013,6 +1013,7 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
                           char **args, int nb_args, int arg_index)
 {
     const mon_cmd_t *cmd;
+    size_t i;
 
     /* No valid arg need to compare with, dump all in *cmds */
     if (arg_index >= nb_args) {
@@ -1034,9 +1035,15 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
             } else {
                 help_cmd_dump_one(mon, cmd, args, arg_index);
             }
-            break;
+            return;
         }
     }
+
+    /* Command not found */
+    monitor_printf(mon, "unknown command: '");
+    for (i = 0; i <= arg_index; i++) {
+        monitor_printf(mon, "%s%s", args[i], i == arg_index ? "'\n" : " ");
+    }
 }
 
 static void help_cmd(Monitor *mon, const char *name)
-- 
2.7.4
