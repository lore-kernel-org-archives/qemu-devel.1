Received: from eggs.gnu.org ([2001:4830:134:3::10]:52955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3EJ0-0002p6-Ru
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 00:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3EIw-0007mo-TK
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 00:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d3EIw-0007lW-Nf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 00:11:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 26 Apr 2017 06:11:47 +0200
Message-Id: <1493179907-22516-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] monitor: Check whether TCG is enabled before
 running the "info jit" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The "info jit" command currently aborts on Mac OS X with the message
"qemu_mutex_lock: Invalid argument" when running with "-M accel=qtest".
We should only call into the TCG code here if TCG has really been
enabled and initialized.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor.c b/monitor.c
index be282ec..3e0979d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1086,6 +1086,11 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
 
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
+    if (!tcg_enabled()) {
+        error_report("JIT information is only available with accel=tcg");
+        return;
+    }
+
     dump_exec_info((FILE *)mon, monitor_fprintf);
     dump_drift_info((FILE *)mon, monitor_fprintf);
 }
-- 
1.8.3.1
