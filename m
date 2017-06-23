Received: from eggs.gnu.org ([2001:4830:134:3::10]:33070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGVS-0006Ga-L3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOGVR-0001P7-PL
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dOGVR-0001Oq-GF
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BD04723B8
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 04:47:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Jun 2017 12:46:46 +0800
Message-Id: <1498193206-18007-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1498193206-18007-1-git-send-email-peterx@redhat.com>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/10] migration: hmp: dump globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Now we have some globals that can be configured for migration. Dump them
in HMP info migration for better debugging.

(we can also use this to monitor whether COMPAT fields are applied
correctly on compatible machines)

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp.c                    |  3 +++
 include/migration/misc.h |  1 +
 migration/migration.c    | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/hmp.c b/hmp.c
index 8c72c58..4c41cac 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "exec/ramlist.h"
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
+#include "migration/misc.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -164,6 +165,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     info = qmp_query_migrate(NULL);
     caps = qmp_query_migrate_capabilities(NULL);
 
+    migration_global_dump(mon);
+
     /* do not display parameters during setup */
     if (info->has_status && caps) {
         monitor_printf(mon, "capabilities: ");
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 854c28d..2255121 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -54,5 +54,6 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_only_migratable_set(void);
+void migration_global_dump(Monitor *mon);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index e7e6cf3..b1b0825 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -43,6 +43,7 @@
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
 #include "hw/boards.h"
+#include "monitor/monitor.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -1993,6 +1994,16 @@ void migrate_fd_connect(MigrationState *s)
     s->migration_thread_running = true;
 }
 
+void migration_global_dump(Monitor *mon)
+{
+    MigrationState *ms = migrate_get_current();
+
+    monitor_printf(mon, "globals: store-global-state=%d, only_migratable=%d, "
+                   "send-configuration=%d, send-section-footer=%d\n",
+                   ms->store_global_state, ms->only_migratable,
+                   ms->send_configuration, ms->send_section_footer);
+}
+
 static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
-- 
2.7.4
