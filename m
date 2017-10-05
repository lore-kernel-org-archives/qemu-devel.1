Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l6-00031o-Nj
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l4-0003Qg-K6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l4-0003Od-E6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7218781E04
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:52:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:54 +0100
Message-Id: <20171005105157.10831-3-dgilbert@redhat.com>
In-Reply-To: <20171005105157.10831-1-dgilbert@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] hmp: Fix unknown command for subtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

(qemu) info foo
unknown command: 'foo'

fix this to:
(qemu) info foo
unknown command: 'info foo'

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170817104216.29150-3-dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 94fb197c0d..fe0d1bdbb4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2697,6 +2697,7 @@ static const mon_cmd_t *search_dispatch_table(const mon_cmd_t *disp_table,
  * the command is found in a sub-command table.
  */
 static const mon_cmd_t *monitor_parse_command(Monitor *mon,
+                                              const char *cmdp_start,
                                               const char **cmdp,
                                               mon_cmd_t *table)
 {
@@ -2712,7 +2713,7 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
     cmd = search_dispatch_table(table, cmdname);
     if (!cmd) {
         monitor_printf(mon, "unknown command: '%.*s'\n",
-                       (int)(p - *cmdp), *cmdp);
+                       (int)(p - cmdp_start), cmdp_start);
         return NULL;
     }
 
@@ -2724,7 +2725,7 @@ static const mon_cmd_t *monitor_parse_command(Monitor *mon,
     *cmdp = p;
     /* search sub command */
     if (cmd->sub_table != NULL && *p != '\0') {
-        return monitor_parse_command(mon, cmdp, cmd->sub_table);
+        return monitor_parse_command(mon, cmdp_start, cmdp, cmd->sub_table);
     }
 
     return cmd;
@@ -3108,7 +3109,7 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
-    cmd = monitor_parse_command(mon, &cmdline, mon->cmd_table);
+    cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
     }
-- 
2.13.6
