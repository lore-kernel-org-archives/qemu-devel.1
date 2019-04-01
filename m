Received: from eggs.gnu.org ([209.51.188.92]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44x-0001iz-Dg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44w-0003fx-8A
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44v-0003ZM-PR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1p1s061963
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:38 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s26y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:38 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:37 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:31 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-58-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 57/97] migration: Stop postcopy fault thread
 before notifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Maximets <i.maximets@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Ilya Maximets <i.maximets@samsung.com>

POSTCOPY_NOTIFY_INBOUND_END handlers will remove userfault fds
from the postcopy_remote_fds array which could be still in
use by the fault thread. Let's stop the thread before
notification to avoid possible accessing wrong memory.

Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Message-Id: <20181008160536.6332-2-i.maximets@samsung.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 55d0fe8254984321a126efd8db358f754737aa63)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/postcopy-ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 932f188949..d6cc99fee1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -519,6 +519,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     if (mis->have_fault_thread) {
         Error *local_err = NULL;
 
+        /* Let the fault thread quit */
+        atomic_set(&mis->fault_thread_quit, 1);
+        postcopy_fault_thread_notify(mis);
+        trace_postcopy_ram_incoming_cleanup_join();
+        qemu_thread_join(&mis->fault_thread);
+
         if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
             error_report_err(local_err);
             return -1;
@@ -527,11 +533,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
             return -1;
         }
-        /* Let the fault thread quit */
-        atomic_set(&mis->fault_thread_quit, 1);
-        postcopy_fault_thread_notify(mis);
-        trace_postcopy_ram_incoming_cleanup_join();
-        qemu_thread_join(&mis->fault_thread);
 
         trace_postcopy_ram_incoming_cleanup_closeuf();
         close(mis->userfault_fd);
-- 
2.17.1
