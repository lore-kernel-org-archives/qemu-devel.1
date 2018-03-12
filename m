Received: from eggs.gnu.org ([2001:4830:134:3::10]:48233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFn-0007E2-VU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFn-0005JT-2E
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFm-0005I5-UK
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:38 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:10 +0100
Message-Id: <1520860275-101576-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/9] hmp: disable monitor in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Ban it for now, if someone would need it to work early,
one would have to implement checks if HMP command is valid
at preconfig state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  * v3 was only printing error but not preventing command execution,
    Fix it by returning after printing error message.
    ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
---
 monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor.c b/monitor.c
index a4417f2..ea0ca57 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3104,6 +3104,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
+    if (runstate_check(RUN_STATE_PRECONFIG)) {
+        monitor_printf(mon, "HMP not available in preconfig state\n");
+        return;
+    }
+
     cmd = monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table);
     if (!cmd) {
         return;
-- 
2.7.4
