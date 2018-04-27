Received: from eggs.gnu.org ([2001:4830:134:3::10]:50191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4xF-0002Lq-8S
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4x9-0003Or-Uy
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fC4x9-0003OD-RF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B12AEEC004
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 15:06:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 27 Apr 2018 17:05:16 +0200
Message-Id: <1524841523-95513-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v6 04/11] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

Ban it for now, if someone would need it to work early,
one would have to implement checks if HMP command is valid
at preconfig state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v5:
  * add 'use QMP instead" to error message, suggesting user
    the right interface to use
v4:
  * v3 was only printing error but not preventing command execution,
    Fix it by returning after printing error message.
    ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
---
 monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor.c b/monitor.c
index 39f8ee1..0ffdf1d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3374,6 +3374,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
+    if (runstate_check(RUN_STATE_PRECONFIG)) {
+        monitor_printf(mon, "HMP not available in preconfig state, "
+                            "use QMP instead\n");
+        return;
+    }
+
     cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
-- 
2.7.4
