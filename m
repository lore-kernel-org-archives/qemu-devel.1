Received: from eggs.gnu.org ([2001:4830:134:3::10]:52214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRT-0000De-LF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRQ-0006is-UI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3NRQ-0006il-Ne
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EF363D959
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:57:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 26 Apr 2017 14:57:04 +0100
Message-Id: <20170426135707.5261-3-dgilbert@redhat.com>
In-Reply-To: <20170426135707.5261-1-dgilbert@redhat.com>
References: <20170426135707.5261-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] monitor: Check whether TCG is enabled
 before running the "info jit" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

The "info jit" command currently aborts on Mac OS X with the message
"qemu_mutex_lock: Invalid argument" when running with "-M accel=qtest".
We should only call into the TCG code here if TCG has really been
enabled and initialized.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1493179907-22516-1-git-send-email-thuth@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor.c b/monitor.c
index a27dc8003f..6289e5256c 100644
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
2.12.2
