Received: from eggs.gnu.org ([2001:4830:134:3::10]:37496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFq-0003WD-Hi
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFp-0005DK-1b
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diIFo-0005D4-Rz
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF036FA8B8
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 10:42:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 17 Aug 2017 11:42:16 +0100
Message-Id: <20170817104216.29150-3-dgilbert@redhat.com>
In-Reply-To: <20170817104216.29150-1-dgilbert@redhat.com>
References: <20170817104216.29150-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hmp: Fix unknown command for subtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

(qemu) info foo
unknown command: 'foo'

fix this to:
(qemu) info foo
unknown command: 'info foo'

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index e0f880107f..0695bd59d4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2693,6 +2693,7 @@ static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_table,
  * the command is found in a sub-command table.
  */
 static const mon_cmd_t *monitor_parse_command(Monitor *mon,
+                                              const char *cmdp_start,
                                               const char **cmdp,
                                               mon_cmd_t *table)
 {
@@ -2708,7 +2709,7 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
     cmd = search_dispatch_table(table, cmdname);
     if (!cmd) {
         monitor_printf(mon, "unknown command: '%.*s'\n",
-                       (int)(p - *cmdp), *cmdp);
+                       (int)(p - cmdp_start), cmdp_start);
         return NULL;
     }
 
@@ -2720,7 +2721,7 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
     *cmdp = p;
     /* search sub command */
     if (cmd->sub_table != NULL && *p != '\0') {
-        return monitor_parse_command(mon, cmdp, cmd->sub_table);
+        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table);
     }
 
     return cmd;
@@ -3104,7 +3105,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
-    cmd = monitor_parse_command(mon, &cmdline, mon->cmd_table);
+    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
     }
-- 
2.13.5
