Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA1-0004aF-RV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA0-0008WE-P4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAA0-0008Vn-Im
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:21 -0300
Message-Id: <20180530230528.30166-6-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] hmp: disable monitor in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Ban it for now, if someone would need it to work early,
one would have to implement checks if HMP command is valid
at preconfig state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1525423069-61903-5-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor.c b/monitor.c
index 46814af533..9e50418afe 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3371,6 +3371,12 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 
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
2.17.1
