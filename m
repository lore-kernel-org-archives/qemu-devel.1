Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82l-0005yg-42
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82k-0002nS-Cv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY82k-0002mt-83
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8E9B77888
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:51:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 18:51:08 +0800
Message-Id: <20180627105112.31401-2-peterx@redhat.com>
In-Reply-To: <20180627105112.31401-1-peterx@redhat.com>
References: <20180627105112.31401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] migration: delay postcopy paused state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Before this patch we firstly setup the postcopy-paused state then we
clean up the QEMUFile handles.  That can be racy if there is a very fast
"migrate-recover" command running in parallel.  Fix that up.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c2f34ffc7c..851d74e8b6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2194,9 +2194,6 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     /* Clear the triggered bit to allow one recovery */
     mis->postcopy_recover_triggered = false;
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                      MIGRATION_STATUS_POSTCOPY_PAUSED);
-
     assert(mis->from_src_file);
     qemu_file_shutdown(mis->from_src_file);
     qemu_fclose(mis->from_src_file);
@@ -2209,6 +2206,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     mis->to_src_file = NULL;
     qemu_mutex_unlock(&mis->rp_mutex);
 
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_POSTCOPY_PAUSED);
+
     /* Notify the fault thread for the invalidated file handle */
     postcopy_fault_thread_notify(mis);
 
-- 
2.17.1
